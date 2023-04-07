//
//  AllStruct.swift
//  TA
//
//  Created by Artem Leschenko on 03.04.2023.
//

import Foundation
import SwiftUI

struct YearOfMarks{
    var year: Int
    var marks = [String : Int]()
}

struct Student {
    var name: String
    var grade: Double
}

class Year{
    var top: Int
    var year: Int
    var maxSize: Int
    var students: [Student] = []
    
    
    init(maxSize: Int, year: Int) {
        self.year = year
        self.maxSize = maxSize

        top = -1
    }
    
    func isEmpty() -> Bool {
        return top == -1
    }
    
    func isFull() -> Bool {
        return top == maxSize - 1
    }
    
    func clear() -> Bool {
        top = -1
        students.removeAll()
        return true
    }
    
    func Top() -> Student? {
        if isEmpty() {
            return nil
        } else {
            return students[top]
        }
    }
    
    func size() -> Int {
        return top + 1
    }
    
    func swap() -> Bool{
        if size() < 2 {
            return true
        }
        guard students.count >= 2 else { return true }
        let last = students.removeLast()
        let secondToLast = students.removeLast()
        students.append(last)
        students.append(secondToLast)
        return true
    }
    
    func push(_ student: Student) -> Bool {
        if isFull() {
            return false
        } else {
            top += 1
            students.append(student)
            return true
        }
    }
    
    func pop() -> Bool {
        if isEmpty() {
            return true
        } else {
            let student = students[top]
            top -= 1
            students.removeLast()
            return true
        }
    }
}

class Stack {
    var name: String
    var years: [Year]
    
    init(maxSize: Int, name: String, year: Int) {
        self.years = [Year(maxSize: maxSize, year: year)]
        self.name = name
    }
}
