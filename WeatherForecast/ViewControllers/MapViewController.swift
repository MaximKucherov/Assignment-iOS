//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Maxim Kucherov on 23/11/2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var mapView: MKMapView!
    var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Создаем экземпляр MKMAPView
        mapView = MKMapView()
        
        // Установите фрейм (размер и положение) карты
        mapView.frame = view.bounds
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Добавьте карту в иерархию представлений
        view.addSubview(mapView)
        
        // Создаем UISegmentedControl с двумя сегментами
        segmentedControl = UISegmentedControl(items: ["Standard", "Satellite"])
        segmentedControl.selectedSegmentIndex = 0 // Выбираем стандартный вид при загрузке
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        segmentedControl.tintColor = .gray
        segmentedControl.selectedSegmentTintColor = .gray
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        
        // Создаем UIButton с изображением местоположения
        let locationButton = UIButton(type: .system)
        locationButton.setImage(UIImage(systemName: "location"), for: .normal)
        locationButton.tintColor = .purple
        locationButton.addTarget(self, action: #selector(locationButtonPressed), for: .touchUpInside)

        // Создаем UIStackView для размещения UISegmentedControl и UIImageView
        let stackView = UIStackView(arrangedSubviews: [segmentedControl, locationButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 100

        // Создаем дополнительный UIView с черным фоном
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -44),
            backgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        // Устанавливаем UIStackView в дополнительный UIView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -8)
        ])
    
        // Добавляем разделительную линию
        let separatorLine = UIView()
        separatorLine.backgroundColor = .gray
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separatorLine)
        NSLayoutConstraint.activate([
            separatorLine.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorLine.topAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        // Отобразите текущее местоположение пользователя
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        let _ = LocationManager()
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        // Обработка изменений значения UISegmentedControl
        switch sender.selectedSegmentIndex {
        case 0:
            // Переключение на стандартный вид карты
            mapView.mapType = .standard
        case 1:
            // Переключение на спутниковый вид карты
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    @objc func locationButtonPressed() {
        guard let userLocation = mapView.userLocation.location else {
            return
        }
        
        mapView.setCenter(userLocation.coordinate, animated: true)
    }
}

