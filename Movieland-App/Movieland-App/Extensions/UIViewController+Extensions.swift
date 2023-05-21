//
//  UIViewController+Extensions.swift
//  Movieland-App
//
//  Created by Massimiliano Faustini on 21/05/23.
//

import SwiftUI

extension UIViewController {
  func embedSwiftUI<L>(view_: L) where L: View {
    let hostingController = UIHostingController(rootView: view_)

    addChild(hostingController)
    view.addSubview(hostingController.view)
    hostingController.view.frame = view.frame
    hostingController.didMove(toParent: self)
  }
}

