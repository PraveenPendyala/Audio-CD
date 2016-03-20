//
//  DetailViewController.swift
//  ShopCD
//
//  Created by Naga Praveen Kumar Pendyala on 3/7/16.
//  Copyright (c) 2016 Naga Praveen Kumar Pendyala. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!

    @IBOutlet weak var artistTextField: UITextField!

    @IBOutlet weak var yearTextField: UITextField!
    
    var master: UINavigationController? = nil
    
    var detailItem: CD? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: CD = self.detailItem {
            
            self.title = detail.title
            
            if let textfield = self.titleTextField {
                textfield.text = detail.title
            }
            
            if let textfield = self.artistTextField {
                textfield.text = detail.artist
            }
            
            if let textfield = self.yearTextField {
                textfield.text = "\(detail.year)"
            }
        }
        else
        {
            // set the title of the view
            self.title = "Add an Album"
        }
    }
    
    // save the detail item
    func saveCD(){
        
        // get the text field values
        var artist = self.artistTextField.text
        var title = self.titleTextField.text
        var year = self.yearTextField.text
        
        if( artist != "" && title != "" && year != "")
            
        {
            // if Album already exists
            if((self.detailItem) != nil)
            {
                self.detailItem?.setValue(title, forKey: "title")
                self.detailItem?.setValue(artist, forKey: "artist")
                self.detailItem?.setValue(year.toInt()!, forKey: "year")
            }
            else
            {
                // create a new CD
                self.detailItem = CD.createInManagedObjectContext(master!.viewControllers[0].managedObjectContext!, title: title, artist: artist, year: year.toInt()!)
            }
            
            
            // save the data
            var error: NSError? = nil
            self.detailItem?.managedObjectContext?.save(&error)
            master!.popViewControllerAnimated(true)
        }
        else
        {
                // show an alert view if any of the fields are empty
                UIAlertView(title: "ERROR", message: "Please fill all the fields", delegate: self, cancelButtonTitle: "OK").show()
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        master = self.splitViewController?.childViewControllers[0] as? UINavigationController
        
        // set the navigation buttons
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self , action: "saveCD")
        self.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
        self.navigationItem.leftItemsSupplementBackButton = true
        
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

