//
//  NetworkUtilities.swift
//  SampleApp_Swift_iOS
//
//  Created by Durai on 01/08/17.
//  Copyright © 2017 Durai. All rights reserved.
//
//
//  Have to implement Reachability
//
//
import UIKit
import Alamofire

extension URLSession
{
    /// Return data from synchronous URL request
    public func requestSynchronousData(request: NSURLRequest) -> (NSData?, URLResponse?) {
        var data: NSData? = nil
        var response: URLResponse? = nil
        let group = DispatchGroup()
        group.enter()
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (taskData, taskResponse, taskError) in
            data = taskData as NSData?
            response = taskResponse
            if data == nil, let taskError = taskError {
                print(taskError)
            }
            group.leave()
        }
        task.resume()
        return (data,response)
    }
}

public class NetworkUtilities {
    

    static var refreshActionName = ""
    static var refreshHttpMethod = ""
    static var refreshRequestBody:AnyObject?
    static var refreshcontentType = ""


    /**
     create session
     
     - parameter contentType: either JSON OR URLENCODED
     
     - returns: URLSession
     */
    static func getSessionWithContentType(contentType : String) -> URLSession {
        let sessoinConfiguration = URLSessionConfiguration.default
        sessoinConfiguration.httpAdditionalHeaders = ["content-type":contentType]
        let session : URLSession  = URLSession.init(configuration: sessoinConfiguration)
        return session
    }
    
    
    static func getAuthenticationHeadersWithUserNameAndPassword(request : NSMutableURLRequest){
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("REST", forHTTPHeaderField: "REQUEST_TYPE")
    }
    
    static func getAuthenticationHeadersWithSessionIdAndToken(request : NSMutableURLRequest){
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("REST", forHTTPHeaderField: "REQUEST_TYPE")
        //print(UserDefaults.standard.value(forKey: "sessionToken") as! String? ?? "def")
        //print(UserDefaults.standard.value(forKey: "sessionId") as! String? ?? "def id")

    }
    
    
    /**
     Create mutable url request to send the server
     
     - parameter actionName:  which action to be performed login
     - parameter httpMethod:  either POST OR GET OR PUT OR DELETE
     - parameter requestBody: parameters
     - parameter contentType: either JSON OR URLENCODED
     
     - returns: URLRequest
     */
    
    
    
    static func getUrlRequest(urlString:String , httpMethod : String, requestBody: AnyObject?,contentType : String) -> NSMutableURLRequest {

        let requestUrl = NSURL.init(string: urlString)
        let request  = NSMutableURLRequest.init(url: requestUrl! as URL)
        request.httpMethod = httpMethod
        request.timeoutInterval = 120

        var jsonData = Data()
//        if requestBody != nil {
            if contentType == CommonValues.jsonApplication{
            do {
                jsonData = try JSONSerialization.data(withJSONObject: requestBody!)
                // here "jsonData" is the dictionary encoded in JSON data
                
                //#-- For checking given format is json or not
//                let jsonString = NSString.init(data: jsonData, encoding: String.Encoding.utf8.rawValue)
                //print(jsonString as Any);
                
                request.httpBody? =  jsonData
                let postLength = String(jsonData.count)
                request.setValue(contentType, forHTTPHeaderField: "Content-type")
                request.setValue(postLength, forHTTPHeaderField: "Content-Length")
            } catch let error as NSError {
                print(error)
            }
            }
            if contentType == CommonValues.urlencoded {
                        if requestBody != nil {
                jsonData = (requestBody as! String).data(using: .utf8)!
                }
//                var postLength: String = "\(UInt(jsonData.count))"
//                request.setValue(postLength, forHTTPHeaderField: "Content-Length")
               // getAuthenticationHeadersWithSessionIdAndToken(request: request)
                request.httpBody = jsonData
            }
//        }
//        else{
//            
//        }
        
        return request
        
    }
    
    
    
    
    
