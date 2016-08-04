//
//  ViewController.swift
//  MemeMe
//
//  Created by Guilherme Silva on 03/08/16.
//  Copyright © 2016 Guilherme B G Silva. All rights reserved.
//

import UIKit

class MemeMeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    
    var activeTextField: UITextField?
    
//    let memeFont = [
//        NSStrokeColorAttributeName : UIColor.blackColor(),
//        NSForegroundColorAttributeName : UIColor.whiteColor(),
//        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
//        NSStrokeWidthAttributeName : 0.5
//    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.delegate = self
        bottomTextField.delegate = self
        
//        topTextField.defaultTextAttributes = memeFont
//        bottomTextField.defaultTextAttributes = memeFont
//        topTextField.attributedText = NSAttributedString(string: "TOP", attributes: memeFont)
//        bottomTextField.attributedText = NSAttributedString(string: "BOTTOM", attributes: memeFont)
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeToKeyboardNotifications()
    }
    
    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("User cancelled the action")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("User picked an image")
        
//        let UIImagePickerControllerMediaType: String
//        let UIImagePickerControllerOriginalImage: String
//        let UIImagePickerControllerEditedImage: String
//        let UIImagePickerControllerCropRect: String
//        let UIImagePickerControllerMediaURL: String
//        let UIImagePickerControllerReferenceURL: String
//        let UIImagePickerControllerMediaMetadata: String
//        let UIImagePickerControllerLivePhoto: String
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            imagePickerView.contentMode = UIViewContentMode.ScaleAspectFit
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
        activeTextField = textField
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let text = textField.text {
            if text == "" {
                switch textField {
                case bottomTextField:
                    textField.text = "BOTTOM"
                case topTextField:
                    textField.text = "TOP"
                default:
                    break
                }
            }
        }
        textField.resignFirstResponder()
        return false
    }
    
    // MARK: moving view when keyboard appears
    func keyBoardWillShow(notification: NSNotification){
        if activeTextField != nil && activeTextField == bottomTextField{
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyBoardWillHide(notification: NSNotification){
        if activeTextField != nil && activeTextField == bottomTextField{
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyBoardWillShow(_:)) , name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyBoardWillHide(_:)) , name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
}

