//
//  AlbumViewController.swift
//  SimpleRouter
//
//  Created by Wen Zhao on 3/11/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var albumId: Int?
    var album:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        if (albumId != nil) {
            album = getAlbumById(albumId!)
        }
        tableView.dataSource = self        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getAlbumById(albumId: Int) -> [String] {
        let albums:[Int: [String]] = [
            1 : ["A Familiar Feeling", "A Pirate's Life for Me", "Above the City", "Abstract of Seren", "Abstract of Sliske"],
            2 : ["Abstract of Zamorak", "Adorno I", "Adorno II", "Adorno III", "Adorno IV", "Adorno V", "Adorno VI", "Adorno VI", "Adorno X", "Adventure"]
        ]
        return albums[albumId]!
    }
}

extension AlbumViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.album.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel?.text = self.album[indexPath.row]
        return cell
    }
}
