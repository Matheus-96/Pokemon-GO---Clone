//
//  ViewController.swift
//  PokemonGO
//
//  Created by Matheus Rodrigues Araujo on 09/12/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapa: MKMapView!
    var gerenciadorLocalizacao = CLLocationManager()
    var contador = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        mapa.delegate = self
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()
    }

    // centralizar a localizacao do usuário
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if contador < 3 {
            if let coordenadas = gerenciadorLocalizacao.location?.coordinate {
                let regiao = MKCoordinateRegion.init(center: coordenadas, latitudinalMeters: 200, longitudinalMeters: 200)
                mapa.setRegion(regiao, animated: true)
            }
            contador += 1
        } else {
            gerenciadorLocalizacao.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           if status != .authorizedWhenInUse && status != .notDetermined {
               // alerta
               let alertController = UIAlertController(title: "Permissao de Localizacao", message: "Para que voce possa cacar pokemons, precisamos de sua localizacao! por favor habilite", preferredStyle: .alert)
               let acaoConfiguracao = UIAlertAction(title: "Abrir Configuracoes", style: .default) { (alertaConfiguracoes) in
                   if let configuracoes = NSURL(string: UIApplication.openSettingsURLString) {
                       UIApplication.shared.open(configuracoes as URL)
                   }
               }
               let acaoCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
               alertController.addAction(acaoConfiguracao)
               alertController.addAction(acaoCancelar)
               present(alertController, animated: true, completion: nil)
           }
       }
}

