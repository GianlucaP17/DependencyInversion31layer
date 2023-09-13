//
//  DependencyInversion31layerTests.swift
//  DependencyInversion31layerTests
//
//  Created by Gianluca Posca on 11/09/23.
//

import XCTest
@testable import DependencyInversion31layer

final class DependencyInversion31layerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //Test Sync code
    func test_PostDetailVM_loadPost_bodyTest() throws {
        //given
        let di = PostDetailsDI(appEnvironment: AppEnvironment())
        
        //when
        let vm = di.postDetailsDependencies(post: PostEntity(userId: 1242, id: 56342, title: "Prova", body: "Test"))
        
        //then
        XCTAssert(vm.post.body == "Test")
    }
    
    //Test async code
    func test_Async_PostVM_loadPosts_nonNil() throws {
        //given
        let baseURL = AppEnvironment().baseURL
        // Data Source
        let postRemoteDataSource = PostRemoteDataSource(urlString: baseURL)
        // Data Repo
        let postDataRepo = PostDataRepo(postRemoteDataSource: postRemoteDataSource)
        // Domain Layer
        let postInteractor = PostInteractor(postDomainRepo: postDataRepo)
        // Presentation
        let postVM = PostVM(postInteractor: postInteractor)
        
        //when
        let expectation = XCTestExpectation(description: "Posts loaded successfully")
        postVM.getPosts { posts in
            if !(posts.isEmpty) {
                expectation.fulfill()
            }
        }
        
        //then
        wait(for: [expectation], timeout: 10)
    }

    /// > XCUITest
}
