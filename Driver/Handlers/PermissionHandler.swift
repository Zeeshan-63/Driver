

import Foundation
import AVFoundation
import Photos

class PermissionHandler{
    
    private init() { }
    
    static let instance: PermissionHandler =
    {
        return PermissionHandler()
    }()
    
    // MARK: Open App Setting
    static func openAppSettings(title: String, message:String)
    {
        
        let galleryAccessAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Setting", style: UIAlertActionStyle.default, handler:
        { (alert: UIAlertAction!) -> Void in
            if let url = URL(string: UIApplicationOpenSettingsURLString)
            {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        })
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel",comment:""), style: UIAlertActionStyle.cancel, handler:
        { (alert: UIAlertAction!) -> Void in })
        galleryAccessAlert.addAction(okAction)
        galleryAccessAlert.addAction(cancelAction)
        Utility.instance.topViewController()?.present(galleryAccessAlert, animated: true, completion: nil)
    }
    
    // MARK: Check Camer Permission
    func isPermissionAuthorizedforCamera() -> Bool
    {
        return AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized
    }
    
    
    //MARK: Request for Camera Permission
    func requestCameraPermission(completion: @escaping (_ result: Bool) -> Void)
    {
        let permission = AVCaptureDevice.authorizationStatus(for: .video)
        
        if permission == .denied
        {
            PermissionHandler.openAppSettings(title: "", message: "Driver does not have access to your camera. To enable access, tap Setting and turn on Camera.")
            
        }
        else if permission == .notDetermined
        {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
                if granted
                {
                    completion(true)
                }
                else
                {
                    completion(false)
                }
            })
        }
    }
    
    // MARK: Check PhotoLibrary Permission
    func isPermissionAuthorizedforPhotoLibrary() -> Bool
    {
        return PHPhotoLibrary.authorizationStatus() == .authorized
    }
    
    //MARK: Request for PhotoLibrary Permission
    func requestPhotoLibraryPermission(completion: @escaping (_ result: Bool) -> Void)
    {
        let permission = PHPhotoLibrary.authorizationStatus()
        
        if permission == .denied
        {
            PermissionHandler.openAppSettings(title: "", message: "Driver does not have access to your photos. To enable access, tap Setting and turn on Photos.")
            
        }
        else if permission == .notDetermined
        {
            PHPhotoLibrary.requestAuthorization({ (granted) in
                if granted == .authorized
                {
                    completion(true)
                }
                else
                {
                    completion(false)
                }
            })
        }
    }
    
}
