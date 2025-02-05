#if canImport(UIKit)
import UIKit

fileprivate let usePixelEncoder = true

extension UIImage {
    public var pixelData: PixelData {
        get throws {
            return try srgbCGImage.pixelData
        }
    }

    public func blurHash(numberOfComponents components: (Int, Int)) -> String? {
        return try? UIImageEncoder().encode(self, numberOfComponents: components)
    }

    private var srgbCGImage: CGImage {
        get throws {
            let pixelWidth = Int(round(size.width * scale))
            let pixelHeight = Int(round(size.height * scale))

            guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB) else {
                throw UIImageExtensionsError.cannotCreateColorSpace
            }

            guard let context = CGContext(
                data: nil,
                width: pixelWidth,
                height: pixelHeight,
                bitsPerComponent: 8,
                bytesPerRow: pixelWidth * 4,
                space: colorSpace,
                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
            ) else { throw UIImageExtensionsError.cannotCreateContext }

            context.scaleBy(x: scale, y: -scale)
            context.translateBy(x: 0, y: -size.height)

            UIGraphicsPushContext(context)
            draw(at: .zero)
            UIGraphicsPopContext()

            guard let image = context.makeImage() else {
                throw UIImageExtensionsError.cannotCreateCGImage
            }

            return image
        }
    }
}

enum UIImageExtensionsError: Error {
    case cannotCreateCGImage
    case cannotCreateColorSpace
    case cannotCreateContext
}
#endif
