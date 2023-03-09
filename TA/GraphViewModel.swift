//
//  GraphViewModel.swift
//  TA
//
//  Created by Artem Leschenko on 09.03.2023.
//

import Foundation


class GraphViewModel: ObservableObject{
    let graph = [
        "Київська політехніка": ["Червоний університет": 5400],
        "Червоний університет": ["Золоті ворота": 1000],
        "Золоті ворота": ["Фонтан на Хрещатику": 1000,"Софія київська": 500],
        "Фонтан на Хрещатику" : ["Лядські ворота": 1100],
        "Лядські ворота": ["Софія київська": 650, "Михайлівський собор": 500, "Національна філармонія":850],
        "Софія київська": ["Золоті ворота": 500, "Лядські ворота": 650, "Михайлівський собор": 500, "Андріївська церква": 500],
        "Михайлівський собор": ["Софія київська": 500, "Лядські ворота": 500, "Андріївська церква": 600, "Фунікулер": 800],
        "Андріївська церква": ["Софія київська": 500, "Михайлівський собор": 600, "Музей однієї вулиці": 600],
        "Музей однієї вулиці": ["Андріївська церква": 600, "Фунікулер": 800],
        "Фунікулер": ["Михайлівський собор": 800, "Національна філармонія": 850, "Музей однієї вулиці": 800],
        "Національна філармонія": ["Лядські ворота":850,"Фунікулер": 850]
    ]
    
    
    var dict = ["1": "Київська політехніка",
                "2": "Червоний університет",
                "3": "Золоті ворота",
                "4": "Фонтан на Хрещатику",
                "5": "Лядські ворота",
                "6": "Софія київська",
                "7": "Михайлівський собор",
                "8": "Андріївська церква",
                "9": "Музей однієї вулиці",
                "10": "Фунікулер",
                "11": "Національна філармонія"
    ]
    
    func bellmanFord(start: String, end: String) -> (String, String){
        
        var start = start
        var end = end
        if dict.keys.contains(start){
            start = dict[start]!
        }
        if dict.keys.contains(end){
            end = dict[end]!
        }
        
        // Ініціалізація змінних distances та predecessors
        var distances: [String: Int] = [:]
        var predecessors: [String: String] = [:]
        for vertex in graph.keys {
            distances[vertex] = Int.max // Встановлюємо відстань до кожного вузла на початку як найбільше
            predecessors[vertex] = nil // Встановлюємо попередників на початку як неіснуючих
        }
        distances[start] = 0 // Відстань до початкового вузла - 0
        
        
        // Ітерації для знаходження найкоротшого шляху
        for _ in 0..<graph.keys.count - 1 {
            for (u, edges) in graph {
                for (v, weight) in edges {
                    // Якщо поточна відстань до вузла v більша за відстань до u + відстань від u до v, то змінюємо відстань та попередника v
                    if distances[u] != Int.max && distances[u]! + weight < distances[v]! {
                        distances[v] = distances[u]! + weight
                        predecessors[v] = u
                    }
                }
            }
        }
        
        
        // Перевірка на наявність від'ємних циклів в графі
        for (u, edges) in graph {
            for (v, weight) in edges {
                if distances[u] != Int.max && distances[u]! + weight < distances[v]! {
                    return ("Щось ти не те записав)", "")
                }
            }
        }
        
        
        // Формування найкоротшого шляху
        var path: [String] = []
        var current = end
        while current != start {
            if let predecessor = predecessors[current] {
                path.append(current)
                current = predecessor
            } else {
                return ("Щось ти не те записав)", "")
            }
        }
        path.append(start)
        path.reverse()
        
        var text1 = ""
        
        var chislo = 1
        // Виведення результатів
        text1 += "Найкоротший шлях між місцями \(start) та \(end):\n\n"
        for i in path{
            text1 += "\(chislo). \(i)\n"
            chislo += 1
        }
        
        
        return (text1, String(distances[end]!))
        
    }
    
    func deikstri(start: String, end: String) -> (String, String) {
        
        var start = start
        var end = end
        if dict.keys.contains(start){
            start = dict[start]!
        }
        if dict.keys.contains(end){
            end = dict[end]!
        }
        
        
        // ініціалізуємо словник відстаней на початку з Int.max
        var distances = [String: Int]()
        for vertex in graph.keys {
            distances[vertex] = Int.max
        }
        // відстань до вихідної вершини встановлюємо на 0
        distances[start] = 0
        
        // словник, що містить попередні вершини на шляху від початкової вершини
        var previousVertices = [String: String?]()
        
        // пріоритетна черга, що містить вершини та їх відстані від початкової вершини
        var pq = [(distance: Int, vertex: String)]()
        pq.append((0, start))
        
        // поки черга не пуста
        while !pq.isEmpty {
            // вибираємо вершину з найменшою відстанню до початкової
            let (currentDistance, currentVertex) = pq.removeFirst()
            
            // якщо досягли кінцевої вершини, виходимо з циклу
            if currentVertex == end {
                break
            }
            
            // проходимо по сусіднім вершинам
            for (neighbor, weight) in graph[currentVertex]! {
                let distance = currentDistance + weight
                // якщо знайдено коротший шлях до сусідньої вершини, оновлюємо відстань
                if distance < distances[neighbor]! {
                    distances[neighbor] = distance
                    previousVertices[neighbor] = currentVertex
                    // додаємо вершину до черги
                    pq.append((distance, neighbor))
                    // сортуємо чергу за зростанням відстані
                    pq.sort { $0.distance < $1.distance }
                }
            }
        }
        
        // збираємо шлях від кінцевої до початкової вершини
        var path = [end]
        var vertex = end
        while vertex != start {
            if let previousVertex = previousVertices[vertex] {
                path.append(previousVertex!)
                vertex = previousVertex!
            } else {
                break
            }
        }
        path.reverse()
        
        // визначаємо загальну відстань шляху
        let totalDistance = distances[end]!
        
        // якщо відстань більша або дорівнює 15000, видаємо повідомлення про помилку
        if totalDistance >= 15000 {
            return ("Щось ти не те записав)", "")
        }
        
        var text1 = ""
        
        var chislo = 1
        // Виведення результатів
        text1 += "Найкоротший шлях між місцями \(start) та \(end):\n\n"
        for i in path{
            text1 += "\(chislo). \(i)\n"
            chislo += 1
        }
        
        print(totalDistance)
        print(text1)
        return (text1, String(totalDistance))
        
    }
}
