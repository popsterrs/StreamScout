//
//  View+Extentions.swift
//  SocialMediaApp
//
//  Created by popsters on 13/02/2023.
//

import SwiftUI

enum MediaType {
    case movie
    case tvSeries
    case unknown
}

extension View{
    func closeKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for :nil)
    }
    
    func disableWithOpacity(_ condition: Bool)->some View {
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
    
    func hAlign(_ alignment: Alignment)->some View {
        self
            .frame(maxWidth: . infinity,alignment: alignment)
    }
    
    func vAlign(_ alignment: Alignment)->some View {
        self
            .frame(maxHeight: . infinity,alignment: alignment)
    }
    
    func border(_ width: CGFloat,_ color: Color)->some View {
        self
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background {
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .stroke(color, lineWidth: width)
            }
    }
    
    func fillView(_ color: Color)->some View {
        self
            .background {
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .fill(color)
            }
    }
    
    func fillViewPadding(_ color: Color)->some View {
        self
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background {
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .fill(color)
            }
    }
    
    func bottomGradient()->some View {
        self
            .overlay(content: {
                ZStack(alignment: .bottom) {
                    Rectangle()
                        .fill(
                            .linearGradient(colors: [
                                .black.opacity(0),
                                .black.opacity(0.1),
                                .black.opacity(0.3),
                                .black.opacity(0.5),
                                .black.opacity(0.8),
                                .black.opacity(1),
                            ], startPoint: .top, endPoint: .bottom)
                        )
                }
            })
    }
    
    func getSafeAreaTop()->CGFloat{
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        return keyWindow?.safeAreaInsets.top ?? 0
    }
    
    func getMovieIdsByGenre(genreId: Int, completion: @escaping (Result<Array<Int>, Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&with_genres=\(genreId)&language=en-US")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "Unknown error", code: 0, userInfo: nil)))
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                let results = json?["results"] as? [[String: Any]]
                let movieIds = results?.compactMap { $0["id"] as? Int }
                
                completion(.success(movieIds ?? []))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getSeriesIdsByGenre(genreId: Int, completion: @escaping (Result<Array<Int>, Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/discover/tv?api_key=\(apiKey)&with_genres=\(genreId)&language=en-US")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "Unknown error", code: 0, userInfo: nil)))
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                let results = json?["results"] as? [[String: Any]]
                let movieIds = results?.compactMap { $0["id"] as? Int }
                
                completion(.success(movieIds ?? []))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getMovieDetails(movieID: Int, completion: @escaping (Result<MovieDetails, Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)?api_key=\(apiKey)&language=en-US")!
            
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let decodedData = try JSONDecoder().decode(MovieDetails.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(error))
                    }
                } else if let error = error {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func getSeriesDetails(seriesID: Int, completion: @escaping (Result<SeriesDetails, Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/tv/\(seriesID)?api_key=\(apiKey)&language=en-US")!
            
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let decodedData = try JSONDecoder().decode(SeriesDetails.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(error))
                    }
                } else if let error = error {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func getSeasonDetails(seriesID: Int, seasonNumber: Int, completion: @escaping (Result<SeasonDetails, Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/tv/\(seriesID)/season/\(seasonNumber)?api_key=\(apiKey)&language=en-US")!
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let decodedData = try JSONDecoder().decode(SeasonDetails.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(error))
                    }
                } else if let error = error {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func getSimilarMovies(movieID: Int, completion: @escaping (Result<SimilarMovies, Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/similar?api_key=\(apiKey)&language=en-US")!
            
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let decodedData = try JSONDecoder().decode(SimilarMovies.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(error))
                    }
                    
                } else if let error = error {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func getWatchProviders(id: Int, completion: @escaping (Result<WatchProviderResults, Error>) -> Void) {
        let movieURL = URL(string: "https://api.themoviedb.org/3/movie/\(id)/watch/providers?api_key=\(apiKey)")!
        let seriesURL = URL(string: "https://api.themoviedb.org/3/tv/\(id)/watch/providers?api_key=\(apiKey)")!
        let unknownURL = URL(string: "https://api.themoviedb.org/3/movie/\(id)/watch/providers?api_key=\(apiKey)")!
        
        getMediaType(id: id) { type in
            switch type {
            case .movie:
                URLSession.shared.dataTask(with: movieURL) { data, _, error in
                    DispatchQueue.main.async {
                        if let data = data {
                            do {
                                let decodedData = try JSONDecoder().decode(WatchProviderResults.self, from: data)
                                completion(.success(decodedData))
                            } catch {
                                completion(.failure(error))
                            }
                            
                        } else if let error = error {
                            completion(.failure(error))
                        }
                    }
                }.resume()
            case .tvSeries:
                URLSession.shared.dataTask(with: seriesURL) { data, _, error in
                    DispatchQueue.main.async {
                        if let data = data {
                            do {
                                let decodedData = try JSONDecoder().decode(WatchProviderResults.self, from: data)
                                completion(.success(decodedData))
                            } catch {
                                completion(.failure(error))
                            }
                            
                        } else if let error = error {
                            completion(.failure(error))
                        }
                    }
                }.resume()
            case .unknown:
                URLSession.shared.dataTask(with: unknownURL) { data, _, error in
                    DispatchQueue.main.async {
                        if let data = data {
                            do {
                                let decodedData = try JSONDecoder().decode(WatchProviderResults.self, from: data)
                                completion(.success(decodedData))
                            } catch {
                                completion(.failure(error))
                            }
                            
                        } else if let error = error {
                            completion(.failure(error))
                        }
                    }
                }.resume()
            }
        }
    }

    
    func getTVSeriesType(id: Int, completion: @escaping (MediaType) -> Void) {
        let session = URLSession.shared

        let tvSeriesURL = URL(string: "https://api.themoviedb.org/3/tv/\(id)?api_key=\(apiKey)")!
        let tvSeriesRequest = URLRequest(url: tvSeriesURL)
        
        let tvSeriesTask = session.dataTask(with: tvSeriesRequest) { data, response, error in
            guard let data = data,
                  let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200,
                  error == nil else {

                completion(.unknown)
                return
            }
            
            completion(.tvSeries)
        }
        
        tvSeriesTask.resume()
    }

    func getMediaType(id: Int, completion: @escaping (MediaType) -> Void) {
        let session = URLSession.shared

        let movieURL = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)")!
        let movieRequest = URLRequest(url: movieURL)
        
        let movieTask = session.dataTask(with: movieRequest) { data, response, error in
            guard let data = data,
                  let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200,
                  error == nil else {

                getTVSeriesType(id: id) { tvSeriesType in
                    completion(tvSeriesType == .tvSeries ? .tvSeries : .unknown)
                }
                return
            }
            
            completion(.movie)
        }
        movieTask.resume()
    }
    
    func searchMoviesAndSeries(query: String, page: Int, completion: @escaping (Result<SearchResultDetails, Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/search/multi?api_key=\(apiKey)&language=en-US&query=\(query.replacingOccurrences(of: " ", with: "%20") ?? "")&page=\(page ?? 1)&include_adult=false")!
            
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let decodedData = try JSONDecoder().decode(SearchResultDetails.self, from: data)
                        
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(error))
                    }
                    
                } else if let error = error {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func getCollectionDetails(collectionID: Int, completion: @escaping (Result<CollectionDetails, Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/collection/\(collectionID)?api_key=\(apiKey)")!
            
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let decodedData = try JSONDecoder().decode(CollectionDetails.self, from: data)
                        
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(error))
                    }
                    
                } else if let error = error {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func stringDateToYear(string: String) -> String {
        let array = string.components(separatedBy: "-")

        return array[0]
    }
    
    func minutesToHoursAndMinutes(int: Int) -> (hours: Int, minutes: Int)  {
        let hours = int / 60
        let minutes = int % 60
        
        return (hours, minutes)
    }
    
    func splitStringIntoArray(string: String) -> [Int] {
        let array = string.components(separatedBy: "-")
        let intArray = array.compactMap { Int($0) }
        
        return intArray
    }

}
