//
//  MeteorMapViewController.swift
//  meteor-explorer-app
//
//  Created by Feranmi on 17/09/2021.
//

import MapKit
import UIKit

final class MeteorMapViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet var navItem: UINavigationItem!
    
    var meteor: MeteorModel?
    let notificationCenter = NotificationCenter.default

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupView()
    }
    
    private func setupView() {
        overrideUserInterfaceStyle = .dark
        navItem.title = meteor?.name ?? ""
        favoriteButton.accessibilityIdentifier = "favorite-button"
        favoriteButton.target = self
        favoriteButton.action = #selector(onFavouritePressed(_:))
        
        backButton.accessibilityIdentifier = "back-button"
        backButton.target = self
        backButton.action = #selector(onBackPressed(_:))
        
        let isFavourite = FavoritesManager.favouriteCheck(id: meteor?.id ?? "")
        toggleFavouriteButton(isFavourite)
        setupMap()
    }
    
    private func setupMap() {
        guard let model = meteor else {
            return
        }
        
        let mass = convertMassToKg(mass: model.mass ?? "")
        let date = formatDate(dateString: model.year ?? "")
        let annotation = MKPointAnnotation()
        annotation.title = model.name
        annotation.subtitle = "(\(date), \(mass) kg)"
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(model.geolocation?.coordinates[1] ?? 0),
                                                       longitude: CLLocationDegrees(model.geolocation?.coordinates[0] ?? 0))
        
        mapView.addAnnotation(annotation)
        mapView.setCenter(annotation.coordinate, animated: false)
    }

    @objc func onBackPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @objc func onFavouritePressed(_ sender: UIBarButtonItem) {
        FavoritesManager.toggleFavorites(meteor) { result in
            toggleFavouriteButton(result)
        }
        
        notificationCenter.post(name: .onMeteorFavourited, object: nil)
    }
    
    func toggleFavouriteButton(_ on: Bool) {
        if on {
            favoriteButton.image = UIImage(named: "favourite-filled")
            favoriteButton.tintColor = .appGreen
        }
        else {
            favoriteButton.image = UIImage(named: "favourite")
            favoriteButton.tintColor = .greyDF
        }
    }
}
