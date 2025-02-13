import Foundation

public struct PixelData {
    let width: Int
    let height: Int
    public let bytesPerPixel: Int
    public let data: Data

    public init(
        width: Int,
        height: Int,
        bytesPerPixel: Int,
        data: Data
    ) {
        self.width = width
        self.height = height
        self.bytesPerPixel = bytesPerPixel
        self.data = data
    }
}
