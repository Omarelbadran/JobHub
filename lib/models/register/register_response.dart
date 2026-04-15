class RegisterResponse {
  bool? status;
  String? message;

  RegisterResponse({
    this.status,
    this.message
  });


  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      status: json['status'],
      message: json['message'],
    );
  }
  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
