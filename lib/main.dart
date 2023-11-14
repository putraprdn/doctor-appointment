import 'package:doctor_appointment/core.dart';
import 'package:doctor_appointment/main_layout.dart';
import 'package:doctor_appointment/models/auth_model.dart';
import 'package:doctor_appointment/screens/auth_page.dart';
import 'package:doctor_appointment/screens/booking_page.dart';
import 'package:doctor_appointment/screens/doctor_details.dart';
import 'package:doctor_appointment/screens/success_booked.dart';
import 'package:doctor_appointment/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // This is for push navigator
  static final navigatorKey = GlobalKey<NavigatorState>();

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthModel>(
      create: (context) => AuthModel(),
      child: MaterialApp(
        title: 'Flutter Doctor App',
        navigatorKey: Get.navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
            focusColor: Config.primaryColor,
            border: Config.outlinedBorder,
            focusedBorder: Config.focusBorder,
            errorBorder: Config.errorBorder,
            enabledBorder: Config.outlinedBorder,
            floatingLabelStyle: TextStyle(color: Config.primaryColor),
            prefixIconColor: Colors.black38,
          ),
          scaffoldBackgroundColor: Colors.white,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Config.primaryColor,
            selectedItemColor: Colors.white,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            unselectedItemColor: Colors.green.shade700,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const AuthPage(),
          'main': (context) => const MainLayout(),
          'doc_details': (context) => const DoctorDetails(),
          'booking_page': (context) => const BookingPage(),
          'success_booking': (context) => const AppointmentBooked(),
        },
      ),
    );
  }
}
