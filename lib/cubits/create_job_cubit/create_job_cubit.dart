import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:job_hub_app/models/create_job/create_job_response.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api_errors.dart';
import '../../models/create_job/create_job_request.dart';
import '../../repos/main_repo.dart';

part 'create_job_state.dart';

class CreateJobCubit extends Cubit<CreateJobState> {
  CreateJobCubit() : super(CreateJobInitial());
  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController contractPeriodController = TextEditingController();
  TextEditingController workHoursController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  TextEditingController requirementController = TextEditingController();
  List<String> requirements = [];
  var formKey = GlobalKey<FormState>();
  @override
  Future<void> close() async {
    titleController.dispose();
    locationController.dispose();
    companyController.dispose();
    descriptionController.dispose();
    salaryController.dispose();
    contractPeriodController.dispose();
    workHoursController.dispose();
    imageUrlController.dispose();
    requirementController.dispose();
    return await super.close();
  }
  void addRequirement() {
    final text = requirementController.text.trim();
    if (text.isNotEmpty) {
      requirements.add(text);
      requirementController.clear();
      emit(RequirementUpdated(List.from(requirements)));
    }
  }

  void removeRequirement(int index) {
    requirements.removeAt(index);
    emit(RequirementUpdated(List.from(requirements)));
  }
  Future<void> createJob() async {
    if (formKey.currentState != null && !formKey.currentState!.validate()) return;
    emit(CreateJobLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token == null) {
        throw Exception('Token not found in SharedPreferences');
      }
      final request = CreateJobRequest(
        title: titleController.text.trim(),
        location: locationController.text.trim(),
        company: companyController.text.trim(),
        description: descriptionController.text.trim(),
        salary: salaryController.text.trim(),
        contractPeriod: contractPeriodController.text.trim(),
        workHours: workHoursController.text.trim(),
        imageUrl: imageUrlController.text.trim(),
        requirements: requirements,
      );
      var response = await MainRepo.createJob(request ,token);
      emit(CreateJobSuccess(response));
    } on Exception catch (e) {
    String errorMessage = APIError.getErrorMessage(e);
    emit(CreateJobFailure(errorMessage));
    }
    }
  }

