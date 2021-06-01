//
//  Protocols.swift
//  Bird App
//
//  Created by TCS on 20/05/2021.
//

import Foundation

protocol UpdateListing {
    func updateStatus(status: String)
    func updateSpecies(species: TBL_SPECIES)
    func updateVarieties(varieties: TBL_VARIETIES)
}

protocol AddNewItems {
    func addNewSpecies()
    func addNewVariety()
    func addNewMutation()
}
