#if canImport(UIKit)
import Foundation
import UIKit
import Testing

@testable import BlurHash

struct UIImageExtensionsTests {
    private func encodeImage(named name: String) throws -> String {
        let imageURL = try #require(Bundle.module.url(forResource: "TestResources/\(name)", withExtension: "png"))
        let imageData = try Data(contentsOf: imageURL)
        let image = try #require(UIImage(data: imageData))
        return try #require(image.blurHash(numberOfComponents: (4, 3)))
    }

    @Test func encodePic1() throws {
        try #expect(encodeImage(named: "pic1") == "LbJal#Vu8{~pkXsmR,a~xZoLWCRj")
    }

    @Test func encodePic2() throws {
        try #expect(encodeImage(named: "pic2") == "LlM~Oi00%#MwS|WDWEIoR*X8R*bH")
    }

    @Test func encodePic3() throws {
        try #expect(encodeImage(named: "pic3") == "LA9?qERP14Ezr=xYI?I[9~WW-6xF")
    }

    @Test func encodePic6() throws {
        try #expect(encodeImage(named: "pic6") == "L#N^0dxa?wNa-;WBf,WBs;baR*af")
    }
}
#endif
