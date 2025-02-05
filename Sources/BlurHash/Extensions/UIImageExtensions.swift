#if canImport(UIKit)
import UIKit

fileprivate let usePixelEncoder = true

extension UIImage {
    public var pixelData: PixelData {
        get throws {
            guard let cgImage else { throw UIImageExtensionsError.cannotCreateCGImage }
            return try cgImage.srgb.pixelData
        }
    }

    public func blurHash(numberOfComponents components: (Int, Int)) -> String? {
        return try? UIImageEncoder().encode(self, numberOfComponents: components)
    }
}

enum UIImageExtensionsError: Error {
    case cannotCreateCGImage
}
#endif
