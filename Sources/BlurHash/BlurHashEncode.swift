import Foundation

func encodeDC(_ value: (Float, Float, Float)) -> Int {
    let roundedR = Math.linearToSRGB(value.0)
    let roundedG = Math.linearToSRGB(value.1)
    let roundedB = Math.linearToSRGB(value.2)
    return (roundedR << 16) + (roundedG << 8) + roundedB
}

func encodeAC(_ value: (Float, Float, Float), maximumValue: Float) -> Int {
    let quantR = Int(max(0, min(18, floor(Math.signPow(value.0 / maximumValue, 0.5) * 9 + 9.5))))
    let quantG = Int(max(0, min(18, floor(Math.signPow(value.1 / maximumValue, 0.5) * 9 + 9.5))))
    let quantB = Int(max(0, min(18, floor(Math.signPow(value.2 / maximumValue, 0.5) * 9 + 9.5))))

    return quantR * 19 * 19 + quantG * 19 + quantB
}

extension BinaryInteger {
    func encode83(length: Int) -> String {
        var result = ""
        for i in 1 ... length {
            let digit = (Int(self) / pow(83, length - i)) % 83
            result += String.encodeCharacters[Int(digit)]
        }
        return result
    }
}

private func pow(_ base: Int, _ exponent: Int) -> Int {
    return (0 ..< exponent).reduce(1) { value, _ in value * base }
}
