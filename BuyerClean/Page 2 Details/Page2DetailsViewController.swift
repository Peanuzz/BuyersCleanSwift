//
//  Page2DetailsViewController.swift
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

protocol Page2DetailsViewControllerInterface: class
{
    func displayPhone(viewModel: Page2Model.showDetails.ViewModel)
    func displayImage(viewModel: Page2Model.GetAPIImage.ViewModel)
}

class Page2DetailsViewController: UIViewController, Page2DetailsViewControllerInterface
{
    
    var interactor: Page2DetailsInteractorInterface!
    var router: Page2DetailsRouter!
    var phone : Phone!
    var displayedImage: [DisplayedImage] = []
    
    @IBOutlet weak var mCollectionView:UICollectionView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

  // MARK: Object lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup(viewController: self)
    }
  
  // MARK: Setup
  
    private func setup(viewController: Page2DetailsViewController)
  {
    let router = Page2DetailsRouter()
    router.viewController = viewController
    
    let presenter = Page2DetailsPresenter()
    presenter.viewController = viewController
    
    let interactor = Page2DetailsInteractor()
    interactor.presenter = presenter
    
    viewController.interactor = interactor
    viewController.router = router
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    router.passDataToNextScene(segue: segue)
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    interactor.showDetails(request: Page2Model.showDetails.Request())
  }
  
  // MARK: Do something
  
  func displayPhone(viewModel: Page2Model.showDetails.ViewModel)
  {
    phone = viewModel.json
    descriptionLabel.text = phone?.description
    priceLabel.text = "Price: $\(phone!.price)"
    rateLabel.text = "Rating: \(phone!.rating)"
    let id = Page2Model.GetAPIImage.Request(id: phone.id)
    self.interactor.feedAPI(request: id)
  }
    
    func displayImage(viewModel: Page2Model.GetAPIImage.ViewModel) {
        if viewModel.success{
            displayedImage = viewModel.json
            mCollectionView.reloadData()
        }else{
            createAlert(title: "Error", message: "Can not reload image")
        }
    }
    
    func createAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
    }
}

extension Page2DetailsViewController:UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Page2ImageCollectionViewCell
        let item = displayedImage[indexPath.row]
        let url = item.url
        if url.contains("http"){
            cell.mImage.kf.setImage(with: URL(string: url))
        } else {
            cell.mImage.kf.setImage(with: URL(string: "http://\(url)"))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
}
