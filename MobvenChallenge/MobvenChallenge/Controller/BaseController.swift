//
//  BaseController.swift
//  MobvenChallenge
//
//  Created by Yavuz BİTMEZ on 15/04/2019.
//  Copyright © 2019 Yavuz BİTMEZ. All rights reserved.
//

import UIKit

class BaseController: UIViewController {
    
    var searchQuerry:OMDBAPI.OMDBAPITypes = .nill

    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var yearTextfield: UITextField!
    
    @IBOutlet weak var movieButtonOption: UIButton!
    @IBAction func movieButton(_ sender: Any) {
       searchQuerry = .nill
        movieButtonOption.backgroundColor = UIColor.red
        seriesButtonOption.backgroundColor = UIColor.black
        episodeButtonOption.backgroundColor = UIColor.black
        self.searchQuerry = .Movie

    }
    
    @IBOutlet weak var filmS: UIImageView!
    
    @IBOutlet weak var seriesButtonOption: UIButton!
    @IBAction func seriesButton(_ sender: Any) {
        searchQuerry = .nill

        seriesButtonOption.backgroundColor = UIColor.red
        movieButtonOption.backgroundColor = UIColor.black
        episodeButtonOption.backgroundColor = UIColor.black
        self.searchQuerry = .Series

    }
    
    @IBOutlet weak var episodeButtonOption: UIButton!
    @IBAction func episodeButton(_ sender: Any) {
        searchQuerry = .nill
        episodeButtonOption.backgroundColor = UIColor.red
        seriesButtonOption.backgroundColor = UIColor.black
        movieButtonOption.backgroundColor = UIColor.black
        self.searchQuerry = .Episode
    }
    
    // Fetch Button
    @IBAction func fetchFilm(_ sender: Any) {
        if titleTextfield.text != "" {
            self.performSegue(withIdentifier: "basetojson", sender: self)
        }else {
            //null title warning Animation
            let jump = CASpringAnimation(keyPath: "position.y")
            jump.fromValue = titleTextfield.layer.position.y + 5.0
            jump.toValue = titleTextfield.layer.position.y
            jump.duration = jump.settlingDuration
            titleTextfield.layer.add(jump, forKey: nil)
        }
    }
    //Data sender
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let senderData = segue.destination as! ViewController
        senderData.getTitle = titleTextfield.text!.replacingOccurrences(of: " ", with: "%20")
        senderData.getYear = yearTextfield.text!
        senderData.getType = searchQuerry
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
   //Footer Animate
    override func viewDidAppear(_ animated: Bool) {
       
        UIView.animateKeyframes(withDuration: 1.2, delay: 0, options: [.repeat ,.autoreverse ], animations: {
            self.filmS.center.x += self.view.bounds.width/2
        }, completion: nil)
    }
   

}
