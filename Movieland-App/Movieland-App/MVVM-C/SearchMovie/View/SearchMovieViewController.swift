//
//  SearchMoviewViewController.swift
//  Movieland-App
//
//  Created by Massimiliano Faustini on 21/05/23.
//

import UIKit
import SwiftUI

class SearchMovieViewController<ViewModel: SearchMovieViewModeling & ObservableObject>: UIViewController {
  
  @ObservedObject private var viewModel: ViewModel
  
  init(viewModel: ViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = viewModel.titleCopy
    embedSwiftUI(view_: SearchMovieView(viewModel: viewModel))
  }
  
  
}
