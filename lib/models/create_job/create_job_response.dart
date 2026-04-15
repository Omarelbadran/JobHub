class CreateJobResponse {
  CreateJobResponse({
    required this.status,
    required this.message,
  });

  final bool status;
  final String message;

  factory CreateJobResponse.fromJson(Map<String, dynamic> json) {
    return CreateJobResponse(
      status: json['status'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}