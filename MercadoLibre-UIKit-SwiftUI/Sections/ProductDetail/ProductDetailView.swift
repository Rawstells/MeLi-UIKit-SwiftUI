//
//  ProductDetailView.swift
//  MercadoLibre
//
//  Created by Joan Narvaez on 18/02/24.
//

import SwiftUI

struct ProductDetailView: View {
    var product: ProductResultResponse
    var relatedProducts: [ProductResultResponse]
    @State private var showWebView = false
    private let url: URL?
    
    init(product: ProductResultResponse, relatedProducts: [ProductResultResponse]) {
        self.product = product
        self.relatedProducts = relatedProducts
        self.url = URL(string: product.permalink)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(spacing: 30) {
                    rowProduct
                    share
                    arrival
                    withdrawal
                    showMore
                    prompt
                }
                .padding(.horizontal)
                relatedProductsView
            }
            .background(Color.white)
        }
        .background(Color.primaryYellow)
        .navigationTitle("Detalle")
    }
    
    private var rowProduct: some View {
        VStack {
            title
            AsyncImage(url: product.imageUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width - 200)
            } placeholder: {
                ProgressView()
            }
            
            HStack {
                Text("$ \(product.formattedPrice)")
                    .bold()
                    .font(.system(size: 30))
                
                //Descuento
                Text(product.id)
                    .foregroundStyle(.green)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            //Cuotas
            
            //Llegada
        }
    }
    
    private var share: some View {
        HStack {
            Image(systemName: "creditcard")
                .padding(.bottom)
            VStack {
                Text(product.id)
                    .multilineTextAlignment(.leading)
                Text(product.id)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.blue)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var arrival: some View {
        VStack (alignment: .leading) {
            Text(product.id)
                .multilineTextAlignment(.leading)
                .foregroundStyle(.green)
            Text(product.id)
                .multilineTextAlignment(.leading)
                .foregroundStyle(.blue)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var withdrawal: some View {
        VStack (alignment: .leading) {
            Text(product.id)
                .multilineTextAlignment(.leading)
            Text(product.id)
                .foregroundStyle(.blue)
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var title: some View {
        VStack {
            Text(product.title)
                .lineLimit(nil)
                .font(.title2)
                .font(.system(size: 16))
                .multilineTextAlignment(.leading)
        }
    }
    
    private var showMore: some View {
        Button("Ver más") {
            showWebView = true
        }
        .bold()
        .sheet(isPresented: $showWebView) {
            if let url = url {
                WebView(url: url.absoluteString)
            }
        }
    }
    
    private var prompt: some View {
        Text("Productos relacionados")
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var relatedProductsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: .zero) {
                ForEach(relatedProducts) { item in
                    ProductsRowView(product: item)
                        .frame(width: 150, height: 250)
                        .padding(.leading)
                }
            }
        }.frame(height: 300)
    }
}

/////////
public extension Color {
    static var primaryYellow: Color { .init(hex: "#F8DE46") ?? .yellow }
    static var lightGrayColor: Color { .init(hex: "#F2F2F2") ?? .yellow }
}

//////
public extension Color {
    init?(hex: String,
          alpha: Double = 1) {
        guard let uint = UInt(("0x" + hex).suffix(6), radix: 16) else {
            return nil
        }
        self.init(hex: uint, alpha: alpha)
    }

    init(hex: UInt, alpha: Double = 1) {
        self.init(.sRGB,
                  red: Double((hex >> 16) & 0xff) / 255,
                  green: Double((hex >> 08) & 0xff) / 255,
                  blue: Double((hex >> 00) & 0xff) / 255,
                  opacity: alpha)
    }
}


/////
import WebKit

struct WebView: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: URL(string: url)!))
    }
}

