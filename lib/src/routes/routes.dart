import 'package:flutter/material.dart';
import 'package:hhu_assist/src/controller/haversine.dart';
import 'package:hhu_assist/src/screens/screens.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/readings':
        return MaterialPageRoute(builder: (_) => const ReadingsScreen());

      case '/multi_edit':
        if (args is EditScreenArguments) {
          return MaterialPageRoute(
              builder: (_) => CustomEditForm(
                    args: args,
                  ));
        }
        return _errorRoute();
      case '/camera_screen':
        return MaterialPageRoute(builder: (_) => const CameraScreen());
      case '/qr':
        return MaterialPageRoute(builder: (_) => const QRScreen());
      case '/from_api':
        return MaterialPageRoute(builder: (_) => const APITest());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
