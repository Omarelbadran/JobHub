class GetUserResponse {
  bool? status;
  UserData? userData;

  GetUserResponse({
    this.status,
    this.userData,
  });

  factory GetUserResponse.fromJson(Map<String, dynamic> json) {
    return GetUserResponse(
      status: json["status"],
      userData: json["userData"] == null
          ? null
          : UserData.fromJson(json["userData"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "userData": userData?.toJson(),
  };
}

class UserData {
  String? id;
  String? username;
  String? email;
  String? phone;
  String? location;
  bool? isAdmin;
  String? imageUrl;
  String? resumeUrl;
  List<String>? skills;

  UserData({
    this.id,
    this.username,
    this.email,
    this.phone,
    this.location,
    this.isAdmin,
    this.imageUrl,
    this.resumeUrl,
    this.skills,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    username = json["username"];
    email = json["email"];
    phone = json["phone"];
    location = json["location"];
    isAdmin = json["isAdmin"];
    imageUrl = json["imageUrl"];
    resumeUrl = json["resumeUrl"];
    skills = json["skills"] == null ? null : List<String>.from(json["skills"]);
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "email": email,
    "phone": phone,
    "location": location,
    "isAdmin": isAdmin,
    "imageUrl": imageUrl,
    "resumeUrl": resumeUrl,
    "skills": skills,
  };
}