    /**
     Synchronous request
     
     - parameter actionName:  action Name like Login
     - parameter httpMethod:  http methid like Get or Post
     - parameter requestBody: parameters with json format
     - parameter contentType: content type - json or urlencoded
     
     - returns: Object if success or error
     */
    static public func sendSynchronousRequestToServer(actionName : String,httpMethod : String, requestBody :AnyObject?, contentType : String ) -> AnyObject?{
        UIApplication.shared.startNetworkActivity(info: "Fetching Data")
        let request = self.getUrlRequest(urlString: actionName, httpMethod: httpMethod, requestBody: requestBody, contentType: contentType)
        let responseObject = self.getSessionWithContentType(contentType: contentType).requestSynchronousData(request: request)
        UIApplication.shared.stopNetworkActivity()
        return self.getResponseData(responseData: responseObject.0, response: responseObject.1)
    }
    
    
    /**
     Asynchronous request
     
     - parameter actionName:        action Name like Login
     - parameter httpMethod:        http methid like Get or Post
     - parameter requestBody:       parameters with json format
     - parameter contentType:       ontent type - json or urlencoded
     - parameter completionHandler: completiontype Called after request was finished or failed
     */
    static public func sendAsynchronousRequestToServer(actionName:String, httpMethod:String, requestBody:AnyObject?, contentType:String, completionHandler: @escaping ((_ obj: AnyObject)->())){
        
        var methodName: HTTPMethod = HTTPMethod.get
        switch httpMethod {
        case "GET":
            methodName = HTTPMethod.get
            break
        case "POST":
            methodName = HTTPMethod.post
            break
        case "DELETE":
            methodName = HTTPMethod.delete
            break
        default:
            methodName = HTTPMethod.get
            break
        }
        
        var params: [String: AnyObject]? = nil
        
        if let requestBody = requestBody as? Data {
            do {
            let jsonObject = try JSONSerialization.jsonObject(with: requestBody, options: JSONSerialization.ReadingOptions.allowFragments)
                params = jsonObject as? [String : AnyObject]
            } catch {
                print(error)
            }
        }
        
        Alamofire.request(actionName, method: methodName, parameters: params, encoding: JSONEncoding.default, headers: nil).responseData { (data) in
            switch data.result {
            case .success(let json):
                print(json)
                if data.data == nil{
                    UIApplication.shared.stopNetworkActivity()
                    completionHandler(AnyObject.self as AnyObject)
                    return
                }
                guard (try? JSONSerialization.jsonObject(with: data.data!, options: []) as? [String: AnyObject]) != nil else{
                    UIApplication.shared.stopNetworkActivity()
                    completionHandler(AnyObject.self as AnyObject)
                    return
                }
                //print(dataString)
                completionHandler(self.getResponseData(responseData: data.data! as NSData?, response: data.response)!)
                break
            case .failure(let error):
                print(error)
                break
            }
        }

        refreshActionName = actionName
        refreshHttpMethod = httpMethod
        refreshcontentType = contentType
        refreshRequestBody = requestBody
        
//        if !self.hasConnectivity() {
//            self.topViewController()?.showAlert(title: "Message", contentText: "No Internet connection", actions: nil)
//            completionHandler("" as AnyObject)
//        } else {
//        let requestUrl = NSURL.init(string: actionName)
//        let request  = NSMutableURLRequest.init(url: requestUrl! as URL)
//        request.httpMethod = httpMethod
//        request.timeoutInterval = 120
//        request.setValue(contentType, forHTTPHeaderField: "Content-type")
//        if requestBody != nil {
//            request.httpBody = requestBody as? Data
//        } else {
//            request.httpBody = nil
//        }
//        
//        let  postDataTask = self.getSessionWithContentType(contentType: contentType).dataTask(with: request as URLRequest) { (data, response, error) in
//            if data == nil{
//                UIApplication.shared.stopNetworkActivity()
//                completionHandler(AnyObject.self as AnyObject)
//               return
//            }
//            guard (try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]) != nil else{
//                UIApplication.shared.stopNetworkActivity()
//                completionHandler(AnyObject.self as AnyObject)
//                return
//            }
//            //print(dataString)
//            completionHandler(self.getResponseData(responseData: data as NSData?, response: response)!)
//        };
//        postDataTask.resume()
//        }
    }
    
