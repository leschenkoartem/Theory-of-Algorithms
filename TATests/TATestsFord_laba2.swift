import XCTest
@testable import TA

class BellmanFordTests: XCTestCase {
    var sut:GraphViewModel!
    var graph: [String: [String: Int]]!
    var points = 1000
    override func setUpWithError() throws {
        sut = GraphViewModel()
        graph = [:]
        
        // Создаем граф с 30 вершинами и случайными весами ребер
        for i in 1..<points {
            let vertex = "\(i)"
            var edges: [String: Int] = [:]
            for j in 1..<points {
                if i != j {
                    let neighbor = "\(j)"
                    let weight  = Int.random(in: 1...points)
                    edges[neighbor] = weight
                }
            }
            graph[vertex] = edges
        }
    }
    
    override func tearDownWithError() throws {
        sut = nil
        graph = [:]
    }
    
    func testBellmanFordTime() {
        // Выбираем случайную пару вершин
        let startVertex = "\(Int.random(in: 1..<points))"
        let endVertex = "\(Int.random(in: 1..<points))"

        measure (metrics: [XCTClockMetric()]){
            sut.bellmanFord(start: startVertex, end: endVertex, graph: graph)
        }
    }
    
    func testDeikstriTime(){
        // Выбираем случайную пару вершин
        let startVertex = "\(Int.random(in: 1..<points))"
        let endVertex = "\(Int.random(in: 1..<points))"
        
        measure (metrics: [XCTClockMetric()]) {
            sut.deikstri(start: startVertex, end: endVertex, graph: graph)
        }
    }
}
