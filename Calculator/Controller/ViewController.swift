import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var isFinishedTyping: Bool = true //Only available in the scope. prevents accidentally modifying the code
    
    private var displayValue: Double {
        get {
            guard let number = Double(displayLabel.text!) else {
                fatalError("Cannot convert display label text to a Double.")
            }
            return number
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    
    private var calc = CalculatorLogic()
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        //What should happen when a non-number button is pressed
        isFinishedTyping = true
        
        calc.setNumber(displayValue)
        
        if let calcMethod = sender.currentTitle {
            
            if let result = calc.calculate(symbol: calcMethod){
                displayValue = result
            }
        }
    }
    
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        //What should happen when a number is entered into the keypad
        if let numValue = sender.currentTitle {
            
            if isFinishedTyping {
                displayLabel.text = numValue
                isFinishedTyping = false
            } else {
                let isInt = floor(displayValue) == displayValue
                if !isInt {
                    return //stops the function running if it already is an integar.
                }
                displayLabel.text = displayLabel.text! + numValue
            }
        }
    }
}
