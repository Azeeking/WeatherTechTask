//
//  ViewController.swift
//  WeatherTask
//
//  Created by Azik on 19.12.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var tableView : UITableView!
    
    var networkManager = NetworkManager()
    var weatherData = [WeatherData]()
    var searchController:UISearchController!
  
    @IBOutlet weak var searchBar: UISearchBar!
    
    var cityArray = ["Warsaw","Bucharest","Martuni","Shah Alam","Karmie","Budapest","Munich","Netivot","Santa Cruz de la Sierra","Porto Alegre","Kfar Yona","Palermo","Bremen","Jermuk","Beit Shemesh","Florence","Utrecht","Buenos Aires","Guayaquil","Rosario","Soledad","Subang Jaya","Valencia","Pasir Gudang","Akhtala"]
    
    var filteredArray : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        filteredArray = cityArray
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSecondView" {
            let secondView = segue.destination as! SecondViewController
            secondView.cityName = sender as! String
          
        }
    }
}

extension ViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if !filteredArray.isEmpty {
            cell.textLabel?.text = filteredArray[indexPath.row]
        } else {
            cell.textLabel?.text = cityArray[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !filteredArray.isEmpty {
            return filteredArray.count
        }
        return cityArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !filteredArray.isEmpty {
            let filteredSelectedCity = filteredArray[indexPath.row]
            performSegue(withIdentifier: "goToSecondView", sender: filteredSelectedCity)
        } else {
            let selectedCity = cityArray[indexPath.row]
            performSegue(withIdentifier: "goToSecondView", sender: selectedCity)
        }
    }
    
    
}

extension ViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredArray = []
        
        if searchText == "" {
            filteredArray = cityArray
        } else {
            
            for city in cityArray {
                if city.lowercased().contains(searchText.lowercased()) {
                    filteredArray.append(city)
                }
            }
        }
       
        self.tableView.reloadData()
    }
}
