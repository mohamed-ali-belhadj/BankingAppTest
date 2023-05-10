
import Foundation

enum HTTPHeaderFields {
    case application_json
    case application_x_www_form_urlencoded
    case none
}

class HttpRequestHelper {
    func GET<T: Codable>(url: String, params: [String: String], httpHeader: HTTPHeaderFields, type: T.Type, mockFilePath: String, complete: @escaping (Bool, T?) -> ()) {
        
        guard AppConstants.environment == .prod else {
            complete(true, getMock(fromFile: mockFilePath, type: T.self))
            return
        }
        
        guard var components = URLComponents(string: url) else {
            print("Error: cannot create URLCompontents")
            return
        }
        components.queryItems = params.map { key, value in
            URLQueryItem(name: key, value: value)
        }

        guard let url = components.url else {
            print("Error: cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        switch httpHeader {
        case .application_json:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        case .application_x_www_form_urlencoded:
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        case .none: break
        }

        
        // .ephemeral prevent JSON from caching (They'll store in Ram and nothing on Disk)
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: problem calling GET")
                print(error!)
                complete(false, nil)
                return
            }
            guard let data = data else {
                print("Error: did not receive data")
                complete(false, nil)
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                complete(false, nil)
                return
            }
            do{
                let model = try JSONDecoder().decode(T.self, from: data)
                complete(true, model)
            }catch{
                complete(false, nil)
            }
            
        }.resume()
    }
    
    func getMock<T: Codable>(fromFile: String, type: T.Type) -> T?{
        guard let path = Bundle.main.url(forResource: fromFile, withExtension: "json") else {
            return nil
        }
        do {
            let data = try Data(contentsOf: path)
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        } catch {
            return nil
        }
    }

}
