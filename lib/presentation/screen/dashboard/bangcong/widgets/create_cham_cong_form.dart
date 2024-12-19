import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ci_co/core/strings/string_validate.dart';
import 'package:quan_ly_ci_co/presentation/screen/dashboard/bangcong/cubit/bangcong_cubit.dart';
import 'package:quan_ly_ci_co/presentation/widgets/input/input_text_field.dart';

class CreateChamCongForm extends StatelessWidget {
  const CreateChamCongForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text('Thông tin cá nhân'),
        const SizedBox(height: 16),
        InputTextField(
          hint: 'Mã nhân viên',
          label: 'Mã nhân viên *',
          validator: StringValidate.validateRequired,
          onChanged: context.read<BangCongCubit>().updateId,
        ),
        const SizedBox(height: 16),
        InputTextField(
                hint: 'DD/MM/YYYY',
                label: 'Ngày công',
                validator: (value) =>
                    StringValidate.validateDateTime(value),
                onChanged: context.read<BangCongCubit>().updateDate,
              ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: InputTextField(
                hint: 'DD/MM/YYYY',
                label: 'Giờ vào *',
                validator: StringValidate.validateRequired,
                onChanged: context.read<BangCongCubit>().updateGioVao,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: InputTextField(
                hint: 'Giờ ra',
                label: 'Giờ ra *',
                validator: StringValidate.validateRequired,
                onChanged: context.read<BangCongCubit>().updateGioRa,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
