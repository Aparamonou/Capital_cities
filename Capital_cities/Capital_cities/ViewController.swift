//
//  ViewController.swift
//  Capital_cities
//
//  Created by Alex Paramonov on 17.05.22.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCapitals()
        setRightButtonItem()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else {return nil}
        
        let id = "Capital"
        
        var anatationView = mapView.dequeueReusableAnnotationView(withIdentifier: id)
        
        if anatationView == nil {
            anatationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: id)
            anatationView?.canShowCallout = true
            let btn  = UIButton(type: .detailDisclosure)
            anatationView?.rightCalloutAccessoryView = btn
        } else {
            anatationView?.annotation = annotation
        }
       
        return anatationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else {return}
        let placeName = capital.title
       
        
        switch placeName! {
        case "London":
            pushViewContoller("https://ru.wikipedia.org/wiki/%D0%9B%D0%BE%D0%BD%D0%B4%D0%BE%D0%BD")
        case "Oslo":
            pushViewContoller("https://ru.wikipedia.org/wiki/%D0%9E%D1%81%D0%BB%D0%BE")
        case "Paris":
            pushViewContoller("https://ru.wikipedia.org/wiki/%D0%9F%D0%B0%D1%80%D0%B8%D0%B6")
        case "Rome":
            pushViewContoller("https://ru.wikipedia.org/wiki/%D0%A0%D0%B8%D0%BC")
        case "Washington DC":
            pushViewContoller("https://ru.wikipedia.org/wiki/%D0%92%D0%B0%D1%88%D0%B8%D0%BD%D0%B3%D1%82%D0%BE%D0%BD")
        default:
            return
        }

    }
    
    private func createCapitals() {
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        mapView.addAnnotations([london, oslo, paris,  rome, washington])
    }
    
    private func pushViewContoller(_ Url: String) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController else {return}
        vc.url = Url
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setRightButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(choseTheme))
        navigationItem.rightBarButtonItem?.tintColor = .red
    }
    
    @objc private func choseTheme() {
        
        let ac = UIAlertController(title: "Chose Theme", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "hybrid", style: .default, handler: { UIAlertAction in
            self.mapView.mapType = .hybrid
        }))
        ac.addAction(UIAlertAction(title: "mutedStandard", style: .default, handler: { UIAlertAction in
            self.mapView.mapType = .mutedStandard
        }))
        ac.addAction(UIAlertAction(title: "hybridFlyover", style: .default, handler: { UIAlertAction in
            self.mapView.mapType = .hybridFlyover
        }))
        ac.addAction(UIAlertAction(title: "satellite", style: .default, handler: { UIAlertAction in
            self.mapView.mapType = .satellite
        }))
        ac.addAction(UIAlertAction(title: "standard", style: .default, handler: { UIAlertAction in
            self.mapView.mapType = .standard
        }))
        
        present(ac, animated: true)
        
    }


}

