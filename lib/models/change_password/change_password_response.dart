class ChangePasswordResponse {
  bool? status;
  String? message;

  ChangePasswordResponse({
    this.status,
    this.message
  });


  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponse(
      status: json['status'],
      message: json['message'],
    );
  }
  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}