//
//  MapViewController.swift
//  Insurance
//
//  Created by Rahul Surti on 4/9/17.
//  Copyright © 2017 rahulsurti. All rights reserved.
//

import UIKit
import MapKit
import DTMHeatmap
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {

    var TIVHeatMap: DTMHeatmap!
    var WildfiresUSHeatMap: DTMHeatmap!
    var WildfiresWorldHeatMap: DTMHeatmap!

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        let span: MKCoordinateSpan = MKCoordinateSpanMake(80, 100)
        let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(32.7396323, -086.8434593)
        self.mapView.region = MKCoordinateRegionMake(center, span);
        
        self.TIVHeatMap = DTMHeatmap()
        self.WildfiresUSHeatMap = DTMHeatmap()
        self.WildfiresWorldHeatMap = DTMHeatmap()
        
        var dict: [NSObject : AnyObject] = self.readData(array: self.readFile(filename: "iOS"))
        self.TIVHeatMap.setData(dict);
        
        dict = self.readData(array: self.readFile(filename: "USA"))
        self.WildfiresUSHeatMap.setData(dict);

        dict = self.readData(array: self.readFile(filename: "World"))
        self.WildfiresWorldHeatMap.setData(dict);

        self.mapView.add(self.TIVHeatMap)
    }
    
    func readFile(filename: String) -> [[Double]] {
        if let path = Bundle.main.path(forResource: filename, ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let strings = data.components(separatedBy: .newlines)
                var doubleArray: [[Double]] = []
                for s in strings {
                    if s == "" {
                        continue
                    }
                    let array = s.components(separatedBy: ",")
                    var arr: [Double] = []
                    for i in array {
                        arr.append(Double(i)!)
                    }
                    doubleArray.append(arr)
                    
                }
                return doubleArray
            } catch {
                print("error reading file")
            }
        }
        return [[]]
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    func readData(array: [[Double]]) -> [NSObject : AnyObject] {
        var dict = Dictionary<NSObject, AnyObject>();
        
        for entry in array {
            let coordinate = CLLocationCoordinate2D(latitude: entry[0], longitude: entry[1]);
            let mapPoint = MapKit.MKMapPointForCoordinate(coordinate)
            let value: NSValue = NSValue(mkMapPoint: mapPoint)
            dict[value] = 100 as AnyObject
        }
        
        return dict as [NSObject : AnyObject]
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        return DTMHeatmapRenderer.init(overlay: overlay)
    }
    
    @IBOutlet weak var segControl: UISegmentedControl!
    
    @IBAction func segControlChange(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case 0:
            let overlays: [DTMHeatmap] = [self.WildfiresUSHeatMap, self.WildfiresWorldHeatMap]
            self.mapView.removeOverlays(overlays)
            self.mapView.add(self.TIVHeatMap)
            break
        case 1:
            let overlays: [DTMHeatmap] = [self.TIVHeatMap, self.WildfiresWorldHeatMap]
            self.mapView.removeOverlays(overlays)
            self.mapView.add(self.WildfiresUSHeatMap)
            break
        case 2:
            let overlays: [DTMHeatmap] = [self.TIVHeatMap, self.WildfiresUSHeatMap]
            self.mapView.removeOverlays(overlays)
            self.mapView.add(self.WildfiresWorldHeatMap)
            break
        default:
            break
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
