import SwiftUI

struct SettingView: View {
    var body: some View {
        TabView {
            APISettingView()
                .tabItem {
                    Label("Api", systemImage: "bolt.fill")
                }
        }
        .frame(width: 500, height: 400)
    }
}

struct APISettingView: View {
    @AppStorage("queryHost") var queryHost: String = "p1txh7zfb3-3.algolianet.com"
    @State var host = ""
    
    @AppStorage("queryKey") var queryKey: String = "766fcf8cd4746fa79b3d99852cfe8027"
    @State var key = ""

    var body: some View {
        Form {
            TextField("Query Host: ", text: $host)
                .onChange(of: host) { newValue in
                    if newValue.isEmpty {
                        queryHost = "p1txh7zfb3-3.algolianet.com"
                    } else {
                        queryHost = host
                    }
                }
            TextField("Api Key: ", text: $key)
                .onChange(of: host) { newValue in
                    if newValue.isEmpty {
                        queryKey = "766fcf8cd4746fa79b3d99852cfe8027"
                    } else {
                        queryKey = key
                    }
                }

            Spacer()
        }
        .padding()
    }
}
