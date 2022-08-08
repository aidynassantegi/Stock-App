//
//  TickerViewController.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 04.08.2022.
//

import UIKit
import Charts
import SwiftTickerView

protocol TickerViewInput: AnyObject {
    func handleObtainedEntity(_ entities: [TickerViewEntity])
}

protocol TickerViewOutput: AnyObject {
    func didLoadView()
}

class TickerViewController: UIViewController {

    private var identifier = "tickerView"
    private var tickerView: SwiftTickerView!
    
    private var entities: [TickerViewEntity] = []
    
    var tickerViewOutput: TickerViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tickerView.registerNodeView(TickerView.self, for: identifier)
        tickerView.contentProvider = entities.self as! SwiftTickerProviderProtocol
        tickerView.separator = " "
        tickerView.render = Renderer.leftToRight
        tickerView.reloadData()
        tickerView.viewProvider = self
        tickerViewOutput?.didLoadView()
    }

}

extension TickerViewController: SwiftTickerViewProvider {
    func tickerView(_ tickerView: SwiftTickerView, prepareSeparator separator: UIView) {
        
    }
    
    func tickerView(_ tickerView: SwiftTickerView, viewFor: Any) -> (UIView, reuseIdentifier: String?) {
        let tickerViews = tickerView.dequeReusableNodeView(for: identifier) as! TickerView
      
        return (tickerViews,  reuseIdentifier: identifier)
    }
}

extension TickerViewController: TickerViewInput {
    func handleObtainedEntity(_ entities: [TickerViewEntity]) {
        self.entities = entities
    }
}

