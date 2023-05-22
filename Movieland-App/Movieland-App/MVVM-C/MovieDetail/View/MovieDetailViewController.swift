//
//  MovieDetailViewController.swift
//  Movieland-App
//
//  Created by Massimiliano Faustini on 22/05/23.
//

import UIKit
import SwiftUI

class MovieDetailViewController<ViewModel: MovieDetailViewModeling & ObservableObject>: UIViewController {
  
  @ObservedObject private var viewModel: ViewModel
  
  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(viewModel: ViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //self.navigationItem.title = viewModel.titleCopy
    embedSwiftUI(view_: MovieDetailView(viewModel: viewModel))
  }
  
}
