//
//  File.swift
//  
//
//  Created by Vishal Polepalli on 1/28/23.
//

import Foundation
import FirebaseAuth

public protocol FirebaseAuthServiceProtocol: AnyObject {
    func requestOTP(phoneNumber: String, completion: @escaping (String?, Error?) -> Void)
    func signInWithCode(code: String, verificationId: String, completion: @escaping (AuthDataResult?, Error?) -> Void)
    func getUserIDToken(completion: @escaping (String?) -> Void)
    func getCurrentUser() -> User?
    func isUserSignedIn() -> Bool
    func signOutUser()
}

public class FirebaseAuthService: DependencyContainer.Component, FirebaseAuthServiceProtocol {
    public func requestOTP(phoneNumber: String, completion: @escaping (String?, Error?) -> Void) {
        Auth.auth().languageCode = "en"
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            completion(verificationID, error)
        }
    }
    
    public func signInWithCode(code: String, verificationId: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: code)

        Auth.auth().signIn(with: credential) { (authResult, error) in
            completion(authResult,error)
        }
    }
    
    public func getUserIDToken(completion: @escaping (String?) -> Void) {
        guard let currentUser = getCurrentUser() else {
            completion(nil)
            return
        }
        
        currentUser.getIDTokenResult(forcingRefresh: true) { idToken, error in
            completion(idToken?.token)
        }
    }
    
    public func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    public func isUserSignedIn() -> Bool {
        return getCurrentUser() != nil
    }
    
    public func signOutUser() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error: ", error)
        }
        // Reset the App State on sign out
        entity.dataComponent.appState.value = .init()
    }
}

