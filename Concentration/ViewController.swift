import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)

    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }

    @IBOutlet weak var flipCountLabel: UILabel!

    @IBOutlet weak var scoreLabel: UILabel!

    @IBOutlet var cardButtons: [UIButton]!

    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }

    @IBAction func newGame(_ sender: UIButton) {
        emoji = [:]
        emojiChoices = emojiThemes[Int.random(in: 0..<emojiThemes.count)]
        game.reset()
        updateViewFromModel()
    }

    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        score = game.score
        flipCount = game.flipCount
    }

    var emojiThemes: [[String]] = [
        ["🎃", "👻", "🦇", "💀", "🍭", "🍬", "🍎"],
        ["🇦🇩", "🇦🇴", "🇦🇹", "🇧🇪", "🇧🇷", "🇨🇦", "🇺🇸"],
        ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉"],
        ["🥐", "🥯", "🥞", "🧇", "🥓", "🍔", "🍟"],
        ["🏖", "🛫", "🛳", "🚤", "⛵️", "🗺", "⛱"],
        ["🦍", "🐍", "🐢", "🦒", "🦑", "🦏", "🦙"]
    ]
    lazy var emojiChoices: [String] = emojiThemes[Int.random(in: 0..<emojiThemes.count)]
    var emoji = [Int: String]()

    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }

        return emoji[card.identifier] ?? "?"
    }
}

