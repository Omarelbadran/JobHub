import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api_config.dart';
import '../api/api_services.dart';
import '../models/change_password/change_password_request.dart';
import '../models/change_password/change_password_response.dart';
import '../models/get_all_users/get_all_users.response.dart';
import '../models/get_user/get_user_response.dart';
import '../models/login/login_request.dart';
import '../models/login/login_response.dart';
import '../models/register/register_request.dart';
import '../models/register/register_response.dart';
import '../models/update_user/update_user_request.dart';
import '../models/update_user/update_user_response.dart';

class AuthRepo {
  static Future<LoginResponse> login(LoginRequest request) async {
    var response = await APIService.post(
      endpoint: APIConfig.login,
      body: request.toJson(),
    );
    return LoginResponse.fromJson(response);
  }
  static Future<RegisterResponse> register(RegisterRequest request) async {
    var response = await APIService.post(
      endpoint: APIConfig.register,
      body: request.toJson(),
    );
    return RegisterResponse.fromJson(response);
  }
  static Future<ChangePasswordResponse> changePassword(ChangePasswordRequest request, String token) async {
    var response = await APIService.put(
      endpoint: APIConfig.changePassword,
      body: request.toJson(),
      token: token,
    );
    return ChangePasswordResponse.fromJson(response);
  }


  static final cloudinary = CloudinaryPublic(
    'dtzxftayk',
    'Dxfile',
    cache: false,
  );

  static Future<UpdateUserResponse> updateUser(
      UpdateUserRequest request,
      String token,
      String? resumePath,
      String? imagePath,
      ) async {


    String? finalImageUrl = request.imageUrl;
    String? finalResumeUrl = request.resumeUrl;

      if (imagePath != null) {
        CloudinaryResponse imageRes = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(imagePath, folder: 'profiles'),
        );
        finalImageUrl = imageRes.secureUrl;
      }

      if (resumePath != null) {
        CloudinaryResponse resumeRes = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(resumePath, folder: 'resumes'),
        );
        finalResumeUrl = resumeRes.secureUrl;
      }

      Map<String, dynamic> body = {
        "location": request.location,
        "phone": request.phone,
        "skills": request.skills ?? [],
        "imageUrl": finalImageUrl,
        "resumeUrl": finalResumeUrl,
      };

      var response = await APIService.put(
        endpoint: APIConfig.updateUser,
        body: body,
        token: token,
      );

      return UpdateUserResponse.fromJson(response);
  }
  static Future<GetUserResponse> getUser(String token) async {
    var response = await APIService.get(
      endpoint: APIConfig.getUser,
      token: token,
    );

    return GetUserResponse.fromJson(response);
  }
  static Future<GetAllUsersResponse> getAllUsers(String token) async {
    var response = await APIService.get(
      endpoint: APIConfig.getAllUsers,
      token: token,
    );

    return GetAllUsersResponse.fromJson(response);
  }



  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('userData');
    // await prefs.clear();
  }
}