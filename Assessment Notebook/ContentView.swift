//
//  ContentView.swift
//  Assessment Notebook
//
//  Created by Xia He on 2021/7/29.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var assignmentList = AssignmentList()
    var body: some View {
        NavigationView {
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
                .navigationBarItems(leading: EditButton())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AssignmentItem: Identifiable {
    var id = UUID()
    var description = String()
    var course = String()
    var date = Date()
}
