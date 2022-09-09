//
//  URLSessionDataTaskProtocol.swift
//  iOS-Dev-Assignment
//
//  Created by Raphael Velasqua on 07/09/2022.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
    func cancel()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }
