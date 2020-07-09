import Foundation

class APIClient {
    
    let config = AppConfig()
  
    func getRepositories(completion: @escaping (_ data: [GitHubRepository], _ error: Error?) -> Void) {
        var request = URLRequest(url: URL(string: config.APIURL)!)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode([GitHubRepository].self, from: data!)
                completion(responseModel, error)
            } catch {
                completion([], error)
            }
        }).resume()
    }
}
