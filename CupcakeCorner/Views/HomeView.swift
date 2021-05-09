//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Lucas Parreira on 15/04/21.
//

import SwiftUI


struct HomeView: View {
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Select your cake type: ",selection: $order.type){
                        ForEach(0..<Order.types.count, id:\.self){
                            Text(Order.types[$0])
                    }
                }
                    Stepper(value: $order.quantity,in:1...20){
                        Text("Number of cakes: \(order.quantity)")
                    }
            }
                Section{
                    Toggle(isOn: $order.specialRequestEnabled.animation()){
                        Text("Any special request?")
                    }
                    if order.specialRequestEnabled {
                        Toggle(isOn: $order.extraFrosting){
                            Text("add extra frosting")
                        }
                        
                        Toggle(isOn: $order.addSprinkles){
                            Text("add sprinkles")
                        }
                    }
                    
                }
                
                Section{
                    NavigationLink(
                        destination: AdressView(order: order)){
                            Text("Delivery Details")
                        }
                    }
                }
            .navigationBarTitle("Cupcake Corner")
          }
            
        
        }
    }

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
