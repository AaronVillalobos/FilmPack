//
//  PackEntryViewTests.swift
//  FilmPackTests
//
//  Created by Aaron Villalobos on 7/3/26.
//

import XCTest
@testable import FilmPack

final class PackEntryViewTests: XCTestCase {
    
    func testSimulateButtonIsDisabledWithEmptyTitle() {
        // Arrange
        let pack = Pack(
            title: "",
            caption: "A successful launch night.",
            imageData: ["launch_2", "launch_1"].compactMap {
                UIImage(named: $0)
            }
        )
        
        // Action
        let buttonIsDisabled: Bool = pack.title.isEmpty || pack.imageData.isEmpty

        // Assert
        XCTAssertTrue(buttonIsDisabled)
    }
    
    func testSimulateButtonIsDisabledWithEmptyImageData() {
        // Arrange
        let pack = Pack(
            title: "Launch Party",
            caption: "A successful launch party.",
            imageData: []
        )
        
        // Action
        let buttonIsDisabled: Bool = pack.title.isEmpty || pack.imageData.isEmpty
        
        // Assert
        XCTAssertTrue(buttonIsDisabled)
    }
    
    func testSimulateButtonIsNotDisabledWithTitleAndImageData() {
        // Arrange
        let pack = Pack(
            title: "Launch Party",
            caption: "A successful launch night.",
            imageData: ["launch_2", "launch_1"].compactMap {
                UIImage(named: $0)
            }
        )
        
        // Action
        let buttonIsDisabled: Bool = pack.title.isEmpty || pack.imageData.isEmpty
        
        // Assert
        XCTAssertFalse(buttonIsDisabled)
    }
    
    func testCancellationActionWithEmptyData() {
        // Arrange
        let pack = Pack(
            title: "",
            caption: "",
            imageData: []
        )
        var dismiss = false
        
        // Action
        if pack.title.isEmpty, pack.caption.isEmpty, pack.imageData == [] {
            dismiss = true
        }
        
        // Assert
        XCTAssertTrue(dismiss)
    }
    
    func testCancellationConfirmationDialog() {
        // Arrange
        let pack = Pack(
            title: "Launch Party",
            caption: "A sucessful launch night",
            imageData: []
        )
        var dismiss = false
        var isShowingCancelOnConfirmation = false
        
        // Action
        if pack.title.isEmpty, pack.caption.isEmpty, pack.imageData == [] {
            dismiss = true
        } else {
            isShowingCancelOnConfirmation = true
        }
        
        // Assert
        XCTAssertTrue(isShowingCancelOnConfirmation && dismiss != true)
    }
}
