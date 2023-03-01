//
//  DetailRows.swift
//  RandomUserGenerator
//
//  Created by Don Bouncy on 01/03/2023.
//

import SwiftUI

struct DetailRows: View {
    let field: String
    let detail: String
    var body: some View {
        VStack{
            HStack {
                Text(field)
                    .font(.headline)
                Spacer()
                Text(detail)
                    .font(.subheadline)
            }
            .padding(.vertical, 10)
            Divider()
        }
        .padding(.horizontal)
    }
}

struct DetailRows_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//        DetailRows(field: "", detail: "")
    }
}
