extension String {
    static let encodeCharacters: [String] = {
        return "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz#$%*+,-.:;=?@[]^_{|}~".map { String($0) }
    }()

    private static let decodeCharacters: [String: Int] = {
        var dict: [String: Int] = [:]
        for (index, character) in encodeCharacters.enumerated() {
        dict[character] = index
        }
        return dict
    }()

    func decode83() -> Int {
        var value: Int = 0
        for character in self {
            if let digit = Self.decodeCharacters[String(character)] {
                value = value * 83 + digit
            }
        }
        return value
    }

    subscript (offset: Int) -> Character {
        return self[index(startIndex, offsetBy: offset)]
    }

    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start...end]
    }

    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start..<end]
    }
}
