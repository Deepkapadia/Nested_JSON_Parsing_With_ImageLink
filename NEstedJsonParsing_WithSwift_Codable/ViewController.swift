//
//  ViewController.swift
//  NEstedJsonParsing_WithSwift_Codable
//
//  Created by DeEp KapaDia on 27/01/19.
//  Copyright © 2019 DeEp KapaDia. All rights reserved.
//

import UIKit

struct Heroes : Decodable {
    
    let localized_name : String
    let img : String
    
}

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var TableViewOL: UITableView!
    
    var Hero = [Heroes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://api.opendota.com/api/heroStats")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error == nil {
                do{
                    self.Hero = try JSONDecoder().decode([Heroes].self, from: data!)
                    
                }catch{
                    
                    print("parse error")
                    
                }
                
                DispatchQueue.main.async {
               
                    self.TableViewOL.reloadData()
                    
                }
                
            }
            
            }.resume()
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Hero.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        
        cell.name.text = Hero[indexPath.row].localized_name.capitalized
        
        let defaultlink = "https://api.opendota.com"
        
        let completelink = defaultlink + Hero[indexPath.row].img
        
        cell.IMG.downloadedFrom(link: completelink)
        
        cell.IMG.layer.cornerRadius = cell.IMG.frame.height / 2
        
        cell.IMG.contentMode = .scaleAspectFill
        
        
        return cell
        
    }
    
    
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}


