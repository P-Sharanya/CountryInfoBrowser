import SwiftUI

struct CountryDetailView: View {
    let country: Country

    var body: some View {
        VStack(spacing: 16) {
            AsyncImage(url: URL(string: country.flags?.png ?? "")) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(height: 160)
                    .cornerRadius(8)
            } placeholder: {
                ProgressView()
            }
            
            Text(country.name.common)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            if let region = country.region {
                Text("🌍 Region: \(region)")
                    .font(.headline)
            }
            
            if let capital = country.capital?.first {
                Text("🏙 Capital: \(capital)")
                    .font(.headline)
            }
            
            if let population = country.population {
                Text("👥 Population: \(population)")
                    .font(.headline)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(country.name.common)
        .navigationBarTitleDisplayMode(.inline)
    }
}
