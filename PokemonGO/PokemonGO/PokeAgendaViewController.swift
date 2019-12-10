//
//  PokeAgendaViewController.swift
//  PokemonGO
//
//  Created by Matheus Rodrigues Araujo on 09/12/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit

class PokeAgendaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var pokemonsCapturados: [Pokemon] = []
    var pokemonsNaoCapturados:[Pokemon] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coreDataPokemon = CoreDataPokemon()
        self.pokemonsCapturados = coreDataPokemon.recuperarPokemonsCapturados(capturado: true)
        self.pokemonsNaoCapturados = coreDataPokemon.recuperarPokemonsCapturados(capturado: false)
        
        print( String (self.pokemonsNaoCapturados.count) )
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Capturados"
        } else {
            return "Não Capturados"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.pokemonsCapturados.count
        } else {
            return self.pokemonsNaoCapturados.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pokemon:Pokemon
        if indexPath.section == 0 {
            pokemon = self.pokemonsCapturados[ indexPath.row ]
        } else {
            pokemon = self.pokemonsNaoCapturados[ indexPath.row ]
        }
        
        let celula = UITableViewCell(style: .default, reuseIdentifier: "celula")
        celula.textLabel?.text = pokemon.nome
        celula.imageView?.image = UIImage(named:pokemon.nomeImagem!)
        return celula
    }
    

    @IBAction func voltarMapa(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
