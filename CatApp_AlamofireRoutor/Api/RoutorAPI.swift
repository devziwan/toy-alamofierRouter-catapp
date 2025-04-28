//
//  RoutorAPI.swift
//  CatApp_AlamofireRoutor
//
//  Created by 유지완 on 4/24/25.
//

import Foundation

import Alamofire

// MARK: - 고양이 이미지 생성하기 라우터 패턴

/// SeverBase URL
var endPoint: String = "https://api.thecatapi.com/"

enum CatRouter: URLRequestConvertible {
    case fetch(imageLimit: Int)
    case create
    case fetchUpload(imageLimit: Int)
    case delete(imageID: String)
    
    var baseURL: URL {
        return URL(string: endPoint)!
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetch, .fetchUpload:
            return .get
        case .create: return .post
        case .delete: return .delete
        }
    }
    
    var path: String {
        switch self {
        case .fetch:
            return "v1/images/search"
        case .create:
            return "v1/images/upload"
        case .fetchUpload:
            return "v1/images/"
        case .delete(imageID: let imageID):
            return "v1/images/\(imageID)"
        }
    }
    
    var httpHeaders: HTTPHeaders {
        switch self {
        case .fetch, .fetchUpload, .delete:
            let headers: HTTPHeaders = [
                "Content-Type": "application/",
                "x-api-key": "live_xLST3RHbCI8ZlLXfi7PG8uwm9GjmFsiqiAz4yrtWVGtCXeB7wZELTOZEAfnfF3Jf"
            ]
            return headers
        case .create:
            let boundary: String = UUID().uuidString
            let headers: HTTPHeaders = [
                "x-api-key": "live_xLST3RHbCI8ZlLXfi7PG8uwm9GjmFsiqiAz4yrtWVGtCXeB7wZELTOZEAfnfF3Jf",
                "Content-Type": "multipart/form-data; boundary=\(boundary)"
            ]
            return headers
        }
    }
    
    // 쿼리 파라미터
    var parameters: Parameters {
        switch self {
        case .fetch(imageLimit: let imageLimit), .fetchUpload(imageLimit: let imageLimit):
            return ["limit" : imageLimit]
        case .create, .delete:
            return [:]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        request.headers = httpHeaders
        
        switch self {
        case .fetch, .fetchUpload:
            request = try URLEncoding.queryString.encode(request, with: parameters)
            print(#file, #function, #line, "fetchUpload URL: \(request)")
            return request
        default:
            break
        }
        
        return request
    }
    
}

// MARK: - 고양이 이미지 즐겨찾기 라우터 패턴

enum CatFavoriteRouter: URLRequestConvertible {
    case create(imageID: String)
    case fatch
    case delete(imageID: Int)
    
    var baseURL: URL {
        return URL(string: endPoint)!
    }
    
    var method: HTTPMethod {
        switch self {
        case .create: return .post
        case .fatch: return .get
        case .delete: return .delete
        }
    }
    
    var path: String {
        switch self {
        case .create, .fatch:
            return "v1/favourites"
        case .delete(imageID: let imageID):
            return "v1/favourites/" + "\(imageID)"
        }
    }
    
    var httpHeaders: HTTPHeaders {
        return [
        "Content-Type": "application/json",
        "x-api-key": "live_xLST3RHbCI8ZlLXfi7PG8uwm9GjmFsiqiAz4yrtWVGtCXeB7wZELTOZEAfnfF3Jf"
        ]
    }
    
    var body: [String: Any] {
        switch self {
        case .create(let imageID):
            return ["image_id": imageID]
        default:
            break
        }
        return [:]
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        request.headers = httpHeaders
        
        let jsonData: Data? = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        request.httpBody = jsonData
        return request
    }
}

