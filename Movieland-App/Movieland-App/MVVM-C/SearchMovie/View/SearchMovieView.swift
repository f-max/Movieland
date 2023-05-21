//
//  SearchMoviewView.swift
//  Movieland-App
//
//  Created by Massimiliano Faustini on 21/05/23.
//

import SwiftUI
import Kingfisher
import Movieland_Model

struct SearchMovieView<ViewModel: SearchMovieViewModeling & ObservableObject>: View {
  
  @ObservedObject private var viewModel: ViewModel
  @State var searchExpression = ""
  
  init(viewModel: ViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack {
      SearchBar(viewModel: viewModel, text: $searchExpression)
      if viewModel.loading {
        LoadingView(viewModel: viewModel)
      } else if !viewModel.errorMessage.isEmpty {
        ErrorView(viewModel: viewModel)
      } else if viewModel.movies.isEmpty && !viewModel.hasLoadedOnce {
        EmptyView()
      } else if viewModel.movies.isEmpty && viewModel.hasLoadedOnce {
        NoResultsView(viewModel: viewModel)
      } else {
        ContentView(viewModel: viewModel)
      }
      Spacer()
    }
  }
}

private extension SearchMovieView {
  struct NoResultsView: View {
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
      self.viewModel = viewModel
    }
    var body: some View {
      VStack {
        Spacer()
        Text(viewModel.noResultsCopy)
        Spacer()
      }
    }
  }
}

private extension SearchMovieView {
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

private extension SearchMovieView {
  struct LoadingView: View {
    @ObservedObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
      self.viewModel = viewModel
    }
    
    var body: some View {
      VStack {
        Spacer()
          .frame(height: 30)
        ProgressView()
          .progressViewStyle(CircularProgressViewStyle())
        Spacer()
          .frame(height: 20)
        Text(viewModel.searchingCopy)
        Spacer()
      }
    }
  }
}

private extension SearchMovieView {
  struct ContentView: View {
    @ObservedObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
      self.viewModel = viewModel
    }
    
    var body: some View {
      ScrollView() {
        LazyVStack {
          ForEach(viewModel.movies, id: \.movie.id) { entity in
            MoviewRow(movieWithRatings: entity)
          }
        }
      }
    }
  }
}

struct MoviewRow: View {
  var movieWithRatings: MoviewWithRatings
  var body: some View {
    VStack(alignment: .leading) {
      HStack(alignment: .top) {
        KFImage(URL(string: movieWithRatings.movie.image))
          .placeholder {
            Image("placeHolder")
              .resizable()
              .frame(width: 60, height: 90)
          }
          .downsampling(size: .init(width: 60, height: 90))
          .padding()
        VStack(alignment: .leading) {
          Text(movieWithRatings.movie.title)
          Text(movieWithRatings.firstAvailableRating ?? "")
        }
        .padding()
      }
      Divider()
    }
    .frame(idealHeight: 110)
  }
}


// Kindly borrowed and adapted from https://stackoverflow.com/questions/59503609
private extension SearchMovieView {
  struct SearchBar: UIViewRepresentable {

    @ObservedObject var viewModel: ViewModel
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {

      @ObservedObject var viewModel: ViewModel
      @Binding var text: String

      init(text: Binding<String>, viewModel: ViewModel) {
        _text = text
        self.viewModel = viewModel
      }

      func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        text = searchText
        Task {
          await viewModel.didUpdate(searchExpression: searchText)
        }
      }
      
      func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        Task {
          await viewModel.didPerformSearchAction()
        }
      }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
      return Coordinator(text: $text, viewModel: viewModel)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
      let searchBar = UISearchBar(frame: .zero)
      searchBar.delegate = context.coordinator
      searchBar.autocapitalizationType = .none
      searchBar.searchBarStyle = UISearchBar.Style.minimal
      return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
      uiView.text = text
    }
  }
}





//struct SearchMoviewView_Previews: PreviewProvider {
//  static var previews: some View {
//    SearchMoviewView()
//  }
//}
