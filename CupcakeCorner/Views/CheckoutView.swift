//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Lucas Parreira on 16/04/21.
//

import SwiftUI

struct CheckoutView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var order = Order()
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        GeometryReader{view in
            ScrollView{
                
                VStack{
                    
                    Image("cupcakes")
                        .resizable()
                        .frame(width: view.size.width,height: 250)
                
                    Text("Your total is $ \(self.order.cost,specifier: "%.2f")").font(.title)
                    
                    Spacer()
                    HStack{
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }){
                            Text("Edit order")
                                .frame(width: 105, height: 35)
                                .background(Color(.purple))
                                .foregroundColor(.white)
                                
                        }
                        .padding(.leading,5)
                        .padding(.top,120)
                        
                        
                        Button("Place order"){
                            self.placeOrder()
                        }
                        .frame(width: 105, height: 35)
                        .background(Color(.purple))
                        .foregroundColor(.white)
                        .padding(.top,120)
                    }
                    
                }
                
                
    
                
            }
            .navigationBarTitle("Check Out",displayMode:.inline)
            .navigationBarHidden(true)
        }
        .alert(isPresented: $showingConfirmation){
            Alert(title:Text("Thank you!"),message: Text(confirmationMessage),dismissButton: .default(Text("Ok")))
        }
        .edgesIgnoringSafeArea(.top)
        
    }
    
    func placeOrder(){
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Falha ao processar a ordem")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request){
            data,response,error in
            
            guard let data = data else {
                print("No data in response \(error?.localizedDescription ?? "Unknow error").")
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data){
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way"
                self.showingConfirmation = true
            } else {
                print("Wrong response from server")
            }
            
            
            
        }.resume()
        
    }
    
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
