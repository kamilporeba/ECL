@testable import ECLModel
import XCTest

class CityDetailsViewModelTests: XCTestCase {
    var dataCreatingMock: ECLDataTaskCreatingMock!
    var mockedModel: CityListModel!
    var sut: CityDetailsViewModel!
    var mockDelegate: CityDetailsViewModelMockDelegate!
    let mockRate = Rate.test_sampleRate()
    let mockVisitors = Visitors.test_sampleVisitors()
    let mockPersisting = PersistingMock()
    
    override func setUp() {
        dataCreatingMock = ECLDataTaskCreatingMock()
        mockedModel = CityListModel(dataTaskCreating: dataCreatingMock, persisting: mockPersisting)
        sut = CityDetailsViewModel(with: mockedModel, of: 2)
        mockDelegate = CityDetailsViewModelMockDelegate()
        sut.delegate = mockDelegate
        super.setUp()
    }

    override func tearDown() {
        dataCreatingMock = nil
        mockedModel = nil
        sut = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    func testShouldCallErrorDelegate_WhenVisitorsErrorReturned() {
        let exp = expectation()
        
        dataCreatingMock.mock_visitorsDataTaskCompletion = { completion in
            completion(.unknownError)
            return TaskMock()
        }
        
        mockDelegate.mock_didErrorOccured = { _ in
            exp.fulfill()
        }
        sut.fetchAllDetails()
        
        waitForExpectations()
    }
    
    func testShouldCallErrorDelegate_WhenRateErrorReturned() {
        let exp = expectation()
        
        dataCreatingMock.mock_visitorsDataTaskCompletion = { completion in
            completion(.success(self.mockVisitors))
            return TaskMock()
        }
        
        dataCreatingMock.mock_rateDataTaskCompletion = { completion in
            completion(.unknownError)
            return TaskMock()
        }
        mockDelegate.mock_didErrorOccured = { _ in
            exp.fulfill()
        }
        sut.fetchAllDetails()

        waitForExpectations()
    }
    
    func testShouldCallAllDetails_WhenRateAndVisitorsFetched() {
        let exp = expectation()
        
        dataCreatingMock.mock_visitorsDataTaskCompletion = { completion in
            completion(.success(self.mockVisitors))
            return TaskMock()
        }
        
        dataCreatingMock.mock_rateDataTaskCompletion = { completion in
            completion(.success(self.mockRate))
            return TaskMock()
        }
        
        mockDelegate.mock_didFetchDetails = { _, _ in
            exp.fulfill()
        }
        
        sut.fetchAllDetails()
        
        waitForExpectations()
    }
    
    func testShouldSetVisitorsAndRate_WhenRateAndVisitorsFetched() {
        let exp = expectation()
        
        dataCreatingMock.mock_visitorsDataTaskCompletion = { completion in
            completion(.success(self.mockVisitors))
            return TaskMock()
        }
        
        dataCreatingMock.mock_rateDataTaskCompletion = { completion in
            completion(.success(self.mockRate))
            return TaskMock()
        }
        
        mockDelegate.mock_didFetchDetails = { _, _ in
            XCTAssertEqual(self.sut.visitors.count , self.mockVisitors.visitors.count)
            XCTAssertEqual(self.sut.visitors.first, self.mockVisitors.visitors.first?.name)
            XCTAssertEqual(self.sut.rate , self.mockRate.rating)
            exp.fulfill()
        }
        
        sut.fetchAllDetails()
        
        waitForExpectations()
    }
}


class CityDetailsViewModelMockDelegate: CityDetailsViewModelDelegate {
    
    var mock_didErrorOccured: ((_ message: String)->())?
    func didErrorOccured(errorMessage: String) {
        mock_didErrorOccured?(errorMessage)
    }
    
    var mock_didFetchDetails: ((_ visitors: [String], _ reate: Float)->())?
    func didFetchDetails(visitors: [String], rate: Float) {
        mock_didFetchDetails?(visitors,rate)
    }
}
