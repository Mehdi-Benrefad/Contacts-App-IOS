//
//  AddContactController.swift
//  Contacts-App-IOS
//
//  Created by Mehdi Benrefad on 20/04/2021.
//  Copyright © 2021 Mehdi Benrefad. All rights reserved.
//

import UIKit

class AddContactController: UIViewController {
    @IBOutlet weak var nom: UITextField!
    @IBOutlet weak var prenom: UITextField!
    @IBOutlet weak var tel: UITextField!
    
    @IBOutlet weak var boutonAjouter: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        boutonAjouter.layer.cornerRadius=25.0    }
    
    @IBAction func ajouter(_ sender: Any) {
        //On fait appel au contexte
        let contact=Contact(context: AppDelegate.viewContext)
        //On remplis lw Contexte
        contact.nom = nom.text
        contact.prenom = prenom.text
        contact.tel = tel.text
        //sauvegarder le contexte
        try? AppDelegate.viewContext.save()
       
        //revenir en arriere
        dismiss(animated: true, completion: nil)
        
        
    }
    
    @IBAction func dismiss(_ sender: Any) {
        nom.resignFirstResponder()
        prenom.resignFirstResponder()
        tel.resignFirstResponder()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
