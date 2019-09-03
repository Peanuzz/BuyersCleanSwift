//
//  Page2DetailsPresenter.swift
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

protocol Page2DetailsPresenterInterface
{
  func presentDeatails(response: Page2Model.showDetails.Response)
    func presentImage(response: Page2Model.GetAPIImage.Response)
}

class Page2DetailsPresenter: Page2DetailsPresenterInterface
{
  weak var viewController: Page2DetailsViewControllerInterface?
  
  // MARK: Do something
  
  func presentDeatails(response: Page2Model.showDetails.Response)
  {
    let viewModel =  Page2Model.showDetails.ViewModel(json: response.json)
    print("viewmodel : \(viewModel)")
    viewController?.displayPhone(viewModel: viewModel)
  }
    
    func presentImage(response: Page2Model.GetAPIImage.Response) {
        let displayedsImage: [DisplayedImage] = response.json.map() { phone in
            DisplayedImage(url: phone.url)
        }
        let viewModel = Page2Model.GetAPIImage.ViewModel(success: true, json: displayedsImage)
        viewController?.displayImage(viewModel: viewModel)
    }
}

