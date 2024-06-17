//
//  MeView.swift
//  HotProspects
//
//  Created by FZJ on 2024/6/14.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    @AppStorage("name") private var name = "fzj"
    @AppStorage("emailAddress") private var emailAddress = "2919839271@qq.com"
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    @State private var qrcode = UIImage()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                
                TextField("emailAddress", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                
                Image(uiImage: qrcode)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu {
                        ShareLink(item: Image(uiImage: qrcode), preview: SharePreview("My QRcode", image: Image(uiImage: qrcode)))
                    }
            }
            .navigationTitle("Code")
            .onAppear(perform: update)
            .onChange(of: name, update)
            .onChange(of: emailAddress, update)
        }
    }
    
    func update() {
        qrcode = generateQRCode(from: "\(name)\n\(emailAddress)")
    }
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    MeView()
}
