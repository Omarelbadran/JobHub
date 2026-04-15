import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/cubits/get_all_users_cubit/get_all_users_cubit.dart';
import 'package:job_hub_app/main_views/manage_user_view/widgets/user_card.dart';
import 'package:job_hub_app/main_views/show_job_view/widgets/show_job_card.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetAllUsersCubit()..getAllUsers(),
      child: BlocBuilder<GetAllUsersCubit, GetAllUsersState>(
        builder: (context, state) {
          final GetAllUsersCubit cubit = context.read<GetAllUsersCubit>();
          if (state is GetAllUsersLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (cubit.users.isEmpty) {
            return const Center(child: Text('No users found'));
          }
          if (state is GetAllUsersFailure) {
            return Center(child: Text(state.error));
          }
          return RefreshIndicator(
            onRefresh: () async {
              await context.read<GetAllUsersCubit>().getAllUsers();
            },
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: cubit.users.length,
              itemBuilder: (context, index) {
                final user = cubit.users[index];
                return UserCard(user: user);
              },
            ),
          );
        },
      ),
    );
  }
}
