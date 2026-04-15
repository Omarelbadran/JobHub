class ChangePasswordRequest {
  ChangePasswordRequest({
    required this.currentPassword,
    required this.newPassword,
  });
  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) {
    return ChangePasswordRequest(
      currentPassword: json['currentPassword'],
        newPassword: json['newPassword'],
    );
  }
  final String currentPassword;
  final String newPassword;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currentPassword'] = currentPassword;
    map['newPassword'] = newPassword;
    return map;
  }
}
