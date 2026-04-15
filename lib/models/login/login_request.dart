class LoginRequest {
  LoginRequest({
    this.email,
    this.password,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      email: json['email'],
      password: json['password'],
    );
  }

  final String? email;
  final String? password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    return map;
  }
}