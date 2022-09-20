//
//  ContentView.swift
//  SSFloatingTextFieldDemo
//
//  Created by Parth Dumaswala on 19/09/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack(alignment: .center) {
        
            //Customize textfield
            SSFloatingTextField(text: "") { textIs in
                print(textIs)
            }
            .frame(width: 350, height: 50)
            .border(.black)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
