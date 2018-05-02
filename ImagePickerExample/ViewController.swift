//
//  ViewController.swift
//  ImagePickerExample
//
//  Created by Ricardo V Del Frari on 02/05/2018.
//  Copyright © 2018 Ricardo V Del Frari. All rights reserved.
//

import UIKit

 //Adopt the UIImagePickerControllerDelegate protocol because ViewController will be in charge of presenting the image picker controller, it also needs to adopt the UINavigationControllerDelegate protocol, which simply lets ViewController take on some basic navigation responsibilities.
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: Properties
    
    //Don't forget to set User Interaction Enabled to true on the Attributes Inspector for the image
    @IBOutlet weak var exampleImage: UIImageView!
    
    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    let imagePickerController = UIImagePickerController()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //To edit the picture after choosing
        imagePickerController.allowsEditing = true
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        setupAlertController()
    }
    
    //MARK: AlertController
    func setupAlertController() {
        
        let action1 = UIAlertAction(title: "Take Photo", style: .default) { (action:UIAlertAction) in
            print("Take Photo pressed");
            
            //Allow to take photos.
            // Add 'Privacy - Camera Usage Description' on the Info.plist
            self.imagePickerController.sourceType = .camera
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
        
        let action2 = UIAlertAction(title: "Choose Photo", style: .default) { (action:UIAlertAction) in
            print("Choose Photo");
            
            // Only photos to be picked, not taken.
            // Add 'Privacy - Photo Library Usage Description' on the Info.plist
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
        
        alert.addAction(action1)
        alert.addAction(action2)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Default action"), style: .cancel, handler: { _ in
            NSLog("Cancel alert.")
        }))
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the Edited Image.
        guard let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }

        // Set exampleImage to display the selected image.
        exampleImage.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }

    //MARK: Actions
    @IBAction func selectImage(_ sender: UITapGestureRecognizer) {
        print("Show Alert")
        self.present(alert, animated: true, completion: nil)
    }
    
}

