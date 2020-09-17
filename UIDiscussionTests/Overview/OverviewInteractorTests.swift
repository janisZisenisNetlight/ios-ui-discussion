import XCTest
@testable import UIDiscussion

class OverviewInteractorTests: XCTestCase {
    let presenting = OverViewPresentingSpy()
    let account = BankAccountSpy()
    let routing = OverviewRoutingSpy()
    lazy var sut = OverviewInteractor(presenter: presenting, account: account, router: routing)
    
    func testHandleShowHistory_ShouldRouteToHistoryWithItsAccount() throws {
        let request = OverviewModel.RouteToHistory.Request()
        
        sut.handleRouteToHistory(request)
        
        let actual = routing.receivedHistory
        let expected = account
        XCTAssert(actual === expected)
    }
    
    func testIfAccountOwnerIs_JanisZisenis_ShouldPresentViewDidLoadWithJanisZisenisAsOwner() throws {
        let request = OverviewModel.ViewDidLoad.Request()
        account.stubbedOwner = AccountOwner(firstName: "Janis", familyName: "Zisenis")
        account.stubbedBalance = 0
        
        sut.handleViewDidLoad(request)
        
        let actual = presenting.receivedViewDidLoadResponse.owner
        let expected = AccountOwner(firstName: "Janis", familyName: "Zisenis")
        XCTAssert(actual == expected)
    }
    
    func testIfAccountOwnerIs_JaneDoe_ShouldPresentViewDidLoadWithJaneDoeAsOwner() throws {
        let request = OverviewModel.ViewDidLoad.Request()
        account.stubbedOwner = AccountOwner(firstName: "Jane", familyName: "Doe")
        account.stubbedBalance = 0
        
        sut.handleViewDidLoad(request)
        
        let actual = presenting.receivedViewDidLoadResponse.owner
        let expected = AccountOwner(firstName: "Jane", familyName: "Doe")
        XCTAssertEqual(actual, expected)
    }
    
    func testIfBalanceIs_5_ShouldPresentViewDidLoadWith5AsBalance() throws {
        let request = OverviewModel.ViewDidLoad.Request()
        account.stubbedOwner = AccountOwner(firstName: "Jane", familyName: "Doe")
        account.stubbedBalance = 5
        
        sut.handleViewDidLoad(request)
        
        let actual = presenting.receivedViewDidLoadResponse.balance
        let expected: Double = 5
        XCTAssertEqual(actual, expected, accuracy: 0.0001)
    }
    
    func testIfBalanceIs_10_ShouldPresentViewDidLoadWith10AsBalance() throws {
        let request = OverviewModel.ViewDidLoad.Request()
        account.stubbedOwner = AccountOwner(firstName: "Jane", familyName: "Doe")
        account.stubbedBalance = 10
        
        sut.handleViewDidLoad(request)
        
        let actual = presenting.receivedViewDidLoadResponse.balance
        let expected: Double = 10
        XCTAssertEqual(actual, expected, accuracy: 0.0001)
    }
    
    func testIfAmountIs_10_OnWithDraw_ShouldWithDraw10OnAccount() throws {
        let request = OverviewModel.WithDraw.Request(amount: "10.0")
        account.stubbedBalance = 0
        
        sut.handleWithDraw(request)
        
        let actual = account.receivedWithDraw!
        let expected: Double = 10
        XCTAssertEqual(actual, expected, accuracy: 0.0001)
    }
    
    func testIfAmountIs_5_OnWithDraw_ShouldWithDraw5OnAccount() throws {
        let request = OverviewModel.WithDraw.Request(amount: "5.0")
        account.stubbedBalance = 0
        
        sut.handleWithDraw(request)
        
        let actual = account.receivedWithDraw!
        let expected: Double = 5
        XCTAssertEqual(actual, expected, accuracy: 0.0001)
    }
    
    func testIfBalanceIs5_OnWithDraw_ShouldPresentWithDrawWithBalance5() throws {
        let request = OverviewModel.WithDraw.Request(amount: "1.0")
        account.stubbedBalance = 5
        
        sut.handleWithDraw(request)
        
        let actual = presenting.receivedWithDrawResponse.balance
        let expected: Double = 5
        XCTAssertEqual(actual, expected, accuracy: 0.0001)
    }
    
    func testIfBalanceIs10_OnWithDraw_ShouldPresentWithDrawWithBalance10() throws {
       let request = OverviewModel.WithDraw.Request(amount: "1.0")
       account.stubbedBalance = 10
       
       sut.handleWithDraw(request)
       
       let actual = presenting.receivedWithDrawResponse.balance
       let expected: Double = 10
       XCTAssertEqual(actual, expected, accuracy: 0.0001)
    }
    
    func testIfAmountIsNotADouble_OnWithDraw_ShouldNotWithDraw() throws {
        let request = OverviewModel.WithDraw.Request(amount: "NotADoubleValue")
        account.stubbedBalance = 0
    
        sut.handleWithDraw(request)
        
        XCTAssert(account.invokedWithDraw == false)
    }
    
    func testIfAmountIsNotADouble_OnWithDraw_ShouldNotPresentABalance() throws {
        let request = OverviewModel.WithDraw.Request(amount: "NotADoubleValue")
        account.stubbedBalance = 0
    
        sut.handleWithDraw(request)
        
        XCTAssert(presenting.invokedPresentWithDraw == false)
    }
}
