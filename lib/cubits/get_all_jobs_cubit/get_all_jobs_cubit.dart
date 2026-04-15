import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api_errors.dart';
import '../../models/delete_job/delete_job_request.dart';
import '../../models/get_all_jobs/get_all_jobs_response.dart';
import '../../models/job_model/job_model.dart';
import '../../models/update_job/update_job_request.dart';
import '../../repos/main_repo.dart';

part 'get_all_jobs_state.dart';

class GetAllJobsCubit extends Cubit<GetAllJobsState> {
  GetAllJobsCubit() : super(GetAllJobsInitial());
  List<JobModel> jobs = [];
  List<JobModel> recentJobs = [];

  Future<void> getJobs() async {
    emit(GetAllJobsLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        emit(GetAllJobsFailure("Token not found"));
        return;
      }

      final response = await MainRepo.getAllJobs(token);

      jobs = response.jobs;
      recentJobs = List.from(jobs)
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

      emit(GetAllJobsSuccess(response));
    } on Exception catch (e) {
      String errorMessage = APIError.getErrorMessage(e);
      emit(GetAllJobsFailure(errorMessage));
    }
  }
  void updateSingleJobLocally(JobModel updatedJob) {
    // 1. دور على مكان الوظيفة القديمة في اللستة عن طريق الـ ID
    // بنقول له: هات لي الـ index بتاع العنصر اللي الـ id بتاعه بيساوي الـ id اللي راجع من صفحة التعديل
    int index = jobs.indexWhere((element) => element.id == updatedJob.id);

    if (index != -1) {
      // 2. بنشيل الداتا القديمة ونحط الداتا الجديدة (updatedJob) مكانها في نفس الـ index
      jobs[index] = updatedJob;

      // 3. 💡 أهم خطوة: بنعمل emit لـ State نجاح جديدة
      // بنبعت لستة جديدة خالص (List.from) عشان الـ Bloc يحس بالتغيير ويرسم الـ UI من تاني
      emit(GetAllJobsSuccess(
        GetAllJobsResponse(status: true, jobs: List.from(jobs)),
      ));
    }
  }
  Future<void> deleteJob(String jobId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        emit(GetAllJobsFailure("Token not found"));
        return;
      }

      final response = await MainRepo.deleteJob(token, DeleteJobRequest(jobId: jobId));

      if (response.status == true) {
        // حذف العنصر من اللستة اللي في الميموري فوراً
        jobs.removeWhere((element) => element.id == jobId);

        // إرسال النجاح باللستة المحدثة
        emit(GetAllJobsSuccess(GetAllJobsResponse(status: true, jobs: List.from(jobs))));
      } else {
        emit(GetAllJobsFailure(response.message ?? "Failed to delete job"));
      }
    } on Exception catch (e) {
      String errorMessage = APIError.getErrorMessage(e);
      emit(GetAllJobsFailure(errorMessage));
    }
  }
}
