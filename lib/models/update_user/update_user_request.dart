class UpdateUserRequest {
  final String? resumeUrl;
  final List<String>? skills;
  final String? location;
  final String? phone;
  final String? imageUrl;

  UpdateUserRequest({
    this.resumeUrl,
    this.skills,
    this.location,
    this.phone,
    this.imageUrl
  });
  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) {
    return UpdateUserRequest(
      resumeUrl: json['resumeUrl'],
      skills: json['skills'] != null ? List<String>.from(json['skills']) : null,
      location: json['location'],
      phone: json['phone'],
      imageUrl: json['imageUrl'],
    );
  }
  Map <String, dynamic> toJson() => {
    "resumeUrl": resumeUrl,
    "skills": skills ?? [],
    "location": location,
    "phone": phone,
    "imageUrl": imageUrl,
  };
}