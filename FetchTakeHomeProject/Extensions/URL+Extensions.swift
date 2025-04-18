//
//  URL+Extensions.swift
//  FetchTakeHomeProject
//
//  Created by Cool-Ish on 4/18/25.
//

import Foundation

extension URL: Identifiable {
    public var id: String { absoluteString }
}

