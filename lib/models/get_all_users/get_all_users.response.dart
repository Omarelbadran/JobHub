import '../login/login_response.dart';

class GetAllUsersResponse {
  bool? status;
  List<UserData> users;

  GetAllUsersResponse({
    this.status,
    required this.users,
  });

  factory GetAllUsersResponse.fromJson(Map<String, dynamic> json) {
    return GetAllUsersResponse(
      status: json['status'],
      users: json['users'] == null
          ? []
          : List<UserData>.from(
          json['users'].map((x) => UserData.fromJson(x))),
    );
  }
}