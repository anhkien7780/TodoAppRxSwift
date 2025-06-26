//
//  Coordinator.swift
//  TodoAppRxSwift
//
//  Created by Admin on 6/24/25.
//

import Foundation
import UIKit

protocol Coordinator{
    var navigationController: UINavigationController { get set }
    func start()
}
