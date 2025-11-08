import SwiftUI

struct CountryListView: View {
    @StateObject private var presenter: CountryPresenter
    @State private var selectedCountry: Country?

    init(presenter: CountryPresenter) {
        _presenter = StateObject(wrappedValue: presenter)
    }

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Countries")
        }
        .onAppear {
            presenter.loadCountries()
        }
    }

    @ViewBuilder
    private var content: some View {
        if presenter.isLoading {
            ProgressView("Loading...")
        } else if let error = presenter.errorMessage {
            VStack {
                Text(error)
                    .foregroundColor(.red)
                Button("Retry") {
                    presenter.loadCountries()
                }
            }
        } else {
            List(presenter.countries) { country in
                NavigationLink(value: country) {
                    HStack {
                        AsyncImage(url: URL(string: country.flags?.png ?? "")) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 40, height: 25)
                        .clipShape(RoundedRectangle(cornerRadius: 4))

                        VStack(alignment: .leading) {
                            Text(country.name.common)
                                .font(.headline)
                            Text(country.region ?? "")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationDestination(for: Country.self) { country in
                CountryDetailView(country: country)
            }


            }
        }
    }

