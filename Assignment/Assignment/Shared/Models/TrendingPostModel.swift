//
//  TrendingPostModel.swift
//  Assignment
//
//  Created by Mohammad Zaid on 20/03/23.
//

import Foundation

// MARK: - TrendingPostResponse
struct TrendingPostResponse: Codable {
    let data: PostList
    let status: Int
    let success: Bool
}

// MARK: - DataClass
struct PostList: Codable {
    let posts: [[Post]]
    let meta: [Meta]
}

// MARK: - Meta
struct Meta: Codable {
    let tagText: String
    let mentions, order: Int

    enum CodingKeys: String, CodingKey {
        case tagText = "tag_text"
        case mentions, order
    }
}

// MARK: - Post
struct Post: Codable {
    let postID, tags, tagText: String
    let order, mentions: Int
    let userID: String
    let language: Language
    let liveAt, title, text: String
    let isSponsored: Int
    let muxPlaybackID: String
    let muxStatus: MuxStatus
    let bucketStatus: BucketStatus
    let origin: Origin
    let maxDownRes: MaxDownRes?
    let muxAssestID, resh, resw: String
    let handle: Handle
    let profilePic: String
    let interestID: String
    let likes, views: Int
    let isFollowed, isLiked: Bool
    let products: [String]
    let brand: [Brand]

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case tags
        case tagText = "tag_text"
        case order, mentions
        case userID = "user_id"
        case language
        case liveAt = "live_at"
        case title, text
        case isSponsored = "is_sponsored"
        case muxPlaybackID = "mux_playback_id"
        case muxStatus = "mux_status"
        case bucketStatus = "bucket_status"
        case origin
        case maxDownRes = "max_down_res"
        case muxAssestID = "mux_assest_id"
        case resh, resw, handle
        case profilePic = "profile_pic"
        case interestID = "interest_id"
        case likes, views
        case isFollowed = "is_followed"
        case isLiked = "is_liked"
        case products, brand
    }
}

// MARK: - Brand
struct Brand: Codable {
    let id, brandID: Int
    let createdAt, brandName: String
    let image, imageV2: String?
    let category, description, meta: String?
    let isOnboarded: Bool
    let website: String?

    enum CodingKeys: String, CodingKey {
        case id
        case brandID = "brand_id"
        case createdAt = "created_at"
        case brandName = "brand_name"
        case image
        case imageV2 = "image_v2"
        case category, description, meta
        case isOnboarded = "is_onboarded"
        case website
    }
}

enum BucketStatus: String, Codable {
    case synced = "synced"
}

enum Handle: String, Codable {
    case athleticanuj = "athleticanuj"
    case keshavTyagiii = "keshav.tyagiii"
    case mensGrooming = "MENS_GROOMING"
    case techinvent = "Techinvent"
    case vivankaul00 = "vivankaul00"
}

enum Language: String, Codable {
    case english = "English"
    case hindi = "Hindi"
}

enum MaxDownRes: String, Codable {
    case high = "high"
}

enum MuxStatus: String, Codable {
    case queued = "queued"
}

enum Origin: String, Codable {
    case videoUpload = "video/upload"
}

// MARK: - TrendingPostResponse
struct TrendingPostRequest: Codable {
    let language = [ "English","Hindi"]
    let interestID = ["26","27","28" ]
    let startPos = 0
    let endPos = 1000

    enum CodingKeys: String, CodingKey {
        case language
        case interestID = "interest_id"
        case startPos = "start_pos"
        case endPos = "end_pos"
    }
}
