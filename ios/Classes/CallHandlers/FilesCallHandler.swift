//
//  FilesCallHandler.swift
//  Flutter-SDK
//
//  Created by Andrii Bodnar on 5/2/19.
//  Copyright © 2019 Andrii Bodnar. All rights reserved.
//

import Foundation
import Flutter
import Backendless

class FilesCallHandler: FlutterCallHandlerProtocol {
    
    // MARK: -
    // MARK: - Constants
    private enum Methods {
        static let copyFile = "Backendless.Files.copyFile"
        static let exists = "Backendless.Files.exists"
        static let getFileCount = "Backendless.Files.getFileCount"
        static let listing = "Backendless.Files.listing"
        static let moveFile = "Backendless.Files.moveFile"
        static let remove = "Backendless.Files.remove"
        static let removeDirectory = "Backendless.Files.removeDirectory"
        static let renameFile = "Backendless.Files.renameFile"
        static let saveFile = "Backendless.Files.saveFile"
        static let upload = "Backendless.Files.upload"
    }
    
    private enum Args {
        static let sourcePathName = "sourcePathName"
        static let targetPath = "targetPath"
        static let path = "path"
        static let pattern = "pattern"
        static let recursive = "recursive"
        static let countDirectories = "countDirectories"
        static let pageSize = "pagesize"
        static let offset = "offset"
        static let fileUrl = "fileUrl"
        static let oldPathName = "oldPathName"
        static let newName = "newName"
        static let fileName = "fileName"
        static let fileContent = "fileContent"
        static let overwrite = "overwrite"
        static let directoryPath = "directoryPath"
    }
    
    // MARK: -
    // MARK: - FileService Reference
    private let fileService = SwiftBackendlessSdkPlugin.backendless.fileService
    
    // MARK: -
    // MARK: - Route Flutter Call
    func routeFlutterCall(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let arguments: [String: Any] = call.arguments.flatMap(cast) ?? [:]
        
        switch call.method {
        case Methods.copyFile:
            self.copyFile(arguments, result)
        case Methods.exists:
            self.exists(arguments, result)
        case Methods.getFileCount:
            self.getFileCount(arguments, result)
        case Methods.listing:
            self.listing(arguments, result)
        case Methods.moveFile:
            self.moveFile(arguments, result)
        case Methods.remove:
            self.remove(arguments, result)
        case Methods.removeDirectory:
            self.removeDirectory(arguments, result)
        case Methods.renameFile:
            self.renameFile(arguments, result)
        case Methods.saveFile:
            self.saveFile(arguments, result)
        case Methods.upload:
            self.upload(arguments, result)
        default:
            result(FlutterMethodNotImplemented)
        }
        
    }
    
    // MARK: -
    // MARK: - CopyFile
    private func copyFile(_ arguments: [String: Any], _ result: @escaping FlutterResult) {
        print("~~~> Hello in CopyFile")
        
        guard
            let sourcePath: String = arguments[Args.sourcePathName].flatMap(cast),
            let targetPath: String = arguments[Args.targetPath].flatMap(cast)
        else {
            result(FlutterError.noRequiredArguments)
            
            return
        }
        
        fileService.copy(sourcePath: sourcePath, targetPath: targetPath,
            responseHandler: {
                result($0)
            },
            errorHandler: {
                result(FlutterError($0))
            })
    }
    
    // MARK: -
    // MARK: - Exists
    private func exists(_ arguments: [String: Any], _ result: @escaping FlutterResult) {
        print("~~~> Hello in Exists")
        
        guard let path: String = arguments[Args.path].flatMap(cast) else {
            result(FlutterError.noRequiredArguments)
            
            return
        }
        
        fileService.exists(path: path,
            responseHandler: {
                result($0)
            },
            errorHandler: {
                result(FlutterError($0))
            })
    }
    
    // MARK: -
    // MARK: - GetFileCount
    private func getFileCount(_ arguments: [String: Any], _ result: @escaping FlutterResult) {
        print("~~~> Hello in Get File Count")
        
        guard let path: String = arguments[Args.path].flatMap(cast) else {
            result(FlutterError.noRequiredArguments)
            
            return
        }
        
        let pattern: String? = arguments[Args.pattern].flatMap(cast)
        let recursive: Bool? = arguments[Args.recursive].flatMap(cast)
        let countDirectories: Bool? = arguments[Args.countDirectories].flatMap(cast)
        
        if let pattern = pattern {
            if let recursive = recursive {
                if let countDirectories = countDirectories {
                    fileService.getFileCount(path: path, pattern: pattern, recursive: recursive, countDirectories: countDirectories,
                        responseHandler: {
                            result($0)
                        },
                        errorHandler: {
                            result(FlutterError($0))
                        })
                } else {
                    fileService.getFileCount(path: path, pattern: pattern, recursive: recursive,
                        responseHandler: {
                            result($0)
                        },
                        errorHandler: {
                            result(FlutterError($0))
                        })
                }
            } else {
                fileService.getFileCount(path: path, pattern: pattern,
                    responseHandler: {
                        result($0)
                    },
                    errorHandler: {
                        result(FlutterError($0))
                    })
            }
        } else {
            fileService.getFileCount(path: path,
                responseHandler: {
                    result($0)
                },
                    errorHandler: {
                result(FlutterError($0))
                })
        }
    }
    
