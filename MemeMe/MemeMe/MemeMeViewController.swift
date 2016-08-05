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
        
        imagePickerView.contentMode = UIViewContentMode.ScaleAspectFit
        
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
    
    func save() -> Meme{
        let meme = Meme(top: topTextField.text!, bottom: bottomTextField.text!, original: imagePickerView.image!, meme: generateMemeImage())
        return meme
    }
    
    func generateMemeImage() -> UIImage {
        UIGraphicsBeginImageContext(self.view.frame.size)
        
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return memedImage
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
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func shareImage(sender: AnyObject) {
        let meme = save()
        if let image = meme.memeImage {
            let activityController =
                UIActivityViewController(activityItems: [image],
                                         applicationActivities: nil)
            self.presentViewController(activityController, animated: true, completion: nil)
        }
        
        
    }

    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            configImageViewSize()
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func configImageViewSize() {
        if let image = imagePickerView.image {
            var imageProportion = image.size.width / imagePickerView.bounds.size.width
            if imageProportion < 0 {
                imagePickerView.bounds.size.height = image.size.height * imageProportion
            } else {
                imageProportion = imagePickerView.bounds.size.width / image.size.width
                imagePickerView.bounds.size.height = image.size.height * imageProportion
            }
        }
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

