//
//  ViewController.swift
//  MobvenChallenge
//
//  Created by Yavuz BİTMEZ on 13/04/2019.
//  Copyright © 2019 Yavuz BİTMEZ. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,OMDBAPIDelegate {
 
    
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var typeFilter: UIButton!
    @IBOutlet weak var yearFilter: UIButton!
    
    @IBAction func typeFilterClick(_ sender: Any) {
       omdbAPI.getSearch(title: self.getTitle, year: Int(self.getYear))
        self.getType = .nill
        typeFilter.isHidden = true

    }
    
    @IBAction func yearFilterClick(_ sender: Any) {
        omdbAPI.getSearch(title: self.getTitle, type: getType)
        self.getYear = ""
        yearFilter.isHidden = true
    }
    
    @IBOutlet weak var collectionViv: UICollectionView!
    
    
    var OmdbArr:[Movie] = []
    var omdbAPI = OMDBAPI()
    var getYear:String=""
    var getTitle:String=""
    var getType:OMDBAPI.OMDBAPITypes = .nill

  

    override func viewDidLoad() {
        super.viewDidLoad()
      
        omdbAPI.delegate = self
        omdbAPI.getSearch(title: self.getTitle, year: Int(self.getYear), type: getType)
    
        self.searchLabel.text = self.getTitle.replacingOccurrences(of: "%20", with: " ")
        filterSetting()
    }

    //Filter Settings
    func filterSetting(){
        if self.getType != .nill {
            typeFilter.backgroundColor = UIColor.red
            typeFilter.setTitle("\(self.getType)-", for: .normal)
        }else {
            typeFilter.isHidden = true
        }
        if self.getYear.isEmpty {
            yearFilter.isHidden = true
        }else {
            
            yearFilter.backgroundColor = UIColor.red
            yearFilter.setTitle("\(self.getYear)-", for: .normal)
        }
    }
 
    func didReceiveSearchResults(results: [Movie]) {
        for i in results {
            let appendData = Movie()
            appendData.imdbID = i.imdbID!
            appendData.poster = i.poster!
            appendData.title = i.title!
            appendData.type = i.type!
            appendData.year = i.year!
            self.OmdbArr.append(appendData)
        }
        DispatchQueue.main.sync {
            self.collectionViv.reloadData()
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if OmdbArr.isEmpty{
            return 1
        }else {
            return OmdbArr.count

        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Push WebView
        if (OmdbArr.isEmpty == false){
            let vc = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController
            vc?.urlget = (self.OmdbArr[indexPath.item].imdbID)!
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Show CollectionView Cell
        if (OmdbArr.isEmpty){
            let cell = collectionViv.dequeueReusableCell(withReuseIdentifier: "DataCollectionViewCell", for: indexPath) as! DataCollectionViewCell
            cell.titleText.text = "Birşey Bulamadım"
            cell.typeText.text = " "
            cell.yearText.text = " "
            cell.posterImage.contentMode = .scaleAspectFit
            cell.posterImage.image = UIImage(named: "notfind")
            return cell

        }else{
            let cell = collectionViv.dequeueReusableCell(withReuseIdentifier: "DataCollectionViewCell", for: indexPath) as! DataCollectionViewCell
            cell.titleText.text = OmdbArr[indexPath.item].title
            cell.typeText.text = OmdbArr[indexPath.item].type
            cell.posterImage.contentMode = .scaleToFill
            cell.posterImage.downloadImage(from: OmdbArr[indexPath.item].poster!)
            cell.yearText.text = OmdbArr[indexPath.item].year
            return cell
        }
       
    }
    

}

//String to ImageView Converter
extension UIImageView {
    func downloadImage (from url: String){
        let urlRequest = URLRequest(url:URL(string: url)!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, urlresponse, error) in
            if error != nil {print(error!); return}
            
            DispatchQueue.main.async
                {
                    self.image = UIImage(data:data!)
            }
        }
        task.resume()
    }
}
