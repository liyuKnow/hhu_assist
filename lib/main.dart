import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hhu_assist/src/data/helper/object_box.dart';
import 'package:hhu_assist/src/routes/routes.dart';

late ObjectBox objectbox;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  objectbox = await ObjectBox.create();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // useMaterial3: true,
      ),
      // initialRoute: '/',
      // initialRoute: '/from_api',
      initialRoute: '/readings',
      // initialRoute: '/qr',
      // initialRoute: '/multi_edit',
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
