//
//  WebViewOptions.swift
//  marvel-project
//
//  Created by Gerson Vieira on 10/03/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit
import WebKit

class WebViewOptions: BaseViewController {
    
    @IBOutlet weak var optionWebView: WKWebView!
    var option: urlOptions?
    
    required init(with option: urlOptions) {
        super.init(nibName: "WebViewOptions", bundle: nil)
        self.option = option
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let option = option else {
            alert(message: "Erro ao carrgear webView")
            return
        }
        optionWebView.load(URLRequest(url: option.url))
    }
    
    private func alert(message: String) {
          let alert = UIAlertController(title: "Alert", message: "Error: \(message)",
              preferredStyle: UIAlertController.Style.alert)
          alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
          self.present(alert, animated: true, completion: nil)
      }
}