    // MARK: -
    // MARK: - Listing
    private func listing(_ arguments: [String: Any], _ result: @escaping FlutterResult) {
        print("~~~> Hello in Listing")
        
        guard let path: String = arguments[Args.path].flatMap(cast) else {
            result(FlutterError.noRequiredArguments)
            
            return
        }
        
        let pattern: String? = arguments[Args.pattern].flatMap(cast)
        let recursive: Bool? = arguments[Args.recursive].flatMap(cast)
        let pageSize: Int? = arguments[Args.pageSize].flatMap(cast)
        let offset: Int? = arguments[Args.offset].flatMap(cast)
        
        if let pattern = pattern, let recursive = recursive {
            if let pageSize = pageSize, let offset = offset {
                fileService.listing(path: path, pattern: pattern, recursive: recursive, pageSize: pageSize, offset: offset,
                    responseHandler: {
                        result($0)
                    },
                    errorHandler: {
                        result(FlutterError($0))
                    })
            } else {
                fileService.listing(path: path, pattern: pattern, recursive: recursive,
                    responseHandler: {
                        result($0)
                    },
                    errorHandler: {
                        result(FlutterError($0))
                    })
            }
        } else {
            fileService.listing(path: path,
                responseHandler: {
                    result($0)
                },
                errorHandler: {
                    result(FlutterError($0))
                })
            }
    }
    
    // MARK: -
    // MARK: - MoveFile
    private func moveFile(_ arguments: [String: Any], _ result: @escaping FlutterResult) {
        print("~~~> Hello in Move File")
        
        guard
            let sourcePathName: String = arguments[Args.sourcePathName].flatMap(cast),
            let targetPath: String = arguments[Args.targetPath].flatMap(cast)
        else {
            result(FlutterError.noRequiredArguments)
            
            return
        }
        
        fileService.move(sourcePath: sourcePathName, targetPath: targetPath,
            responseHandler: {
                result($0)
            },
            errorHandler: {
                result(FlutterError($0))
            })
    }
    
    // MARK: -
    // MARK: - Remove
    private func remove(_ arguments: [String: Any], _ result: @escaping FlutterResult) {
        print("~~~> Hello in Remove")
        
        guard let fileUrl: String = arguments[Args.fileUrl].flatMap(cast) else {
            result(FlutterError.noRequiredArguments)
            
            return
        }
        
        fileService.remove(path: fileUrl,
            responseHandler: {
                result(nil)
            },
            errorHandler: {
                result(FlutterError($0))
            })
    }
    
    // MARK: -
    // MARK: - RemoveDirectory
    private func removeDirectory(_ arguments: [String: Any], _ result: @escaping FlutterResult) {
        print("~~~> Hello in Remove Directory")
        
        guard
            let directoryPath: String = arguments[Args.directoryPath].flatMap(cast),
            let pattern: String? = arguments[Args.pattern].flatMap(cast),
            let recursive: Bool? = arguments[Args.recursive].flatMap(cast)
        else {
            result(FlutterError.noRequiredArguments)
            
            return
        }
        
        if let pattern = pattern, let recursive = recursive {
            fileService.remove(path: directoryPath, pattern: pattern, recursive: recursive,
                responseHandler: {
                    result(nil)
                },
                errorHandler: {
                    result(FlutterError($0))
                })
        } else {
            fileService.remove(path: directoryPath, pattern: "*", recursive: true,
                responseHandler: {
                    result(nil)
                },
                    errorHandler: {
                result(FlutterError($0))
                })
        }
    }
    
    // MARK: -
    // MARK: - RenameFile
    private func renameFile(_ arguments: [String: Any], _ result: @escaping FlutterResult) {
        print("~~~> Hello in RenameFile")
        
        guard
            let path: String = arguments[Args.oldPathName].flatMap(cast),
            let newName: String = arguments[Args.newName].flatMap(cast)
        else {
            result(FlutterError.noRequiredArguments)
            
            return
        }
        
        fileService.rename(path: path, newName: newName,
            responseHandler: {
                result($0)
            },
            errorHandler: {
                result(FlutterError($0))
            })
    }
    
    // MARK: -
    // MARK: - SaveFile
    private func saveFile(_ arguments: [String: Any], _ result: @escaping FlutterResult) {
        print("~~~> Hello in Save File")
        
        guard
            let path: String = arguments[Args.path].flatMap(cast),
            let fileName: String = arguments[Args.fileName].flatMap(cast),
            let fileContent: Data = arguments[Args.fileContent].flatMap(cast),
            let overWrite: Bool? = arguments[Args.overwrite].flatMap(cast)
        else {
            result(FlutterError.noRequiredArguments)
            
            return
        }
        
        let base64Content = fileContent.base64EncodedString()
        
        if let overWrite = overWrite {
            fileService.saveFile(fileName: fileName, filePath: path, base64Content: base64Content, overwrite: overWrite,
                responseHandler: {
                    result($0)
                },
                errorHandler: {
                    result(FlutterError($0))
                })
        } else {
            fileService.saveFile(fileName: fileName, filePath: path, base64Content: base64Content,
                responseHandler: {
                    result($0)
                },
                errorHandler: {
                    result(FlutterError($0))
                })
        }
        
        // TODO: - No method to handle "filePathName"
        fatalError("No method to handle \"filePathName\"")
        //
    }
    
    // MARK: -
    // MARK: - Upload
    private func upload(_ arguments: [String: Any], _ result: @escaping FlutterResult) {
        print("~~~> Hello in Upload")
        
        // TODO: - Check parameters type
        fatalError("Check parameters type")
    }
    
    
}
