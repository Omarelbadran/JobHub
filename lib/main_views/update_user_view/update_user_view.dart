import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/main_views/update_user_view/widgets/skill_item.dart';
import 'package:job_hub_app/main_views/update_user_view/widgets/update_location_text_field.dart';
import 'package:job_hub_app/main_views/update_user_view/widgets/update_phone_text_field.dart';
import 'package:job_hub_app/widgets/custom_elevated_button.dart';
import 'package:job_hub_app/widgets/custom_text_form_field.dart';
import 'package:job_hub_app/widgets/settings_app_bar.dart';
import '../../cubits/update_user_cubit/update_user_cubit.dart';
import '../../functions/show_snack_bar.dart';

class UpdateUserView extends StatelessWidget {
  const UpdateUserView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) {
        final cubit = UpdateUserCubit();
        cubit.loadSkillsFromCache();
        return cubit;
      },
      child: Scaffold(
        body: BlocConsumer<UpdateUserCubit, UpdateUserState>(
          listener: (context, state) {
            if (state is UpdateUserSuccess) {
              showCustomSnackBar(context, "User Updated Successfully");
              Navigator.pop(context, true);
            }

            if (state is UpdateUserFailure) {
              showCustomSnackBar(context, state.error);
            }
          },
          builder: (context, state) {
            UpdateUserCubit cubit = BlocProvider.of<UpdateUserCubit>(context);
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SettingsAppBar(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        title: 'Update User',
                      ),
                      SizedBox(height: screenHeight * .01),
                      Center(
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 55.r,
                              backgroundColor: Colors.grey[200],
                              backgroundImage: cubit.imagePath != null
                                  ? FileImage(File(cubit.imagePath!))
                                  : null,
                              child: cubit.imagePath == null
                                  ? Icon(
                                      Icons.person,
                                      size: 55.sp,
                                      color: Colors.grey[400],
                                    )
                                  : null,
                            ),
                            GestureDetector(
                              onTap: () => cubit.pickImage(),
                              child: CircleAvatar(
                                radius: 18.r,
                                backgroundColor: Colors.deepPurple,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 18.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * .01),
                      Text(
                        'PersonalDetails',
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * .01),
                      UpdatePhoneTextField(
                        keyboardType: TextInputType.phone,
                        onCountryChanged: (country) {
                          cubit.updateCountryCode(country.dialCode!);
                        },
                        autofillHints: const [AutofillHints.telephoneNumber],
                        controller: cubit.phoneController,
                      ),
                      SizedBox(height: screenHeight * .02),
                      UpdateLocationTextField(
                        autofillHints: const [AutofillHints.location],
                        controller: cubit.locationController,
                      ),
                      SizedBox(height: screenHeight * .01),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          fixedSize: Size(350.w, 40.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                        onPressed: () {
                          cubit.pickResume();
                        },
                        child: Text(
                          'Edit Resume',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * .01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Professional Skills',
                            style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              cubit.skillsController.clear();
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Add New Skill"),
                                  content: CustomTextFormField(
                                    controller: cubit.skillsController,
                                    hintText: "Skill Name",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        cubit.addSkill();
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Add"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.add_circle,
                              color: Colors.deepPurple,
                              size: 28.sp,
                            ),
                          ),
                        ],
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cubit.skills.length,
                        itemBuilder: (context, index) {
                          return SkillItem(
                            skillName: cubit.skills[index],
                            onTap: () {
                              cubit.skillsController.text = cubit.skills[index];
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Update Skill"),
                                    content: CustomTextFormField(
                                      controller: cubit.skillsController,
                                      hintText: "Skill",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel"),
                                      ),

                                      TextButton(
                                        onPressed: () {
                                          cubit.updateSkill(index);
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Update"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(height: screenHeight * .01),
                      Builder(
                        builder: (context) {
                          if (state is UpdateUserLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return CustomElevatedButton(
                            onPressed: () {
                              cubit.saveChanges();
                            },
                            butName: 'Save Changes',
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
