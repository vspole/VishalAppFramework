//
//  DependencyContainer.swift
//  AppFramework
//
//  Created by Vishal Polepalli on 10/2/22.
//


import Foundation

public class DependencyContainer: ObservableObject, EntityProtocol {
    public var components: [AnyObject] = []

}

extension DependencyContainer {
    public class Component {
        unowned var entity: DependencyContainer

        init(entity: DependencyContainer) {
            self.entity = entity
        }
    }

    public static func create() -> DependencyContainer {
        let container = DependencyContainer()
        container.components = [
            LocationService(entity: container),
            FirebaseAuthService(entity: container),
            DataComponent(entity: container),
            TokenManager(entity: container),
            LocalStorageManager()
        ]
        return container
    }
}

// MARK: - Convenience property wrappers

extension DependencyContainer {
    var locationService: LocationServiceProtocol { getComponent() }
    var firebaseAuthService: FirebaseAuthServiceProtocol { getComponent() }
    var localStorageManager: LocalStorageManagerProtocol { getComponent() }
    var appState: Store<AppState> { dataComponent.appState }
    var dataComponent: DataComponentProtocol { getComponent() }
    var tokenManager: TokenManagerProtocol { getComponent() }
}

