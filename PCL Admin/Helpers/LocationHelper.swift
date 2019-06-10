//
//  LocationHelper.swift
//  PCL Admin
//
//  Created by Manoj on 6/7/19.
//  Copyright © 2019 akhil. All rights reserved.
//

import Foundation
import MapKit

class LocationHelper {
    static func getlatlong(address: String, completion: @escaping (_ lat: Double, _ lon: Double) -> Void) {
        let str = "https://nominatim.openstreetmap.org/search/\(address)?format=json"
        let urlString = str.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        guard let requestUrl = URL(string:urlString) else {
            print("could not create url")
            return
        }
        let request = URLRequest(url:requestUrl)
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if error == nil,let usableData = data {
                do {let json = try JSONSerialization.jsonObject(with: usableData) as! [Any]
                    if json.count > 0 {
                        let first = json[0] as! [String : Any]
                        let lat = Double(first["lat"]  as? String ?? "0.0") ?? 0.0
                        let lon = Double(first["lon"]  as? String ?? "0.0") ?? 0.0
                        DispatchQueue.main.async {
                            completion(lat,lon)
                        }
                    }
                } catch {
                    print("json serialization error")
                }
            }
        }
        task.resume()
    }
}

extension MKMapView {
    func fitAll() {
        var zoomRect = MKMapRect.null;
        for annotation in annotations {
            let annotationPoint = MKMapPoint(annotation.coordinate)
            let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0.01, height: 0.01);
            zoomRect = zoomRect.union(pointRect);
        }
        setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50), animated: true)
    }
}