    static func getResponseData(responseData : NSData? , response: URLResponse?) -> AnyObject? {
        guard response != nil else{
            return "Your device is having poor or no connection to connect the server. Please check or reset your connection." as AnyObject?;
        }
        let httpResponse = response as? HTTPURLResponse
        let statusCode = httpResponse?.statusCode
        let allHeaderFields : NSDictionary = (httpResponse?.allHeaderFields)! as NSDictionary
        
        //#-- Response is success
        if statusCode == 200 {
            //#-- Check respose is either JSON or XML or TEXT
            let contentType = allHeaderFields.value(forKey: "Content-Type") as? String
            if (contentType!.range(of:"application/json") != nil) {
                //#--  JSON
                var jsonResponse: AnyObject?
                do {
                    jsonResponse = try JSONSerialization.jsonObject(with: responseData! as Data, options: JSONSerialization.ReadingOptions()) as AnyObject
                } catch let jsonError {
                    print(jsonError)
                }
                return jsonResponse
            }
            else {
                //#-- Do part other values
                
                let responseStr  = NSString.init(data:responseData! as Data, encoding: String.Encoding.utf8.rawValue)
                if (responseStr != nil)  {
                    
                    let jsonResponse = self.json_StringToDictionary(jsonStr: responseStr! as String)
                    
//                    if !(jsonResponse["message"]! is NSNull) && jsonResponse["message"]! as! String == "Sign in required."{
//                        // Refresh to get the new sessionId and token
////                        self.getRefresh()
////                        return "" as AnyObject?
//                        
//                    } else {
//                    return jsonResponse
//                    }
                    return jsonResponse
                    
//                    // To Check: expiry of sessionId
//                    let jsonResponse = self.json_StringToDictionary(jsonStr: responseStr as! String)
//                    
//                    if !(jsonResponse["message"]! is NSNull) && jsonResponse["message"]! as! String == "Sign in required."{
//                        // Refresh to get the new sessionId and token
////                        self.getRefresh()
//                        
//                    }

//                    return responseStr
                }
                
            }
            
        } else {
            //#-- Response is failure case
            var jsonResponse : AnyObject?
            do {
                jsonResponse = try JSONSerialization.jsonObject(with: responseData! as Data, options: JSONSerialization.ReadingOptions()) as AnyObject
            } catch let jsonError {
                print(jsonError)
            }
            
            let  errorMessage  = (jsonResponse as? Dictionary<String, AnyObject>)?["message"] as? String
            if errorMessage != nil && errorMessage!.count > 0 {
                return errorMessage as AnyObject?
            }
            else{
                return "Error while send request" as AnyObject?
            }
        }
        return "Error while send request" as AnyObject?
    }
    
    
    
    // MARK:- LOGIN METHODS

    
    static public func loginMethod(requestBody:AnyObject?, contentType:String, completionHandler: @escaping ((_ obj: AnyObject)->())){
        //    static public func loginMethod( requestBody :AnyObject?, contentType : String ) -> AnyObject?{
        
//        if !self.hasConnectivity() {
//            self.topViewController()?.showAlert(title: "Message", contentText: "No Internet connection", actions: nil)
//            completionHandler("" as AnyObject)
//        } else {
        UIApplication.shared.startNetworkActivity(info: "Logging in...")
        
        let requestUrl = NSURL.init(string: Constants.UrlConfig.LOGIN_API)
        let request  = NSMutableURLRequest.init(url: requestUrl! as URL)
        request.httpMethod = "POST"
        request.timeoutInterval = 120
        request.setValue(contentType, forHTTPHeaderField: "Content-type")
        request.httpBody = (requestBody as! Data)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            if data == nil{
                UIApplication.shared.stopNetworkActivity()
                completionHandler(AnyObject.self as AnyObject)
                return
            }
            guard let dataString =  try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject] else{
                UIApplication.shared.stopNetworkActivity()
                completionHandler(AnyObject.self as AnyObject)
                return
            }
            print(dataString!)
            completionHandler(self.getResponseData(responseData: data as NSData?, response: response)!)

        };
        task.resume()
