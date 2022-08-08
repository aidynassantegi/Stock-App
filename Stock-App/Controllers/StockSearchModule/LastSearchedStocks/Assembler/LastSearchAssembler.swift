//
//  LastSearchAssembler.swift
//  Stock-App
//
//  Created by Aidyn Assan on 04.08.2022.
//

import Foundation

final class LastSearchAssembler {
    func assemble() -> LastSearchedViewController {
        let view = LastSearchedViewController()
        let interactor = LastSeachInteractor()
        let presenter = LastSearchPresenter()
        
        view.output = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.output = presenter
        
        return view
    }
}
