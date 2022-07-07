//
//  ApiLoading.swift
//  LabTest
//
//  Created by Wong Tian Haw on 06/07/2022.
//

import Foundation

final class ApiLoading {
    @Published
    var loading: Bool = false
    
    init(loading: Bool) {
        self.loading = loading
    }
}
