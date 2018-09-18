//
//  TodayViewController.swift
//  ExtensionToday
//
//  Created by chayarak on 18/9/2561 BE.
//  Copyright © 2561 chayarak. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
            
    @IBOutlet weak var noteLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func gotoApp(_ sender: Any) {
        let url = URL(string: "mainAppUrl://Page2")!
        print(url)
        self.extensionContext?.open(url, completionHandler: { (success) in
            if !success {
                print("error: failed to open app from Today Extension")
            }
        })
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        animateTextLabels()
        if activeDisplayMode == .compact {
            self.preferredContentSize = maxSize
        } else if activeDisplayMode == .expanded {
            self.preferredContentSize = CGSize(width: maxSize.width, height: 150)
        }
    }
    
    func animateTextLabels() {
        let isExpandedMode = self.extensionContext?.widgetActiveDisplayMode == .expanded
        let scaleText:CGFloat = isExpandedMode ? 3 : 0.3
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
            self.noteLabel.transform = .init(scaleX: scaleText, y: scaleText)
            self.noteLabel.transform = isExpandedMode ? .init(translationX: 0, y: 20) : .identity
        }) { (finished) in
            UIView.animate(withDuration: 0.3, animations: {
                self.noteLabel.transform = .identity
            })
        }
    }
}
