//
//  UserServiceCallHandler.swift
//  backendless_sdk
//
//  Created by Andrii Bodnar on 5/27/19.
//

import Foundation
import Flutter
import Backendless

class UserServiceCallHandler: FlutterCallHandlerProtocol {
    
    // MARK: -
    // MARK: - Constants
    private enum Methods {
        static let currentUser = "Backendless.UserService.currentUser"
        static let describeUserClass = "Backendless.UserService.describeUserClass"
        static let findById = "Backendless.UserService.findById"
        static let getUserRoles = "Backendless.UserService.getUserRoles"
        static let isValidLogin = "Backendless.UserService.isValidLogin"
        static let loggedInUser = "Backendless.UserService.loggedInUser"
        static let login = "Backendless.UserService.login"
        static let logout = "Backendless.UserService.logout"
        static let register = "Backendless.UserService.register"
        static let resendEmailConfirmation = "Backendless.UserService.resendEmailConfirmation"
        static let restorePassword = "Backendless.UserService.restorePassword"
        static let update = "Backendless.UserService.update"
        static let setUserToken = "Backendless.UserService.setUserToken"
        static let getUserToken = "Backendless.UserService.getUserToken"
        static let loginAsGuest = "Backendless.UserService.loginAsGuest"
        static let loginWithFacebook = "Backendless.UserService.loginWithFacebook"
        static let loginWithTwitter = "Backendless.UserService.loginWithTwitter"
        static let loginWithGoogle = "Backendless.UserService.loginWithGoogle"
    }
    
    private enum Args {
        static let identity = "identity"
        static let id = "id"
        static let login = "login"
        static let password = "password"
        static let stayLoggedIn = "stayLoggedIn"
        static let user = "user"
        static let email = "email"
        static let userToken = "userToken"
        static let accessToken = "accessToken"
        static let fieldsMapping = "fieldsMapping"
        static let authToken = "authToken"
        static let authTokenSecret = "authTokenSecret"
        static let guestUser = "guestUser"
    }
    
    // MARK: -
    // MARK: - FileService Reference
    private let userService = SwiftBackendlessSdkPlugin.backendless.userService
    
