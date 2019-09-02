//
//  Page1ListViewController.swift
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
import Alamofire
import Kingfisher

protocol Page1ListViewControllerInterface: class
{
    func displayPage1(viewModel: Page1Model.GetAPI.ViewModel)
    func sortPhonePage1(viewModel: Page1Model.Sort.ViewModel)
}

class Page1ListViewController: UIViewController, Page1ListViewControllerInterface
{
  var interactor: Page1ListInteractor!
  var router: Page1ListRouter!
  var displayedPhones: [DisplayedPhone] = []
    
    @IBOutlet weak var tableView: UITableView!

  // MARK: Object lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup(viewController: self)
    }
  
  // MARK: Setup
  
    private func setup(viewController: Page1ListViewController)
  {
    let router = Page1ListRouter()
    router.viewController = viewController
    
    let presenter = Page1ListPresenter()
    presenter.viewController = viewController
    
    let interactor = Page1ListInteractor()
    interactor.presenter = presenter

    viewController.interactor = interactor
    viewController.router = router
  }
  
  // MARK: Routing
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    interactor.feedAPI(request: Page1Model.GetAPI.Request())
  }
  
  func displayPage1(viewModel: Page1Model.GetAPI.ViewModel)
  {
    if viewModel.success{
        displayedPhones = viewModel.json
        tableView.reloadData()
        print("Page1 Phone: \(displayedPhones)")
    }else{
        createAlert(title: "Error", message: "Can not reload data")
    }
  }
    
    func createAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
    }
    
    func sortPhonePage1(viewModel: Page1Model.Sort.ViewModel) {
        displayedPhones = viewModel.array
        tableView.reloadData()
    }
    
    @IBAction func actionSort(_ sender: Any) {
//        var sortCase : Int
        let alert = UIAlertController(title: "Sort",
                                      message: "",
                                      preferredStyle: .alert)
         let sortLowtoHight = UIAlertAction(title: "Price low to Hight", style: .default) { (action) -> Void in
            let sort = Page1Model.Sort.Request(sortCase: 1)
            self.interactor.sortPhone(request: sort)
        }
        
        let sortHighttoLow = UIAlertAction(title: "Price hight to low", style: .default,handler: { (action) -> Void in
            let sort = Page1Model.Sort.Request(sortCase: 2)
            self.interactor.sortPhone(request: sort)
        })
        let sortRating = UIAlertAction(title: "Rating", style: .default,handler: { (action) -> Void in
            let sort = Page1Model.Sort.Request(sortCase: 3)
            self.interactor.sortPhone(request: sort)
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        
        alert.addAction(sortLowtoHight)
        alert.addAction(sortHighttoLow)
        alert.addAction(sortRating)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let page2 : [DisplayedPhone] = displayedPhones
        router.passDataToPage2Details(displayPhone: page2, segue: segue)
    }
}

// Display logic

extension Page1ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedPhones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Page1TableViewCell
        let product: DisplayedPhone = displayedPhones[indexPath.item]
        cell.nameLabel.text = product.name
        cell.descriptionLabel.text = product.description
        cell.priceLabel.text = "Price: $\(product.price)"
        cell.ratingLabel.text = "Rating: \(product.rating)"
        cell.productImageView.kf.setImage(with: URL(string: product.thumbImageURL))
        return cell
    }
}

extension Page1ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}