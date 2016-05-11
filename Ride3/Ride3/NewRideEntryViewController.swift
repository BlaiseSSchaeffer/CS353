//
//  NewRideEntryViewController.swift
//  Ride3
//
//  Created by Blaise Schaeffer on 4/30/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import UIKit

class NewRideEntryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var rideEntry: RideEntry?
    var defaults = NSUserDefaults.standardUserDefaults()
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var newImageView: UIImageView! = nil
    
    private struct Storyboard {
        static let RideEntreisObjectKey = "SavedRideEntries"
    }
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var distanceField: UITextField!
    @IBOutlet weak var timeField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) {}
    }
    
    @IBAction func save(sender: AnyObject) {
        if let title = titleField.text where title != "" {
            if let distance = distanceField.text {
                if let time = timeField.text {
                    rideEntry = RideEntry(rideTitle: title, distance: (distance as NSString).floatValue, time: (time as NSString).floatValue)
                
                    if let decodedEntries = defaults.objectForKey(Storyboard.RideEntreisObjectKey) as? NSData {
                        if var entries = NSKeyedUnarchiver.unarchiveObjectWithData(decodedEntries) as? [RideEntry] {
                            entries.insert(rideEntry!, atIndex: 0)
                        
                            let encodedEntries = NSKeyedArchiver.archivedDataWithRootObject(entries)
                            defaults.setObject(encodedEntries, forKey: Storyboard.RideEntreisObjectKey)
                        }
                    }
                }
            }
        }
        self.dismissViewControllerAnimated(true) {}
    }

    @IBOutlet weak var selectImageButton: UIButton!
    @IBAction func selectImage() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            newImageView.contentMode = .ScaleAspectFill
            newImageView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getImage() -> UIImage? {
        return newImageView.image
    }
}
