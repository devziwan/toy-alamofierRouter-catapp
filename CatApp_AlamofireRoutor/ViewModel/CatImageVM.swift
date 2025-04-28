//
//  CatImageVM.swift
//  CatApp_Turtorial
//
//  Created by 유지완 on 3/13/25.
//

import Foundation

import Alamofire


import Toast
import Combine

class CatImageVM: ObservableObject {
    
    // MARK: - Properties
    
    static let shared : CatImageVM = CatImageVM()

    
//    @Published var name: String = ""
    
    // disposeBag
    var subscriptions = Set<AnyCancellable>()
    
    var catImageList: [CatImageResponse] = []
    var uploadImageList: [UploadCatImage] = []
    var favoriteList: [AllFavoriteResponse] = []
    
    var onCatImageUpdate: (() -> Void)? = nil
    var onCatImageUpload: (() -> Void)? = nil
    var onCatImageFavouriteReload: (() -> Void)? = nil
    
    // MARK: - init Method
    
    init() {
        print(#file, #function, #line, "초기 ")
        self.fatchCatImage(imageLimit: 20)
        self.fetchAllFavourites()
        self.fatchUploadCatImage()
        
        do {
            let value = try testFunction(error: .decodingError, resultValue: nil)
            print(#file, #function, #line, "초기 value: \(value)")
//        } catch(let err as ApiError) {
        } catch(let err) {
            
            if let afError = err as? AFError {
//                switch afE
            }
            
            if let customApiError = err as? ApiError {
//                switch customApiError {
//                case .noContent:
//                    <#code#>
//                case .unknownError(let _):
//                    <#code#>
//                case .unauthorized:
//                    <#code#>
//                case .decodingError:
//                    <#code#>
//                }
            }
            
//            switch err {
//            case .decodingError:
//                print(#file, #function, #line, "\(err)")
//            case .noContent:
//                print(#file, #function, #line, "\(err)")
//            case .unknownError(let unknownError):
//                
//                if let unknownError = unknownError as? AFError {
//                    
//                }
//                
//                if let unknownError = unknownError as? DecodingError {
//                    
//                }
//                
//                print(#file, #function, #line, "\(unknownError)")
//            case .unauthorized:
//                print(#file, #function, #line, "\(err)")
//            }
            
            print(#file, #function, #line, "초기 - error: \(err)")
        }
        
        
    }
    
    func testFunction(error: ApiError, resultValue: String?) throws -> String{
        
        if let resultValue = resultValue{
            return resultValue
        } else {
            throw error
        }
    }
    
    // MARK: - Public Methods
    
    /// 고양이 이미지를 가져옵니다.
    /// - Parameter imageLimit: 고양이 이미지 최대 요청 수를 제한합니다.
    func fatchCatImage(imageLimit: Int) {
<<<<<<< HEAD
<<<<<<< HEAD
        
        
        
        // 성공시 - 이미지 유알엘 보여주기
        // 실패시 - 빈 이미지 소스 보여주기 (로컬)
        
        // data, error type
        CatImagesAPI.someApiCallPublisher01(imageLimit: imageLimit)
            .compactMap({
                $0?.first?.url
            })
//            .catch({ apiError in
                
//                switch apiError {
//                case .decodingError:
//                    print(#file, #function, #line, "")
//                case .noContent:
//                    print(#file, #function, #line, "")
//                case .unauthorized:
//                    print(#file, #function, #line, "")
//                case .unknownError(let unknownError):
//                    print(#file, #function, #line, "")
//                }
//                return Just(apiError.message)
//            })
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(#file, #function, #line, "error: \(error)")
                    
                case .finished:
                    print(#file, #function, #line, "finished")
                }
            } receiveValue: { imageUrl in
                // 성공하면 receiveValue 들어온다.
            }
            .store(in: &subscriptions)

        
//        let apiCallPublisher = CatImagesAPI.someApiCallPublisher01(imageLimit: imageLimit) // [CatImageResponse]?
//        // api success
//        
//        // api failure
//        
//        
//        apiCallPublisher
//            .compactMap({
//                $0?.first
//            }) // CatImageResponse
//            .map({
//                let id = $0.id
//                let url = $0.url
//                return (id: id, url: url)
//            })
//            .sink { completion in
//                switch completion {
//                case .finished:
//                    print(#file, #function, #line, "")
//                case .failure(let error):
//                    print(#file, #function, #line, "error: \(error)")
//                }
//            } receiveValue: { value in
//                let id = value.id
//                let url = value.url
//                
//            }.store(in: &subscriptions)

        
        CatImagesAPI.fatchCatImage(imageLimit: imageLimit ,completion: { result in
=======
        CatImagesAPI.fetchCatImage(imageLimit: imageLimit ,completion: { result in
>>>>>>> 52cec21
=======
        CatImagesAPI.fetchCatImage(imageLimit: imageLimit ,completion: { result in
>>>>>>> 52cec21 (Alamofier Router 적용하기 완료)
            
            switch result {
            case.success(let catImages):
                print(#file, #function, #line, "- 고양이 이미지 가져오기 성공:")
                self.catImageList.append(contentsOf: catImages)
                
                self.onCatImageUpdate?()
            case .failure(let error):
                print(#file, #function, #line, "고양이 이미지 가져오기: \(error)")
            }
        })
    }
    
    func fatchCatImageTest(imageLimit: Int) {
        Task {
            do {
                let value = try await CatImagesAPI.someAsyncApiCall(imageLimit: imageLimit)
                
            } catch {
                print(#file, #function, #line, "error: \(error)")
            }
        }
    }

    /// 고양이 이미지를 업로드합니다.
    /// - Parameter image: 등록할 고양이 이미지 데이터
    func uploadCatImage(image: Data) {
        CatImagesAPI.uploadCatImage(selected: image, completion: { result in
            
            switch result {
            case.success(let uploadImage):
                print(#file, #function, #line, "- 이미지 업로드 성공:")
                
                self.fatchUploadCatImage()
//                self.uploadImageList.append(uploadImage)
                print("- ☑️ 이미지 업로드 리스트 증가: \(self.uploadImageList.count)")
                
//                guard let onCatImageUpLoad = self.onCatImageUpload else {
//                    print(#file, #function, #line, "- onCatImageUpLoad is nil")
//                    return
//                }
//                
//                onCatImageUpLoad()
            case.failure(let error):
                print(#file, #function, #line, "- 이미지 업로드 실패: \(error)")
            }
        })
    }
    
    /// 업로드 했던 고양이 이미지를 조회 합니다.
    func fatchUploadCatImage() {
        CatImagesAPI.fetchUploadCatImage(imageLimit: 100, completion: { result in
            
            switch result {
            case.success(let uploadImages):
                print(#file, #function, #line, "- 이미지 업로드 조회 성공: \(uploadImages)")
                self.uploadImageList = uploadImages
                
                guard let onCatImageUpLoad = self.onCatImageUpload else {
                    print(#file, #function, #line, "- onCatImageUpLoad is nil")
                    return
                }
                
                onCatImageUpLoad()
            case .failure(_):
                print(#file, #function, #line, "- 이미지 업로드 조회 실패:")
            }
            
        })
    }
    
    /// 업로드 목록에서 고양이 이미지를  삭제합니다.
    /// - Parameter imageID: 삭제하고 싶은 고양이 이미지 ID
    func deleteUploadCatImage(imageID: String) {
        CatImagesAPI.deleteUploadCatImage(imageID: imageID, completion: { result in
            
            switch result {
            case .success(let deletedFavorites):
                print(#file, #function, #line, "- 이미지 업로드 삭제 성공: \(deletedFavorites)")
                self.fatchUploadCatImage()
            case .failure(_):
                print(#file, #function, #line, "- 이미지 업로드 삭제 실패:")
            }
            
        })
    }
    
    /// 업로드 목록에서 선택된 고양이 이미지들을  삭제합니다.
    /// - Parameter imageIDs: 삭제할 이미지들의  ID 목록
    func deleteUploadCatImages(imageIDs: [String]) {
        for id in imageIDs {
            deleteUploadCatImage(imageID: id)
        }
    }
    
    /// 고양이 이미지를 즐겨찾기로 등록합니다.
    /// - Parameter imageID: 등록한 즐겨찾기 고양이 이미지 ID
    func createFavouriteCatImage(imageID: String) {
        CatImagesAPI.createFavoriteCatImage(imageID: imageID, completion: { result in
            
            switch result {
            case .success(let favoriteImage):
                print(#file, #function, #line, "- 즐겨찾기 성공 했습니다: \(favoriteImage)")
                self.fetchAllFavourites()
                
            case .failure(let error):
                print(#file, #function, #line, "- 즐겨찾기 실패 했습니다: \(error) ")
            }
        })
    }
    
    /// 고양이 이미지를 즐겨찾기 했던 것을 전체 조회합니다.
    func fetchAllFavourites() {
        CatImagesAPI.fetchFavoritesCatImages(completion: { result in
            
            switch result {
            case .success(let fatchFavorites):
                print(#file, #function, #line, "- 즐겨찾기 전체 조회 성공")
                self.favoriteList = fatchFavorites

                self.onCatImageFavouriteReload?()
                
            case .failure(_):
                print(#file, #function, #line, "- 즐겨찾기 전체 조회 실패")
            }
        })
    }
    
    /// 고양이 이미지를 즐겨찾기 했던 목록에서 삭제합니다.
    /// - Parameter imageID: 삭제할 고양이  이미지 ID
    func deleteFavoriteCatImage(imageID: Int) {
        CatImagesAPI.deleteFavoriteCatImage(imageID: imageID, completion: { result in
            
            switch result {
            case .success(let deletedFavorites):
                print(#file, #function, #line, "- 즐겨찾기 삭제 성공: \(deletedFavorites)")
                
            case .failure(_):
                print(#file, #function, #line, "- 즐겨찾기 삭제 실패:")
            }
        })
    }
    
} // CatImageVM



