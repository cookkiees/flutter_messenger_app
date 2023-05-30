import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger_app/firebase_options.dart';
import 'app/data/services/api_binding.dart';
import 'app/modules/main/main_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  )
      // ignore: avoid_print
      .then((value) => print("connected ${value.options.asMap}"))
      // ignore: avoid_print
      .catchError((e) => print(e.toString()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      initState: (_) {},
      builder: (controller) {
        return Obx(
          () => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.initial,
            initialBinding: ApiServiceBinding(),
            getPages: AppPages.pages,
            theme: ThemeData(
              scaffoldBackgroundColor: controller.isPrimaryLight.value,
              iconTheme: IconThemeData(color: controller.isPrimaryDark.value),
              splashColor: Colors.grey,
              drawerTheme: DrawerThemeData(
                  elevation: 1,
                  shadowColor: controller.isPrimaryLight.value,
                  backgroundColor: controller.isPrimaryLight.value),
              colorScheme: ColorScheme(
                background: Colors.blue,
                brightness: Brightness.light,
                error: Colors.red,
                onBackground: Colors.blue,
                onError: Colors.red,
                primary: controller.isPrimaryLight.value,
                onPrimary: controller.isPrimaryDark.value,
                onSecondary: Colors.orange,
                onSurface: Colors.blue,
                secondary: Colors.blue,
                surface: Colors.purple,
              ),
            ),
          ),
        );
      },
    );
  }
}
