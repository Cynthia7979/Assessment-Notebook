//
//  ContentView.swift
//  Assessment Notebook
//
//  Created by Xia He on 2021/7/29.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var assignmentList = AssignmentList()
    @State private var showAddAssignmentView = false
    
    var body: some View {
        NavigationView {
            Group {
                if assignmentList.assignments.count == 0 {
                    HStack {
                        Text("Add Your First Assignment by Clicking")
                        
                        Image(systemName: "plus")
                            .foregroundColor(.blue)
                        
                        Text("!")
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: { showAddAssignmentView = true }) { Image(systemName: "plus") }
                        }
                    }
                } else {
                    List {
                        ForEach(assignmentList.assignments) { assignment in
                            HStack {
                                VStack {
                                    Text(assignment.course)
                                        .font(.headline)
                                    
                                    Text(assignment.description)
                                }
                                
                                Spacer()
                                
                                Text(assignment.date, style: .date)
                            }
                        }
                        .onMove(perform: { indices, newIndex in
                            assignmentList.assignments.move(fromOffsets: indices, toOffset: newIndex)
                        })
                        .onDelete(perform: { indexSet in
                            assignmentList.assignments.remove(atOffsets: indexSet)
                        })
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) { EditButton() }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: { showAddAssignmentView = true }) { Image(systemName: "plus") }
                        }
                    }
                }
            }
            .navigationBarTitle("Assignment List")
            .sheet(isPresented: $showAddAssignmentView, content: {
                AddAssignmentView(assignmentList: assignmentList)
            })
        }
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
