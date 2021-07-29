//
//  AddAssignmentView.swift
//  Assessment Notebook
//
//  Created by Xia He on 2021/7/29.
//

import SwiftUI

struct AddAssignmentView: View {
    @ObservedObject var assignmentList: AssignmentList
    @State private var description = String()
    @State private var course = String()
    @State private var date = Date()
    @Environment(\.presentationMode) var presentationMode
    
    static let courseChoices = ["English", "Math", "Science", "Social Science", ]
    static let courseIcons = ["books.vertical", "plusminus.circle", "eyeglasses", "figure.stand.line.dotted.figure.stand"]
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Course", selection: $course) {
                    ForEach(0..<Self.courseChoices.count, id: \.self) { i in
                        HStack {
                            Image(systemName: Self.courseIcons[i])
                                .frame(width:50)
                            Text(Self.courseChoices[i])
                        }
                        .tag(Self.courseChoices[i])
                    }
                }
                
                TextField("Description", text: $description)
                
                DatePicker("Date", selection: $date, displayedComponents: .date)
            }
            .navigationBarTitle("Add New Assignment", displayMode: .inline)
            .toolbar() {
                ToolbarItem(placement: .navigationBarTrailing) {
                        print(course)
                        if (course.count > 0) && (description != "") && (date != Date()) {
                            let assignment = AssignmentItem(description: description, course: course, date: date)
                            assignmentList.assignments.append(assignment)
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
        }
    }
}

struct AddAssignmentView_Previews: PreviewProvider {
    static var previews: some View {
        AddAssignmentView(assignmentList: AssignmentList())
    }
}
