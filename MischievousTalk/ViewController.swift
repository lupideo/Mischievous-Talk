//
//  ViewController.swift
//  MischievousTalk
//
//  Created by Lisbeth Bispo on 07/09/21.
//

import UIKit
import PhotosUI

class ViewController: UIViewController {
    
    @IBOutlet weak var nounTextField: UITextField!
    @IBOutlet weak var adjectiveTextField: UITextField!
    @IBOutlet weak var verbTextField: UITextField!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var numberSlider: UISlider!
    @IBOutlet weak var mischievousTalkImageView: UIImageView!
    
    let mischievousTalk = MischievousTalkEntry()
    
    @IBAction func changeNumber(_ sender: UISlider) {
        numberLabel.text = "Number: \(Int(sender.value))"
        mischievousTalk.number = Int(sender.value)
    }
    
    @IBAction func changeTalkType(_ sender: UISegmentedControl) {
        if let talk = MischievousTalks.Talk(rawValue: sender.selectedSegmentIndex) {
            mischievousTalk.talk = talk
        } else {
            mischievousTalk.talk = .dirty
        }
    }

    @IBAction func talkMischievously(_ sender: Any) {
        updateMischievousTalk()
        if mischievousTalk.isValid() {
            print(mischievousTalk)
        } else {
            let alert = UIAlertController(title: "Invalid Talk!", message: "Fill the fields, bitch!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Go bich!", style: .default) { (action) in
                //
            }
            alert.addAction(action)
            present(alert, animated: true) {
                //
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mischievousTalk.noun = "Eva Green"
        mischievousTalk.adjective = "fatale"
        mischievousTalk.verb = "kills"
        numberSlider.value = 3.0
        mischievousTalk.number = Int(numberSlider.value)
        mischievousTalkImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeImage))
        mischievousTalkImageView.addGestureRecognizer(gestureRecognizer)
//        print(mischievousTalk)
    }
    
    @objc func changeImage() {
        var configuation = PHPickerConfiguration()
        configuation.filter = .images
        configuation.selectionLimit = 1
        let controller = PHPickerViewController(configuration: configuation)
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }

    func updateMischievousTalk() {
        mischievousTalk.noun = nounTextField.text ?? ""
        mischievousTalk.adjective = adjectiveTextField.text ?? ""
        mischievousTalk.verb = verbTextField.text ?? ""
    }
    
}

extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    updateMischievousTalk()
    return true
  }
}

extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if !results.isEmpty {
            let result = results.first!
            let itemProvider = result.itemProvider
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                    guard let image = image as? UIImage else {
                        return
                    }
                    DispatchQueue.main.async {
                        self?.mischievousTalkImageView.image = image
                    }
                }
            }
        }
    }
}
