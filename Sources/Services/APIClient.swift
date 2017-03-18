//
//  APIClient.swift
//  cosmos
//
//  Created by Tue Nguyen on 4/14/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import Foundation
import Alamofire

extension Request {
    public func debugLog() -> Self {
        #if DEBUG
            debugPrint(self)
        #endif
        return self
    }
}

let APIErrorDomain = "com.common.error";
let APIKEY = ""

class APIClient {
    fileprivate static var client: APIClient?
    fileprivate var baseURLString: String
    
    
    var accessToken: String?//Set this value for api client sending request after user logged in
    
    var defaultHeaders: Dictionary<String, String> {
        return [:]//["app-type":"VEND", "device-udid" : UIDevice.current.uniqueDeviceIdentifier]
    }
    
    class func setCurrentClient(_ aClient: APIClient) {
        client = aClient
    }
    
    class func currentClient() -> APIClient? {
        return client
    }
    
    init(baseURLString: String) {
        self.baseURLString = baseURLString
//        accessToken = Constant.APIKey
        NetworkActivityIndicatorManager.shared.isEnabled = true
    }
    
    // MARK: -- Private Methods
    
    fileprivate func resolvePath(_ path: String) -> String {
        return baseURLString + path;
    }
    
    fileprivate func request(
        _ method: HTTPMethod,
        _ path: String,
          parameters: Parameters? = nil,
          encoding: ParameterEncoding = URLEncoding.default,
          headers: HTTPHeaders? = nil)
        -> DataRequest
    {
        let requestURL = URL(string: resolvePath(path))
        
        var requestHeaders = HTTPHeaders()
        var requestParams = Parameters()
        
        for (key, value) in defaultHeaders {
            requestHeaders[key] = value
        }
        
        if let parameters = parameters {
            for (key, value) in parameters {
                requestParams[key] = value as AnyObject?
            }
        }
        
        if let headers = headers {
            for (key, value) in headers {
                requestHeaders[key] = value
            }
        }
        
        //Insert code to authenticate the request
        if let token = accessToken {
            requestParams["key"] = token as AnyObject?
        }
        
        let request = Alamofire.request(requestURL!, method: method, parameters: requestParams, encoding: encoding, headers: requestHeaders)
        
        //Logging request & response data
        #if DEBUG
        request.responseString { [weak request](response: DataResponse<String>) in
            LogDebug(request.debugDescription)
            switch response.result {
            case .success(let value):
                LogDebug("Response:\n===============\n\(value)\n===============")
            case .failure(let error):
                LogDebug("Response:\n===============\n\(error)\n===============")
            }
            
        }
        #endif
        return request
    }
    func errorFromResponse(_ orginError: Error?, response: BaseResponse?) -> BaseError? {
        if orginError == nil  {
            if response != nil {
                let value:BaseResponse = response!
                if let _ = value.errorCode{
                    var msg = "Unexpected Error".localized()
                    if value.errorMessage != nil || (value.errorMessage?.length)! > 0 {
                        msg = (value.errorMessage)!
                    }
                    return BaseError(code: 1000, message: msg)
                }
            }
            return nil
        }
        return BaseError(code: 1000, message: (orginError?.localizedDescription)!)
    }

    // MARK: API Methods for Demo usage
    
    @discardableResult func login(_ email: String, password: String, completionHandler: @escaping (LoginResponse?, Error?) -> Void) -> Request {
        let params: Parameters = ["email" : email,
                                  "password" : password]
        
        return request(.post, "/api/order/merchant_login", parameters: params).responseObject(completionHandler: { (response: DataResponse<LoginResponse>) in
            completionHandler(response.result.value, response.result.error)
        })
    }
    
    @discardableResult func restaurantDetails(_ completionHandler: @escaping (RestaurantDetailsResponse?, Error?) -> Void) -> Request {
        return request(.get, "/api/merchant/restaurant/detail", encoding:URLEncoding.default).responseObject(completionHandler: { (response: DataResponse<RestaurantDetailsResponse>) in
            completionHandler(response.result.value, response.result.error)
        })
    }
}
//MARK: Get Playlist
extension APIClient{
//    /playlists
    @discardableResult func getPlaylists(_ maxResults: Int, pageToken: String?, completionHandler: @escaping (ListPlayListResponse?, BaseError?) -> Void) -> Request {
        var params: Parameters = [
            "part": "snippet,contentDetails,id,localizations,player,status",
            "channelId": Constant.chanelID,
            "maxResults": maxResults,
            "key": Constant.APIKey
        ]
        if let token = pageToken{
            params["pageToken"] = token
        }
        return request(.get, "/playlists", parameters: params).responseObject(completionHandler: { (response: DataResponse<ListPlayListResponse>) in
            completionHandler(response.result.value, self.errorFromResponse(response.result.error, response:response.result.value))
        })
    }
    // /playlistItems
    @discardableResult func getPlaylistItems(_ maxResults: Int, pageToken: String?, playlistId: String, completionHandler: @escaping (VideoResponse?, BaseError?) -> Void) -> Request {
        var params: Parameters = [
            "part": "snippet,contentDetails",
            "maxResults": maxResults,
            "playlistId": playlistId,
            "key": Constant.APIKey
        ]
        if let token = pageToken{
            params["pageToken"] = token
        }
        return request(.get, "/playlistItems",parameters: params).responseObject(completionHandler: { (response:DataResponse<VideoResponse>) in
             completionHandler(response.result.value, self.errorFromResponse(response.result.error, response:response.result.value))
        })
    }
    //GET https://www.googleapis.com/youtube/v3/search
    //Search Playlist
    @discardableResult func search(_ maxResults: Int, pageToken: String?, order: String, query: String?, searchType: String , completionHandler: @escaping (SearchResponse?, BaseError?) -> Void) -> Request {
        var params: Parameters = [
            "part": "snippet",
            "channelId": Constant.chanelID,
            "maxResults": maxResults,
            "key": Constant.APIKey,
            "order": order,
            "type": searchType,
            "q":""
        ]
        if let token = pageToken{
            params["pageToken"] = token
        }
        return request(.get, "/search", parameters: params).responseObject(completionHandler: { (response :DataResponse<SearchResponse>) in
                completionHandler(response.result.value, self.errorFromResponse(response.result.error, response:response.result.value))
        })
    }
//    GET https://www.googleapis.com/youtube/v3/videos
    @discardableResult func getVideos(_ maxResults: Int, pageToken: String?, videoIDs: [String], completionHandler: @escaping (VideoDetailResponse?, BaseError?) -> Void) -> Request {
        let id = videoIDs.joined(separator: ",")
        var params: Parameters = [
            "part": "snippet,statistics,contentDetails",
            "maxResults": maxResults,
            "key": Constant.APIKey,
            "id": id
        ]
        if let token = pageToken{
            params["pageToken"] = token
        }
        return request(.get, "/videos", parameters: params).responseObject(completionHandler: { (response: DataResponse<VideoDetailResponse>) in
            completionHandler(response.result.value, self.errorFromResponse(response.result.error, response:response.result.value))
        })
    }
}

























