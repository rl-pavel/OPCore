import Foundation

// This makes it possible to create an array [URLQueryItem] using a [String: String?] dictionary.
extension Array: @retroactive ExpressibleByDictionaryLiteral where Element == URLQueryItem {
  public init(dictionaryLiteral elements: (String, String?)...) {
    let queriesWithValue = elements.filter { $0.1 != nil }
    self.init(queriesWithValue.map { URLQueryItem(name: $0.0, value: $0.1) })
  }
}


extension URLRequest {
  public enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"
  }
  
  public init(
    _ method: HTTPMethod,
    to url: URL,
    headers: [String: String] = [:],
    queryItems: [URLQueryItem] = [:],
    body: Data? = nil) {
      var components = URLComponents(string: url.absoluteString)!
      
      // Set the query items directly if the URL doesn't have any already.
      if components.queryItems.isNilOrEmpty {
        components.queryItems = queryItems.nonEmpty
        
        // Otherwise append the additional query items, if any.
      } else if !queryItems.isEmpty {
        components.queryItems?.append(contentsOf: queryItems)
      }
      
      self.init(url: components.url!)
      
      timeoutInterval = 60
      httpBody = body
      httpMethod = method.rawValue
      
      setValue("application/json", forHTTPHeaderField: "Content-Type")
      
      headers.forEach {
        setValue($0.value, forHTTPHeaderField: $0.key)
      }
    }
}
