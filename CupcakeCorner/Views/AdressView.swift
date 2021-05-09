//
//  AdressView.swift
//  CupcakeCorner
//
//  Created by Lucas Parreira on 16/04/21.
//

import SwiftUI

struct AdressView: View {
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Name : ",text: $order.name)
                    TextField("Street Adress : ",text: $order.streetAddress)
                    TextField("City : ",text: $order.city)
                    TextField("Zip : ",text:$order.zip)
                }
            
                Section{
                    NavigationLink(
                        destination: CheckoutView(order: order)){
                            Text("Check out")
                     }
                    .disabled(order.hasValidAddress == false)
                    }
                }
            .navigationBarTitle("Delivery Details")
            }
        }
}

struct AdressView_Previews: PreviewProvider {
    static var previews: some View {
        AdressView(order: Order())
    }
}
