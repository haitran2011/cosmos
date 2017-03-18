//
//  Imageprocessor.swift
//  MilkyChat
//
//  Created by HieuiOS on 12/28/16.
//  Copyright © 2016 Savvycom. All rights reserved.
import UIKit
class  Imageprocessor{
    fileprivate struct ImageConstant {
        static let imageWidth = 320 * 2
        static let imageHeight = 407 * 2
        static let imageCompressType = "JPEG" //if PNG, no rate is needed
        static let imageCompressQuality:CGFloat = 0.6 //only for JPEG
        static let cacheMemoryMaxMB = 8
        static let cacheDiskMaxMB = 20
        static let imageFolder = "milkychat_images"
    }
    class  func preprocessingImageInput(image :UIImage) -> UIImage{
        let image = Imageprocessor.compressImage(with: image, compressRate: ImageConstant.imageCompressQuality)
        return image
    }
    
    class func compressImage(with imageInput:UIImage, compressRate rate:CGFloat) -> UIImage{
        let imagedata:Data?
        if ImageConstant.imageCompressType.lowercased() == "png" {
            imagedata = UIImagePNGRepresentation(imageInput)
        }else{
            imagedata = UIImageJPEGRepresentation(imageInput, rate)
        }
        return UIImage(data: imagedata!)!
    }
    
    class func flipImageInput(with image:UIImage) -> UIImage{
        let flippedImage = UIImage(cgImage: image.cgImage!, scale: image.scale, orientation: .left)
        return flippedImage
    }
    
    class func flipImageInput(with image:UIImage, direction direct:UIImageOrientation) -> UIImage {
        
        let flippedImage = UIImage(cgImage: image.cgImage!, scale: image.scale, orientation: direct)
        return flippedImage
    }
    
    class func representImage(with image:UIImage) -> Data {
        if ImageConstant.imageCompressType.lowercased() == "png" {
            return UIImagePNGRepresentation(image)!
        }else{
            return UIImageJPEGRepresentation(image, ImageConstant.imageCompressQuality)!
        }
    }
    
