import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ci_co/core/strings/string_validate.dart';
import 'package:quan_ly_ci_co/presentation/screen/dashboard/user/cubit/user_cubit.dart';
import 'package:quan_ly_ci_co/presentation/widgets/input/input_text_field.dart';

class CreateUserForm extends StatelessWidget {
  const CreateUserForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text('Thông tin cá nhân'),
        const SizedBox(height: 16),
        InputTextField(
          hint: 'Họ và tên',
          label: 'Họ và tên *',
          validator: StringValidate.validateRequired,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
          ],
          onChanged: context.read<UserCubit>().updateFullName,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: InputTextField(
                hint: 'DD/MM/YYYY',
                label: 'Ngày sinh',
                validator: (value) =>
                    StringValidate.validateDateTime(value, isRequired: false),
                onChanged: context.read<UserCubit>().updateBirthDay,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: InputTextField(
                hint: 'Số điện thoại',
                label: 'Số điện thoại *',
                validator: StringValidate.validatePhoneNumber,
                onChanged: context.read<UserCubit>().updatePhoneNumber,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Thông tin công việc'),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: InputTextField(
                hint: 'Phòng ban',
                label: 'Phòng ban *',
                onChanged: context.read<UserCubit>().updateDepartment,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: InputTextField(
                  hint: 'Chức danh',
                  label: 'Chức danh *',
                  onChanged: context.read<UserCubit>().updateRole),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: InputTextField(
                  hint: 'Email',
                  label: 'Email *',
                  onChanged: context.read<UserCubit>().updateEmail),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: InputTextField(
                label: 'Ngày vào làm *',
                hint: 'DD/MM/YYYY',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                  LengthLimitingTextInputFormatter(10),
                ],
                onChanged: context.read<UserCubit>().updateOnBoardingDate,
              ),
            ),
          ],
        )
      ],
    );
  }
}
