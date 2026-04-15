import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api_errors.dart';
import '../../models/job_model/job_model.dart';
import '../../models/update_job/update_job_request.dart';
import '../../repos/main_repo.dart';

part 'update_job_state.dart';

class UpdateJobCubit extends Cubit<UpdateJobState> {
  UpdateJobCubit() : super(UpdateJobInitial());

  // 1. التعريفات (نفس ستايل الكنترولرز والـ Key)
  final titleController = TextEditingController();
  final companyController = TextEditingController();
  final descController = TextEditingController();
  final locationController = TextEditingController();
  final salaryController = TextEditingController();
  final contractController = TextEditingController();
  final workHoursController = TextEditingController();
  final imageUrlController = TextEditingController();

  final requirementController = TextEditingController();

  List<String> requirements = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Future<void> close() async {
    titleController.dispose();
    companyController.dispose();
    descController.dispose();
    locationController.dispose();
    salaryController.dispose();
    contractController.dispose();
    workHoursController.dispose();
    imageUrlController.dispose();
    requirementController.dispose();
    return await super.close();
  }

  // 2. ميثود تحميل بيانات الوظيفة (زي loadUserData)
  void loadJobData(JobModel job) {
    titleController.text = job.title;
    companyController.text = job.company;
    descController.text = job.description;
    locationController.text = job.location;
    salaryController.text = job.salary;
    contractController.text = job.contractPeriod;
    workHoursController.text = job.workHours ?? "";
    imageUrlController.text = job.imageUrl ?? "";
    requirements = List.from(job.requirements ?? []);
    emit(UpdateJobInitial());
  }

  void addRequirement() {
    final text = requirementController.text.trim();
    if (text.isNotEmpty) {
      requirements.add(text);
      requirementController.clear();
      emit(UpdateJobInitial());
    }
  }

  void removeRequirement(int index) {
    requirements.removeAt(index);
    emit(UpdateJobInitial());
  }

  Future<void> updateJob(String jobId) async {

    if (formKey.currentState != null && !formKey.currentState!.validate()) return;

    emit(UpdateJobLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception("Token not found");
      }

      final request = UpdateJobRequest(
        id: jobId,
        title: titleController.text.trim(),
        company: companyController.text.trim(),
        description: descController.text.trim(),
        location: locationController.text.trim(),
        salary: salaryController.text.trim(),
        contractPeriod: contractController.text.trim(),
        workHours: workHoursController.text.trim(),
        imageUrl: imageUrlController.text.trim(),
        requirements: requirements,
      );
      final response = await MainRepo.updateJob(token, request);

      if (response.status == true && response.job != null) {
        emit(UpdateJobSuccess(response.job!));
      } else {
        emit(UpdateJobFailure("Failed to update job data"));
      }

    } on Exception catch (e) {
      String errorMessage = APIError.getErrorMessage(e);
      emit(UpdateJobFailure(errorMessage));
    }
  }
}