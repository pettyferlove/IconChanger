import SwiftUI
import LaunchPadManagerDBHelper

struct ImageView: View {
    let icon: IconRes
    let setPath: LaunchPadManagerDBHelper.AppInfo
    @State var preveiw: NSImage?

    @Binding var showPro: Bool

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        if let preveiw = preveiw {
            Image(nsImage: preveiw)
                .resizable()
                .scaledToFit()
                .onTapGesture {
                    Task {
                        do {
                            showPro = true

                            guard let nsimage = try await MyRequestController().sendRequest(icon.icnsUrl) else {
                                showPro = false
                                return
                            }
                            try IconManager.shared.setImage(nsimage, app: setPath)

                            showPro = false
                            presentationMode.wrappedValue.dismiss()

                        } catch {
                            print(error)
                        }
                    }
                }
        } else {
            Image("Unknown")
                .resizable()
                .scaledToFit()
                .overlay {
                    ProgressView()
                }
                .task {
                    do {
                        preveiw = try await MyRequestController().sendRequest(icon.lowResPngUrl)
                    } catch {
                        print(error)
                    }
                }
        }
    }

    func saveImage(_ image: NSImage) -> Data? {
        guard
            let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)
            else { return nil } // TODO: handle error
        let newRep = NSBitmapImageRep(cgImage: cgImage)
        newRep.size = image.size // if you want the same size
        guard
            let pngData = newRep.representation(using: .png, properties: [:])
            else { return nil } // TODO: handle error
        return pngData
    }
}
