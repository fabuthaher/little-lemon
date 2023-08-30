//
//  DishRow.swift
//  little-lemon-capstone
//
//  Created by pwc on 29/08/2023.
//

import SwiftUI

struct DishRow: View {
    let dish: Dish
    
    var body: some View {
        HStack {
            Text("\(dish.title!) - $\(dish.price!)") // Display title and price
            
            AsyncImage(url: URL(string: dish.image!)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .frame(width: 50, height: 50) // Adjust the size as needed
                        .cornerRadius(10) // Apply corner radius for styling
                } else if phase.error != nil {
                    // Handle error state
                    Image(systemName: "photo") // Placeholder image for errors
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(10)
                } else {
                    // Handle loading state
                    ProgressView()
                }
            }
            .scaledToFit()
        }
    }
}
//
//struct DishRow_Previews: PreviewProvider {
//    static var previews: some View {
//        DishRow()
//    }
//}
