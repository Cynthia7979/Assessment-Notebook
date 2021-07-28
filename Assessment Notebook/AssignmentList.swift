//
//  AssignmentList.swift
//  Assessment Notebook
//
//  Created by Xia He on 2021/7/29.
//

import Foundation

class AssignmentList: ObservableObject {
    @Published var assignments = [
        AssignmentItem(description: "First Assignment", course: "Math", date: Date())
    ]
}
