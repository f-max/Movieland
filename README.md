# Movieland
A simple iOS app about movies based on IMDb API's

### App Launch 
Xcode provides either a solely SfiwUI-based template or a UIKit template based on Storyboards. It was decided to pick the UIKit one but removing the Storyboard, which is regarded as a bit obsolete approach, and creating programmatically the root VC. 

Reasoning behing it can be found in [Navigation](#navigation)

### Navigation
Although SwiftUI navigation was introduced by means of a set of APIs in WWDC-22, it has been decided to stick to UIKit for it, so that the app is still based on VCs and SwiftUI is used to define the inner layout by means of UIHostingController.

Reasoning behind that is a belief that SwiftUI navigation is not mature enough for real-world production applications and also because it requires iOS16+, while we normally want to support at least two major versions of iOS (see [Deployment Target](#deployment-target))

### Modularisation 
SPM has been used to add EUSTACE a simpe DI container from same developer and KingFisher as it seems provide better user experience by caching Image data.

Other modules have been defined as frameworks, with a CLEAN-like architecture in mind, namely:

APP           module
Model         module 
Services      module
Shared mocks  module

and related test modules

### MVVM-C
Although in many other projects out there business logic is implemented in VMs and Ms are just used to define data types, it is developer's belief that VMs should only contain view-related status and business logic should reside in the model. 

VMs should _implement a strategy_ on Ms, and update their view-related status (or _ViewState_ which is the set of its @Published properties) accordingly.
 
Therefore services and other dependencies are stored in the Ms, happy to discuss this detail in case.

Coordinators: see related section.

### Dependency Injection
We don't want a specific solution for a particular feature (especially if based on third party components) to be hard-tied in the app code.

Business-logic-related dependencies are abstracted out in the Model module by means of a set of interfaces, and injected by means of a very simple self-provided DI container (a bit of a CLEAN architecture).

Coordinators use the container to resolve the dependencies and inject them in the M, which is then passed to the VM.

Exception is KingFisher, directly imported in SwiftUI views. 

### Plug-and-Play
As a consequence of the [above](#dependency-injection) we can rely on some sort of plug-and-play effect (see `Container+Extensions.swift`).
According to build configuration, we can change used components.
Specifically, DEBUG works offline as it uses a mock service.

### Coordinators
Coordinators objects do provide navigation flow (including deep linking resolving if needed), and are those in charge to build other MVVM-C structures and passing control to the newly created coordinator.
The keep-alive scheme is View->ViewModel->Model and View->ViewModel->Coordinator.

In case of need for a reference other than the above, that should be 'weak' to avoid retain-cycles.
The view is kept alive by view-hyerarchy (window).

Whenever a view model has to handle something which require navigation or is out of its scope anyway, it will ask its coordinator for it.

### Deployment target
15.0 (current major version and previous one)


### Combine and SwiftUI
As we started using `@MainActor` in the VM classes, we added `nonisolated` for properties and `async` for functions in related protocols.
Still it would be worth investigating more and find out whether this is the best approach.


### Testing
Some unit testing has been provided as an example. Code coverage is lower than ideal for lack of time.


### Localised Strings
Localised strings have not been used for time limitations.

### Known Issues

For some reason the unit tests bundle won't build if choosing 'Host application' as `none` in general pane. Hence as a provisional solution the host application has been set (thus the unwanted behaviour of launching the app while unit testing).

Unit tests _per-se_ would not require the app to launch nor any context or state.

However, as a part of the solution, we are using a dedicated testing scheme tied to a test build configuration and we are able to skip any logic upon app launch.



