//
//  ContactsController.swift
//  Contacts-App-IOS
//
//  Created by Mehdi Benrefad on 20/04/2021.
//  Copyright © 2021 Mehdi Benrefad. All rights reserved.
//

import UIKit

class ContactsController: UIViewController ,UITableViewDataSource , UITableViewDelegate{
    
    var contacts = Contact.All()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   //on declare le controlleur comme cible potencielle d'un unwind segue
    @IBAction func unwindToWelcome(segue:UIStoryboardSegue) {
        contacts = Contact.All()
        tableView.reloadData()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contacts = Contact.All()
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
       //on charge chaque "Movie" dans sa cellule correspondante
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        let contact = contacts[indexPath.row]
        let fullname = contact.nom! + " " + contact.prenom!
        cell.textLabel?.text = fullname
        cell.detailTextLabel?.text = contact.tel
       return cell
    }
    
    
    
    //supprimer un contact[utiliser la valeur par defaut]
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        /*
        if editingStyle == .delete
        {
            //tableView.deleteRows(at: [indexPath], with: .automatic)
            let contactToRemove = contacts[indexPath.row]
            AppDelegate.viewContext.delete(contactToRemove)
            try? AppDelegate.viewContext.save()
            //rafraichire la page
            contacts = Contact.All()
            tableView.reloadData()
            
        }
         */
    }
    
    
    /*
        Personnliser le style d'edition des lignes:
            +[SUPPRIMER UN CONTACT]
            +[EFFECTUER UN APPEL]
     */
    //************************************************************************************************
        func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
        
        func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
            
            //bouton supprimer
            let deleteButton = UITableViewRowAction(style: .normal , title: "Delete"){ (rowAction , indexpath) in
                
                //tableView.deleteRows(at: [indexPath], with: .automatic)
                let contactToRemove = self.contacts[indexPath.row]
                           AppDelegate.viewContext.delete(contactToRemove)
                           try? AppDelegate.viewContext.save()
                           //rafraichire la page
                            self.contacts = Contact.All()
                           tableView.reloadData()
                
            }
            deleteButton.backgroundColor = #colorLiteral(red: 0.9528660178, green: 0.5290379524, blue: 0.5794923902, alpha: 1)
            
            
            //boutton appeler
            let callButton = UITableViewRowAction(style: .normal , title: "Call"){ (rowAction , indexpath) in
                
                //tableView.deleteRows(at: [indexPath], with: .automatic)
                
            }
            callButton.backgroundColor = #colorLiteral(red: 0.7834928632, green: 0.9266354442, blue: 0.6264371276, alpha: 1)
            
            return [deleteButton , callButton]
        }
    //*************************************************************************************************
    
    
    
    //modifier un contact via une alerte
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //select contact
        let contact = contacts[indexPath.row]
        print("hello")
        //creer une alerte
        let alertVC = UIAlertController(title: "Edit Person", message: "Entrer le nom , le prenom puis le telephone", preferredStyle:.alert)
       
        //creer les labels pour l'alerte
        //let label = UILabel(frame: CGRect(x: 0, y: 30, width: 50, height: 50))
        //label.text = "Nom/prenom/Telephone"
        //alertVC.view.addSubview(label)
        
        //creer les textfields pour l'alerte
        alertVC.addTextField()
        alertVC.addTextField()
        alertVC.addTextField()
        
        //recuperer les champs de l'alerte
        var nom = alertVC.textFields![0]
        var prenom = alertVC.textFields![1]
        var tel = alertVC.textFields![2]
        
        //remplir les champs par les anciennes valeurs
        nom.text = contact.nom
        prenom.text = contact.prenom
        tel.text = contact.tel
        
        //on met un ecouteur sur le bouton save
        let saveButton = UIAlertAction(title: "save" , style: .default){ (action) in
            
            //on remliot le contact par les nouvelles valeurs
            contact.nom=alertVC.textFields![0].text
            contact.prenom=alertVC.textFields![1].text
            contact.tel=alertVC.textFields![2].text
            
            //on enregistre les nouvelles donnees
            do{
                try AppDelegate.viewContext.save()
            }catch{
                
            }
            
            self.contacts = Contact.All()
            tableView.reloadData()
            
        }
        
        //ajouter une action a l'alerte
        alertVC.addAction(saveButton)
        //lancer l'alerte
        self.present(alertVC, animated: true, completion: nil)
        
        //reload data
        contacts = Contact.All()
        tableView.reloadData()
    }
}
