//
//  ContentView.swift
//  Testing
//
//  Created by Shell on 6/26/21.
//

import SwiftUI
import CoreLocation
import V2binding

struct ContentView: View {
    var LocationAssistInst = LocationAssist()
    
    init() {
        V2bindingStartAPIInstance("todo")
    }
    var body: some View {
        Text("The V2Ray/V2Fly instance should be running in background.\nLocation is required for it to stay in background.")
            .padding()
        Button("Open UI in Browser"){
            if let url = URL(string: "http://127.0.0.1:18888"){
                UIApplication.shared.open(url)
            }
        }.padding()
        Button("Enable Location Access"){
            LocationAssistInst.createLocationAccess()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class LocationAssist: NSObject, CLLocationManagerDelegate{
    var locationmgr = CLLocationManager()
    func createLocationAccess(){
        locationmgr.delegate = self;
        locationmgr.requestWhenInUseAuthorization()
        switch(locationmgr.authorizationStatus){
        case .notDetermined, .restricted, .denied:
            //no access
        break
        case .authorizedAlways, .authorizedWhenInUse:
            startlistenlocation()
        }
    }
    func startlistenlocation(){
        locationmgr.distanceFilter = kCLDistanceFilterNone
        locationmgr.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationmgr.allowsBackgroundLocationUpdates = true
        locationmgr.startUpdatingLocation()
    }
    
    
    
}

