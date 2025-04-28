//
//  CatImagesAPI.swift
//  CatApp_Turtorial
//
//  Created by 유지완 on 3/13/25.
//

import Foundation

import Toast
import Alamofire
import Combine

// API - 먼저 서버에 요청 - request

// - 나중에 응답이 들어옴 - response / completion(decoding, ), publisher, async await

enum ApiError : Error{
    case noContent
    case unknownError(_ error: Error)
    case unauthorized
    case decodingError
//    case testCase(Int, _ code: Int, _ completion: () -> Void)
    
//    var message : String {
//        switch self {
//        case .noContent:
//            return "noContent 에러"
//        case .unknownError(let error):
//            return "unknownError 에러 : error code : \((error as? URLError)?.code.rawValue ?? 0)"
//        case .unauthorized:
//            return "unauthorized 에러"
//        case .decodingError:
//            return "decodingError 에러"
//        }
//    }
}

//AF.request(CatFavoriteRouter.delete(imageId: 20))

// 수정


// API 호출 담당자
enum CatImagesAPI {
    
<<<<<<< HEAD
//    static let endPoint: String = "https://api.thecatapi.com/"
   
    static func someApiCallPublisher02(imageLimit: Int) -> AnyPublisher<[CatImageResponse], Never> {
        let urlString: String = endPoint + "v1/images/search" + "?limit=\(imageLimit)"
        
        return AF.request(urlString, method: .get, parameters: nil, headers: [
            "Content-Type": "application",
            "x-api-key": "live_xLST3RHbCI8ZlLXfi7PG8uwm9GjmFsiqiAz4yrtWVGtCXeB7wZELTOZEAfnfF3Jf"
        ])
        .publishDecodable(type: [CatImageResponse].self)
        .tryMap({
            $0.value ?? []
        })
        .replaceError(with: [])
        .eraseToAnyPublisher()
    }
    
    static func someApiCallPublisher01(imageLimit: Int) -> AnyPublisher<[CatImageResponse]?, ApiError> {
        let urlString: String = endPoint + "v1/images/search" + "?limit=\(imageLimit)"
        
        return AF.request(urlString, method: .get, parameters: nil, headers: [
            "Content-Type": "application",
            "x-api-key": "live_xLST3RHbCI8ZlLXfi7PG8uwm9GjmFsiqiAz4yrtWVGtCXeB7wZELTOZEAfnfF3Jf"
        ])
        .publishDecodable(type: [CatImageResponse].self)
//        .filter({ response in
//            response.value?.count > 0
//        })
        .tryMap({
            $0.value
        })
        .mapError({ error in
            if let _ = error as? DecodingError {
                return ApiError.decodingError
            }
            return ApiError.unknownError(error)
        })
        .eraseToAnyPublisher()
    }
    
    static func someAsyncApiCall(imageLimit: Int) async throws -> [CatImageResponse] {
        let urlString: String = endPoint + "v1/images/search" + "?limit=\(imageLimit)"
        
        return try await AF.request(urlString, method: .get, parameters: nil, headers: [
            "Content-Type": "application",
            "x-api-key": "live_xLST3RHbCI8ZlLXfi7PG8uwm9GjmFsiqiAz4yrtWVGtCXeB7wZELTOZEAfnfF3Jf"
        ])
        .serializingDecodable(decoder: [CatImageResponse].self as! DataDecoder).value
    }
=======
    //    static let endPoint: String = "https://api.thecatapi.com/"
>>>>>>> subBranch
    
