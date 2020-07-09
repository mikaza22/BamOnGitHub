import Foundation

struct Permissions : Codable {
	let admin : Bool?
	let push : Bool?
	let pull : Bool?

	enum CodingKeys: String, CodingKey {

		case admin = "admin"
		case push = "push"
		case pull = "pull"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		admin = try values.decodeIfPresent(Bool.self, forKey: .admin)
		push = try values.decodeIfPresent(Bool.self, forKey: .push)
		pull = try values.decodeIfPresent(Bool.self, forKey: .pull)
	}

}
