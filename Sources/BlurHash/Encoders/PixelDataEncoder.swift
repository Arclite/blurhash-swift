import Foundation

struct PixelDataEncoder {
    func encode(_ pixels: PixelData, numberOfComponents components: (Int, Int)) throws -> String {
        var factors: [(Float, Float, Float)] = []
        for y in 0 ..< components.1 {
            for x in 0 ..< components.0 {
                let normalisation: Float = (x == 0 && y == 0) ? 1 : 2
                let factor = multiplyBasisFunction(pixels: pixels) {
                    normalisation * cos(Float.pi * Float(x) * $0 / Float(pixels.width)) as Float * cos(Float.pi * Float(y) * $1 / Float(pixels.height)) as Float
                }
                factors.append(factor)
            }
        }

        let dc = factors.first!
        let ac = factors.dropFirst()

        var hash = ""

        let sizeFlag = (components.0 - 1) + (components.1 - 1) * 9
        hash += sizeFlag.encode83(length: 1)

        let maximumValue: Float
        if ac.count > 0 {
            let actualMaximumValue = ac.map({ max(abs($0.0), abs($0.1), abs($0.2)) }).max()!
            let quantisedMaximumValue = Int(max(0, min(82, floor(actualMaximumValue * 166 - 0.5))))
            maximumValue = Float(quantisedMaximumValue + 1) / 166
            hash += quantisedMaximumValue.encode83(length: 1)
        } else {
            maximumValue = 1
            hash += 0.encode83(length: 1)
        }

        hash += encodeDC(dc).encode83(length: 4)

        for factor in ac {
            hash += encodeAC(factor, maximumValue: maximumValue).encode83(length: 2)
        }

        return hash
    }

    private func multiplyBasisFunction(
        pixels: PixelData,
        basisFunction: (Float, Float) -> Float
    ) -> (Float, Float, Float) {
        var r: Float = 0
        var g: Float = 0
        var b: Float = 0

        let data = pixels.data
        let bytesPerPixel = pixels.bytesPerPixel
        let bytesPerRow = bytesPerPixel * pixels.width

        for x in 0 ..< pixels.width {
            for y in 0 ..< pixels.height {
                let basis = basisFunction(Float(x), Float(y))
                r += basis * Math.srgbToLinear(data[bytesPerPixel * x + 0 + y * bytesPerRow])
                g += basis * Math.srgbToLinear(data[bytesPerPixel * x + 1 + y * bytesPerRow])
                b += basis * Math.srgbToLinear(data[bytesPerPixel * x + 2 + y * bytesPerRow])
            }
        }

        let scale = 1 / Float(pixels.width * pixels.height)

        return (r * scale, g * scale, b * scale)
    }
}
