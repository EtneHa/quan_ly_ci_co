import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ci_co/core/apps/enums/base_screen_state.dart';
import 'package:quan_ly_ci_co/core/styles/box_shadow_app.dart';
import 'package:quan_ly_ci_co/core/styles/text_styles_app.dart';
import 'package:quan_ly_ci_co/presentation/screen/dashboard/user/cubit/user_cubit.dart';
import 'package:quan_ly_ci_co/presentation/screen/dashboard/user/cubit/user_state.dart';
import 'package:quan_ly_ci_co/presentation/screen/dashboard/user/user_data_grid.dart';
import 'package:quan_ly_ci_co/presentation/widgets/input/input_text_field.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserCubit()..loadUsers(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state.screenState == BaseScreenState.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.screenState == BaseScreenState.loading) {
              return Center(child: Text(state.errorText!));
            }

            return Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text('Danh sách nhân viên',
                          style: TextStylesApp.heading4(color: Colors.black)),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                            boxShadow: BoxShadowApp.elevation1),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 276,
                                    child: InputTextField(
                                      label: 'Tìm kiếm',
                                      onChanged: (value) {
                                        context.read<UserCubit>().search(value);
                                      },
                                      hint: 'Mã nhân viên, Họ tên,...',
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  SizedBox(
                                    width: 276,
                                    child: InputTextField(
                                      label: 'Tìm kiếm',
                                      onChanged: (value) {
                                        context.read<UserCubit>().search(value);
                                      },
                                      hint: 'Mã nhân viên, Họ tên,...',
                                    ),
                                  ),
                                  const Spacer(),
                                  const SizedBox(width: 16),
                                  OutlinedButton(
                                      onPressed: () {},
                                      child: Text('Xuất danh sách nhân viên',
                                          style: TextStylesApp.medium(
                                              color: Colors.black))),
                                  const SizedBox(width: 16),
                                  FilledButton(
                                      onPressed: () {},
                                      child: Text('Thêm nhân viên',
                                          style: TextStylesApp.medium(
                                              color: Colors.white)))
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            Expanded(
                                child: UserDataGrid(data: state.users ?? [])),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
