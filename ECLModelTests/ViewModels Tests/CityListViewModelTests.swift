@testable import ECLModel
import XCTest

class CityListViewModelTests: XCTestCase {
    var dataCreatingMock: ECLDataTaskCreatingMock!
    var mockedModel: CityListModel!
    var sut: CityListViewModel!
    var mockDelegate: CityListViewModelMockDelegate!
    let mockCityList = CityList.test_sampleCityList()
    let mockPersisting = PersistingMock()
    
    override func setUp() {
        dataCreatingMock = ECLDataTaskCreatingMock()
        mockedModel = CityListModel(dataTaskCreating: dataCreatingMock, persisting: mockPersisting)
        sut = CityListViewModel(with: mockedModel)
        mockDelegate = CityListViewModelMockDelegate()
        sut.delegate = mockDelegate
        super.setUp()
    }
    
    override func tearDown() {
        dataCreatingMock = nil
        mockedModel = nil
        sut = nil
        super.tearDown()
    }
    
    func testShuoldCallFetchCity_WhenFetched() {
        let exp = expectation()
        dataCreatingMock.mock_cityListDataTaskCompletion = { completion in
            completion(.success(self.mockCityList))
            return TaskMock()
        }
        
        mockDelegate.mock_updateListCompletion = { _ in
            exp.fulfill()
        }
        
        sut.fetchList()
        waitForExpectations()
    }
    
    func testShuoldFillModelCellArray_WhenFetched() {
        let exp = expectation()
        dataCreatingMock.mock_cityListDataTaskCompletion = { completion in
            completion(.success(self.mockCityList))
            return TaskMock()
        }
        
        mockDelegate.mock_updateListCompletion = { cityList in
            XCTAssertEqual( cityList.first?.id , self.mockCityList.europeCities.first?.id)
            exp.fulfill()
        }
        
        sut.fetchList()
        waitForExpectations()
    }
    
    func testShuoldSaveCellModel_WhenFetched() {
        let exp = expectation()
        dataCreatingMock.mock_cityListDataTaskCompletion = { completion in
            completion(.success(self.mockCityList))
            return TaskMock()
        }
        
        mockDelegate.mock_updateListCompletion = { cityList in
            XCTAssertFalse(self.sut.cityCell.isEmpty)
            exp.fulfill()
        }
        
        sut.fetchList()
        waitForExpectations()
    }
    
    func testShouldCallErrorDelegate_WhenErrorReturned() {
        let exp = expectation()
        dataCreatingMock.mock_cityListDataTaskCompletion = { completion in
            completion(.unknownError)
            return TaskMock()
        }
        
        mockDelegate.mock_didErrorOccured = { _ in
            exp.fulfill()
        }
        
        sut.fetchList()
        waitForExpectations()
    }
    
}

class CityListViewModelMockDelegate: CityListViewModelDelegate {
    
    var mock_updateListCompletion: ((_ cityList: [CityCellViewModel])->())?
    func didUpdateList(cityList: [CityCellViewModel]) {
        mock_updateListCompletion?(cityList)
    }
    
    var mock_didFetchImage: ((_ cityId: Int)->())?
    func didFetchImage(for cityId: Int) {
        mock_didFetchImage?(cityId)
    }
    
    var mock_didErrorOccured: ((_ message: String)->())?
    func didErrorOccured(message: String) {
        mock_didErrorOccured?(message)
    }
}