//        }
        
        
        //        let responseObject = self.getSessionWithContentType(contentType: contentType).requestSynchronousData(request: request)
        //        UIApplication.shared.stopNetworkActivity()
        //        return self.getResponseData(responseData: responseObject.0, response: responseObject.1)
    }
    
    static func getLoginUrlRequest(requestBody: AnyObject?,contentType : String) -> NSMutableURLRequest {
        
        var  urlString : String
        
        urlString = Constants.UrlConfig.LOGIN_API
        
        let requestUrl = NSURL.init(string: urlString)
        let request  = NSMutableURLRequest.init(url: requestUrl! as URL)
        request.httpMethod = "POST"
        request.timeoutInterval = 120
        
        var jsonData = Data()
        //        if requestBody != nil {
        if contentType == CommonValues.jsonApplication{
            do {
                jsonData = try JSONSerialization.data(withJSONObject: requestBody!, options: .prettyPrinted)
                // here "jsonData" is the dictionary encoded in JSON data
                
                //#-- For checking given format is json or not
                let jsonString = NSString.init(data: jsonData, encoding: String.Encoding.utf8.rawValue)
                print(jsonString as Any)
                
                request.httpBody? =  jsonData
                let postLength = String(jsonData.count)
                request.setValue(contentType, forHTTPHeaderField: "Content-type")
                request.setValue(postLength, forHTTPHeaderField: "Content-Length")
            } catch let error as NSError {
                print(error)
            }
        }
        if contentType == CommonValues.urlencoded {
            
            //                jsonData = (requestBody as! String).data(using: .utf8)!
            //                var postLength: String = "\(UInt(jsonData.count))"
            
           // getAuthenticationHeadersWithUserNameAndPassword(request: request)
       
            request.httpBody = jsonData
        }
        //        }
        //        else{
        //
        //        }
        //
        return request
        
    }
    


    static func json_StringToDictionary(jsonStr:String) -> AnyObject {
        var _: NSError?
        let objectData = jsonStr.data(using: String.Encoding.utf8)!
        var jsonResponse : AnyObject?
        do {
            jsonResponse = try JSONSerialization.jsonObject(with: objectData as Data, options: JSONSerialization.ReadingOptions()) as AnyObject
        } catch let jsonError {
            print(jsonError)
        }
        return jsonResponse!
    }


    
    static public func hasConnectivity() -> Bool {
        let reachability  = Reachability()!
        do {
            try reachability.startNotifier()
        } catch {

        }
       return reachability.isReachable
    }
    
    
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    
    
    
    static public func uploadImageToServer(actionName:String, httpMethod:String, requestBody:AnyObject?, contentType:String, completionHandler: @escaping ((_ obj: AnyObject)->())){
        var request = URLRequest(url: URL(string: actionName)!)
        request.httpMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("REST", forHTTPHeaderField: "ZURMO_API_REQUEST_TYPE")
        request.setValue(UserDefaults.standard.value(forKey: "sessionId") as! String?, forHTTPHeaderField: "ZURMO_SESSION_ID")
        request.setValue(UserDefaults.standard.value(forKey: "sessionToken") as! String?, forHTTPHeaderField: "ZURMO_TOKEN")
    
        let boundary = "Boundary---------------------------14737809831466499882746641449)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = requestBody as? Data
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if data == nil{
                UIApplication.shared.stopNetworkActivity()
                completionHandler(AnyObject.self as AnyObject)
                return
            }
            guard let dataString =  try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject] else{
                UIApplication.shared.stopNetworkActivity()
                completionHandler(AnyObject.self as AnyObject)
                return
            }
            print(dataString as Any)
            completionHandler(self.getResponseData(responseData: data as NSData?, response: response)!)
        }
        task.resume()
    }   
}



