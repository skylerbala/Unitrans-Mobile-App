//
//  TabBarVC.swift
//  Unitrans
//
//  Created by Skyler Bala on 8/21/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit
import UIColor_Hex_Swift

class TabBarVC: UITabBarController, UISearchResultsUpdating {
        
    var searchController: UISearchController!
    var lines: [Line]! = [Line]()
    var groupDispatch: DispatchGroup! = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
        apiService()
        setNavBar()
        
        let allVC = self.viewControllers
        let linesVC = allVC![1] as! LinesVC
        linesVC.linesDisplayDelegate = self
    }

    func setTabBar() {
        let mapVC = MapVC()
        mapVC.tabBarItem = UITabBarItem(title: "Map", image: nil, selectedImage: nil)
        let linesVC = LinesVC()
        linesVC.tabBarItem = UITabBarItem(title: "Lines", image: nil, selectedImage: nil)
        
        self.viewControllers = [mapVC, linesVC]
        
    }
    
    func setNavBar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search"
        self.navigationItem.searchController = searchController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func updateLines() {
        let allVC = self.viewControllers
        let linesVC = allVC![1] as! LinesVC
        linesVC.lines = self.lines
    }
    
    func apiService() {
        self.groupDispatch.enter()
        Alamofire.request("http://webservices.nextbus.com/service/publicJSONFeed?command=routeConfig&a=unitrans").responseJSON { (response) in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
                        
            if let data = response.data {
                let json = JSON(data)
                let lines = json["route"].arrayValue
                for line in lines {
                    let lineTitle = line["title"].stringValue
                    let lineColor = UIColor.blue
                    let lineOppositeColor = UIColor.white
                    
                    let stops = line["stop"].arrayValue
                    
                    var lineStops = [Stop]()
                    
                    for stop in stops {
                        let lat = Double(stop["lat"].stringValue)!
                        let lon = Double(stop["lon"].stringValue)!
                        let title = stop["title"].stringValue
                        
                        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                        let newStop = Stop(lat: lat, lon: lon, title: title)
                        
                        lineStops.append(newStop)
                    }
                    
                    let points = line["path"].arrayValue
                    
                    var path = [[CLLocationCoordinate2D]]()
                    
                    for point in points {
                        let coordinates = point["point"].arrayValue
                        var pathA = [CLLocationCoordinate2D]()
                        for coordinate in coordinates {
                            let lon = Double(coordinate["lon"].stringValue)!
                            let lat = Double(coordinate["lat"].stringValue)!
                            pathA.append(CLLocationCoordinate2D(latitude: lat, longitude: lon))
                        }
                        path.append(pathA)
                    }
                    
                    
                    let newLine = Line(lineTitle: lineTitle, color: lineColor, oppositeColor: lineOppositeColor, stops: lineStops, path: path)
                    
                    self.lines.append(newLine)
                    lineStops = [Stop]()
                    path = [[CLLocationCoordinate2D]()]
                }
            }
            self.groupDispatch.leave()
        }
        groupDispatch.notify(queue: .main, execute: {
            self.updateLines()
        })
    }
}

extension TabBarVC: LinesDisplayDelegate {
    func updateLinesDisplay(lines: [Line]) {
        self.lines = lines/Users/admin/Desktop/Developer/CreateML.playground
        let allVC = self.viewControllers
        let mapVC = allVC![0] as! MapVC
        
        // UpdateMap
        
        for line in self.lines {
            if (line.isDisplayed) {
                let stops = line.stops
                mapVC.mapView.addAnnotations(stops)
                let coordinates = line.stops.map({ (stop) -> CLLocationCoordinate2D in
                    return stop.coordinate
                })
                for pathA in line.path {
                    let polyline = MKPolyline(coordinates: pathA, count: pathA.count)
                    
                    //
                    
                    mapVC.mapView.add(polyline)
                }
            }
            else {
                let stops = line.stops
                mapVC.mapView.removeAnnotations(stops)
            }
        }
    }
}
