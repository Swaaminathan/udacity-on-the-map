//
//  MapViewControllerExtension.swift
//  udacity-on-the-map
//
//  Created by Russell Austin on 6/11/15.
//  Copyright (c) 2015 Ra Ra Ra. All rights reserved.
//
//  Some ideas from http://www.raywenderlich.com/90971/introduction-mapkit-swift-tutorial

import Foundation
import MapKit

extension MapViewController {
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if let annotation = annotation as? StudentInformation {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
            }
            return view
        }
        return nil
    }
    
    /// save the selected view so it can be used to open the url
    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
        view.addGestureRecognizer(tapGesture)
        selectedView = view
    }
    
    /// Forget the saved view
    func mapView(mapView: MKMapView!, didDeselectAnnotationView view: MKAnnotationView!) {
        selectedView = nil
        view.removeGestureRecognizer(tapGesture)
    }
    
    /// Open the URL for the saved view
    func calloutTapped(sender: MapViewController) {
        if let studentInfo = selectedView!.annotation as? StudentInformation,
            let url = NSURL(string: studentInfo.mediaURL)
        {
                UIApplication.sharedApplication().openURL(url)
        }
    }
}