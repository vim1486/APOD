//
//  AstroPictureDemoTests.swift
//  AstroPictureDemoTests
//
//  Created by Vimlesh Bhatt on 30/01/2022.
//

import XCTest
@testable import AstroPictureDemo

class AstroPictureDemoTests: XCTestCase {
    
    var sut: URLSession!
    
    override func setUpWithError() throws {
        super.setUp()
        sut = URLSession(configuration: .default)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func testValidCall () throws {
        let url = URL(string: "https://api.nasa.gov/planetary/apod?thumbs=true&date=2022-01-31&api_key=s33WJmOuKbCPHimtxE0wrSysVa0erXJNfyG8f6TS")
        let promise = expectation(description: "Status code: 200")
        
        let dataTask = sut.dataTask(with: url!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 10)
    }
    
    func testCallCompletion() {
        
        let url = URL(string: "https://api.nasa.gov/planetary/apod?thumbs=true&date=2022-01-31&api_key=s33WJmOuKbCPHimtxE0wrSysVa0erXJNfyG8f6TS")
        
        let promise = expectation(description: "Completion handler called")
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = sut.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        
        wait(for: [promise], timeout: 10)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testMediaTypeVideo() {
        
        let url = URL(string: "https://api.nasa.gov/planetary/apod?thumbs=true&date=2021-10-11&api_key=s33WJmOuKbCPHimtxE0wrSysVa0erXJNfyG8f6TS")
        let promise = expectation(description: MediaType.video.rawValue)
        
        let dataTask = sut.dataTask(with: url!) { data, response, error in
            do{
                let type = PictureModel.self
                let decoder = JSONDecoder()
                let apod = try decoder.decode(type, from: data!)
                if(apod.media_type == MediaType.video.rawValue){
                    promise.fulfill()
                }
            }catch _ {
                XCTFail("Error parsing response \(String(describing: error))")
            }
        }
        
        dataTask.resume()
        wait(for: [promise], timeout: 10)
    }
    
    func testMediaTypeImage() {
        
        let url = URL(string: "https://api.nasa.gov/planetary/apod?thumbs=true&date=1996-08-14&api_key=s33WJmOuKbCPHimtxE0wrSysVa0erXJNfyG8f6TS")
        let promise = expectation(description: MediaType.image.rawValue)
        
        let dataTask = sut.dataTask(with: url!) { data, response, error in
            do{
                let type = PictureModel.self
                let decoder = JSONDecoder()
                let apod = try decoder.decode(type, from: data!)
                if(apod.media_type == MediaType.image.rawValue){
                    promise.fulfill()
                }
            }catch _ {
                XCTFail("Error parsing response \(String(describing: error))")
            }
        }
        
        dataTask.resume()
        wait(for: [promise], timeout: 10)
    }
    
    func testFutureImageHandling() {
        
        let url = URL(string: "https://api.nasa.gov/planetary/apod?thumbs=true&date=1996-08-14&api_key=s33WJmOuKbCPHimtxE0wrSysVa0erXJNfyG8f6TS")
        let promise = expectation(description: "Date must be between Jun 16, 1995 and Feb 02, 2022.")
        
        let dataTask = sut.dataTask(with: url!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 400 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 10)
    }
    
    func testInvalidPastDate() {
        
        let url = URL(string: "https://api.nasa.gov/planetary/apod?thumbs=true&date=2022-03-01&api_key=s33WJmOuKbCPHimtxE0wrSysVa0erXJNfyG8f6TS")
        let promise = expectation(description: "Status code: 400")
        
        let dataTask = sut.dataTask(with: url!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 400 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 10)
    }
}
