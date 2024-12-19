import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ci_co/core/apps/enums/base_screen_state.dart';
import 'package:quan_ly_ci_co/core/strings/string_validate.dart';
import 'package:quan_ly_ci_co/core/styles/text_styles_app.dart';
import 'package:quan_ly_ci_co/core/utils/toast.dart';
import 'package:quan_ly_ci_co/gen/assets.gen.dart';
import 'package:quan_ly_ci_co/presentation/widgets/button/filled_button_app.dart';
import 'package:quan_ly_ci_co/presentation/widgets/input/input_text_field.dart';
import 'cubit/cham_cong_cubit.dart';
import 'cubit/cham_cong_state.dart';

class ChamCongScreen extends StatefulWidget {
  const ChamCongScreen({super.key});

  @override
  _ChamCongScreenState createState() => _ChamCongScreenState();
}

class _ChamCongScreenState extends State<ChamCongScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final FocusNode _idFocusNode = FocusNode();
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    // Set focus to input field when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _idFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _idFocusNode.dispose();
    _idController.dispose();
    super.dispose();
  }

  void _handleChamCong() {
    if (_formKey.currentState!.validate()) {
      context.read<ChamCongCubit>().chamCong(_idController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<ChamCongCubit, ChamCongState>(
          listenWhen: (previous, current) =>
              previous.isSuccess != current.isSuccess,
          listener: (context, state) {
            print(state.isSuccess);
            if (state.isSuccess) {
              ToastApp.showSuccess('Chấm công thành công');
              _idController.clear();
              context.read<ChamCongCubit>().resetState();
            } else if (state.screenState == BaseScreenState.error) {
              ToastApp.showError(state.errorMessage ?? 'Có lỗi xảy ra');
            }
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 6),
                    blurRadius: 30,
                    spreadRadius: 5,
                    color: Colors.black.withOpacity(0.12),
                  ),
                  BoxShadow(
                    offset: const Offset(0, 16),
                    blurRadius: 24,
                    spreadRadius: 2,
                    color: Colors.black.withOpacity(0.14),
                  ),
                  BoxShadow(
                    offset: const Offset(0, 8),
                    blurRadius: 10,
                    spreadRadius: -5,
                    color: Colors.black.withOpacity(0.20),
                  ),
                ]),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Assets.svg.logo.svg(width: 120, height: 24),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Chấm công',
                      style: TextStylesApp.heading5(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: 450,
                    child: Column(
                      children: [
                        InputTextField(
                          label: 'Mã nhân viên',
                          hint: 'Mã nhân viên',
                          controller: _idController,
                          focusNode: _idFocusNode,
                          validator: StringValidate.validateRequired,
                        ),
                        const SizedBox(height: 32),
                        FilledButtonApp(
                          onPressed: _handleChamCong,
                          label: 'Chấm công'
                        ),
                      ],
                    ),                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
