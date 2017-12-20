//
//  DetailViewController.swift
//  MapLocationApp
//
//  Created by Mobile Developer on 12/8/17.
//  Copyright © 2017 Jin Xing. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var detail_ImgView: UIImageView!
    @IBOutlet var title_Lbl: UILabel!
    @IBOutlet var artist_Lbl: UILabel!
    @IBOutlet var year_Lbl: UILabel!
    @IBOutlet var information_Lbl: UILabel!
    @IBOutlet var location_Lbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getImage(imageName: (GlobalData.filenameStr.replacingOccurrences(of: " ", with: "%20")))
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backBtn_clicked(_ sender: UIButton) {
         _ = navigationController?.popViewController(animated: true)
    }
    
    // Download the image file of Artist
    func getImage(imageName: String) {
        
        let catPictureURL = URL(string: "https://cgi.csc.liv.ac.uk/~phil/Teaching/COMP327/artwork_images/" + imageName)!
        print(catPictureURL)

        let data = try? Data(contentsOf: catPictureURL)
        let image: UIImage = UIImage(data: data!)!
        
        self.detail_ImgView.image = image
        self.title_Lbl.text = GlobalData.titleStr
        self.artist_Lbl.text = GlobalData.artistStr
        self.year_Lbl.text = GlobalData.yearStr
        self.information_Lbl.text = GlobalData.informationStr
        self.location_Lbl.text = GlobalData.locationStr
        
    }
}


