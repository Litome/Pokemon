//
//  PokemonTests.swift
//  PokemonTests
//
//  Created by Lisandre Taylor on 21/05/2024.
//

import XCTest

final class PokemonTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPokemonsEquality() throws {
        let pokemon1 = PokemonNWM(name: "Poke1", url: "SameURL")
        let pokemon2 = PokemonNWM(name: "Poke2", url: "SameURL")
        let pokemon3 = PokemonNWM(name: "Poke1", url: "DifferentURL")

        XCTAssertEqual(pokemon1, pokemon3, "Pokemons with the same name are the same, as the names should be unique")
        XCTAssertNotEqual(pokemon1, pokemon2, "Pokemons with different name are unique, even if they have the same URL and thus the same details")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
