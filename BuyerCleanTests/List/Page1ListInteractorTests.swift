//
//  Page1ListInteractorTests.swift
//  BuyerClean
//
//  Created by Peanuz on 4/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import BuyerClean
import XCTest

class Page1ListInteractorTests: XCTestCase
{
  // MARK: Subject under test
  var sut: Page1ListInteractor!
  var presenterSpy: Page1ListPresenterSpy!
  let array : [Phone] = getPhoneList()
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupPage1ListInteractor()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupPage1ListInteractor()
  {
    sut = Page1ListInteractor()
    presenterSpy = Page1ListPresenterSpy()
    sut.presenter = presenterSpy
  }
  
  // MARK: Test doubles
  class WokerSpy: Page1WokerAPI {
    var workerCalled = false
    
    override func getAPI(completion: @escaping (Result<[Phone], Error>) -> Void) {
      workerCalled = true
      completion(.success([Phone(rating: 4.6, id: 1, thumbImageURL: "URL1", price: 179.99, brand: "Moto", name: "Moto E4 Plus", description: "First place")]))
    }
  }
  
  class Page1ListPresenterSpy: Page1ListPresenterInterface {
    var presentPage1Called = false
    var sortPage1Called = false
    var passSelectedCalled = false
    var apiResponse: Page1Model.GetAPI.Response?
    var sortPhone: Page1Model.Sort.Response?
    
    func presentPage1(response: Page1Model.GetAPI.Response) {
      presentPage1Called = true
      apiResponse = response
    }
    
    func sortPage1(response: Page1Model.Sort.Response) {
      sortPage1Called = true
      sortPhone = response
    }
    
    func passSelected() {
      passSelectedCalled = true
    }
  }
  
  // MARK: Tests
  
  func testFeedAPI() {
    //Given
    sut.worker = WokerSpy()
//    sut.feedAPI(request: Page1Model.GetAPI.Request())
    let request = Page1Model.GetAPI.Request()
    
    sut.feedAPI(request: request)
    
    //Then
    if let mockData = presenterSpy.apiResponse {
      let data = Phone(rating: 4.6, id: 1, thumbImageURL: "URL1", price: 179.99, brand: "Moto", name: "Moto E4 Plus", description: "First place")
      XCTAssertTrue(mockData.success)
      XCTAssertEqual(mockData.json, [data])
      XCTAssertEqual(mockData.json.count, 1)
    } else {
      XCTFail()
    }
    
  }
  
  func testLowToHight() {
    //Given
    sut.phons = array
    
    let lowToHight = Page1Model.Sort.Request.sortCase.lowToHight

    //When
    sut.sortPhone(request: lowToHight)

    //Then
    if let sort = presenterSpy.sortPhone {
      XCTAssertEqual(sort.sortPhone[0].price, 165.0)
      XCTAssertEqual(sort.sortPhone[1].price, 179.99)
      XCTAssertEqual(sort.sortPhone[2].price, 199.99)
    } else {
      XCTFail()
    }
  }
  
  func testHightToLow() {
    //Given
    sut.phons = array
    
    let hightToLow = Page1Model.Sort.Request.sortCase.hightToLow
    
    //When
    sut.sortPhone(request: hightToLow)
    
    //Then
    if let sort = presenterSpy.sortPhone {
      XCTAssertEqual(sort.sortPhone[0].price, 199.99)
      XCTAssertEqual(sort.sortPhone[1].price, 179.99)
      XCTAssertEqual(sort.sortPhone[2].price, 165.0)
    } else {
      XCTFail()
    }
  }
  
  func testRating() {
    //Given
    sut.phons = array
    
    let rating = Page1Model.Sort.Request.sortCase.raing
    
    //When
    sut.sortPhone(request: rating)
    
    //Then
    if let sort = presenterSpy.sortPhone {
      XCTAssertEqual(sort.sortPhone[0].rating, 5.0)
      XCTAssertEqual(sort.sortPhone[1].rating, 4.7)
      XCTAssertEqual(sort.sortPhone[2].rating, 3.8)
    } else {
      XCTFail()
    }
  }
}

private func getPhoneList() -> [Phone] {
  var array : [Phone] = []
  array = [Phone(rating: 5.0, id: 1, thumbImageURL: "URL1", price: 179.99, brand: "Moto", name: "Moto E4 Plus", description: "First place"),
           Phone(rating: 3.8, id: 2, thumbImageURL: "URL2", price: 199.99, brand: "Nokia", name: "Nokia 6", description: "Nokia is back"),
           Phone(rating: 4.7, id: 3, thumbImageURL: "URL3", price: 165.0, brand: "Moto", name: "Moto G5", description: "Motorola's")]
  return array
}