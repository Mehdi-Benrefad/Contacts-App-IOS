//
//  Contact.swift
//  Contacts-App-IOS
//
//  Created by Mehdi Benrefad on 20/04/2021.
//  Copyright © 2021 Mehdi Benrefad. All rights reserved.
//

import Foundation
import CoreData

class Contact:NSManagedObject{
    
    //recuperer tous les contacts
    static func All() -> [Contact]{
        let request:NSFetchRequest <Contact> = Contact.fetchRequest()
        guard let contacts = try? AppDelegate.viewContext.fetch(request) else{
            return []
        }
        return contacts
    }
    
    //supprimer un contact
}

