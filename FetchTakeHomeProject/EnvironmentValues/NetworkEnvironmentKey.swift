//
//  NetworkEnvironmentKey.swift
//  FetchTakeHomeProject
//
//  Created by Cool-Ish on 4/17/25.
//

import Foundation
import SwiftUI

struct NetworkEnvironmentKey: EnvironmentKey {
    static let defaultValue: NetworkingStore = .shared
}

extension EnvironmentValues {
    var networkStore: NetworkingStore {
        get { self[NetworkEnvironmentKey.self] }
        set { self[NetworkEnvironmentKey.self] = newValue }
    }
}
