import XCTest
@testable import UIDiscussion

class OverviewPresenterTests: XCTestCase {
    let displaying = OverviewDisplayingSpy()
    lazy var sut: OverviewPresenter = {
        let sut = OverviewPresenter()
        sut.display = displaying
        return sut
    }()
    
    func testIfAccountOwnerIs_JanisZisenis_OnViewDidLoad_ShouldDisplayJanisZisenisAsAccountOwner() {
        let owner = AccountOwner(firstName: "Janis", familyName: "Zisenis")
        let request = OverviewModel.ViewDidLoad.Response(owner: owner, balance: 0)
        
        sut.presentViewDidLoad(request)
        
        XCTAssert(displaying.receivedViewDidLoadViewModel.firstName == "Janis")
        XCTAssert(displaying.receivedViewDidLoadViewModel.familyName == "Zisenis")
    }
    
    func testIfAccountOwnerIs_JaneDoe_OnViewDidLoad_ShouldDisplayJaneDoeAsAccountOwner() {
        let owner = AccountOwner(firstName: "Jane", familyName: "Doe")
        let request = OverviewModel.ViewDidLoad.Response(owner: owner, balance: 0)
        
        sut.presentViewDidLoad(request)
        
        XCTAssert(displaying.receivedViewDidLoadViewModel.firstName == "Jane")
        XCTAssert(displaying.receivedViewDidLoadViewModel.familyName == "Doe")
    }
    
    func testIfBalanceIs_10_OnViewDidLoad_ShouldDisplayABalanceOf10WithTheColorGreen() {
        let owner = AccountOwner(firstName: "Some", familyName: "Name")
        let balance: Double = 10
        let request = OverviewModel.ViewDidLoad.Response(owner: owner, balance: balance)
        
        sut.presentViewDidLoad(request)
        
        XCTAssert(displaying.receivedViewDidLoadViewModel.balance.balance == "€10.00")
        XCTAssert(displaying.receivedViewDidLoadViewModel.balance.balanceColor == .green)
    }
    
    func testIfBalanceIs_Minus10_OnViewDidLoad_ShouldDisplayABalanceOfMinus10WithTheColorRed() {
        let owner = AccountOwner(firstName: "Some", familyName: "Name")
        let balance: Double = -10
        let request = OverviewModel.ViewDidLoad.Response(owner: owner, balance: balance)
        
        sut.presentViewDidLoad(request)
        
        XCTAssert(displaying.receivedViewDidLoadViewModel.balance.balance == "-€10.00")
        XCTAssert(displaying.receivedViewDidLoadViewModel.balance.balanceColor == .red)
    }
    
    func testIfBalanceIs_0_OnViewDidLoad_ShouldDisplayABalanceOf0WithTheColorBlack() {
        let owner = AccountOwner(firstName: "Some", familyName: "Name")
        let balance: Double = 0
        let request = OverviewModel.ViewDidLoad.Response(owner: owner, balance: balance)
        
        sut.presentViewDidLoad(request)
        
        XCTAssert(displaying.receivedViewDidLoadViewModel.balance.balance == "€0.00")
        XCTAssert(displaying.receivedViewDidLoadViewModel.balance.balanceColor == .black)
    }
    
    func testIfBalanceIs_10_OnWithDraw_ShouldDisplayABalanceOf10WithTheColorGreen() {
        let balance: Double = 10
        let request = OverviewModel.WithDraw.Response(balance: balance)
        
        sut.presentWithDraw(request)
        
        XCTAssert(displaying.receivedWithDrawViewModel.balance.balance == "€10.00")
        XCTAssert(displaying.receivedWithDrawViewModel.balance.balanceColor == .green)
    }
    
    func testIfBalanceIs_Minus10_ShouldDisplayABalanceOfMinus10WithTheColorRed() {
        let balance: Double = -10
        let request = OverviewModel.WithDraw.Response(balance: balance)
        
        sut.presentWithDraw(request)
        
        XCTAssert(displaying.receivedWithDrawViewModel.balance.balance == "-€10.00")
        XCTAssert(displaying.receivedWithDrawViewModel.balance.balanceColor == .red)
    }
    
    func testIfBalanceIs_0_ShouldDisplayABalanceOf0WithTheColorBlack() {
        let balance: Double = 0
        let request = OverviewModel.WithDraw.Response(balance: balance)
        
        sut.presentWithDraw(request)
        
        XCTAssert(displaying.receivedWithDrawViewModel.balance.balance == "€0.00")
        XCTAssert(displaying.receivedWithDrawViewModel.balance.balanceColor == .black)
    }
}
