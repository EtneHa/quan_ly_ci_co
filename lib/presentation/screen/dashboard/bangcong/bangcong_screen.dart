import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ci_co/core/apps/enums/base_screen_state.dart';
import 'package:quan_ly_ci_co/core/styles/box_shadow_app.dart';
import 'package:quan_ly_ci_co/core/styles/text_styles_app.dart';
import 'package:quan_ly_ci_co/presentation/screen/dashboard/bangcong/bangcong_data_grid.dart';
import 'package:quan_ly_ci_co/presentation/screen/dashboard/user/widgets/create_user_form.dart';
import 'package:quan_ly_ci_co/presentation/widgets/button/filled_button_app.dart';
import 'package:quan_ly_ci_co/presentation/widgets/button/outlined_button_app.dart';
import 'package:quan_ly_ci_co/presentation/widgets/dialog/dialog.dart';
import 'package:quan_ly_ci_co/presentation/widgets/input/input_text_field.dart';
import 'cubit/bangcong_cubit.dart';
import 'cubit/bangcong_state.dart';

class BangCongScreen extends StatelessWidget {
  BangCongScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BangCongCubit()..loadData(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bảng Công'),
        ),
        body: BlocBuilder<BangCongCubit, BangCongState>(
          builder: (context, state) {
            if (state.screenState == BaseScreenState.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.screenState == BaseScreenState.loading) {
              return Center(child: Text(state.errorText!));
            }

            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      // context.read<UserCubit>().search(value);
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
                                      // context.read<UserCubit>().search(value);
                                    },
                                    hint: 'Mã nhân viên, Họ tên,...',
                                  ),
                                ),
                                const Spacer(),
                                const SizedBox(width: 16),
                                OutlinedButtonApp(
                                    onPressed: () {},
                                    child: Text('XUẤT BẢNG CÔNG'.toUpperCase(),
                                        style: TextStylesApp.medium(
                                            color: Colors.black))),
                                const SizedBox(width: 16),
                                FilledButtonApp(
                                    onPressed: () => CustomDialog.show(
                                        context: context,
                                        title: 'Thêm nhân viên',
                                        actions: [
                                          OutlinedButtonApp(
                                              onPressed: () {},
                                              child: Text('Huỷ'.toUpperCase(),
                                                  style: TextStylesApp.medium(
                                                      color: Colors.blue))),
                                          const SizedBox(width: 8),
                                          FilledButtonApp(
                                            onPressed: () {
                                              if (formKey.currentState!
                                                  .validate()) {}
                                            },
                                            child: Text(
                                                'Thêm nhân viên'.toUpperCase(),
                                                style: TextStylesApp.medium(
                                                    color: Colors.white)),
                                          )
                                        ],
                                        content: Form(
                                            key: formKey,
                                            child: CreateUserForm())),
                                    child: Text('Chỉnh sửa'.toUpperCase(),
                                        style: TextStylesApp.medium(
                                            color: Colors.white)))
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Expanded(
                              child: BangCongDataGrid(
                                  data: state.chamgCongData ?? [])),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
