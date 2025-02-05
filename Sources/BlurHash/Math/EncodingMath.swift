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

func decodeDC(_ value: Int) -> (Float, Float, Float) {
    let intR = value >> 16
    let intG = (value >> 8) & 255
    let intB = value & 255
    return (Math.srgbToLinear(intR), Math.srgbToLinear(intG), Math.srgbToLinear(intB))
}

func decodeAC(_ value: Int, maximumValue: Float) -> (Float, Float, Float) {
    let quantR = value / (19 * 19)
    let quantG = (value / 19) % 19
    let quantB = value % 19

    let rgb = (
        Math.signPow((Float(quantR) - 9) / 9, 2) * maximumValue,
        Math.signPow((Float(quantG) - 9) / 9, 2) * maximumValue,
        Math.signPow((Float(quantB) - 9) / 9, 2) * maximumValue
    )

    return rgb
}
