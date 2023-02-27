//
//  ViewController.swift
//  TextFields
//
//  Created by Данік on 24/02/2023.
//

import UIKit
import SafariServices

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        onlyText.delegate = self
        onlyText.keyboardType = .alphabet
        
        passwordTextfield.delegate = self
        textAndNumbers.delegate = self
        inputLimit.delegate = self
        linkTextField.delegate =  self
    }

    @IBOutlet weak var passwordProgress: UIProgressView!
    
    var isTyping = false
    var safariViewController: SFSafariViewController?
    
    // Labels
    @IBOutlet weak var oneDig: UILabel!
    @IBOutlet weak var eightChar: UILabel!
    @IBOutlet weak var oneCapital: UILabel!
    @IBOutlet weak var oneLowercase: UILabel!
    
    
    @IBOutlet weak var inputLimit: UITextField!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var textAndNumbers: UITextField!
    @IBOutlet weak var onlyText: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var linkTextField: UITextField!
    
}

// MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == onlyText {
            // Exclude numbers from the textField field
            let allowedCharacters = CharacterSet.letters
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
            
        } else if textField == textAndNumbers {
            // Calculate new character count
            let oldText = textField.text ?? ""
            let newText = (oldText as NSString).replacingCharacters(in: range, with: string)
            let charCount = newText.count
            
            
            if charCount == 6 && oldText.count == 7 {
                let text = oldText.dropLast(2)
                textAndNumbers.text = String(text)
            } else if charCount < 6 {
                let allowedCharacters = CharacterSet.letters
                let characterSet = CharacterSet(charactersIn: string)
                return allowedCharacters.isSuperset(of: characterSet)
            } else if charCount == 6 {
                textAndNumbers.text?.insert("-", at: String.Index(utf16Offset: charCount - 1, in: textAndNumbers.text!))
            } else if charCount <= 11 {
                let allowedCharacters = CharacterSet.decimalDigits
                let characterSet = CharacterSet(charactersIn: string)
                return allowedCharacters.isSuperset(of: characterSet)
            }
        } else if textField == inputLimit {
            // Calculate new character count
            let oldText = textField.text ?? ""
            let newText = (oldText as NSString).replacingCharacters(in: range, with: string)
            let charCount = newText.count
            
            if charCount <= 10 {
                countLabel.text = "\(charCount)/10"
                countLabel.textColor = UIColor.black
                textField.layer.borderWidth = 0
                textField.layer.cornerRadius = 0
                return true
            } else if charCount > 10 {
                countLabel.text = "\(charCount)/10"
                countLabel.textColor = UIColor.red
                textField.layer.borderWidth = 1
                textField.layer.borderColor = UIColor.red.cgColor
                textField.layer.cornerRadius = 5
                return true
            }
        }
        
        
        else if textField == passwordTextfield {
            var strength: Float = 0.0

            let currentText = textField.text ?? ""
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            let digitRegEx = ".*[0-9]+.*"
            let digitTest = NSPredicate(format:"SELF MATCHES %@", digitRegEx)
            
            let lowercaseRegEx = ".*[a-z]+.*"
            let lowercaseTest = NSPredicate(format:"SELF MATCHES %@", lowercaseRegEx)
            
            let capitalRegEx = ".*[A-Z]+.*"
            let capitalTest = NSPredicate(format:"SELF MATCHES %@", capitalRegEx)
            

            if digitTest.evaluate(with: updatedText) {
                oneDig.textColor = UIColor.green
                strength += 0.25
            } else {
                oneDig.textColor = UIColor.black
            }
            if lowercaseTest.evaluate(with: updatedText) {
                oneLowercase.textColor = UIColor.green
                strength += 0.25
            } else {
                oneLowercase.textColor = UIColor.black
            }
            if capitalTest.evaluate(with: updatedText) {
                oneCapital.textColor = UIColor.green
                strength += 0.25
            } else {
                oneCapital.textColor = UIColor.black
            }
            if updatedText.count >= 8 {
                strength += 0.25
                eightChar.textColor = UIColor.green
            } else {
                eightChar.textColor = UIColor.black
                
            }
            
            passwordProgress.progress = strength
            
            if strength < 0.3 {
                passwordProgress.progressTintColor = .red
            } else if strength < 0.6 {
                passwordProgress.progressTintColor = .orange
            } else if strength < 0.8 {
                passwordProgress.progressTintColor = .orange
            } else {
                passwordProgress.progressTintColor = .green
            }
            
            return true
        } else if textField == linkTextField {
            return true
        }
        
        return false
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == linkTextField {
            guard let text = textField.text, !text.isEmpty else {
                safariViewController?.dismiss(animated: true, completion: nil)
                safariViewController = nil
                return
            }

            if !isTyping {
                isTyping = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.checkForLink(text)
                    self.isTyping = false
                }
            }
        }
    }
    func checkForLink(_ text: String) {
        if let url = URL(string: text), UIApplication.shared.canOpenURL(url) {
            safariViewController = SFSafariViewController(url: url)
            present(safariViewController!, animated: true, completion: nil)
        } else {
            safariViewController?.dismiss(animated: true, completion: nil)
            safariViewController = nil
        }
    }
        
    }
    
    
    
    
    


