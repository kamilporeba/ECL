@testable import ECLModel
import XCTest

class CityListModelTests: XCTestCase {
    
    var dataCreatingMock = ECLDataTaskCreatingMock()
    var sut: CityListModel!
    var listenerMock : CityListModelListenerMock!
    let mockCityList = CityList.test_sampleCityList()
    let mockVisitor = Visitors.test_sampleVisitors()
    let mockRate = Rate.test_sampleRate()
    let mockPersisting = PersistingMock()
    
    override func setUp() {
        sut = CityListModel(dataTaskCreating: dataCreatingMock, persisting: mockPersisting)
        listenerMock = CityListModelListenerMock()
        sut.addListener(listener: listenerMock)
    }
    
    override func tearDown() {
        sut = nil
        listenerMock = nil
    }
    
    func testShouldCityListDataCreatingCalled_WhenFetchCalled() {
        let exp = expectation()
        dataCreatingMock.mock_cityListDataTaskCompletion = { completion in 
            completion(.success(self.mockCityList))
            return TaskMock()
        }
        
        listenerMock.mock_didUpdateCityListCompletion = { _ in
            exp.fulfill()
        }
        
        sut.fetchCityList()
        
        waitForExpectations()
    }
    
    func testShouldCallErrorListener_WhenErrorOnCityFetchOccured() {
        let exp = expectation()
        
        dataCreatingMock.mock_cityListDataTaskCompletion = { completion in
            completion(.unknownError)
            return TaskMock()
        }
        
        listenerMock.mock_didErrorOccuredCompletion = { _ in
            exp.fulfill()
        }
        
        sut.fetchCityList()
        
        waitForExpectations()
    }
    
    func testShouldNotCallCityListener_WhenErrorOnCityFetchOccured() {
        dataCreatingMock.mock_cityListDataTaskCompletion = { completion in
            completion(.unknownError)
            return TaskMock()
        }
        
        listenerMock.mock_didUpdateCityListCompletion = { _ in
            XCTFail("This method should not be called!")
        }
        
        sut.fetchCityList()
    }
    
    func testShouldNotCallError_WhenOnCityFetchSuccess() {
        dataCreatingMock.mock_cityListDataTaskCompletion = { completion in
            completion(.success(self.mockCityList))
            return TaskMock()
        }
        
        listenerMock.mock_didErrorOccuredCompletion = { _ in
            XCTFail("This method should not be called!")
        }
        
        sut.fetchCityList()
    }
    
    
    
    func testShouldCallErrorListener_WhenErrorOnVisitorFetchOccured() {
        let exp = expectation()
        
        dataCreatingMock.mock_visitorsDataTaskCompletion = { completion in
            completion(.unknownError)
            return TaskMock()
        }
        
        listenerMock.mock_didErrorOccuredCompletion = { _ in
            exp.fulfill()
        }
        
        sut.fetchDetails(of: 2)
        
        waitForExpectations()
    }
    
    func testShouldNotCallErrorListener_WhenOnVisitorFetchSuccess() {
        dataCreatingMock.mock_visitorsDataTaskCompletion = { completion in
            completion(.success(self.mockVisitor))
            return TaskMock()
        }
        
        listenerMock.mock_didErrorOccuredCompletion = { _ in
            XCTFail("This method should not be called")
        }
        
        sut.fetchDetails(of: 2)
        
    }
    
    func testShouldVisitorDataCreatingCalled_WhenFetchDetailsCalled() {
        let exp = expectation()
        
        dataCreatingMock.mock_visitorsDataTaskCompletion = { completion in
            completion(.success(self.mockVisitor))
            return TaskMock()
        }
        
        listenerMock.mock_didUpdateVisitorsCompletion = { _ in
            exp.fulfill()
        }
        
        sut.fetchDetails(of: 3)
        
        waitForExpectations()
    }
    
    func testShouldNotCallVisitorListener_WhenOnVisitorFetchError() {
        dataCreatingMock.mock_visitorsDataTaskCompletion = { completion in
            completion(.unknownError)
            return TaskMock()
        }
        
        listenerMock.mock_didUpdateVisitorsCompletion = { _ in
            XCTFail("This method should not be called")
        }
        
        sut.fetchDetails(of: 2)
    }
    
    func testShouldRateDataCreatingCalled_WhenFetchDetailsCalled() {
        let exp = expectation()
        dataCreatingMock.mock_rateDataTaskCompletion = { completion in
            completion(.success(self.mockRate))
            return TaskMock()
        }
        
        dataCreatingMock.mock_visitorsDataTaskCompletion = { completion in
            completion(.success(self.mockVisitor))
            return TaskMock()
        }
        
        listenerMock.mock_didUpdateRateCompletion = { _ in
            exp.fulfill()
        }
        
        sut.fetchDetails(of: 2)
        
        waitForExpectations()
    }
    
