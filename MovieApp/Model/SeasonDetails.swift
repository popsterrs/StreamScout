struct SeasonDetails: Codable, Identifiable, Equatable, Hashable {
    let id, airDate: String
    let episodes: [Episode]
    let name, overview: String
    let seasonDetailsID: Int
    let posterPath: String?
    let seasonNumber: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case airDate = "air_date"
        case episodes, name, overview
        case seasonDetailsID = "id"
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Episode: Codable, Equatable, Hashable {
    let airDate: String
    let episodeNumber: Int
    let crew, guestStars: [Crew]
    let id: Int
    let title: String
    let overview, productionCode: String
    let seasonNumber: Int
    let stillPath: String? 
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case crew
        case guestStars = "guest_stars"
        case id, overview
        case title = "name"
        case productionCode = "production_code"
        case seasonNumber = "season_number"
        case stillPath = "still_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Crew: Codable, Equatable, Hashable {
//    let department: Department?
//    let job: Job?
    let creditID: String
    let adult: Bool
    let gender, id: Int
//    let knownForDepartment: Department
    let name, originalName: String
    let popularity: Double
    let profilePath: String?
    let order: Int?
    let character: String?

    enum CodingKeys: String, CodingKey {
//        case department, job
        case creditID = "credit_id"
        case adult, gender, id
//        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case order, character
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
