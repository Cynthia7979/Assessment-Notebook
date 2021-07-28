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
    static let courses = ["English", "Math", "Science", "Social Science", ]
    var body: some View {
        NavigationView {
            Form {
                Picker("Course", selection: $course) {
                    ForEach(Self.courses, id: \.self) { courseChoice in
                        Text(courseChoice)
                    }
                }
                TextField("Description", text: $description)
                DatePicker("Date", selection: $date, displayedComponents: .date)
            }
            .navigationBarItems(trailing: Button("Save") {
                if course.count > 0 && description != "" && date != Date() {
                    let assignment = AssignmentItem(description: description, course: course, date: date)
                    assignmentList.assignments.append(assignment)
                    presentationMode.wrappedValue.dismiss()
                }
            })
            .navigationBarTitle("Add New Assignment", displayMode: .inline)
        }
    }
}

struct AddAssignmentView_Previews: PreviewProvider {
    static var previews: some View {
        AddAssignmentView(assignmentList: AssignmentList())
    }
}
