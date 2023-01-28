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
}



