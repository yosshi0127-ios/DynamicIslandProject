//
//  ContentView.swift
//  DynamicIslandProject
//
//  Created by yosshi on 2023/10/13.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    
    // MARK: Updating Live Activity
    
    @State var currentID: String = ""
    @State var currentSelection: Status = .received
    
    var body: some View {
        
        NavigationStack {
            VStack {
                
                Picker(selection: $currentSelection) {
                    Text("Recevied")
                        .tag(Status.received)
                    Text("Progress")
                        .tag(Status.progress)
                    Text("Ready")
                        .tag(Status.ready)
                    
                } label: {
                    
                }
                .labelsHidden()
                .pickerStyle(.segmented)
                
                Button("Start Activity") {
                    addLiveActivity()
                }
                
                // MARK: Removing Activity
                Button("Remove Activity") {
                    removeActivity()
                }
                .padding(.top)
                
            }
            .navigationTitle("Live Activities")
            .padding(15)
            .onChange(of: currentSelection) { newValue in
                // Retreiving Current Activity From the List Of Phone Activitites
                if let activity = Activity.activities.first(where: { (activity: Activity<OrderAttributes>) in
                    activity.id == currentID
                }) {
                    print("Activity Found")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        
                        var updateState = activity.contentState
                        updateState.status = currentSelection
                        
                        Task {
                            await activity.update(using: updateState)
                            
                        }
                    }
                }
            }
        }
    }
    
    func removeActivity() {
        
        if let activity = Activity.activities.first(where: { (activity: Activity<OrderAttributes>) in
            activity.id == currentID
        }) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                
                var activityContent = activity.content
                
                Task {
                    await activity.end(activityContent, dismissalPolicy: .immediate)
                }
            }
        }
    }
    
    func addLiveActivity() {
        
        let orderAttributes = OrderAttributes(orderNumber: 26383, orderItems: "Burger & Milk Shake")
        
        let initalContentState = OrderAttributes.ContentState()
        
        do {
            let activity = try Activity<OrderAttributes>.request(attributes: orderAttributes, content: .init(state: initalContentState, staleDate: nil), pushType: nil)
            // MARK: Storing CurrentID For Updating Activity
            currentID = activity.id
            
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
