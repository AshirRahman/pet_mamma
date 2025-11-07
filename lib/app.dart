import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'routes/app_routes.dart';

class PetMamma extends StatelessWidget {
  const PetMamma({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Pet Mamma",
          theme: ThemeData(useMaterial3: true),
          initialRoute: AppRoutes.login,
          routes: AppRoutes.routes,
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
