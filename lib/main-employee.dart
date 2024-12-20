import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:quan_ly_ci_co/core/utils/toast.dart';
import 'package:quan_ly_ci_co/presentation/screen/cham-cong/cham_cong_screen.dart';
import 'package:quan_ly_ci_co/presentation/screen/cham-cong/cubit/cham_cong_cubit.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: (context, child) {
          return Overlay(
            initialEntries: [
              OverlayEntry(builder: (context) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ToastApp.init(context);
                });
                return child!;
              }),
            ],
          );
        },
        home: BlocProvider(
          create: (context) => ChamCongCubit(),
          child: const ChamCongScreen(),
        ));
  }
}
