//
//  ProductRowView.swift
//  MercadoLibre-UIKit-SwiftUI
//
//  Created by Joan Narvaez on 19/02/24.
//

import SwiftUI

struct ProductsRowView: View {
    
    var product: ProductResultResponse
    
    init(product: ProductResultResponse) {
        self.product = product
    }
    
    var body: some View {
        VStack {
            imageView
            headerView
                .padding(.horizontal, 8)
        }
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(.gray, lineWidth: 0.5))
    }
    
    private var imageView: some View {
        AsyncImage(url: product.imageUrl) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
        } placeholder: {
            ProgressView()
        }
        .padding(.vertical)
    }
    
    @ViewBuilder
    private var headerView: some View {
        Text("$ \(product.formattedPrice)")
            .font(.system(size: 12))
            .fontWeight(.bold)
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
        
        Text(product.title)
            .lineLimit(2)
            .font(.body)
            .foregroundStyle(.gray)
            .frame(maxWidth: .infinity, alignment: .leading)
        Spacer()
    }
}

#Preview {
    ProductsRowView(product:ProductResultResponse(id: "1A", title: "Teléfono", thumbnail: "http://http2.mlstatic.com/D_952396-MLU74218675320_012024-I.jpg", permalink: "https://www.mercadolibre.com.co/", price: 12000, originalPrice: 12000))
}
