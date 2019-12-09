//
//  PokemonAnotacao.swift
//  PokemonGO
//
//  Created by Matheus Rodrigues Araujo on 09/12/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit
import MapKit

class PokemonAnotacao: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var pokemon: Pokemon
    
    init(coordenadas:CLLocationCoordinate2D, pokemon:Pokemon) {
        self.coordinate = coordenadas
        self.pokemon = pokemon
    }
    
}
