import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api_errors.dart';
import '../../models/update_user/update_user_request.dart';
import '../../models/update_user/update_user_response.dart';
import '../../repos/auth_repo.dart';
part 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  UpdateUserCubit() : super(UpdateUserInitial()){
  loadSkillsFromCache();
}
  final phoneController = TextEditingController();
  final locationController = TextEditingController();
  final skillsController = TextEditingController();
  String countryCode = "+20";

  List<String> skills = [];
  String? resumePath;
  String? imagePath;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void updateCountryCode(String code) {
    countryCode = code;
  }
  @override
  Future<void> close() async {
    phoneController.dispose();
    locationController.dispose();
    skillsController.dispose();
    return await super.close();
  }
  void loadUserData(UserData userData) {
    phoneController.text = userData.phone ?? "";
    locationController.text = userData.location ?? "";
    skills = userData.skills ?? [];
    emit(SkillsUpdated());
  }
  Future<void> _updateSkillsCache() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('userData');
    if (userJson != null) {
      final userData = UserData.fromJson(jsonDecode(userJson));
      userData.skills = skills;
      await prefs.setString('userData', jsonEncode(userData.toJson()));
    }
  }
  void addSkill() {
    final skill = skillsController.text.trim();

    if (skill.isEmpty) return;

    skills.add(skill);
    skillsController.clear();
    _updateSkillsCache();
    emit(SkillsUpdated());
  }
  void updateSkill(int index) {
    if (skillsController.text.trim().isEmpty) return;

    skills[index] = skillsController.text.trim();
    skillsController.clear();
    _updateSkillsCache();
    emit(SkillsUpdated());
  }
  void deleteSkill(int index) {
    skills.removeAt(index);
    _updateSkillsCache();
    emit(SkillsUpdated());
  }
  Future <void> loadSkillsFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('userData');

    if (userJson != null) {
      final userData = UserData.fromJson(jsonDecode(userJson));
      skills = userData.skills ?? [];
      emit(SkillsUpdated());
    }
  }
  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.single.path != null) {
      imagePath = result.files.single.path;
      emit(ProfileImagePicked(result.files.single.name));
    }
  }
  Future<void> pickResume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null && result.files.single.path != null) {
      resumePath = result.files.single.path;
      emit(ResumePicked(result.files.single.name));
    }
  }
  Future<void> saveChanges() async {
    emit(UpdateUserLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token == null) {
        throw Exception("Token not found");
      }
      String rawPhone = phoneController.text.trim();
      if (rawPhone.startsWith('0')) {
        rawPhone = rawPhone.substring(1);
      }
      String finalFullPhone = "$countryCode$rawPhone";
      final request = UpdateUserRequest(
        phone: finalFullPhone,
        location: locationController.text.trim(),
        skills: skills,
      );
      final response = await AuthRepo.updateUser(
        request,
        token,
        resumePath,
        imagePath,
      );
      emit(UpdateUserSuccess(response));
    } on Exception catch (e) {
      String errorMessage = APIError.getErrorMessage(e);
      emit(UpdateUserFailure(errorMessage));
    }
  }
}
