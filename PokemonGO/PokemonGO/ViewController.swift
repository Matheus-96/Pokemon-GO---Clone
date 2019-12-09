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
        
        //exibir pokemons
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (timer) in
            print("exibe anotacao")
            if let coordenadas = self.gerenciadorLocalizacao.location?.coordinate {
                let anotacao = MKPointAnnotation()
                let latAleatoria = (Double(arc4random_uniform(400)) - 200) / 100000.0
                let lonAleatoria = (Double(arc4random_uniform(400)) - 200) / 100000.0
                anotacao.coordinate = coordenadas
                anotacao.coordinate.latitude += latAleatoria
                anotacao.coordinate.longitude += lonAleatoria
                
                self.mapa.addAnnotation(anotacao)
            }
        }
    }

    // centralizar a localizacao do usuário
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if contador < 3 {
            centralizar()
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
    
    func centralizar() {
        if let coordenadas = gerenciadorLocalizacao.location?.coordinate {
            let regiao = MKCoordinateRegion.init(center: coordenadas, latitudinalMeters: 200, longitudinalMeters: 200)
            mapa.setRegion(regiao, animated: true)
        }
    }
    
    @IBAction func centralizaarJogador(_ sender: Any) {
        centralizar()
    }
    
    @IBAction func abrirPokedex(_ sender: Any) {
    }
}

