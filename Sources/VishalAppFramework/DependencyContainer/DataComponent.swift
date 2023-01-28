//
//  DataComponent.swift
//  AppFramework
//
//  Created by Vishal Polepalli on 10/12/22.
//

import Combine
import Foundation

/// The protocol for a component on the dependency container that holds central app state
public protocol DataComponentProtocol: DependencyContainer.Component {
    var appState: Store<AppState> { get }
}


