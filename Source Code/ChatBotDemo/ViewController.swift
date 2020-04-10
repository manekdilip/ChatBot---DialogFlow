//
//  ViewController.swift
//  ChatBotDemo
//
//  Created by Devubha Manek on 06/04/20.
//  Copyright © 2020 Devubha Manek. All rights reserved.
//

import UIKit
import ApiAI
import AVFoundation

class ViewController: UIViewController {
    
    //MARK: IBOutlet Declarataion
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var lblResponse: UILabel!
    
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
}

//MARK: IBaction Declaration
extension ViewController {
    
    @IBAction func sendMessage(_ sender: Any) {
        
        let request = ApiAI.shared().textRequest()
        
        if let text = self.txtMessage.text, text != "" {
            request?.query = text
        } else {
            return
        }
        
        request?.setMappedCompletionBlockSuccess({ (request, response) in
            let response = response as! AIResponse
            if let textResponse = response.result.fulfillment.speech {
                self.speechAndText(text: textResponse)
            }
        }, failure: { (request, error) in
            print(error!)
        })
        
        ApiAI.shared().enqueue(request)
        txtMessage.text = ""
    }
    
}

//MARK: Other Funcrtions

extension ViewController {
    
    
    func speechAndText(text: String) {
        let speechUtterance = AVSpeechUtterance(string: text)
        speechSynthesizer.speak(speechUtterance)
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
            self.lblResponse.text = text
        }, completion: nil)
    }
}


