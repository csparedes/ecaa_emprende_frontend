import 'package:ecaa_emprende_app/api/backend_api.dart';
import 'package:ecaa_emprende_app/provider/theme_provider.dart';
import 'package:ecaa_emprende_app/routes/routes.dart';
import 'package:ecaa_emprende_app/shared/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MySharedPreferences.init();
  await dotenv.load(fileName: ".env");
  MyFluroRouter.configureRoutes();
  BackendConnection.dioConfiguration();
  runApp(const ProvidersApp());
}

class ProvidersApp extends StatelessWidget {
  const ProvidersApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(
            isDarkMode: MySharedPreferences.isDarkMode,
          ),
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: '/welcome',
      onGenerateRoute: MyFluroRouter.router.generator,
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}
