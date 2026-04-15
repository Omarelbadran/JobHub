import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/cubits/create_job_cubit/create_job_cubit.dart';
import 'package:job_hub_app/widgets/custom_elevated_button.dart';
import 'package:job_hub_app/widgets/custom_text_form_field.dart';
import 'package:job_hub_app/widgets/settings_app_bar.dart';

import '../../functions/show_snack_bar.dart';
import '../update_job_view/widgets/requirments_list.dart';

class AddJobView extends StatelessWidget {
  const AddJobView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => CreateJobCubit(),
      child: Scaffold(
        body: BlocListener<CreateJobCubit, CreateJobState>(
          listener: (context, state) {
            if (state is CreateJobSuccess) {
              showCustomSnackBar(context, 'Job created successfully');
              Navigator.pop(context, true);
            } else if (state is CreateJobFailure) {
             showCustomSnackBar(context, state.error);
            }
          },
          child: Builder(
            builder: (context) {
              final CreateJobCubit cubit = BlocProvider.of<CreateJobCubit>(
                context,
              );
              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SettingsAppBar(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            title: 'Create new job'),
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
                          controller: cubit.descriptionController,
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
                          controller: cubit.contractPeriodController,
                          hintText: 'Add Contract Period',
                        ),
                        SizedBox(height: screenHeight * .01),
                        Text(
                          'Work Hours',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight * .01),
                        CustomTextFormField(
                          hintText: 'Work Hours',
                          controller: cubit.workHoursController,
                        ),
                        SizedBox(height: screenHeight * .01),
                        Text(
                          'Image URL',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight * .01),
                        CustomTextFormField(
                          hintText: 'Image URL',
                          controller: cubit.imageUrlController,
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
                              icon: Icon(Icons.add_circle,
                                  color: const Color(0xFF3B67E1),
                                  size: 35.sp),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * .01),
                        RequirementsListWidget(
                          requirements: cubit.requirements,
                          onRemove: (index) => cubit.removeRequirement(index),
                        ),

                        SizedBox(height: screenHeight * .04),
                        Builder(
                          builder: (context) {
                            if (cubit.state is CreateJobLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return CustomElevatedButton(
                              onPressed: () {
                                if (cubit.titleController.text.isNotEmpty &&
                                    cubit.companyController.text.isNotEmpty &&
                                    cubit.descriptionController.text.isNotEmpty &&
                                    cubit.locationController.text.isNotEmpty &&
                                    cubit.salaryController.text.isNotEmpty &&
                                    cubit.contractPeriodController.text.isNotEmpty&&
                                    cubit.workHoursController.text.isNotEmpty&&
                                    cubit.imageUrlController.text.isNotEmpty
                                ) {
                                  cubit.createJob();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Please fill all fields"),
                                    ),
                                  );
                                }
                              },
                              butName: 'Create Job',
                            );

                          },
                        ),
                        SizedBox(height: screenHeight * .03),
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
