//
//  PokeAgendaViewController.swift
//  PokemonGO
//
//  Created by Matheus Rodrigues Araujo on 09/12/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit

class PokeAgendaViewController: UIViewController {
    
    var pokemonsCapturados: [Pokemon] = []
    var pokemonsNaoCapturados:[Pokemon] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let coreDataPokemon = CoreDataPokemon()
//        let pokemons = coreDataPokemon.recuperarTodosPokemons()
//        print(pokemons)
        self.pokemonsCapturados = CoreDataPokemon().recuperarPokemonsCapturados(capturado: true)
        self.pokemonsNaoCapturados = CoreDataPokemon().recuperarPokemonsCapturados(capturado: false)
        
        print( String (self.pokemonsNaoCapturados.count) )
        
    }

    @IBAction func voltarMapa(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