    // MARK: -
    // MARK: - Route Flutter Call
    func routeFlutterCall(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let arguments: [String: Any] = call.arguments.flatMap(cast) ?? [:]
        
        switch call.method {
        case Methods.currentUser:
            currentUser(arguments, result)
        case Methods.describeUserClass:
            describeUserClass(arguments, result)
        case Methods.findById:
            findById(arguments, result)
        case Methods.getUserRoles:
            getUserRoles(arguments, result)
        case Methods.isValidLogin:
            isValidLogin(arguments, result)
        case Methods.loggedInUser:
            loggedInUser(arguments, result)
        case Methods.login:
            login(arguments, result)
        case Methods.logout:
            logout(arguments, result)
        case Methods.register:
            register(arguments, result)
        case Methods.resendEmailConfirmation:
            resendEmailConfirmation(arguments, result)
        case Methods.restorePassword:
            restorePassword(arguments, result)
        case Methods.update:
            update(arguments, result)
        case Methods.setUserToken:
            setUserToken(arguments, result)
        case Methods.getUserToken:
            getUserToken(arguments, result)
        case Methods.loginAsGuest:
            loginAsGuest(arguments, result)
        case Methods.loginWithFacebook:
            loginWithFacebook(arguments, result)
        case Methods.loginWithTwitter:
            loginWithTwitter(arguments, result)
        case Methods.loginWithGoogle:
            loginWithGoogle(arguments, result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    // MARK: -
    // MARK: - Current user
    private func currentUser(_ arguments: [String: Any], _ result: @escaping FlutterResult) {
        let currentUser = userService.getCurrentUser()
        
        result(currentUser)
    }
    
    // MARK: -
    // MARK: - Describe User Class
    private func describeUserClass(_ arguments: [String: Any], _ result: @escaping FlutterResult) {
        userService.describeUserClass(responseHandler: {
            result($0)
        }, errorHandler: {
            result(FlutterError($0))
        })
    }
    
    // MARK: -
    // MARK: - Find By ID
    private func findById(_ arguments: [String: Any], _ result: @escaping FlutterResult) {
        guard let id: String = arguments[Args.id].flatMap(cast) else {
            result(FlutterError.noRequiredArguments)
            
            return
        }
        
        Backendless.shared.data.of(BackendlessUser.self)
            .findById(objectId: id,
                responseHandler: { response in
                    guard let user = response as? BackendlessUser else {
                        result(FlutterError(code: "", message: "Incorrect Data Type from API", details: nil))
                
                        return
                    }
                    
                    result(user)
                },
                errorHandler: {
                    result(FlutterError($0))
                })
    }
    
    // MARK: -
    // MARK: - Get User Roles
    private func getUserRoles(_ arguments: [String: Any], _ result: @escaping FlutterResult) {
        userService.getUserRoles(responseHandler: {
            result($0)
        }, errorHandler: {
            result(FlutterError($0))
        })
    }
    
    // MARK: -
    // MARK: - Is Valid Login
    private func isValidLogin(_ arguments: [String: Any], _ result: @escaping FlutterResult) {
        userService.isValidUserToken(responseHandler: {
            result($0)
        }, errorHandler: {
            result(FlutterError($0))
        })
    }
    
    // MARK: -
    // MARK: - Logged In User
    private func loggedInUser(_ arguments: [String: Any], _ result: @escaping FlutterResult) {
        guard let user = userService.getCurrentUser() else {
            result("")
            
            return
        }
        
        result(user.objectId)
    }
    
    // MARK: -
    // MARK: - Login
    private func login(_ arguments: [String: Any], _ result: @escaping FlutterResult) {
        guard
            let login: String = arguments[Args.login].flatMap(cast),
            let password: String = arguments[Args.password].flatMap(cast)
        else {
            result(FlutterError.noRequiredArguments)
            
            return
        }
        
        let stayLoggedIn = arguments[Args.stayLoggedIn].flatMap(cast) ?? false
        userService.stayLoggedIn = stayLoggedIn
        
        userService.login(identity: login, password: password,
            responseHandler: {
                result($0)
            },
            errorHandler: {
                result(FlutterError($0))
            })
    }
    
    // MARK: -
    // MARK: - Logout
    private func logout(_ arguments: [String: Any], _ result: @escaping FlutterResult) {
        userService.logout(responseHandler: {
            result(nil)
        }, errorHandler: {
            result(FlutterError($0))
        })
    }
    
    // MARK: -
    // MARK: - Register
    private func register(_ arguments: [String: Any], _ result: @escaping FlutterResult) {
        guard let user: BackendlessUser = arguments[Args.user].flatMap(cast) else {
            result(FlutterError.noRequiredArguments)
            
            return
        }
        
        Locale.current.languageCode.map { user.setLocale(languageCode: $0) }

        userService.registerUser(user: user,
            responseHandler: {
                result($0)
            },
            errorHandler: {
                result(FlutterError($0))
            })
    }
    
    // MARK: -
    // MARK: - Resend Email Confirmation
    private func resendEmailConfirmation(_ arguments: [String: Any], _ result: @escaping FlutterResult) {
        guard let email: String = arguments[Args.email].flatMap(cast) else {
            result(FlutterError.noRequiredArguments)
            
            return
        }
        
        userService.resendEmailConfirmation(email: email,
            responseHandler: {
                result(nil)
            },
            errorHandler: {
                result(FlutterError($0))
            })
    }
    
    // MARK: -
    // MARK: - Restore Password
    private func restorePassword(_ arguments: [String: Any], _ result: @escaping FlutterResult) {
        guard let identity: String = arguments[Args.identity].flatMap(cast) else {
            result(FlutterError.noRequiredArguments)
            
            return
        }
        
        userService.restorePassword(identity: identity, responseHandler: {
            result(nil)
        }, errorHandler: {
            result(FlutterError($0))
        })
    }
    
    // MARK: -
    // MARK: - Update
    private func update(_ arguments: [String: Any], _ result: @escaping FlutterResult) {
        guard let user: BackendlessUser = arguments[Args.user].flatMap(cast) else {
            result(FlutterError.noRequiredArguments)
            
            return
        }
        
        userService.update(user: user,
            responseHandler: {
                result($0)
            },
            errorHandler: {
                result(FlutterError($0))
            })
    }
    
    // MARK: -
    // MARK: - Set User Token
    private func setUserToken(_ arguments: [String: Any], _ result: @escaping FlutterResult) {
        guard let userToken: String = arguments[Args.userToken].flatMap(cast) else {
            result(FlutterError.noRequiredArguments)
            
            return
        }
        
        userService.setUserToken(value: userToken)
        result(nil)
    }
    
    // MARK: -
    // MARK: - Get User Token
    private func getUserToken(_ arguments: [String: Any], _ result: @escaping FlutterResult) {
        let userToken = userService.getUserToken()
        
        result(userToken)
    }

    // MARK: -
    // MARK: - Login As Guest
    private func loginAsGuest(_ arguments: [String: Any], _ result: @escaping FlutterResult) {
        let stayLoggedIn: Bool? = arguments[Args.stayLoggedIn].flatMap(cast)

        if let stayLoggedIn = stayLoggedIn {
            userService.loginAsGuest(stayLoggedIn: stayLoggedIn,
                responseHandler: {
                    result($0)
                },
                errorHandler: {
                    result(FlutterError($0))
                })
        } else {
            userService.loginAsGuest(responseHandler: {
                result($0)
            }, errorHandler: {
                result(FlutterError($0))
            })
        }
    }

    // MARK: -
    // MARK: - Login With Facebook
    private func loginWithFacebook(_ arguments: [String: Any], _ result: @escaping FlutterResult) {
        guard let accessToken: String = arguments[Args.accessToken].flatMap(cast) else {
            result(FlutterError.noRequiredArguments)
            return
        }
        let fieldsMapping: [String: String] = arguments[Args.fieldsMapping].flatMap(cast) ?? [:]
        let stayLoggedIn = arguments[Args.stayLoggedIn].flatMap(cast) ?? false
        userService.stayLoggedIn = stayLoggedIn        
        let guestUser: BackendlessUser? = arguments[Args.guestUser].flatMap(cast)
        if guestUser != nil {
            userService.loginWithFacebook(accessToken: accessToken, guestUser: guestUser!, fieldsMapping: fieldsMapping,
            responseHandler: {
                result($0)
            },
            errorHandler: {
                result(FlutterError($0))
            })
        }   
        else {
            userService.logingWithFacebook(accessToken: accessToken, fieldsMapping: fieldsMapping,
            responseHandler: {
                result($0)
            },
            errorHandler: {
                result(FlutterError($0))
            })
        }   
    }

    // MARK: -
    // MARK: - Login With Twitter
    private func loginWithTwitter(_ arguments: [String: Any], _ result: @escaping FlutterResult) {
        guard
            let authToken: String = arguments[Args.authToken].flatMap(cast),
            let authTokenSecret: String = arguments[Args.authTokenSecret].flatMap(cast)
        else {
            result(FlutterError.noRequiredArguments)
            return
        }
        let fieldsMapping: [String: String] = arguments[Args.fieldsMapping].flatMap(cast) ?? [:]
        let stayLoggedIn = arguments[Args.stayLoggedIn].flatMap(cast) ?? false
        userService.stayLoggedIn = stayLoggedIn
        let guestUser: BackendlessUser? = arguments[Args.guestUser].flatMap(cast)
        if guestUser != nil {
            userService.loginWithTwitter(authToken: authToken, authTokenSecret: authTokenSecret, guestUser: guestUser!, fieldsMapping: fieldsMapping,
            responseHandler: {
                result($0)
            },
            errorHandler: {
                result(FlutterError($0))
            })
        }
        else {
            userService.loginWithTwitter(authToken: authToken, authTokenSecret: authTokenSecret, fieldsMapping: fieldsMapping,
            responseHandler: {
                result($0)
            },
            errorHandler: {
                result(FlutterError($0))
            })            
        }        
    }

    // MARK: -
    // MARK: - Login With Google
    private func loginWithGoogle(_ arguments: [String: Any], _ result: @escaping FlutterResult) {
        guard let accessToken: String = arguments[Args.accessToken].flatMap(cast) else {
            result(FlutterError.noRequiredArguments)
            return
        }
        let fieldsMapping: [String: String] = arguments[Args.fieldsMapping].flatMap(cast) ?? [:]
        let stayLoggedIn = arguments[Args.stayLoggedIn].flatMap(cast) ?? false
        userService.stayLoggedIn = stayLoggedIn
        let guestUser: BackendlessUser? = arguments[Args.guestUser].flatMap(cast)
        if guestUser != nil {
            userService.loginWithGoogle(accessToken: accessToken, guestUser: guestUser!, fieldsMapping: fieldsMapping,
            responseHandler: {
                result($0)
            },
            errorHandler: {
                result(FlutterError($0))
            })
        }
        else {
            userService.loginWithGoogle(accessToken: accessToken, fieldsMapping: fieldsMapping,
            responseHandler: {
                result($0)
            },
            errorHandler: {
                result(FlutterError($0))
            })
        }        
    }
}
