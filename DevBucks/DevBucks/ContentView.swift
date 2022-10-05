//
//  ContentView.swift
//  DevBucks
//
//  Created by Devanshu Dev Chaudhary on 02/10/22.
//

import SwiftUI
import ActivityKit
import WidgetKit

struct ContentView: View {
    
    @State private var isSelected = false
    
    // MARK: - Layout
    var body: some View {
            ZStack {
                Image("bg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
                    .ignoresSafeArea(.all)

                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("DevBucks ")
                            .font(.title)
                            .foregroundColor(.white)

                        Image(systemName: "staroflife.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.green)
                            .background(Circle().fill(.white))
                            .frame(width: 30, height: 30)
                            .shadow(radius: 3)
                    }
                    .padding(.horizontal)
                    Text("Serving you the best coffee since the dawn of time")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    Spacer()
                    HStack {
                        Button(action: placeOrderClicked) {
                                Text("Place Order ☕️").font(.headline)
                                    .foregroundColor(.brown)
                                    .frame(width: 150, height: 60)
                                    .background(RoundedRectangle(cornerRadius: 20).fill(.white))
                        }
                        .shadow(radius: 1)
                        .buttonStyle(.borderless)
                        .buttonBorderShape(.roundedRectangle(radius: 0))
                        
                        Button(action: cancelOrder) {
                                Text("Cancel ❌").font(.headline)
                                    .foregroundColor(.brown)
                                    .frame(width: 150, height: 60)
                                    .background(RoundedRectangle(cornerRadius: 20).fill(.white))
                        }
                        .shadow(radius: 1)
                        .buttonStyle(.borderless)
                        .buttonBorderShape(.roundedRectangle(radius: 0))
                        Spacer()
                    }
                    .padding()
                }
                if isSelected {
                    withAnimation(.linear(duration: 5)) {
                        MenuView()
                    }
                }
            }
            .foregroundColor(.white)
    }
    private func placeOrderClicked() {
        isSelected.toggle()
    }
    
    private func cancelOrder() {
        Task {
            for activity in Activity<OrderAttributes>.activities{
                print("Activity Cancelled \(activity.id)")
                await activity.end(dismissalPolicy: .immediate)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
