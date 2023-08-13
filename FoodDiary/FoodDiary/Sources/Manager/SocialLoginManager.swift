
import Foundation

import FirebaseCore
import FirebaseAuth
import GoogleSignIn

struct SocialLoginModel: Codable {
  var token: String
  var email: String?
  var nickname: String?
  var profileImage: String?
}

final class SocialLoginManager: NSObject {
    
    // MARK: Shared Instances
    
    static let shared = SocialLoginManager()
    
    // MARK: Properties
    private var appleContinuation: CheckedContinuation<SocialLoginModel, Error>?
    
    // MARK: Initialization
    
    override init() {
        super.init()
    }

}
  


extension SocialLoginManager {
    func googleLogin() async throws -> SocialLoginModel {
        try await withCheckedThrowingContinuation  { (continuation: CheckedContinuation<SocialLoginModel, Error>) in
            
            // 기존에 로그인한 기록이 있을 경우 해당 정보를 가져오는 함수.
            GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                if let user, let token = user.idToken?.tokenString {
                    let model = SocialLoginModel(token: token,
                                                 email: user.profile?.email,
                                                 nickname: user.profile?.name,
                                                 profileImage: user.profile?.imageURL(withDimension: 500)?.absoluteString)
                    continuation.resume(returning: model)
                    return
                }
                
                guard let vc = UIApplication.shared.topVC else { return }
                
                debugPrint(Environment.googleClientId)
                let config = GIDConfiguration(clientID: Environment.googleClientId)
                GIDSignIn.sharedInstance.configuration = config
                GIDSignIn.sharedInstance.signIn(withPresenting: vc) { result, error in
                    if let error {
                        continuation.resume(throwing: error)
                    } else if let user = result?.user,
                              let token = user.idToken?.tokenString {
                        let model = SocialLoginModel(token: token,
                                                     email: user.profile?.email,
                                                     nickname: user.profile?.name,
                                                     profileImage: user.profile?.imageURL(withDimension: 300)?.absoluteString)
                        let crendential = GoogleAuthProvider.credential(withIDToken: token, accessToken: user.accessToken.tokenString)
                        Auth.auth().signIn(with: crendential) { result, error in
                            if let error {
                                continuation.resume(throwing: error)
                            } else {
                                continuation.resume(returning: model)
                            }
                        }
                        
                    } else {
                        debugPrint("Error Google Login")
                        //                      continuation.resume(throwing:  (status: 600, message: "Error Google Login"))
                    }
                }
            }
        }
    }

  func application(_ app: UIApplication, openGoogleLoginUrl url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    return GIDSignIn.sharedInstance.handle(url)
  }
}
