import Foundation

class Concentration {
    var cards = [Card]()

    var indexOfOneAndOnlyFaceUpCard: Int?
    var flipCount = 0
    var score = 0

    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else if cards[index].previouslySeen {
                    score -= 1
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        cards[index].previouslySeen = true
        flipCount += 1
    }

    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }

        cards.shuffle()
    }

    func reset() {
        for index in cards.indices {
            cards[index].isMatched = false
            cards[index].isFaceUp = false
            cards[index].previouslySeen = false
        }

        cards.shuffle()
        flipCount = 0
        score = 0
    }
}
