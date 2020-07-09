//
//  ViewController.swift
//  ImageDownloader
//
//  Created by JSMAC on 2020/07/09.
//  Copyright © 2020 JSPRO. All rights reserved.
//

import UIKit

class ViewController: UIViewController, URLSessionDownloadDelegate {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var indeicatorView: UIActivityIndicatorView!
    
    var downloadTask:URLSessionTask!
    
    @IBAction func downloadAction(_ sender: Any) {
        imgView.image = nil
        indeicatorView.startAnimating()
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: .main)
        downloadTask = session.downloadTask(with: URL(string: "https://raw.githubusercontent.com/ChoiJinYoung/iphonewithswift2/master/sample.jpeg")!)
        downloadTask.resume()
    }
    
    @IBAction func suspendAction(_ sender: Any) {
        downloadTask.suspend()
    }
    
    @IBAction func resumeAction(_ sender: Any) {
        downloadTask.resume()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        downloadTask.cancel()
        progressView.setProgress(0.0, animated: false)
        indeicatorView.stopAnimating()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress:Float = Float(totalBytesWritten / totalBytesExpectedToWrite)
        progressView.setProgress(progress, animated: true)
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let dataTemp:Data = try! Data(contentsOf: location)
        self.imgView.image =  UIImage(data: dataTemp)
        indeicatorView.stopAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

