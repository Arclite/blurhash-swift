#if canImport(CoreGraphics)
import CoreGraphics
import Foundation

extension CGImage {
    var pixelData: PixelData {
        get throws {
            guard let data = try srgb.dataProvider?.data else {
                throw CGImageExtensionsError.cannotGetImageData
            }

            return PixelData(width: width, height: height, bytesPerPixel: bytesPerRow / width, data: data as Data)
        }
    }

    var srgb: CGImage {
        get throws {
            guard colorSpace?.name != CGColorSpace.sRGB else { return self }

            guard let srgbSpace = CGColorSpace(name: CGColorSpace.sRGB) else {
                throw CGImageExtensionsError.cannotCreateColorSpace
            }

            guard let context = CGContext(
                data: nil,
                width: width,
                height: height,
                bitsPerComponent: 8,
                bytesPerRow: width * 4,
                space: srgbSpace,
                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
            ) else { throw CGImageExtensionsError.cannotCreateContext }

            context.draw(self, in: CGRect(x: 0, y: 0, width: width, height: height))

            guard let image = context.makeImage() else {
                throw CGImageExtensionsError.cannotCreateCGImage
            }

            return image
        }
    }
}

enum CGImageExtensionsError: Error {
    case cannotCreateCGImage
    case cannotCreateColorSpace
    case cannotCreateContext
    case cannotGetImageData
}
#endif
