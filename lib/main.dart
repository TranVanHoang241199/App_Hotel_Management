import 'package:flutter/material.dart';
import 'package:flutter_app_hotel_management/bloc/auth_bloc/auth.dart';
import 'package:flutter_app_hotel_management/data/repositorys/auth_repository.dart';
import 'package:flutter_app_hotel_management/presentation/views/System/system_screen.dart';
import 'package:flutter_app_hotel_management/presentation/views/auth/register_screen.dart';
import 'package:flutter_app_hotel_management/presentation/views/order/order_screen.dart';
import 'package:flutter_app_hotel_management/presentation/views/profile/profile_screen.dart';
import 'package:flutter_app_hotel_management/presentation/views/retrieval/retrieval_screen.dart';
import 'package:flutter_app_hotel_management/presentation/views/setting/setting_screen.dart';
import 'package:flutter_app_hotel_management/presentation/views/statistical/statistical_screen.dart';
import 'package:flutter_app_hotel_management/utils/config.dart';
import 'package:flutter_app_hotel_management/presentation/views/home/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/views/Error/error_screen.dart';
import 'presentation/views/auth/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AuthBloc(AuthInitState(), AuthRepository()))
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: "Hotel app",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
            focusColor: Config.primaryColor,
            border: Config.outlineBorder,
            focusedBorder: Config.focusBorder,
            errorBorder: Config.errorBorder,
            enabledBorder: Config.outlineBorder,
            floatingLabelStyle: TextStyle(color: Config.primaryColor),
            prefixIconColor: Colors.black38,
          ),
          scaffoldBackgroundColor: Colors.white,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Config.primaryColor,
            selectedItemColor: Colors.white,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            unselectedItemColor: Colors.grey,
            elevation: 10,
            type: BottomNavigationBarType.fixed,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginScreen(),
          '/home': (context) => HomeScreen(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/order': (context) => const OrderScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/retrieval': (context) => const RetrievalScreen(),
          '/room': (context) => HomeScreen(),
          '/setting': (context) => const SettingScreen(),
          '/statistical': (context) => const StatisticalScreen(),
          '/system': (context) => const SystemScreen(),
          '/error': (context) => const ErrorScreeen(),
        },
        //home: LoginPage(),
      ),
    );
  }
}
