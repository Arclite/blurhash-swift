#if canImport(CoreGraphics)
import CoreGraphics
import Foundation

extension CGImage {
    var pixelData: PixelData {
        get throws {
            guard let data = dataProvider?.data else {
                throw CGImageExtensionsError.cannotGetImageData
            }

            return PixelData(width: width, height: height, bytesPerPixel: bytesPerRow / width, data: data as Data)
        }
    }
}

enum CGImageExtensionsError: Error {
    case cannotGetImageData
}
#endif