    // MARK: GET
    /// 서버에서 고양이 이미지을 가져옵니다.
    /// - Parameter imageLimit: 고양이 이미지 최대 요청 수를 제한합니다.
    /// - Parameter completion: 서버에서 받은 응답 및 에러
    static func fetchCatImage(imageLimit: Int, completion: @escaping (Result<[CatImageResponse], Error>) -> Void) {
        
        //        let urlString: String = endPoint + "v1/images/search" + "?limit=\(imageLimit)"
        //        print(#file, #function, #line, "routorURL: \(urlString)")
        //        AF.request(urlString, method: .get, parameters: nil, headers: [
        //            "Content-Type": "application",
        //            "x-api-key": "live_xLST3RHbCI8ZlLXfi7PG8uwm9GjmFsiqiAz4yrtWVGtCXeB7wZELTOZEAfnfF3Jf"
        //        ])
        
        // TODO: 라우터 패턴 적용하기
        AF.request(CatRouter.fetch(imageLimit: imageLimit))
            .responseDecodable(of: [CatImageResponse].self) { response in
                switch response.result {
                case .success(let catImages):
                    print(#file, #function, #line, "-✅ JSON 디코드 성공")
                    completion(Result.success(catImages))
                case .failure(let error):
                    print(#file, #function, #line, "-💣 JSON 디코드 실패")
                    completion(Result.failure(error))
                }
            }
        
    }
    
    // MARK: POST
    /// 고양이 이미지를 서버에 업로드합니다
    /// - Parameters:
    ///   - fileData: 선택한 이미지 파일 데이터
    ///   - completion: 서버에서 받은 응답 및 에러
    static func uploadCatImage(selected fileData: Data, completion: @escaping (Result<UploadCatImageResponse, Error>) -> Void) {
        print(#file, #function, #line, "- 고양이 이미지 업로드 요청")
        
        //        let urlString: String = endPoint + "v1/images/upload"
        //        let boundary: String = UUID().uuidString
        //
        //        let headers: HTTPHeaders = [
        //            "x-api-key": "live_xLST3RHbCI8ZlLXfi7PG8uwm9GjmFsiqiAz4yrtWVGtCXeB7wZELTOZEAfnfF3Jf",
        //            "Content-Type": "multipart/form-data; boundary=\(boundary)"
        //        ]
        //
        //        AF.upload(multipartFormData: { multipartFormData in
        //            multipartFormData.append(fileData, withName: "file", fileName: "cat.jpeg", mimeType: "image/jpeg" )
        //
        //        }, to: urlString, method: .post, headers: headers)
        
        let dateTime: Double = Date().timeIntervalSince1970
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(fileData, withName: "file", fileName: "cat-\(dateTime).jpeg", mimeType: "image/jpeg" )
            
        }, with: CatRouter.create)
        .responseDecodable(of: UploadCatImageResponse.self, completionHandler: { response in
            
            // 고양이 업로드 응답을 받았으면 ToastActivity가 사라진다.
            NotificationCenter.default.post(name: .uploadSuccessToastEvenet, object: nil, userInfo: nil)
            
            switch response.result {
            case .success(let result):
                print(#file, #function, #line, "-✅ JSON 디코드 성공")
                completion(Result.success(result))
                
            case .failure(let error):
                completion(Result.failure(error))
            }
    
        })
        
    }
    
    // MARK: GET
    /// 업로드 했던 고양이 이미지를 조회합니다.
    /// - Parameters:
    ///   - imageLimit: 업로드 이미지 조회 횟수
    ///   - completion: 서버에서 받은 응답 및 에러
    static func fetchUploadCatImage(imageLimit: Int, completion: @escaping (Result<[UploadCatImage], Error>) -> Void) {
        print(#file, #function, #line, "- 업로드 이미지 조회 요청 ")
        //        let urlString: String = endPoint + "v1/images/?limit=\(imageLimit)&page=0&order=DESC"
        //
        //        let headers: HTTPHeaders = [
        //            "Content-Type": "application/json",
        //            "x-api-key": "live_xLST3RHbCI8ZlLXfi7PG8uwm9GjmFsiqiAz4yrtWVGtCXeB7wZELTOZEAfnfF3Jf"
        //        ]
        
        //        AF.request(urlString, method: .get, headers: headers)
        AF.request(CatRouter.fetchUpload(imageLimit: imageLimit))
            .responseDecodable(of: [UploadCatImage].self, completionHandler: { response in
                
                switch response.result {
                case .success(let image):
                    print(#file, #function, #line, "-✅ JSON 디코드 성공")
                    completion(Result.success(image))
                case .failure(let error):
                    print(#file, #function, #line, "-💣 JSON 디코드 실패")
                    completion(Result.failure(error))
                }
                
            })
    }
    
    // MARK: GET
    /// 업로드 했던 고양이 이미지를 삭제 합니다.
    /// - Parameters:
    ///   - imageID: 삭제 이미지 아이디
    ///   - completion: 서버에서 받은 응답 및 에러
    static func deleteUploadCatImage(imageID: String, completion: @escaping (Result<DeleteUploadResponse, Error>) -> Void) {
        print(#file, #function, #line, "- 업로드 삭제 요청")
        
        //        let urlString: String = endPoint + "v1" + "/images/" + "\(imageID)"
        //        print(#file, #function, #line, "\(urlString)")
        //
        //        let headers: HTTPHeaders = [
        //            "Content-Type": "application/json",
        //            "x-api-key": "live_xLST3RHbCI8ZlLXfi7PG8uwm9GjmFsiqiAz4yrtWVGtCXeB7wZELTOZEAfnfF3Jf"
        //        ]
        //
        //        AF.request(urlString, method: .delete, parameters: nil, headers: headers)
        AF.request(CatRouter.delete(imageID: imageID))
            .validate(statusCode: 200..<300)
            .responseDecodable(of: DeleteUploadResponse.self, completionHandler: { response in
                switch response.result {
                case .success(let result):
                    print(#file, #function, #line, "- ✅ JSON 디코드 성공 ")
                    completion(Result.success(result))
                case .failure(let error):
                    completion(Result.failure(error))
                    print(#file, #function, #line, "- 💣JSON 디코드 실패.")
                }
            })
    }
    
    // MARK: - 즐겨찾기 API
    
    // MARK: POST
    /// 고양이 이미지를  즐겨찾기 등록 합니다.
    /// - Parameters:
    ///   - imageID: 즐겨찾기할 이미지 아이디
    ///   - completion: 서버에서 받은 응답 및 에러
    static func createFavoriteCatImage(imageID: String, completion: @escaping (Result<CreateFavoriteResponse, Error>) -> Void) {
        print(#file, #function, #line, "- 즐겨찾기 요청 했습니다.")

      
        AF.request(CatFavoriteRouter.create(imageID: imageID))

        
<<<<<<< HEAD
//        let urlString: String = endPoint + "v1" + "/favourites"
//    
//        let headers: HTTPHeaders = [
//            "Content-Type": "application/json",
//            "x-api-key": "live_xLST3RHbCI8ZlLXfi7PG8uwm9GjmFsiqiAz4yrtWVGtCXeB7wZELTOZEAfnfF3Jf"
//        ]
//        
//        let body: [String: Any] = [
//            "image_id": imageID,
//        ]
//        
//        AF.request(urlString, method: .post, parameters: body, encoding: JSONEncoding.default ,headers: headers)

=======
        //        let urlString: String = endPoint + "v1" + "/favourites"
        //
        //        let headers: HTTPHeaders = [
        //            "Content-Type": "application/json",
        //            "x-api-key": "live_xLST3RHbCI8ZlLXfi7PG8uwm9GjmFsiqiAz4yrtWVGtCXeB7wZELTOZEAfnfF3Jf"
        //        ]
        //
        //        let body: [String: Any] = [
        //            "image_id": imageID,
        //        ]
        //
        //        AF.request(urlString, method: .post, parameters: body, encoding: JSONEncoding.default ,headers: headers)
        AF.request(CatFavoriteRouter.create(imageID: imageID))
>>>>>>> subBranch
            .responseDecodable(of: CreateFavoriteResponse.self, completionHandler: { response in
                switch response.result {
                    
                case .success(let result):
                    print(#file, #function, #line, "- ✅ JSON 디코드 성공 ")
                    completion(Result.success(result))
                case .failure(let error):
                    print(#file, #function, #line, "- 💣JSON 디코드 실패.")
                    completion(Result.failure(error))
                }
            })
    }
    
    // MARK: GET
    /// 즐겨찾기 등록 했던 고양이 이미지를 가져옵니다.
    /// - Parameter completion: 서버에서 받은 응답 및 에러
    static func fetchFavoritesCatImages(completion: @escaping (Result<[AllFavoriteResponse], Error>) -> Void) {
<<<<<<< HEAD
         

        AF.request(CatFavoriteRouter.fetch)

//         let urlString: String = endPoint + "v1/favourites"
//        
//        let headers: HTTPHeaders = [
//            "Content-Type": "application/json",
//            "x-api-key": "live_xLST3RHbCI8ZlLXfi7PG8uwm9GjmFsiqiAz4yrtWVGtCXeB7wZELTOZEAfnfF3Jf"
//        ]
//         
//        AF.request(urlString, method: .get, parameters: nil, headers: headers)

=======
        
        //         let urlString: String = endPoint + "v1/favourites"
        //
        //        let headers: HTTPHeaders = [
        //            "Content-Type": "application/json",
        //            "x-api-key": "live_xLST3RHbCI8ZlLXfi7PG8uwm9GjmFsiqiAz4yrtWVGtCXeB7wZELTOZEAfnfF3Jf"
        //        ]
        //
        //        AF.request(urlString, method: .get, parameters: nil, headers: headers)
        AF.request(CatFavoriteRouter.fatch)
>>>>>>> subBranch
            .responseDecodable(of: [AllFavoriteResponse].self, completionHandler: { response in
                switch response.result {
                    
                case .success(let result):
                    print(#file, #function, #line, "- ✅ JSON 디코드 성공 ")
                    completion(Result.success(result))
                case .failure(let error):
                    print(#file, #function, #line, "- 💣JSON 디코드 실패.")
                    completion(Result.failure(error))
                }
            })
        
        
    }
    
    
    // MARK: DELETE
    /// 즐겨찾기 등록 했던 고양이 이미지를 삭제합니다.
    /// - Parameters:
    ///   - imageID: 삭제할 고양이 이미지 아이디
    ///   - completion: 서버에서 받은 응답 및 에러
    static func deleteFavoriteCatImage(imageID: Int, completion: @escaping (Result<DeleteFavoriteResponse, Error>) -> Void) {
        print(#file, #function, #line, "- 즐겨찾기 삭제 요청 했습니다.")

    
        AF.request(CatFavoriteRouter.delete(imageId: imageID))

        
        //        let urlString: String = endPoint + "v1" + "/favourites/" + "\(imageID)"
        //        print(#file, #function, #line, "\(urlString)")
        //
        //
        //        let headers: HTTPHeaders = [
        //            "Content-Type": "application/json",
        //            "x-api-key": "live_xLST3RHbCI8ZlLXfi7PG8uwm9GjmFsiqiAz4yrtWVGtCXeB7wZELTOZEAfnfF3Jf"
        //        ]
        
<<<<<<< HEAD
//       AF.request(urlString, method: .delete, parameters: nil, headers: headers)

           .responseDecodable(of: DeleteFavoriteResponse.self, completionHandler: { response in
               switch response.result {
                   
               case .success(let result):
                   print(#file, #function, #line, "- ✅ JSON 디코드 성공 ")
                   completion(Result.success(result))
               case .failure(let error):
                   print(#file, #function, #line, "- 💣JSON 디코드 실패.")
                   completion(Result.failure(error))
               }
           })
=======
        //       AF.request(urlString, method: .delete, parameters: nil, headers: headers)
        AF.request(CatFavoriteRouter.delete(imageID: imageID))
            .responseDecodable(of: DeleteFavoriteResponse.self, completionHandler: { response in
                switch response.result {
                    
                case .success(let result):
                    print(#file, #function, #line, "- ✅ JSON 디코드 성공 ")
                    completion(Result.success(result))
                case .failure(let error):
                    print(#file, #function, #line, "- 💣JSON 디코드 실패.")
                    completion(Result.failure(error))
                }
            })
>>>>>>> subBranch
    }
    
    
}