    func testShouldCallErrorListener_WhenErrorOnRateFetchOccured() {
        let exp = expectation()
        
        dataCreatingMock.mock_rateDataTaskCompletion = { completion in
            completion(.unknownError)
            return TaskMock()
        }
        dataCreatingMock.mock_visitorsDataTaskCompletion = { completion in
            completion(.success(self.mockVisitor))
            return TaskMock()
        }
        
        listenerMock.mock_didErrorOccuredCompletion = { _ in
            exp.fulfill()
        }
        
        sut.fetchDetails(of: 2)
        
        waitForExpectations()
    }
    
    func testShouldNotCallRateListener_WhenOnRateFetchError() {
        dataCreatingMock.mock_rateDataTaskCompletion = { completion in
            completion(.unknownError)
            return TaskMock()
        }
        
        listenerMock.mock_didUpdateRateCompletion = { _ in
            XCTFail("This method should not be called")
        }
        
        sut.fetchDetails(of: 2)
    }
    
    func testShouldNotCallErrorListener_WhenOnRateFetchSuccess() {
        dataCreatingMock.mock_rateDataTaskCompletion = { completion in
            completion(.success(self.mockRate))
            return TaskMock()
        }
        
        listenerMock.mock_didErrorOccuredCompletion = { _ in
            XCTFail("This method should not be called")
        }
        
        sut.fetchDetails(of: 2)
        
    }
    
    func testShouldNotCalledDetailsListener_WhenCitiesFetch() {
        
        dataCreatingMock.mock_cityListDataTaskCompletion = { completion in
            completion(.success(self.mockCityList))
            return TaskMock()
        }
        
        listenerMock.mock_didUpdateRateCompletion = { _ in
            XCTFail("This method should not be called")
        }
        
        listenerMock.mock_didUpdateVisitorsCompletion = { _ in
            XCTFail("This method should not be called")
        }
        
        sut.fetchCityList()
    }
    
    func testShouldCalledAllDetailsFetch_WhenVisitorsAndRateFetched() {
        let exp = expectation()
        
        dataCreatingMock.mock_rateDataTaskCompletion = { completion in
            completion(.success(self.mockRate))
            return TaskMock()
        }
        dataCreatingMock.mock_visitorsDataTaskCompletion = { completion in
            completion(.success(self.mockVisitor))
            return TaskMock()
        }
        
        listenerMock.mock_didFetchAllDetails = {
            exp.fulfill()
        }
        
        sut.fetchDetails(of: 2)
        
        waitForExpectations()
    }
    
    func testShouldNotCalledAllDetailsFetch_WhenRateErrorOccured() {
        let exp = expectation()
        
        dataCreatingMock.mock_rateDataTaskCompletion = { completion in
            completion(.unknownError)
            return TaskMock()
        }
        dataCreatingMock.mock_visitorsDataTaskCompletion = { completion in
            completion(.success(self.mockVisitor))
            return TaskMock()
        }
        
        listenerMock.mock_didFetchAllDetails = {
            XCTFail("This method should not be called")
            
        }
        
        listenerMock.mock_didErrorOccuredCompletion = { _ in
            exp.fulfill()
        }
        
        sut.fetchDetails(of: 2)
        
        waitForExpectations()
    }
    
    func testShouldAddCity_whenArrayFavoriteEmpty() {
        sut.addToFavorite(cityId: 1)
        
        let favorite = mockPersisting.retrieveFavorite()
        XCTAssertNotNil(favorite)
        XCTAssertEqual(favorite?.first, 1)
    }
    
    func testShouldAddCity_whenArrayFavoriteNotEmpty() {
        mockPersisting.setFavorite(favArray: [1,2,3])
        
        sut.addToFavorite(cityId: 7)
        
        let favorite = mockPersisting.retrieveFavorite()
        XCTAssertNotNil(favorite)
        XCTAssertEqual(favorite?.first, 1)
        XCTAssertEqual(favorite?.last, 7)
    }
    
    func testShouldRemoveFav_WhenFavNotEmpty() {
        mockPersisting.setFavorite(favArray: [1,2,3])
        
        sut.removeFromFavorite(cityId: 2)
        let favorite = mockPersisting.retrieveFavorite()
        XCTAssertEqual(favorite, [1,3])
    }
    
    func testShouldReturnFavorite_WhenSet() {
        mockPersisting.setFavorite(favArray: [1,2,3])
        
        XCTAssertEqual(sut.favorites, [1,2,3])
    }
    
    func testShouldReturnEmptyFavorite_WhenNotSet() {
        XCTAssertEqual(sut.favorites, [])
    }
    
    func testShouldNotAddValue_WhenExsit() {
        mockPersisting.setFavorite(favArray: [1,2,3])
        sut.addToFavorite(cityId: 2)
        
        XCTAssertEqual(sut.favorites, [1,2,3])
        
    }
}
