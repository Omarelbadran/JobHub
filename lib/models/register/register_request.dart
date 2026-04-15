class RegisterRequest {
  RegisterRequest({
    required this.username,
    required this.email,
    required this.password,
    this.location,
    this.phone,
    this.skills,
  });

final String username;
final String email;
final String password;
final String? location;
final List<String>? skills;
final String? phone;
factory RegisterRequest.fromJson(Map<String, dynamic> json){
  return RegisterRequest(
      username: json['username'],
      email: json['email'],
      password: json['password'],
    location: json['location'],
    phone: json['phone'],
    skills: json['skills'] != null ? List<String>.from(json['skills']) : null,
  );
}
  Map<String, dynamic> toJson() =>{
  "username": username,
  "email": email,
  "password": password,
    "location": location ?? "",
    "phone": phone ?? "",
    "skills": skills ?? [],
  };
}