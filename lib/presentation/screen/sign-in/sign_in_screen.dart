import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ci_co/core/strings/string_validate.dart';
import 'package:quan_ly_ci_co/core/styles/text_styles_app.dart';
import 'package:quan_ly_ci_co/core/utils/toast.dart';
import 'package:quan_ly_ci_co/gen/assets.gen.dart';
import 'package:quan_ly_ci_co/presentation/navigation/app_navigation.dart';
import 'package:quan_ly_ci_co/presentation/widgets/button/filled_button_app.dart';
import 'package:quan_ly_ci_co/presentation/widgets/input/input_text_field.dart';
import 'package:quan_ly_ci_co/presentation/screen/sign-in/cubit/sign_in_cubit.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: 'admin@example.com');
  final TextEditingController _passwordController =
      TextEditingController(text: 'adminpassword123');
  bool obscureText = true;

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      context
          .read<SignInCubit>()
          .signIn(_emailController.text, _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<SignInCubit, SignInState>(
          listener: (context, state) {
            if (state is SignInSuccess) {
              ToastApp.showSuccess('Đăng nhập thành công');
              NavigationApp.routeTo(context, 'dashboard');
            } else if (state is SignInFailure) {
              ToastApp.showError(state.error);
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
                      'Đăng nhập',
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
                          controller: _emailController,
                          validator: StringValidate.validateRequired,
                        ),
                        const SizedBox(height: 16),
                        InputTextField(
                          label: 'Mật khẩu',
                          hint: 'Mật khẩu',
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obscureText,
                          validator: StringValidate.validatePassword,
                          suffixIcon: obscureText
                              ? IconButton(
                                  icon: const Icon(Icons.visibility_off),
                                  onPressed: () => setState(() {
                                    obscureText = !obscureText;
                                  }),
                                )
                              : IconButton(
                                  icon: const Icon(Icons.visibility),
                                  onPressed: () => setState(() {
                                    obscureText = !obscureText;
                                  }),
                                ),
                        ),
                        const SizedBox(height: 32),
                        FilledButtonApp(onPressed: _signIn, label: 'Đăng nhập'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
