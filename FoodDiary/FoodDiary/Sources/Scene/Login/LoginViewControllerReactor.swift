

import Foundation
import ReactorKit
import RxFlow
import RxRelay

// MARK: - Reactor

class LoginViewControllerReactor: Reactor, Stepper {
  
  // MARK: Type
  
  enum Action {
    case google
  }
  
  enum Mutation {
    
  }
  
  struct State {
    
  }
  
  // MARK: Properties
  
  let initialState: State
  let steps = PublishRelay<Step>()
  
  // MARK: Initialization
  
  init() {
    initialState = State()
  }
  
  // MARK: Action -> Mutation
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .google:
        Task {
           debugPrint(try await SocialLoginManager.shared.googleLogin())
        }
        return .empty()
      
    default: break
    }
    
    return .empty()
  }
  
  // MARK: Mutation -> State
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {


    default: break
    }
    return newState
  }
  
  // MARK: Task
  
}
