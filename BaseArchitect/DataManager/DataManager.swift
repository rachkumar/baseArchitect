//
//  DataManager.swift
//  FWmyApp
//
//  Created by Duraipirashanna on 02/08/17.
//  Copyright © 2017 Duraipirashanna. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    
    
    // For Login
    class func loginMethodAPI(urlString: String,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.LOGIN_API, httpMethod: HttpMethod.POST, requestBody: urlString as AnyObject, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                
                let jsonResponse = NetworkUtilities.json_StringToDictionary(jsonStr: responsedata as! String)
                if let status = jsonResponse["Code"] as? String {
                    if status == "1"{
                        CompletionHandler(true, jsonResponse as AnyObject)
                        return
                    }
                }
                guard let message = jsonResponse["ResultText"]  else {
                    CompletionHandler(false, "" as AnyObject)
                    return
                }
                CompletionHandler(false, message as AnyObject)
                
            }
        }
        
    }
    
    
    // Fogetr Get Nationality
    class func getNationalityAPI(CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.NATIONALITY_API, httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                var nationalityList = [NationalityModel]()
                if let response = responsedata as? [Dictionary<String,AnyObject>]{
                    for nationality in response {
                        let newNationality = NationalityModel()
                        if nationality["CodeText"] != nil && !(nationality["CodeText"] is NSNull) {
                            newNationality.name = nationality["CodeText"] as! String
                        }
                        if nationality["CodeValue"] != nil && !(nationality["CodeValue"] is NSNull) {
                            newNationality.id = Int(nationality["CodeValue"] as! String) ?? 1
                        }
                        if nationality["CodeOther"] != nil && !(nationality["CodeOther"] is NSNull) {
                            newNationality.countryCode = nationality["CodeOther"] as! String
                        }
                        nationalityList.append(newNationality)
                    }
                    
                    CompletionHandler(true, nationalityList as AnyObject)
                     return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
            }
        }
        
    }
    
    
    // For Get Dormitry
    class func getDormitryAPI(CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.DORMITORY_API, httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                var dormitryList = [DormitoryModel]()
                if let response = responsedata as? [Dictionary<String,AnyObject>]{
                    for dormitry in response {
                        let newDormitry = DormitoryModel()
                        if dormitry["CodeText"] != nil && !(dormitry["CodeText"] is NSNull) {
                            newDormitry.name = dormitry["CodeText"] as! String
                        }
                        if dormitry["CodeValue"] != nil && !(dormitry["CodeValue"] is NSNull) {
                            newDormitry.id = Int(dormitry["CodeValue"] as! String) ?? 1
                        }
                        dormitryList.append(newDormitry)
                    }
                    
                    CompletionHandler(true, dormitryList as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
        
    }
    
    // For Get Industry
    class func getIndustryAPI(CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.INDUSTRY_API, httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                var industryList = [IndustryModel]()
                if let response = responsedata as? [Dictionary<String,AnyObject>]{
                    for industry in response{
                        let newIndustry = IndustryModel()
                        if industry["CodeText"] != nil && !(industry["CodeText"] is NSNull) {
                            newIndustry.name = industry["CodeText"] as! String
                        }
                        if industry["CodeValue"] != nil && !(industry["CodeValue"] is NSNull) {
                            newIndustry.id = Int( industry["CodeValue"] as! String) ?? 0
                        }
                        industryList.append(newIndustry)
                    }
                    
                    CompletionHandler(true, industryList as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
        
    }
    
    // For Get Hobbies
    class func getHobbiesAPI(CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.HOBBIES_API, httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                var hobbyList = [HobbyModel]()
                if let response = responsedata as? [Dictionary<String,AnyObject>]{
                    for hobby in  response{
                        let newHobby = HobbyModel()
                        if hobby["CodeText"] != nil && !(hobby["CodeText"] is NSNull) {
                            newHobby.hobbyName = hobby["CodeText"] as! String
                        }
                        if hobby["CodeValue"] != nil && !(hobby["CodeValue"] is NSNull) {
                            newHobby.id = Int( hobby["CodeValue"] as! String) ?? 0
                        }
                        hobbyList.append(newHobby)
                    }
                    
                    CompletionHandler(true, hobbyList as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
        
    }
    
    // For Profile
    class func setProfileAPI( requestObj: AnyObject , CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.PROFILE_API, httpMethod: HttpMethod.POST, requestBody: requestObj as AnyObject, contentType: CommonValues.jsonApplication){ (responsedata) in
                print(responsedata)
                UIApplication.shared.stopNetworkActivity()
                
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    let jsonResponse = responsedata
                    if let status = jsonResponse["Code"] as? String {
                        if status == "1"{
                            var message = ""
                            if jsonResponse["ErrorText"] != nil && !(jsonResponse["ErrorText"] is NSNull) {
                                message = jsonResponse["ErrorText"] as! String
                            }
                            CompletionHandler(true, message as AnyObject)
                            return
                        }
                    }
                }
                
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
        
    }
    
    
    // For Post job
    class func setJobDetailsAPI( requestObj: AnyObject , CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.POSTJOB_API, httpMethod: HttpMethod.POST, requestBody: requestObj, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    let jsonResponse = responsedata
                    if let status = jsonResponse["Code"] as? String {
                        if status == "1"{
                            var message = ""
                            if jsonResponse["ErrorText"] != nil && !(jsonResponse["ErrorText"] is NSNull) {
                                message = jsonResponse["ErrorText"] as! String
                            }
                            CompletionHandler(true, message as AnyObject)
                            return
                        }
                    }
                }
                
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
            }
        }
        
    }
    
    
    // For Get Rights and Responsibilities
    class func getRightsAndResponsibilitiesAPI(CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.RIGHTS_RESPONSE_API + "\(UserDefaults.standard.string(forKey: Constants.defaults.selectedLanguage) ?? "English")", httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                var rightsList = [RightsModel]()
                if let response = responsedata as? [Dictionary<String,AnyObject>]{
                    for rights in response{
                        let newRights = RightsModel()
//                        if rights["Colour"] != nil && !(rights["Colour"] is NSNull) {
//                            newRights.Colour = rights["Colour"] as! String
//                        }
//                        if rights["DateTime"] != nil && !(rights["DateTime"] is NSNull) {
//                            newRights.DateTime = rights["DateTime"] as! String
//                        }
//                        if rights["Description"] != nil && !(rights["Description"] is NSNull) {
//                            newRights.assetDescription = rights["Description"] as! String
//                        }
                        if rights["VideoThumbnailUri"] != nil && !(rights["VideoThumbnailUri"] is NSNull) {
                            newRights.thumbnailUrl = rights["VideoThumbnailUri"] as! String
                        }
                        if rights["VideoTitle"] != nil && !(rights["VideoTitle"] is NSNull) {
                            newRights.title = rights["VideoTitle"] as! String
                        }
                        if rights["VideoUri"] != nil && !(rights["VideoUri"] is NSNull) {
                            newRights.url = rights["VideoUri"] as! String
                        }
//                        if rights["Id"] != nil && !(rights["Id"] is NSNull) {
//                            newRights.id = rights["Id"] as? Int ?? 0
//                        }
                        rightsList.append(newRights)
                    }
                    
                    CompletionHandler(true, rightsList as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
        
    }
    
    // For Welcome Guide
    class func getArrivalGuideInfoAPI(CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            
            let apiName = Constants.UrlConfig.WELCOME_GUIDE_API  + "\(getValueForuserArrivalStatus(userArrivalStatus: AppState.shared.userArrivalStatus))&language=\(UserDefaults.standard.string(forKey: Constants.defaults.selectedLanguage) ?? "English")"
            NetworkUtilities.sendAsynchronousRequestToServer(actionName: apiName , httpMethod: HttpMethod.GET, requestBody: nil , contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                
                var guideInfoList = [GuideInfoModel]()
                if let response = responsedata as? [Dictionary<String,AnyObject>]{
                    for value in response {
                        
                        let guideInfo = GuideInfoModel()
                        guideInfo.title = value["Title"] as? String ?? ""
                        guideInfo.imagePath = value["ImagePath"] as? String ?? ""
                        guideInfo.colour = value["Colour"] as? String ?? ""
                        guideInfo.guideDescription = value["Description"]  as? String ?? ""
                        print("GuideInfo", guideInfo)
                        
                        guideInfoList.append(guideInfo)
                    }
                    
                    CompletionHandler(true, guideInfoList as AnyObject)
                    return
                    
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
        
    }
    
    // For Get Intro Slider
    class func getIntroSliderAPI(CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.INTRO_SLIDER_API + "\(UserDefaults.standard.string(forKey: Constants.defaults.selectedLanguage) ?? "English")", httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                var sliderList = [IntroSliderModel]()
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? [Dictionary<String,AnyObject>]{
                    for slide in response {
                        let newSlide = IntroSliderModel()
                        if slide["Colour"] != nil && !(slide["Colour"] is NSNull) {
                            newSlide.colour = slide["Colour"] as! String
                        }
                        if slide["Description"] != nil && !(slide["Description"] is NSNull) {
                            newSlide.sliderDescription = slide["Description"] as! String
                        }
                        if slide["ImagePath"] != nil && !(slide["ImagePath"] is NSNull) {
                            newSlide.imagePath = slide["ImagePath"] as! String
                        }
                        if slide["Title"] != nil && !(slide["Title"] is NSNull) {
                            newSlide.title = slide["Title"] as! String
                        }
                        sliderList.append(newSlide)
                    }
                    CompletionHandler(true, sliderList as AnyObject)
                    return
                    
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
        
    }
    
    
    // For Get My medical
    class func getMyMedicalAPI(CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.MYMEDICAL_APPI + "\(UserDefaults.standard.string(forKey: Constants.defaults.selectedLanguage) ?? "English")", httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                var medicalList = [MyMedicalModel]()
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? [Dictionary<String,AnyObject>]{
                    for medical in response {
                        let newMedical = MyMedicalModel()
                        newMedical.name = medical["Name"] as? String ?? ""
                        newMedical.number = medical["Number"] as? String ?? ""
                        newMedical.Rating = medical["Rating"] as? String ?? ""
                        newMedical.timing = medical["Timing"] as? String ?? ""
                        newMedical.type = medical["Type"] as? String ?? ""
                        newMedical.address = medical["Address"] as? String ?? ""
                        newMedical.logoUrl = medical["LogoUri"] as? String ?? ""
                        medicalList.append(newMedical)
                    }
                    CompletionHandler(true, medicalList as AnyObject)
                    return
                    
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
        
    }
    
    
    // For Get My Helpline
    class func getMyHelpLineAPI(CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.MYHELPLINE_API + "\(UserDefaults.standard.string(forKey: Constants.defaults.selectedLanguage) ?? "English")", httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                var helpLineList = [MyHelpLineModel]()
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? [Dictionary<String,AnyObject>]{
                    for helpLine in response {
                        let newHelpLine = MyHelpLineModel()
                        newHelpLine.name = helpLine["DepartmentName"] as? String ?? ""
                        newHelpLine.number = helpLine["Number"] as? String ?? ""
                        newHelpLine.address = helpLine["Address"] as? String ?? ""
                        newHelpLine.logoUrl = helpLine["LogoUri"] as? String ?? ""
                        
                        helpLineList.append(newHelpLine)
                    }
                    CompletionHandler(true, helpLineList as AnyObject)
                    return
                    
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
        
    }
    
    
    // For Get Feesback Category
    class func getFeedbackCategoryAPI(CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.FEEDBACK_CATEGORY + "\(UserDefaults.standard.string(forKey: Constants.defaults.selectedLanguage) ?? "English")", httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                var feedbackList = [FeedbackCategoryModel]()
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? [Dictionary<String,AnyObject>]{
                    for feedback in response {
                        let newCategory = FeedbackCategoryModel()
                        if feedback["FeedBackDesc"] != nil && !(feedback["FeedBackDesc"] is NSNull) {
                            newCategory.name = feedback["FeedBackDesc"] as! String
                        }
                        if feedback["FeedBackID"] != nil && !(feedback["FeedBackID"] is NSNull) {
                            newCategory.id = feedback["FeedBackID"] as? Int ?? 0
                        }
                        
                        feedbackList.append(newCategory)
                    }
                    CompletionHandler(true, feedbackList as AnyObject)
                    return
                    
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
        
    }
    
    
    // For Contact Us
    class func setContactUsAPI( requestObj: AnyObject , CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Updating Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.CONTACT_US_API, httpMethod: HttpMethod.POST, requestBody: requestObj as AnyObject, contentType: CommonValues.jsonApplication){ (responsedata) in
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    let jsonResponse = responsedata
                    if let status = jsonResponse["Code"] as? String {
                        if status == "1"{
                            var message = ""
                            if jsonResponse["ErrorText"] != nil && !(jsonResponse["ErrorText"] is NSNull) {
                                message = jsonResponse["ErrorText"] as! String
                            }
                            CompletionHandler(true, message as AnyObject)
                            return
                        }
                    }
                }
                
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
        
    }
    
    
    
    // For Feedback to mom
    class func setFeedbacktoMomAPI( requestObj: AnyObject , CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Updating Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.FEEDBACK_TO_MOM_API, httpMethod: HttpMethod.POST, requestBody: requestObj as AnyObject, contentType: CommonValues.jsonApplication){ (responsedata) in
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    let jsonResponse = responsedata
                    if let status = jsonResponse["Code"] as? String {
                        if status == "1"{
                            var message = ""
                            if jsonResponse["ResultText"] != nil && !(jsonResponse["ResultText"] is NSNull) {
                                message = jsonResponse["ResultText"] as! String
                            }
                            CompletionHandler(true, message as AnyObject)
                            return
                        }
                        CompletionHandler(false, jsonResponse["ResultText"] as AnyObject)
                    }
                }
                
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
        
    }

    
    // For Get Storiesy
    class func getStoriesAPI(CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.STORIES_API + "\(UserDefaults.standard.string(forKey: Constants.defaults.selectedLanguage) ?? "English")", httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                var storiesList = [StoriesModel]()
                UIApplication.shared.stopNetworkActivity()
                 if let response = responsedata as? [Dictionary<String,AnyObject>]{
                for story in response {
                    let newStory = StoriesModel()
                    if story["DateTime"] != nil && !(story["DateTime"] is NSNull) {
                        newStory.date = story["DateTime"] as! String
                    }
                    if story["Id"] != nil && !(story["Id"] is NSNull) {
                        newStory.id = story["Id"] as! Int
                    }
                    if story["ImagePath"] != nil && !(story["ImagePath"] is NSNull) {
                        newStory.image = story["ImagePath"] as! String
                    }
                    if story["Title"] != nil && !(story["Title"] is NSNull) {
                        newStory.title = story["Title"] as! String
                    }
                    if story["Url"] != nil && !(story["Url"] is NSNull) {
                        newStory.pdfUrl = story["Url"] as! String
                    }

                    storiesList.append(newStory)
                }
                CompletionHandler(true, storiesList as AnyObject)
                return
            }
            }
            
            CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
        }
        
    }
    
    // For logout
    class func logoutAPI( requestObj: AnyObject , CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Updating Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.LOGOUT_API, httpMethod: HttpMethod.POST, requestBody: requestObj as AnyObject, contentType: CommonValues.jsonApplication){ (responsedata) in
                UIApplication.shared.stopNetworkActivity()
                if responsedata is Dictionary<String,AnyObject>{
                    let jsonResponse = responsedata
                    if let status = jsonResponse["Code"] as? String {
                        if status == "1"{
                            var message = ""
                            if jsonResponse["ResultText"] != nil && !(jsonResponse["ResultText"] is NSNull) {
                                message = jsonResponse["ResultText"] as! String
                            }
                            UserDefaults.standard.set(false, forKey: Constants.defaults.IsFindJobSet)
                            CompletionHandler(true, message as AnyObject)
                            return
                        }
                    }
                }
                
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
        
    }
    
    
    // For token validation
    class func validateTokenAPI( requestObj: AnyObject , CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Updating Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.VALIDATE_TOKEN_API, httpMethod: HttpMethod.POST, requestBody: requestObj as AnyObject, contentType: CommonValues.jsonApplication){ (responsedata) in
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    let jsonResponse = responsedata
                    if let status = jsonResponse["Code"] as? String {
                        if status == "1"{
                            var message = ""
                            if jsonResponse["ResultText"] != nil && !(jsonResponse["ResultText"] is NSNull) {
                                message = jsonResponse["ResultText"] as! String
                            }
                            CompletionHandler(true, message as AnyObject)
                            return
                        }
                    }
                }
                
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
        
    }
   
    
    
    // For Get FAQ
    class func getFAQAPI(CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.FAQ_API + "\(UserDefaults.standard.string(forKey: Constants.defaults.selectedLanguage) ?? "English")", httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                var faqList = [FAQModel]()
                if let response = responsedata as? [Dictionary<String,AnyObject>]{
                    for faq in  response{
                        let newFAQ = FAQModel()
                        
                        newFAQ.faqId = faq["FaqID"] as? Int ?? 0
                        newFAQ.faqUrl = faq["FaqURL"] as? String ?? ""
                        newFAQ.faqText = faq["FaqQuestion"] as? String ?? ""

                        faqList.append(newFAQ)
                    }
                    
                    CompletionHandler(true, faqList as AnyObject)
                    return
                }else{
                    let response = [[
                        "FaqID": 1,
                        "FaqQuestion": "1. I no longer wish to work and want to resign. What should I do?",
                        "FaqURL": "www.google.com"
                        ], [
                            "FaqID": 2,
                            "FaqQuestion": "2. My employer told me not to come for work. What should I do?",
                            "FaqURL": "www.google.com"
                        ], [
                            "FaqID": 3,
                            "FaqQuestion": "3. I want to know about salary payment and claims. What should I do?",
                            "FaqURL": "www.google.com"
                        ], [
                            "FaqID": 4,
                            "FaqQuestion": "4. My employer has deducted my salary. What should I do?",
                            "FaqURL": "www.google.com"
                        ], [
                            "FaqID": 5,
                            "FaqQuestion": "5. I want to know more about my annual and sick leave entitlement. What should I do?",
                            "FaqURL": "www.google.com"
                        ], [
                            "FaqID": 6,
                            "FaqQuestion": "5. I want to know how to calculate my overtime pay. What should I do?",
                            "FaqURL": "www.google.com"
                        ]]
                    
                    
                    for faq in  response{
                        let newFAQ = FAQModel()
                        
                        newFAQ.faqId = faq["FaqID"] as? Int ?? 0
                        newFAQ.faqUrl = faq["FaqURL"] as? String ?? ""
                        newFAQ.faqText = faq["FaqQuestion"] as? String ?? ""
                        
                        faqList.append(newFAQ)
                    }
                    
                    CompletionHandler(true, faqList as AnyObject)
                    return

                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
        
    }
    
    // For check Job set
    class func checkJobRegAPI( requestObj: AnyObject ,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            //UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.SEARCH_JOB_API, httpMethod: HttpMethod.POST, requestBody: requestObj, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
              //  UIApplication.shared.stopNetworkActivity()
                if let isJobRegistred = responsedata["HasCompletedJobRegistration"] as? String {
                    if isJobRegistred == "True" {
                        UserDefaults.standard.set(true, forKey: Constants.defaults.IsFindJobSet)
                    } else {
                        UserDefaults.standard.set(false, forKey: Constants.defaults.IsFindJobSet)
                    }
                }
                
                CompletionHandler(true, "" as AnyObject)
                    return
                }
            }
            
            CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
        }
        
    
    
    // For Search Job
    class func searchJobAPI(showLoadingIndicator: Bool , requestObj: AnyObject ,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            if showLoadingIndicator {
                UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            }
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.SEARCH_JOB_API, httpMethod: HttpMethod.POST, requestBody: requestObj, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                var jobList = [JobModel]()
                
                if showLoadingIndicator {
                    UIApplication.shared.stopNetworkActivity()
                }
                
                let totalRecord = responsedata["TotalNumberRecord"] as? Int ?? 0
                
                if let response = responsedata["Jobs"] as? [Dictionary<String,AnyObject>]{
                    for job in response {
                        let newJob = JobModel()
                        if job["JobDescription"] != nil && !(job["JobDescription"] is NSNull) {
                            newJob.jobDescription = job["JobDescription"] as! String
                        }
                        if job["JobID"] != nil && !(job["JobID"] is NSNull) {
                            newJob.jobId = job["JobID"] as! Int
                        }
                        if job["JobRequirement"] != nil && !(job["JobRequirement"] is NSNull) {
                            newJob.jobRequirment = job["JobRequirement"] as! String
                        }
                        if job["JobTitle"] != nil && !(job["JobTitle"] is NSNull) {
                            newJob.jobTitle = job["JobTitle"] as! String
                        }
                        if job["MaxSalary"] != nil && !(job["MaxSalary"] is NSNull) {
                            newJob.maxSalary = job["MaxSalary"] as! Int
                        }
                        if job["MinSalary"] != nil && !(job["MinSalary"] is NSNull) {
                            newJob.minSalary = job["MinSalary"] as! Int
                        }
                        if job["NumberOfVacancies"] != nil && !(job["NumberOfVacancies"] is NSNull) {
                            newJob.numberOfVaccancies = job["NumberOfVacancies"] as! Int
                        }
                        if job["YearOfExperience"] != nil && !(job["YearOfExperience"] is NSNull) {
                            newJob.yearOfExperience = job["YearOfExperience"] as! Int
                        }
                        if job["WorkerType"] != nil && !(job["WorkerType"] is NSNull) {
                            newJob.workerType = job["WorkerType"] as! String
                        }
                        if job["PostingDate"] != nil && !(job["PostingDate"] is NSNull) {
                            var dateString = job["PostingDate"] as! String
                            dateString = dateString.replacingOccurrences(of: "/Date(", with: "")
                            dateString = dateString.replacingOccurrences(of: ")/", with: "")
                            let timeArray = dateString.components(separatedBy: "+")
                            newJob.postingDate = Date(timeIntervalSince1970: (Double(timeArray[0])!/1000))
                        }
                        newJob.jobCount = totalRecord
                        jobList.append(newJob)
                    }
                    CompletionHandler(true, jobList as AnyObject)
                    return
                }
            }
            
            CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
        }
        
    }

    
    class func getData( api: String, requestBody: AnyObject?, CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
//            UIApplication.shared.startNetworkActivity(info: "Updating Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName: api, httpMethod: HttpMethod.GET, requestBody: requestBody, contentType: CommonValues.jsonApplication){ (responsedata) in
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? [[String: AnyObject]]{
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
    }
    
    class func postData( api: String, requestBody: AnyObject?, CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Updating Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName: api, httpMethod: HttpMethod.POST, requestBody: requestBody, contentType: CommonValues.jsonApplication){ (responsedata) in
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
    }
    
    
    // Apply for job
    class func applyJobAPI( requestObj: AnyObject , CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Updating Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.APPLY_JOB_API, httpMethod: HttpMethod.POST, requestBody: requestObj as AnyObject, contentType: CommonValues.jsonApplication){ (responsedata) in
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
        
    }
    
    
    // For Get job profile
    class func getJobProfileAPI(requestObj: AnyObject ,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
//            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.GET_JOB_PROFILE, httpMethod: HttpMethod.POST, requestBody: requestObj, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                return
            }
            
        }
        
    }
    
    // For change password
    class func changePassword(requestObj: AnyObject ,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.CHANGE_PASSWORD, httpMethod: HttpMethod.POST, requestBody: requestObj, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                return
            }
        }
    }
    
    // For forgot password
    class func forgotPassword(requestObj: AnyObject ,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.FORGOT_PASSWORD, httpMethod: HttpMethod.POST, requestBody: requestObj, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                return
            }
        }
    }
    
    // For email login
    class func loginAuthentication(requestObj: AnyObject ,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.EMAIL_LOGIN_AUTHENTICAITON, httpMethod: HttpMethod.POST, requestBody: requestObj, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                return
            }
        }
    }
    
    // For email login
    class func notificationInbox(requestObj: AnyObject ,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
//            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.NOTIFICATION_INBOX, httpMethod: HttpMethod.POST, requestBody: requestObj, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
//                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                return
            }
        }
    }
    
    class func dashboardData(requestObj: AnyObject ,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.DASHBOARD, httpMethod: HttpMethod.POST, requestBody: requestObj, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                return
            }
        }
    }
    
    // For register now
    class func registerNow(requestObj: AnyObject ,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName: Constants.UrlConfig.CREATE_ACCOUNT, httpMethod: HttpMethod.POST, requestBody: requestObj, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                return
            }
        }
    }
    
    // For Applied jobs
    class func getAppliedJobAPI(url:String,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.GET_APPLIED_JOB + url, httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata["Jobs"] as? [Dictionary<String,AnyObject>]{
                    var jobList = [JobModel]()
                    for job in response {
                        let newJob = JobModel()
                        if job["AppliedOn"] != nil && !(job["AppliedOn"] is NSNull) {
                            var dateString = job["AppliedOn"] as! String
                            dateString = dateString.replacingOccurrences(of: "/Date(", with: "")
                            dateString = dateString.replacingOccurrences(of: ")/", with: "")
                            let timeArray = dateString.components(separatedBy: "+")
                            newJob.appliedOn = Date(timeIntervalSince1970: (Double(timeArray[0])!/1000))
                        }
                        if job["JobID"] != nil && !(job["JobID"] is NSNull) {
                            newJob.jobId = job["JobID"] as! Int
                        }
                        if job["JobApplicationStatusDesc"] != nil && !(job["JobApplicationStatusDesc"] is NSNull) {
                            newJob.status = job["JobApplicationStatusDesc"] as! String
                        }
                        if job["JobTitle"] != nil && !(job["JobTitle"] is NSNull) {
                            newJob.jobTitle = job["JobTitle"] as! String
                        }
                        if job["MaxSalary"] != nil && !(job["MaxSalary"] is NSNull) {
                            newJob.maxSalary = job["MaxSalary"] as! Int
                        }
                        if job["MinSalary"] != nil && !(job["MinSalary"] is NSNull) {
                            newJob.minSalary = job["MinSalary"] as! Int
                        }
                        if job["NumberOfVacancies"] != nil && !(job["NumberOfVacancies"] is NSNull) {
                            newJob.numberOfVaccancies = job["NumberOfVacancies"] as! Int
                        }
                        if job["YearOfExperience"] != nil && !(job["YearOfExperience"] is NSNull) {
                            newJob.yearOfExperience = job["YearOfExperience"] as! Int
                        }
                        
                        jobList.append(newJob)
                    }
                    CompletionHandler(true, jobList as AnyObject)
                    return
                }
            }
            
            CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
        }
        
    }
        
    
    // Update fin number
    class func updateFinAPI( requestObj: AnyObject , CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Updating Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.UPDATE_FIN_API, httpMethod: HttpMethod.POST, requestBody: requestObj as AnyObject, contentType: CommonValues.jsonApplication){ (responsedata) in
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    let jsonResponse = responsedata
                    if let status = jsonResponse["Code"] as? String {
                        if status == "1"{
                            var message = ""
                            if jsonResponse["ResultText"] != nil && !(jsonResponse["ResultText"] is NSNull) {
                                message = jsonResponse["ResultText"] as! String
                            }
                            CompletionHandler(true, message as AnyObject)
                            return
                        }
                    }
                }
                
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                return
                
            }
        }
        
    }
    
    class func getHousingAPI(CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject) ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.HOUSING_API + "\(UserDefaults.standard.string(forKey: Constants.defaults.selectedLanguage) ?? "English")", httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
        
    }

    class func getWorkInjuryAPI(CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject) ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.INJURYMATTER_API + "\(UserDefaults.standard.string(forKey: Constants.defaults.selectedLanguage) ?? "English")", httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
    }
    
    class func getSalaryMattersAPI(CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject) ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.SALARY_MATTER_API + "\(UserDefaults.standard.string(forKey: Constants.defaults.selectedLanguage) ?? "English")", httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
    }
    
    //for generic logging
    class func genericLoggingAPI(requestObj: AnyObject ,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.GENERIC_LOGGING, httpMethod: HttpMethod.POST, requestBody: requestObj, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    print("respectedResponse:\(response)")
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                return
            }
        }
    }
    
    class func getDormsInfo(CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject) ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.DORMS_INFO + "\(dormsiloID)", httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
    }
    
    class func getDormsRulesAndRegulations(CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject) ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.DORMS_RULES_AND_REGULATIONS + "\(dormsiloID)", httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
    }
    
    class func getDormsGuidelines(CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject) ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.DORMS_GUIDELINES + "\(dormsiloID)", httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
    }
    
    class func getDormsFAQs(CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject) ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.DORMS_FAQs + "\(dormsiloID)", httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
    }
    
    class func getDormsContacts(CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject) ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.DORMS_CONTACTS + "\(dormsiloID)", httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
    }
    
    class func setFeedbacktoDormsApi( requestObj: AnyObject , CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Updating Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.DORMS_FEEDBACK, httpMethod: HttpMethod.POST, requestBody: requestObj as AnyObject, contentType: CommonValues.jsonApplication){ (responsedata) in
                UIApplication.shared.stopNetworkActivity()
                if responsedata is Dictionary<String,AnyObject>{
                    let jsonResponse = responsedata
                    if let status = jsonResponse["Code"] as? String {
                        if status == "1"{
                            var message = ""
                            if jsonResponse["ResultText"] != nil && !(jsonResponse["ResultText"] is NSNull) {
                                message = jsonResponse["ResultText"] as! String
                            }
                            CompletionHandler(true, message as AnyObject)
                            return
                        }
                        CompletionHandler(false, jsonResponse["ResultText"] as AnyObject)
                    }
                }
                
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
        
    }
    
    class func notificationInboxGroupedByDate(requestObj: AnyObject ,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.NOTIFICATION_INBOX_NEW, httpMethod: HttpMethod.POST, requestBody: requestObj, contentType: CommonValues.jsonApplication){ (responsedata) in
                
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    //print("Notification inbox: \(responsedata)")
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                return
            }
        }
    }

    class func notificationJobApply(requestObj: AnyObject ,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            //            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.NOTIFICATION_JOB_APPLY, httpMethod: HttpMethod.POST, requestBody: requestObj, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                //                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                return
            }
        }
    }
    
    class func jtcList(languageID: Int, tokenID: String, CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject) ->())) {
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        } else {
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.JTC_LIST + "\(languageID)/" + tokenID, httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                print("get JTC_LIST API:\(Constants.UrlConfig.JTC_LIST + "\(languageID)/" + tokenID)")
                if let response = responsedata as? Dictionary<String,AnyObject> {
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
    }
    
    class func recreationEvents(languageID: Int, CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject) ->())) {
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.RECREATION_EVENT + "\(recreationId)/\(languageID)", httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                print("get event API:\(Constants.UrlConfig.RECREATION_EVENT + "\(recreationId)/\(languageID)")")
                if let response = responsedata as? NSArray{
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
    }
    
    class func recreationPromotions(languageID: Int, CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject) ->())) {
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.RECREATION_PROMOTIONS + "\(recreationId)/\(languageID)", httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                 print("get promotion API:\(Constants.UrlConfig.RECREATION_PROMOTIONS + "\(recreationId)/\(languageID)")")
                if let response = responsedata as? NSArray{
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
    }
    
    class func recreationFacilities(languageID: Int, CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject) ->())) {
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.RECREATION_FACILITIES + "\(recreationId)/\(languageID)", httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                 print("get facilities API:\(Constants.UrlConfig.RECREATION_FACILITIES + "\(recreationId)/\(languageID)")")
                if let response = responsedata as? NSArray{
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
    }
    
    class func recreationTransport(languageID: Int, CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject) ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.RECREATION_TRANSPORT + "\(recreationId)/\(languageID)", httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                 print("get transport API:\(Constants.UrlConfig.RECREATION_TRANSPORT + "\(recreationId)/\(languageID)")")
                if let response = responsedata as? NSArray{
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
    }
    
    class func suggestionBoxJTC( requestObj: AnyObject , CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Updating Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.RECREATION_SUGGESTION_BOX, httpMethod: HttpMethod.POST, requestBody: requestObj as AnyObject, contentType: CommonValues.jsonApplication){ (responsedata) in
                UIApplication.shared.stopNetworkActivity()
                if responsedata is Dictionary<String,AnyObject>{
                    let jsonResponse = responsedata
                    if let status = jsonResponse["Code"] as? String {
                        if status == "1"{
                            var message = ""
                            if jsonResponse["ResultText"] != nil && !(jsonResponse["ResultText"] is NSNull) {
                                message = jsonResponse["ResultText"] as! String
                            }
                            CompletionHandler(true, message as AnyObject)
                            return
                        }
                        CompletionHandler(false, jsonResponse["ResultText"] as AnyObject)
                    }
                }
                
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
        
    }
    
    class func eWalletQRCode(requestObj: AnyObject ,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.EWALLET_QRCODE, httpMethod: HttpMethod.POST, requestBody: requestObj, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                return
            }
        }
    }
    
    class func getNetworkList(tokenID: String, CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject) ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        } else {
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.NETWORK_LIST + tokenID, httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                print("network list", responsedata)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
    }
    
    class func getNetworkProductList(urlString: String, CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject) ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            //UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName: urlString, httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                print("network product list", responsedata)
               // UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject> {
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
    }
    
    class func getNetworkUserDetails(urlString: String, CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject) ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName: urlString, httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                print("user details data", responsedata)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
    }
    
    class func topUpInsertAPI(requestObj: AnyObject ,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
           // UIApplication.shared.startNetworkActivity(info: "Uploading Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.NETWORK_TOPUP_INSERT, httpMethod: HttpMethod.POST, requestBody: requestObj, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
           //     UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                return
            }
        }
    }
    
    class func topUpUpdateAPI(requestObj: AnyObject ,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
          //  UIApplication.shared.startNetworkActivity(info: "Uploading Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.NETWORK_TOPUP_UPDATE, httpMethod: HttpMethod.POST, requestBody: requestObj, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
             //   UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                return
            }
        }
    }
    
    class func getTopUpHistory(requestObj: AnyObject ,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject) ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
              UIApplication.shared.startNetworkActivity(info: "Uploading Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName: Constants.UrlConfig.NETWORK_TRANSACTION_HISTORY, httpMethod: HttpMethod.POST, requestBody: requestObj, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                   UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject> {
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                return
            }
        }
    }
    
    class func updateErrorLog(requestObj: AnyObject ,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            //  UIApplication.shared.startNetworkActivity(info: "Uploading Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.NETWORK_ERROR_LOG, httpMethod: HttpMethod.POST, requestBody: requestObj, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                //   UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                return
            }
        }
    }
    
    class func getPaymentModes(urlString: String, CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject) ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName: urlString, httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                print("payment modes list", responsedata)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject> {
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
            }
        }
    }
    
    class func QRCodeWalletTransfer(requestObj: AnyObject ,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
              UIApplication.shared.startNetworkActivity(info: "")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.QRCODE_WALLET_TRANSFER, httpMethod: HttpMethod.POST, requestBody: requestObj, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                return
            }
        }
    }
    
    class func walletUserDetails(urlString: String, QRCodeOrEmail: String, requestCode: Int, CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName: urlString + "\(QRCodeOrEmail)/" + "\(requestCode)", httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject> {
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
            }
        }
    }
    
    class func getCountryList(CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName: Constants.UrlConfig.GET_COUNTRY_LIST, httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? NSArray {
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
            }
        }
    }
    
    class func telcoTopupNotification(requestObj: AnyObject ,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            // UIApplication.shared.startNetworkActivity(info: "Uploading Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.TELCO_TOPUP_NOTIFICATION, httpMethod: HttpMethod.POST, requestBody: requestObj, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                //     UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                return
            }
        }
    }
    
    class func GetDenominationList(urlString :String, CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName: urlString, httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject> {
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
            }
        }
    }
    
    class func updateLanguageToServer(requestObj: AnyObject ,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
             UIApplication.shared.startNetworkActivity(info: "Uploading Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.UPDATE_USER_PROFILE, httpMethod: HttpMethod.POST, requestBody: requestObj, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                return
            }
        }
    }
    
    class func getQRCodeDetails(urlString: String, CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject) ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName: urlString, httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                print("QRCode details data", responsedata)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
    }
    
    class func paymentConfirmDetails(urlString: String, CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject) ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName: urlString, httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                print("payment confirm data", responsedata)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
    }
    
    class func myCreditDenomination(urlString: String, CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject) ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName: urlString, httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                print("myCreditDenomination data", responsedata)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
    }
    
    class func getTransactionStatement(requestObj: AnyObject ,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            // UIApplication.shared.startNetworkActivity(info: "Uploading Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.GET_TRANSACTION_STATEMENT, httpMethod: HttpMethod.POST, requestBody: requestObj, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                //     UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                return
            }
        }
    }
    
    class func getRDPKeys(urlString: String, CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject) ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            NetworkUtilities.sendAsynchronousRequestToServer(actionName: urlString, httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                print("getRDPKeys data", responsedata)
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
    }
    
    class func getNETSPayKeys(urlString: String, CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject) ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            NetworkUtilities.sendAsynchronousRequestToServer(actionName: urlString, httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                print("getNETSPayKeys data", responsedata)
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
    }

    class func notificationRedirection(urlString: String, CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject) ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            //UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName: urlString, httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                print("notificationRedirection", responsedata)
                // UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject> {
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
    }
    
    class func getNotificationCount(urlString: String, CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject) ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            //UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName: urlString, httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                print("notificationRedirection", responsedata)
                // UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject> {
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                
            }
        }
    }
    
    class func updateWorkerTransferLetter(requestObj: AnyObject ,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Uploading Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.UPDATE_WORKER_TRANSFER_LETTER, httpMethod: HttpMethod.POST, requestBody: requestObj, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                return
            }
        }
    }
    
    //************MCOMMERCE**************//
    
    class func updateProductToWishlist(requestObj: AnyObject ,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
           // UIApplication.shared.startNetworkActivity(info: "")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.ADD_WISHLIST_TO_PRODUCT, httpMethod: HttpMethod.POST, requestBody: requestObj, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
               // UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                return
            }
        }
    }
    
    class func getWishlist(showLoadingIndicator: Bool, requestObj: AnyObject ,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            if showLoadingIndicator {
                UIApplication.shared.startNetworkActivity(info: "")
            }
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.GET_WISHLIST, httpMethod: HttpMethod.POST, requestBody: requestObj, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                if showLoadingIndicator {
                    UIApplication.shared.stopNetworkActivity()
                }
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                return
            }
        }
    }
    
    class func getEvoucherDetail(requestObj: AnyObject ,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.EVOUCHER_DETAIL, httpMethod: HttpMethod.POST, requestBody: requestObj, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                return
            }
        }
    }
    
    class func purchaseNow(requestObj: AnyObject ,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.PURCHASE_NOW, httpMethod: HttpMethod.POST, requestBody: requestObj, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                return
            }
        }
    }
    
    class func updateCartQuantity(requestObj: AnyObject ,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.UPDATE_CART_QUANTITY, httpMethod: HttpMethod.POST, requestBody: requestObj, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                return
            }
        }
    }
    
    class func getTransactionList(start: String,count: String,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject) ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.GET_PURCHASE_HISTORY_API + "\(start)/\(count)", httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
            }
        }
    }
    
    class func getSubCategoryList(urlString:String, CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject) ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName: urlString, httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication){ (responsedata) in
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
            }
        }
    }
    
    class func rateProduct(requestObj: AnyObject ,CompletionHandler:@escaping ((_ success: Bool, _ data: AnyObject)
        ->())) {
        
        if !NetworkUtilities.hasConnectivity() {
            CompletionHandler(false, Constants.errorMessage.noInternetMessage as AnyObject)
        }else{
            UIApplication.shared.startNetworkActivity(info: "Fetching Data")
            NetworkUtilities.sendAsynchronousRequestToServer(actionName:  Constants.UrlConfig.RATE_PRODUCT, httpMethod: HttpMethod.POST, requestBody: requestObj, contentType: CommonValues.jsonApplication){ (responsedata) in
                //print(jsonResponse)
                UIApplication.shared.stopNetworkActivity()
                if let response = responsedata as? Dictionary<String,AnyObject>{
                    
                    CompletionHandler(true, response as AnyObject)
                    return
                }
                CompletionHandler(false, Constants.errorMessage.commonMessage as AnyObject)
                return
            }
        }
    }


}
