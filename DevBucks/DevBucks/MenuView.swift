//
//  MenuView.swift
//  DevBucks
//
//  Created by Devanshu Dev Chaudhary on 02/10/22.
//

import SwiftUI
import ActivityKit
import WidgetKit

struct MenuView: View {
        
    @State private var selectedItem: String = ""
    @State var quantity = 0
        
    var body: some View {
                
        VStack(alignment: .center, spacing: 20) {
                    
            Text("Today's Special")
                .font(.title2)
                .foregroundColor(.white)
                .padding(.top, 10)
                            
            Text("Choose one of our coffees from our delicious range")
                .font(.system(size: 13))
                .foregroundColor(.white)
                        
            RadioButtonGroup(items: ["Caffe latte", "Caffe mocha", "Cappuccino", "Espresso", "Cold Brew"], selectedId: "") { selected in
                selectedItem = selected
            }
            .padding(.horizontal, 35)
            
            Stepper("", value: $quantity, in: 0...5)
                .frame(width: 20, height: 50, alignment: .center)
            
            Text(quantity.description)
                .foregroundColor(.white)
            
            Button(action: placeOrderClicked) {
                Text("Submit")
                    .frame(width: 200, height: 40)
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: 20).fill(.green))
                    .padding(30)
            }
            
        }
        .background(.brown)
        .cornerRadius(10)
        .shadow(radius: 6)
        .padding()
        
    }
    
    private func placeOrderClicked() {
        let attributes = OrderAttributes(numberofCoffees: quantity, selectedCoffee: selectedItem)

        let initialContentState = OrderAttributes.DeliveryStatus(estimatedDeliveryTime: Date()...Date().addingTimeInterval(5 * 60))
                                                  
        do {
            let deliveryActivity = try Activity<OrderAttributes>.request(
                attributes: attributes,
                contentState: initialContentState,
                pushType: nil)
        } catch (let error) {
            print("Error \(error.localizedDescription)")
        }
    }    
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

struct RadioButton: View {

    @Environment(\.colorScheme) var colorScheme

    let id: String
    let callback: (String)->()
    let selectedID : String
    let size: CGFloat
    let color: Color
    let textSize: CGFloat

    init(
        _ id: String,
        callback: @escaping (String)->(),
        selectedID: String,
        size: CGFloat = 20,
        color: Color = Color.primary,
        textSize: CGFloat = 15
        ) {
        self.id = id
        self.size = size
        self.color = color
        self.textSize = textSize
        self.selectedID = selectedID
        self.callback = callback
    }

    var body: some View {
        Button(action:{
            self.callback(self.id)
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: self.selectedID == self.id ? "largecircle.fill.circle" : "circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                    .foregroundColor(.green)
                    .background(Circle().fill(.white))
                Text(id)
                    .font(Font.system(size: textSize))
                    .foregroundColor(.white)
                Spacer()
            }
        }
    }
}

struct RadioButtonGroup: View {

    let items : [String]

    @State var selectedId: String = ""

    let callback: (String) -> ()

    var body: some View {
        
        VStack {
            ForEach(items, id: \.self) { item in
                HStack {
                    RadioButton(item, callback: self.radioGroupCallback, selectedID: self.selectedId)
                }
            }
        }
        
    }

    func radioGroupCallback(id: String) {
        selectedId = id
        callback(id)
    }
    
}


