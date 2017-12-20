//
//  MainViewController.swift
//  MapLocationApp
//
//  Created by Mobile Developer on 12/8/17.
//  Copyright © 2017 Jin Xing. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MainViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource , MKMapViewDelegate {

    @IBOutlet weak var switchBtn: UIButton!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var displayView: UIView!
    @IBOutlet var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    
    var titleArr: [String] = []
    var artistArr: [String] = []
    var yearArr: [String] = []
    var informationArr: [String] = []
    var latArr: [String] = []
    var longArr: [String] = []
    var locationArr: [String] = []
    var fileNameArr: [String] = []
    
    var image: UIImage? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getArtworksData()
        showMap()
        
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        mapView.delegate = self
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // Delegate Method
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let userLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(userLocation, span)
        
        mapView.setRegion(region, animated: true)
        self.mapView.showsUserLocation = true
    }
    
    // Get Artworks data
    
    func getArtworksData() {
        
        let url=URL(string:ARTWORKS_URL)
        do {
            let allContactsData = try Data(contentsOf: url!)
            let allContacts = try JSONSerialization.jsonObject(with: allContactsData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : NSArray]
            if let arrJSON = allContacts["artworks"] {
                for index in 0...arrJSON.count-1 {
                    
                    let aObject = arrJSON[index] as! [String: Any]
                    
                    titleArr.append(aObject["title"] as! String)
                    artistArr.append(aObject["artist"] as! String)
                    yearArr.append(aObject["yearOfWork"] as! String)
                    informationArr.append(aObject["Information"] as! String)
                    latArr.append(aObject["lat"] as! String)
                    longArr.append(aObject["long"] as! String)
                    locationArr.append(aObject["locationNotes"] as! String)
                    fileNameArr.append(aObject["fileName"] as! String)
                    
                }
            }
            
            if (titleArr.count) != 0 {
                addAnnotation()
                self.tableView.reloadData()
            }
        }
        catch {
            
        }
        
    }
    
    // Add the annotation in Map
    
    func addAnnotation(){
        for i in 0 ... titleArr.count-1 {
            
            let coordinates = CLLocationCoordinate2DMake((latArr[i] as NSString).doubleValue, (longArr[i] as NSString).doubleValue)
            let annotation = LocationMapAnnotation(title: titleArr[i], subtitle: artistArr[i], coordinate: coordinates)

            mapView.addAnnotation(annotation)
            
            mapView.selectAnnotation(annotation, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView,
                 didSelect view: MKAnnotationView)
    {
        // 1
        if view.annotation is MKUserLocation
        {
            // Don't proceed with custom callout
            return
        }
        
        print("Annotation selected")
        
        if let annotation = view.annotation as? LocationMapAnnotation {
            
            for i in 0 ... titleArr.count-1 {
                if annotation.title == titleArr[i] {
                    showDetailView(i: i)
                }
            }
        }
        
    }
    
    // TableView implement
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.titleArr.count;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        showDetailView(i: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identity_cell", for: indexPath) as! ArtistTableViewCell
        cell.cell_Title.text = self.titleArr[indexPath.row]
        cell.cell_Artist.text = self.artistArr[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // Display the data in MapView
    func showMap() {
        switchBtn.setTitle("Table", for: .normal)
        displayView.isHidden = true
    }
    
    // Display the data in TableView
    func showTable() {
        switchBtn.setTitle("Map", for: .normal)
        displayView.isHidden = false
    }
    
    func showDetailView(i: Int) {
        
        GlobalData.titleStr = self.titleArr[i]
        GlobalData.artistStr = self.artistArr[i]
        GlobalData.yearStr = self.yearArr[i]
        GlobalData.informationStr = self.informationArr[i]
        GlobalData.locationStr = self.locationArr[i]
        GlobalData.filenameStr = self.fileNameArr[i]
        
        let detailView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: SHOW_DETAIL) as! DetailViewController
        navigationController?.pushViewController(detailView, animated: true)
    }
    
    @IBAction func switchBtn_clicked(_ sender: UIButton) {
        
        if switchBtn.titleLabel?.text == "Map" {
            showMap()
        } else if switchBtn.titleLabel?.text == "Table" {
            showTable()
        }
    }
    
    
}

