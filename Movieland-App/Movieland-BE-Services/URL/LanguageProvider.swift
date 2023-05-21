//
//  LanguageProvider.swift
//  Movieland-BE-Services
//
//  Created by Massimiliano Faustini on 20/05/23.
//

import Foundation

public final class LanguageProvider: LanguageProviding {
  public var language: String = {
    Bundle.main.preferredLocalizations.first ?? "en"
  }()
  
  public  init() {}
}
