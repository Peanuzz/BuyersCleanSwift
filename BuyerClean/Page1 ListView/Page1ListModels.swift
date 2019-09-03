//
//  Page1ListModels.swift
//  BuyerClean
//
//  Created by Peanuz on 30/8/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import SwiftyJSON

enum Page1Model{
  struct GetAPI{
    struct Request : Codable{}
    struct Response
    {
        var success: Bool
        var json: Array<Phone>
    }
    struct ViewModel
    {
        var success: Bool
        var json : Array<DisplayedPhone>
    }
  }
    
    struct Sort {
        struct Request
        {
            var sortCase: Int
        }
        struct Response
        {
            var sortPhone: Array<Phone>
        }
        struct ViewModel
        {
            var array: Array<DisplayedPhone>
        }
    }
    
    struct Selected {
        struct Request
        {
            var indexPath: Int
        }
        struct Response
        {
            
        }
        struct ViewModel
        {
            
        }
    }
}
