
/// - Complexity:  O(V + E) where *V* = visited nodes, *E* = traversed edges.
/// - Parameters:
///   - startNode: The node where the search starts from.
///   - getNeighbors: Gives the adjacent nodes.
///   - shouldInclude: Determines the search criteria. If omitted,
///   the search will walk the whole reachable area.
/// - Returns: Every node reachable from `startNode`
public func depthFirstSearch<Node: Hashable>(
  from startNode: Node,
  getNeighbors: (Node) -> [Node],
  shouldInclude: (Node) -> Bool = { _ in true }
) -> [Node] {
  
  var stack: [Node] = [startNode]
  var visited: Set<Node> = []
  var result: [Node] = []
  
  while let currentNode = stack.popLast() {
    guard !visited.contains(currentNode) else { continue }
    visited.insert(currentNode)
    
    guard shouldInclude(currentNode) else { continue }
    result.append(currentNode)
    
    for neighbor in getNeighbors(currentNode) {
      if !visited.contains(neighbor) {
        stack.append(neighbor)
      }
    }
  }
  return result
}
