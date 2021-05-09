//
//  Order.swift
//  CupcakeCorner
//
//  Created by Lucas Parreira on 16/04/21.
//

import Foundation

enum CodingKeys: CodingKey {
    case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
}

class Order:ObservableObject ,Codable {
    //Codigo para aplicar o metodo Encoding da Classe Codable para persistencia de dados
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
        
    }
    
    //Codigo para aplicar o metodo Decoding da classe Codable para persistencia de dados
    required init(from decoder: Decoder) throws {
        var container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        
        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
    
    //Inicializador para instanciar os metodos de persistencia (sem ele, o inicializador padrão não trata o metodo sozinho
    init() {
        //
    }
    
    //HomeView
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 1
    
    @Published var specialRequestEnabled = false {
        didSet{
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    //AdressView
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }

        return true
    }
    
    //CheckoutView
    
    var cost:Double {
        var cost = Double(quantity) * 2
        
        //cakes elaborados custam mais
        cost += (Double(type) / 2)
        
        //$1 a mais para cada cobertura
        if(extraFrosting){
            cost += Double(quantity)
        }
        
        //$0.5 por sprinkles (confeite)
        if(addSprinkles){
            cost += Double(quantity)/2
        }

        return cost
    }
}
