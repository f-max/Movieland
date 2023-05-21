//
//  SearchMoviewView.swift
//  Movieland-App
//
//  Created by Massimiliano Faustini on 21/05/23.
//

import SwiftUI

struct SearchMoviewView<ViewModel: SearchMovieViewModeling & ObservableObject>: View {
  
  @ObservedObject private var viewModel: ViewModel
  
  init(viewModel: ViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
  }
}

//struct SearchMoviewView_Previews: PreviewProvider {
//  static var previews: some View {
//    SearchMoviewView()
//  }
//}
