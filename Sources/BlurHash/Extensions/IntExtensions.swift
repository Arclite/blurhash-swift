extension Int {
    func encode83(length: Int) -> String {
        var result = ""
        for i in 1 ... length {
            let digit = (Int(self) / pow(83, length - i)) % 83
            result += String.encodeCharacters[Int(digit)]
        }
        return result
    }

    private func pow(_ base: Self, _ exponent: Self) -> Self {
        return (0 ..< exponent).reduce(1) { value, _ in value * base }
    }
}
