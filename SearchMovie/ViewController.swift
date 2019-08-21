//
//  ViewController.swift
//  SearchMovie
//
//  Created by cscoi014 on 2019. 8. 21..
//  Copyright © 2019년 GA-Z-A. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var queryField: UITextField!
    @IBOutlet var tableView: UITableView!
    var movies: [Movie] = []
    
    let cellIdentifier = "movieCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func touchUpSearchButton(_ sender: UIButton) {
        
        guard let query: String = queryField.text, !query.isEmpty else {
            print("검색어를 입력해주세요")
            return
        }
        queryField.endEditing(true)
        search(query)
    }

    @IBAction func textFieldPrimaryActionTriggered(_ sender: Any) {
        guard let query: String = queryField.text, !query.isEmpty else {
            print("검색어를 입력해주세요")
            return
        }
        queryField.endEditing(true)
        search(query)
    }

    
    func search(_ query: String) {
        print("\(query)를 검색할겁니다.")
        
        let clientID = "V15m9aFw8to3fjFd1Cc8"
        let clientSecret = "otsS50vsXz"
        
        let headers: [String: String] = [
            "X-Naver-Client-Id": clientID,
            "X-Naver-Client-Secret": clientSecret
        ]
        let urlString = "https://openapi.naver.com/v1/search/movie.json"
        let parameters: [String: Any] = [
            "query": query,
            "display": 50
        ]
        let request = Alamofire.request(urlString,
                                        method: .get,
                                        parameters: parameters,
                                        encoding: URLEncoding.queryString,
                                        headers: headers)
        
        request.response{ (dataResponse) in print(dataResponse)
            guard let data: Data = dataResponse.data else {
                print("no data")
                return
            }
            
//            guard let image: UIImage = UIImage(data: data) else {
//                print("이미지 변환 실패")
//                return
//            }
            
            let decoder: JSONDecoder = JSONDecoder()
            do {
                let response: MovieResponse
                response = try decoder.decode(MovieResponse.self, from: data)
                
                if let items: [Movie] = response.items {
                    self.movies = items
                }
            } catch {
                print(error.localizedDescription)
            }
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        if let title = movies[indexPath.row].title,
            let pubDate = movies[indexPath.row].pubDate {
            cell.textLabel?.text = title.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            cell.detailTextLabel?.text = pubDate
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? UITableViewCell else { return }
        guard let nextViewController = segue.destination as? DetailViewController else { return }
        
        if let indexPath = tableView.indexPath(for: cell),
            let link = movies[indexPath.row].link {
            nextViewController.link = link
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath)
        
        self.performSegue(withIdentifier: "detail", sender: cell)
    }
}

