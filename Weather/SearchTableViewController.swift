//
//  ViewController.swift
//  Weather
//
//  Created by Abraham Tesfamariam on 11/2/17.
//  Copyright © 2017 RJT Compuquest. All rights reserved.
//

import UIKit
import TWMessageBarManager

class SearchTableViewController: UITableViewController {
    
    var searchController: UISearchController!
    var cities: Array<City> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search City"
        
        searchController = UISearchController(searchResultsController: nil)
        self.tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.definesPresentationContext = true
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell") else { return UITableViewCell() }
        
        let city = cities[indexPath.row]
        cell.textLabel?.text = city.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if cities.isEmpty {
            return "No Cities Available"
        }
        
        return nil
    }
    
    fileprivate func navigateToDetailScreen(_ indexPath: IndexPath) {
        let cityName = cities[indexPath.row].name
        if cities.isEmpty { return }
        
        WeatherService.shared.fetchData(cityName: cityName) { (city, error) in
            if error == nil {
                if let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
                    DispatchQueue.main.async {
                        detailVC.weatherReport = city
                        self.searchController.isActive = false
                        self.navigationController?.pushViewController(detailVC, animated: true)
                    }
                }
            } else {
                let controller = UIAlertController(title: "Error", message: "Data for \(cityName) not available.", preferredStyle: .alert)
                controller.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (alert) in
                    self.searchController.searchBar.text?.removeAll()
                }))
                
                DispatchQueue.main.async {
                    controller.view.layoutIfNeeded()
                    self.searchController.present(controller, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetailScreen(indexPath)
    }

}

extension SearchTableViewController: UISearchResultsUpdating {
    
    /*
     @description: Updates search results as user is typing
     @param: Void
     @return: Void
     */
    func updateSearchResults(for searchController: UISearchController) {
        searchController.obscuresBackgroundDuringPresentation = false
        if let query = searchController.searchBar.text {
            
            if query.isEmpty {
                cities.removeAll()
                tableView.reloadData()
                return
            }
            
            WeatherService.shared.fetchCity(query: query) { (results, error) in
                if error == nil {
                    if let results = results {
                        self.cities = results
                    }
                } else {
                    TWMessageBarManager.sharedInstance().showMessage(withTitle: "Error Updating Results", description: error?.localizedDescription, type: .error)
                    self.cities.removeAll()
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
