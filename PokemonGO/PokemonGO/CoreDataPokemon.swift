//
//  CoreDataPokemon.swift
//  PokemonGO
//
//  Created by Matheus Rodrigues Araujo on 09/12/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit
import CoreData

class CoreDataPokemon {
    
    // recupera contexto
    func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        return context!
    }
    
    func recuperarPokemonsCapturados(capturado: Bool) -> [Pokemon] {
        print(capturado)
        let context = self.getContext()
        let requisicao = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
        let predicate =  NSPredicate(format: "capturado = %i" , capturado as CVarArg)
        requisicao.predicate = predicate
        do {
            let pokemons = try context.fetch(requisicao) as [Pokemon]
            print(pokemons)
            return pokemons
        } catch  {  }
        
        return []
    }
    
    
    func recuperarTodosPokemons() -> [Pokemon]{
        let context = getContext()
        do {
            let pokemons = try context.fetch( Pokemon.fetchRequest() ) as! [Pokemon]
            
            if pokemons.count == 0 {
                self.adcionarTodosPokemons()
                return self.recuperarTodosPokemons()
            }
            return pokemons
        } catch  {}
        return []
    }
    
    //adiciona todos os pokemons
    func adcionarTodosPokemons(){
        
        let context = getContext()
        
        self.criarPokemon(nome: "Mew", nomeImagem: "mew", capturado:false)
        self.criarPokemon(nome: "Meowth", nomeImagem: "meowth", capturado: false)
        self.criarPokemon(nome: "Pikachu", nomeImagem: "pikachu-2", capturado: true)
        self.criarPokemon(nome: "Squirtle", nomeImagem: "squirtle", capturado: false)
        self.criarPokemon(nome: "Charmander", nomeImagem: "charmander", capturado: false)
        self.criarPokemon(nome: "Caterpie", nomeImagem: "caterpie", capturado: false)
        self.criarPokemon(nome: "Bullbasaur", nomeImagem: "bullbasaur", capturado: false)
        self.criarPokemon(nome: "Bellsprout", nomeImagem: "bellsprout", capturado: false)
        self.criarPokemon(nome: "Psyduck", nomeImagem: "psyduck", capturado: false)
        self.criarPokemon(nome: "Rattata", nomeImagem: "rattata", capturado: false)
        self.criarPokemon(nome: "Zubat", nomeImagem: "zubat", capturado: false)
        
        do {
            try context.save()
        } catch  {
            
        }
    }
    
    //criar os pokemons
    func criarPokemon(nome:String, nomeImagem:String, capturado:Bool) {
        
        let context = self.getContext()
        let pokemon = Pokemon(context: context)
        pokemon.nome = nome
        pokemon.nomeImagem = nomeImagem
        pokemon.capturado = capturado
    }
    
}
