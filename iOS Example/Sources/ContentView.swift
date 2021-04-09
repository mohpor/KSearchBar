//
//  ContentView.swift
//  iOS Example
//
//  Created by Mohammad Porooshani on Apr 10, 2021.
//

import SwiftUI
import KSearchBar

struct SwiftUIKSearchBar: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return KSearchBar()
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

struct ContentView: View {
    var body: some View {
        VStack(alignment: .center) {
            SwiftUIKSearchBar()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