    class func fixOrientationOfImage(with image:UIImage) -> UIImage{
        // No-op if the orientation is already correct
        if image.imageOrientation == .up {
            return image
        }
        // We need to calculate the proper transformation to make the image upright.
        // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
        var transform  = CGAffineTransform.identity
        switch image.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: image.size.width, y: image.size.height)
            transform = transform.rotated(by: CGFloat(M_PI))
        break
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: image.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(M_PI_2))
            break
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: image.size.height)
            transform = transform.rotated(by: -(CGFloat)(M_PI_2))
            break
        case .up, .upMirrored:
            break
        }
        switch image.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: image.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            break
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: image.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            break
        case .up, .down, .left, .right:
            break
        }
        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.
        let ctx = CGContext(data: nil, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: image.cgImage!.bitsPerComponent, bytesPerRow: 0, space: image.cgImage!.colorSpace!, bitmapInfo: image.cgImage!.bitmapInfo.rawValue)
        ctx!.concatenate(transform)
        
        switch image.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            //Grr...
            ctx!.draw(image.cgImage!, in: CGRect(x: 0.0,y: 0.0,width: image.size.height,height: image.size.width))
            break
        default:
            ctx!.draw(image.cgImage!, in: CGRect(x: 0.0,y: 0.0,width: image.size.width,height: image.size.height))
            break
        }
        // And now we just create a new UIImage from the drawing context
        let cgimg = ctx!.makeImage()
        let imag = UIImage(cgImage: cgimg!)
        return imag
    }
    
    class func rotateImage(with imageSrc:UIImage, withDirection orientation:UIImageOrientation) -> UIImage{
        UIGraphicsBeginImageContext(imageSrc.size)
        let context = UIGraphicsGetCurrentContext()
        if orientation == .right {
            context!.rotate(by: CGFloat(M_PI_2))
        }else if (orientation == .left){
            context!.rotate(by: -CGFloat(M_PI_2))
        }else if (orientation == .down){
            //DO NOTHING
        }else if (orientation == .up){
            context!.rotate(by: CGFloat(M_PI_2))
        }
        imageSrc.draw(at: CGPoint(x: 0, y :0))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    class func rotateUIImage(with sourceImage:UIImage, clockwise clwise:Bool) -> UIImage{
        let size = sourceImage.size
        UIGraphicsBeginImageContext(CGSize(width: size.height, height: size.width))
        var oritation:UIImageOrientation = .right
        if clwise{
            oritation = .right
        }else{
            oritation = .left
        }
        let cgimage = UIImage(cgImage: sourceImage.cgImage!, scale: 1.0, orientation:oritation)
        cgimage.draw(in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    class func contentTypeForImageData(with data:Data) -> String{
        var ext: String?
        var values = [UInt8](repeating:0, count:data.count)
        data.copyBytes(to: &values, count: data.count)
        switch values[0] {
        case 0xFF:
            ext = "jpeg"
            break
        case 0x89:
            ext = "png"
            break
        case 0x47:
            ext = "gif"
            break
        case 0x42:
            ext = "bmp";
            break
        case 0x49, 0x4D:
            ext = "tiff"
            break
        default:
            ext = "unknown"
            break
        }
        return ext!
    }
    
    class func getImageExtensionType(with sourceImage:UIImage) -> String{
        let imageData = UIImagePNGRepresentation(sourceImage)
        let result = self.contentTypeForImageData(with: imageData!)
        return result
    }
    
    class func createImageSavePathWithDestination(with destinationPath:String) -> String{
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let tempDirectory = paths[0]
        let dataPath = tempDirectory.stringByAppendingPathComponent(destinationPath)
        if !FileManager.default.fileExists(atPath: dataPath) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath, withIntermediateDirectories: false, attributes: nil)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        return dataPath
    }
    
    class func imageFromLocalURL(with imageURL:URL) -> UIImage?{
        let imageFolder = self.createImageSavePathWithDestination(with: ImageConstant.imageFolder)
        let savePath = imageFolder.stringByAppendingPathComponent(imageURL.lastPathComponent)
        let image = UIImage(contentsOfFile: savePath)
        return image
    }
    class func imageFromLocalPath(with path:String) -> UIImage?{
        let imageFolder = self.createImageSavePathWithDestination(with: ImageConstant.imageFolder)
        let savePath = imageFolder.stringByAppendingPathComponent(path.lastPathComponent)
        let image = UIImage(contentsOfFile: savePath)
        return image
    }
    
    class func urlOfImageFromLocalPath(with imageLocalPath:String) -> URL{
        let imageFolder = self.createImageSavePathWithDestination(with: ImageConstant.imageFolder)
        let savePath = imageFolder.stringByAppendingPathComponent(imageLocalPath.lastPathComponent)
        return URL(fileURLWithPath: savePath)
    }
    
    class func removeImage(atLocalPath localPath:String) -> Void{
        let imageFolder = self.createImageSavePathWithDestination(with: ImageConstant.imageFolder)
        let savePath = imageFolder.stringByAppendingPathComponent(localPath.lastPathComponent)
        if FileManager.default.fileExists(atPath: savePath) {
            do{
                try FileManager.default.removeItem(atPath: savePath)
            } catch let error as NSError{
                print(error.localizedDescription)
            }
        }
    }
    
    class func cleanUpAllLocalImages() -> Void{
        let imageFolder = self.createImageSavePathWithDestination(with: ImageConstant.imageFolder)
        let fileManager = FileManager.default
        do {
            let files = try fileManager.contentsOfDirectory(atPath: imageFolder)
            if  files.count == 0 {
                return
            }
            for filename in files {
                let filePath = imageFolder.stringByAppendingPathComponent(filename)
                do {
                    try fileManager.removeItem(atPath: filePath)
                } catch let error as NSError {
                     print(error.localizedDescription)
                }
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    class func imageFromPDF(atPDFURL pdfUrl:URL) -> UIImage?{
        guard let document = CGPDFDocument(pdfUrl as CFURL) else { return nil }
        guard let page = document.page(at: 1) else { return nil }
        let pageRect = page.getBoxRect(.cropBox)
        UIGraphicsBeginImageContext(pageRect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        context?.translateBy(x: 0.0, y: pageRect.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setFillColor(gray: 1.0, alpha: 1.0)
        context?.fill(pageRect)
        let transform =  page.getDrawingTransform(.cropBox, rect: pageRect, rotate: 0, preserveAspectRatio: true)
        context?.concatenate(transform)
        context?.drawPDFPage(page)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        context?.restoreGState()
        UIGraphicsEndImageContext()
        return image
    }
    
    class func moveImageToImageFolder(fromLocalPath localPath:String) -> URL{
        let fileManager = FileManager.default
        let imageFolder = self.createImageSavePathWithDestination(with: ImageConstant.imageFolder)
        let destinasionPath = imageFolder.stringByAppendingPathComponent(localPath.lastPathComponent)
        do {
            try fileManager.moveItem(atPath: localPath, toPath: destinasionPath)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return URL(fileURLWithPath: destinasionPath)
    }
    
    class func saveImageToImageFolder(with image:UIImage, destimationPath desPath:String) -> URL{
        let imageData = UIImageJPEGRepresentation(image, ImageConstant.imageCompressQuality)
        let imageFolder = self.createImageSavePathWithDestination(with: ImageConstant.imageFolder)
        let imagePath = imageFolder.stringByAppendingPathComponent(desPath.lastPathComponent)
        let outPutURL = URL(fileURLWithPath: imagePath)
        do {
            try  imageData?.write(to: outPutURL, options: .atomic)
        } catch let error as NSError {
             print(error.localizedDescription)
        }
       return outPutURL
    }
    @discardableResult class func saveImageImageFolder(with image:UIImage, isthumbnail isthumb:Bool) -> URL{
        let imageData  = isthumb ? UIImageJPEGRepresentation(image, ImageConstant.imageCompressQuality) : UIImageJPEGRepresentation(image, 1)
        let uuid = UUID.init().uuidString
        let imageName = isthumb ?  uuid.appending("-thumb.jpeg") : uuid.appending(".jpeg")
        let imageFolder = self.createImageSavePathWithDestination(with: ImageConstant.imageFolder)
        let imagePath = imageFolder.stringByAppendingPathComponent(imageName)
        let outPutURL = URL(fileURLWithPath: imagePath)
        do {
            try  imageData?.write(to: outPutURL, options: .atomic)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return outPutURL
    }
}
