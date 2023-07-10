//  Created by warren on 7/7/17.

import Foundation
import Collections


/// Visit a node only once. Collect and compare with a set of nodes already visited.
public class Visitor {

    static var Id = 0  // unique identifier for each node
    public static func nextId() -> Int { Id += 1; return Id }

    private var lock = NSLock()
    public var visited = OrderedSet<Int>()
    public var blocked: OrderedSetClass<Int>?

    public var from: VisitFrom

    public init (_ ids: [Int?], from: VisitFrom = .model ) {
        self.from = from
        nowHeres(ids)
    }
    public init (_ id: Int,
                 from: VisitFrom = .model,
                 blocked: OrderedSetClass<Int>? = nil ) {

        self.from = from
        nowHere(id)
    }
    public init (_ from: VisitFrom) {
        self.from = from
    }

    public func remove(_ id: Int) {
        lock.lock()
        visited.remove(id)
        lock.unlock()
    }
    public func nowHere(_ id: Int) {
        lock.lock()
        visited.append(id)
        lock.unlock()
    }
    public func block(_ id: Int) {
        lock.lock()
        if blocked == nil {
            blocked = OrderedSetClass<Int>([id])
        }
        blocked?.append(id)
        lock.unlock()
    }
    public func nowHeres(_ ids: [Int?]) {
        lock.lock()
        for id in ids {
            if let id {
                visited.append(id)
            }
        }
        lock.unlock()
    }
    public func wasHere(_ id: Int) -> Bool {
        lock.lock()
        let visited = visited.contains(id)
        let blocking = blocked?.contains(id) ?? false
        lock.unlock()
        return visited || blocking
    }
    public func isLocal() -> Bool {
        return !from.remote
    }
    public func newVisit(_ id: Int) -> Bool {
        if wasHere(id) {
            return false
        } else {
            nowHere(id)
            return true
        }
    }
    public func via(_ via: VisitFrom) -> Visitor {
        self.from.insert(via)
        return self
    }
    public var log: String {
        lock.lock()
        let visits = visited.map { String($0)}.joined(separator: ",")
        lock.unlock()
        return "\(from.log):(\(visits))"
    }
}

