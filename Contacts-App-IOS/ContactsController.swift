//
//  ContactsController.swift
//  Contacts-App-IOS
//
//  Created by Mehdi Benrefad on 20/04/2021.
//  Copyright © 2021 Mehdi Benrefad. All rights reserved.
//

import UIKit

class ContactsController: UIViewController ,UITableViewDataSource{
    
    var contacts = Contact.All()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        let fullname = contact.nom! + contact.prenom!
        cell.textLabel?.text = fullname
        cell.detailTextLabel?.text = contact.tel
       return cell
    }
    
}
