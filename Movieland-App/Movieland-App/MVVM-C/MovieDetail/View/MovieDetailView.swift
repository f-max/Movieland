//
//  MovieDetailView.swift
//  Movieland-App
//
//  Created by Massimiliano Faustini on 22/05/23.
//

import SwiftUI
import Kingfisher

struct MovieDetailView<ViewModel: MovieDetailViewModeling & ObservableObject>: View {
  
  @ObservedObject private var viewModel: ViewModel
  
  init(viewModel: ViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    if !viewModel.errorMessage.isEmpty {
      ErrorView(viewModel: viewModel)
    } else {
      VStack(alignment: .leading) {
        VStack (alignment:.center){
          Text(viewModel.movieWithRatings.movie.title)
            .font(.largeTitle)
            .padding()
        }
        Spacer()
          .frame(height: 20)
        HStack(alignment: .top) {
          KFImage(URL(string: viewModel.movieWithRatings.movie.image))
            .downsampling(size: .init(width: 150, height: 200))
          Spacer()
            .frame(width: 20)
          VStack(alignment: .leading) {
            Text(viewModel.director)
              .frame(maxWidth: .infinity, maxHeight: 50, alignment: .topLeading)
            Divider()
            Spacer()
              .frame(height: 8)
            Text(viewModel.stars)
              .frame(maxWidth: .infinity, maxHeight: 150, alignment: .topLeading)
          }
        }
        .padding()

        Spacer()
          .frame(height: 20)
        Divider()
        Text(viewModel.plot)
          .italic()
          .padding()
        Spacer()
      }
    }
  }
  
}

private extension MovieDetailView {
  struct ErrorView: View {
    @ObservedObject private var viewModel: ViewModel
    @State var presentAlert = true
    
    init(viewModel: ViewModel) {
      self.viewModel = viewModel
    }
    
    var body: some View {
      Spacer()
        .alert(
          "Uh-Oh",
          isPresented: $presentAlert,
          actions: {
            Button("OK") {
              Task {
                await viewModel.didPerformAlertOkAction()
              }
            }
          },
          message: { Text(viewModel.errorMessage)}
        )
    }
  }
}


