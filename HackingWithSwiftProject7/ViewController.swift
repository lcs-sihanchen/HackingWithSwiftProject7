//
//  ViewController.swift
//  HackingWithSwiftProject7
//
//  Created by Chen, Sihan on 2020-03-30.
//  Copyright © 2020 Chen, Sihan. All rights reserved.
//

/*:
 # What is JSON File?
 Short for JavaScript Object Notation
 This is a way of describing data.
 It's not the easiest to read yourself, but it's compact and easy to parse for computers, which makes it popular online where bandwidth is at a premium.
 
 */

/*
 
 Example JSON code(Whitehouse):
    
    {
       "metadata":{
          "responseInfo":{
             "status":200,
             "developerMessage":"OK",
    } },
       "results":[
          {
             "title":"Legal immigrants should get freedom before
    undocumented immigrants – moral, just and fair",
             "body":"I am petitioning President Trump's
    Administration to take a humane view of the plight of legal
    immigrants. Specifically, legal immigrants in Employment Based
    (EB) category. I believe, such immigrants were short changed in
    the recently announced reforms via Executive Action (EA), which
    was otherwise long due and a welcome announcement.",
    "issues":[ {
    "id":"28",
                   "name":"Human Rights"
                },
    {
                "id":"29",
                "name":"Immigration"
             }
          ],
          "signatureThreshold":100000,
          "signatureCount":267,
          "signaturesNeeded":99733,
 }, {
          "title":"National database for police shootings.",
          "body":"There is no reliable national data on how many
          people are shot by police officers each year. In signing this
          petition, I am urging the President to bring an end to this
          absence of visibility by creating a federally controlled,
          publicly accessible database of officer-involved shootings.",
          "issues":[ {
          "id":"28",
                         "name":"Human Rights"
                      }
                   ],
                   "signatureThreshold":100000,
                   "signatureCount":17453,
                   "signaturesNeeded":82547,
          } ]
          }
 
 1. There's a metadata value, which contains a responseInfo value, which in turn contains a status value. Status 200 is what internet developers use for "everything is OK."
 2. There's a results value, which contains a series of petitions.
 3. Each petition contains a title, a body, some issues it relates to, plus some signature
 information.
 4. JSON has strings and integers too. Notice how the strings are all wrapped in quotes,
 whereas the integers aren't.

 Swift has a built-in support called Codable
 Int and String automatically conform to Codable
 
 
 
 
 */

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Download the content(JSON file)
        // let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        
           let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
           // If let to make sure the URL is valid
           // Possibly more URLs here
           if let url = URL(string: urlString) {
              // The method here returns the contents from the URL
              // It may throw some error due to network connection(try?)
              if let data = try? Data(contentsOf: url) {
                // we're OK to parse!
                parse(json: data)
                }
        }
                }
    

    override func tableView(_ tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
       return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt
    indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier:
    "Cell", for: indexPath)
       
       let petition = petitions[indexPath.row]
        
       cell.textLabel?.text = petition.title
       // Subtitle of the cell
       cell.detailTextLabel?.text = petition.body
       
       
       return cell
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        // Petitions.self is a way json decoder to know what to convert, that is to decode the whole type instead of an instance of it
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json){
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
        
    }

    
    

}

