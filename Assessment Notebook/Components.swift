//
//  AssignmentList.swift
//  Assessment Notebook
//
//  Created by Xia He on 2021/7/29.
//

import Foundation
import Combine

struct AssignmentItem: Identifiable, Codable {
    var id = UUID()
    var description = String()
    var course = String()
    var date = Date()
}

class AssignmentList: ObservableObject {
    @Published var assignments: [AssignmentItem] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(self.assignments) {
                UserDefaults.standard.set(encoded, forKey: "assignmentListData")
            }
        }
    }
    
    init() {
        if let loadedAssignmentsData = UserDefaults.standard.data(forKey: "assignmentListData") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([AssignmentItem].self, from: loadedAssignmentsData) {
                self.assignments = decoded
                return
            }
        }
        self.assignments = []
    }
}
