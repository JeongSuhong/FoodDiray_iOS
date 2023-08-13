
import UIKit
import ReactorKit

// MARK: - ViewController

class LoginViewController: UIViewController, StoryboardView {
    
    typealias Reactor = LoginViewControllerReactor
    
    @IBOutlet weak var googleButton: UIButton!
    
    var disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
    
  func bind(reactor: Reactor) {
      googleButton.rx.tap
          .map { Reactor.Action.google }
          .bind(to: reactor.action)
          .disposed(by: disposeBag)
  }
  
}
