//
//  ContentView.swift
//  DynamicIslandProject
//
//  Created by yosshi on 2023/10/13.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    var body: some View {
        VStack {
            Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/) {
                addLiveActivity()
            }
        }
        .padding()
    }
    
    func addLiveActivity() {
        let orderAttributes = OrderStatusAttributes(name: "test")
        
        let initalContentState = OrderStatusAttributes.ContentState(value: 1)
        
        do {
            let activity = try Activity<OrderStatusAttributes>.request(attributes: orderAttributes, content: .init(state: initalContentState, staleDate: nil), pushType: nil)
            
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
