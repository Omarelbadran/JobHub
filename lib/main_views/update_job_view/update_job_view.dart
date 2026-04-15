import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/main_views/update_job_view/widgets/requirments_list.dart';
import 'package:job_hub_app/widgets/custom_elevated_button.dart';
import 'package:job_hub_app/widgets/custom_text_form_field.dart';
import 'package:job_hub_app/widgets/settings_app_bar.dart';

import '../../cubits/update_job_cubit/update_job_cubit.dart';
import '../../functions/show_snack_bar.dart';
import '../../models/job_model/job_model.dart';

class UpdateJobView extends StatelessWidget {
  final JobModel job;

  const UpdateJobView({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => UpdateJobCubit()..loadJobData(job),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<UpdateJobCubit, UpdateJobState>(
            listener: (context, state) {
              if (state is UpdateJobSuccess) {
                showCustomSnackBar(context, 'Job updated successfully');
                Navigator.pop(context, true);
              } else if (state is UpdateJobFailure) {
                showCustomSnackBar(context, state.error);
              }
            },
            builder: (context, state) {
              final UpdateJobCubit cubit = context.read<UpdateJobCubit>();
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: SingleChildScrollView(
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SettingsAppBar(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            title: 'Update Job'),
                        SizedBox(height: screenHeight * .01),
                        Text(
                          'Job Title',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: screenHeight * .01),
                        CustomTextFormField(
                          controller: cubit.titleController,
                          hintText: 'add job title',
                        ),

                        SizedBox(height: screenHeight * .01),
                        Text(
                          'Company Name',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight * .01),
                        CustomTextFormField(
                          controller: cubit.companyController,
                          hintText: 'Add Company Name',
                        ),

                        SizedBox(height: screenHeight * .01),
                        Text(
                          'Job Description',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight * .01),
                        CustomTextFormField(
                          controller: cubit.descController,
                          hintText: 'Add Job Description',
                        ),

                        SizedBox(height: screenHeight * .01),
                        Text(
                          'Job Location',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight * .01),
                        CustomTextFormField(
                          controller: cubit.locationController,
                          hintText: 'Add Job Location',
                        ),

                        SizedBox(height: screenHeight * .01),
                        Text(
                          'Job Salary',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight * .01),
                        CustomTextFormField(
                          controller: cubit.salaryController,
                          hintText: 'Add Job Salary',
                        ),

                        SizedBox(height: screenHeight * .01),
                        Text(
                          'Contract Period',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight * .01),
                        CustomTextFormField(
                          controller: cubit.contractController,
                          hintText: 'Add Contract Period',
                        ),
                        Text(
                          'Work Hours',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: screenHeight * .01),
                        CustomTextFormField(
                          controller: cubit.workHoursController,
                          hintText: 'add work hours',
                        ),
                        Text(
                          'Image url',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: screenHeight * .01),
                        CustomTextFormField(
                          controller: cubit.imageUrlController,
                          hintText: 'add image url',
                        ),
                        SizedBox(height: screenHeight * .01),
                        Text(
                          'Requirements',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight * .01),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                controller: cubit.requirementController,
                                hintText: 'Add requirement...',
                              ),
                            ),
                            SizedBox(width: 10.w),
                            IconButton(
                              onPressed: () => cubit.addRequirement(),
                              icon: Icon(Icons.add_circle, color: const Color(0xFF3B67E1), size: 35.sp),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * .01),
                        RequirementsListWidget(
                          requirements: cubit.requirements,
                          onRemove: (index) => cubit.removeRequirement(index),
                        ),


                        SizedBox(height: screenHeight * .05),
                        state is UpdateJobLoading
                            ? const Center(child: CircularProgressIndicator())
                            : CustomElevatedButton(
                                onPressed: () {
                                  cubit.updateJob(job.id);
                                },
                                butName: 'Update Job',
                              ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
