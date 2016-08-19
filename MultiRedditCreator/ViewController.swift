//
//  ViewController.swift
//  MultiRedditCreator
//
//  Created by Pedro Rodrigues on 8/19/16.
//  Copyright © 2016 Pedro Howat. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var inputTextView: NSTextView!
    let multiUrl = "https://www.reddit.com/r/"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func goButtonClicked(sender: NSButton) {
        guard let text = inputTextView.string else { return }
        let removeSlash = { (str: String) -> String in
            return str.stringByReplacingOccurrencesOfString("/", withString: "")
        }

        let lines: [String] = text.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
        let subs: [String] = lines.filter({ $0.characters.count > 0 }).map({
            if var range = $0.rangeOfString("/r/") {
                range.startIndex = range.endIndex
                range.endIndex = $0.endIndex
                return removeSlash($0.substringWithRange(range))
            } else {
                return removeSlash($0)
            }
        })

        let url = multiUrl + subs.joinWithSeparator("+")
        print(url)

        NSPasteboard.generalPasteboard().clearContents()
        NSPasteboard.generalPasteboard().setString(url, forType: NSStringPboardType)

        let doneAlert: NSAlert = NSAlert()
        doneAlert.messageText = "URL copied to clipboard 👍"
        doneAlert.alertStyle = NSAlertStyle.InformationalAlertStyle
        doneAlert.addButtonWithTitle("OK")
        doneAlert.runModal()
    }

}

