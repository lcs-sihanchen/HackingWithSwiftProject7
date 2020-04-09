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
    
    var filterPetitions = [Petition]()
    
    var isFiltered = false
    
    var canBeRefreshed = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Download the content(JSON file)
        // let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        let credits = UIBarButtonItem(title: "Credit", style: .plain, target: self, action: #selector(showCredit))
        
        let reset = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetting))
        
        
        navigationItem.rightBarButtonItems = [credits, reset]
        
        
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searching))
        navigationItem.leftBarButtonItem = search
        
        
        
        
        
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        // If let to make sure the URL is valid
        // Possibly more URLs here
        if let url = URL(string: urlString) {
            // The method here returns the contents from the URL
            // It may throw some error due to network connection(try?)
            if let data = try? Data(contentsOf: url) {
                // we're OK to parse!
                parse(json: data)
                return
            }
        }
        showError()
        
        
        
    }
    
    @objc func resetting() {
        canBeRefreshed = true
        tableView.reloadData()
        
    }
 
    @objc func searching(){
        let ac = UIAlertController(title: "Enter the keyword", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            
            // The part I'm still confused
            [weak self, weak ac] action in
            
            guard let userAnswer = ac?.textFields?[0].text else {
                return
            }
            
            self?.filter(with: userAnswer)
            
        }
        
        
        ac.addAction(submitAction)
        present(ac, animated: true)
        filterPetitions.removeAll()
    }
    
    func filter(with word: String){
        
        for n in 0...petitions.count - 1 {
            if petitions[n].title.lowercased().contains(word.lowercased()){
                filterPetitions.append(petitions[n])
            }
        }
        
        guard !filterPetitions.isEmpty else {
            let ac = UIAlertController(title: "Error", message: "The petition with the keyword \(word) does not exist.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .cancel))
            present(ac, animated: true)
            return
        }
        
        isFiltered = true
        tableView.reloadData()
        
    }
    
    @objc func showCredit() {
        let ac = UIAlertController(title: "Credit", message: "The data comes from the We The People API of the Whitehouse.", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default))
        
        present(ac, animated: true)
    }
   @objc override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        if isFiltered == false {
            return petitions.count
        } else if isFiltered == true {
            return filterPetitions.count
        } else {
            return petitions.count
    }
    }
    
   @objc override func tableView(_ tableView: UITableView, cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "Cell", for: indexPath)
        
        var petition: Petition
        // access the petitions in the array
        if isFiltered == false {
            petition = petitions[indexPath.row]
        } else if isFiltered == true {
            petition = filterPetitions[indexPath.row]
        } else {
            petition = petitions[indexPath.row]
    }
        
        
        // Now constant petition is of type PETITION, therefore it can use its property ".title"
        cell.textLabel?.text = petition.title
        // Subtitle of the cell
        cell.detailTextLabel?.text = petition.body
        
        isFiltered = false
        filterPetitions = []
        return cell
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        // Petitions.self is a way json decoder to know what to convert, that is to decode the whole type instead of an instance of it
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json){
            petitions = jsonPetitions.results
            
            // Everytime the view has been opened, refresh
            
            tableView.reloadData()
        }
        
    }
    
    // This time there is no detail view controller in user interface therefore it will be much easier to load the view directly from the code
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        if isFiltered == false {
            vc.detailItem = petitions[indexPath.row]

        } else if isFiltered == true {
            vc.detailItem = filterPetitions[indexPath.row]

        } else {
            vc.detailItem = petitions[indexPath.row]
        }
        navigationController?.pushViewController(vc, animated: true)
        isFiltered = false
    }
    
    // Show the error if the webView does not load or if let statements doesn't pass
    func showError() {
        let ac = UIAlertController(title: "Loading error", message:
            "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
}

