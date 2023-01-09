//
//  CardsView.swift
//  SwifUIDoubleSlots
//
//  Created by Soumya Deekonda on 8/12/22.
//

import SwiftUI

struct CardsView: View {
    @Binding var background:Color
    @Binding var symbol:String
   
    var body: some View {
        Image(symbol)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .background(background.opacity(0.5))
            .cornerRadius(20)
    }
}
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardsView(background: Binding.constant(Color.green), symbol: Binding.constant("cherry"))
    }
}

