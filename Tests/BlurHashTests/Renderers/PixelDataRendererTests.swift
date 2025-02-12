import Testing

@testable import BlurHash

struct PixelDataRendererTests {
    @Test
    func sample() throws {
        let renderedData = try PixelDataRenderer().render("LbJal#Vu8{~pkXsmR,a~xZoLWCRj", width: 4, height: 3, punch: 1)
        print(renderedData.data.map { String(format: "%02hhx", $0) }.joined())
    }
}
