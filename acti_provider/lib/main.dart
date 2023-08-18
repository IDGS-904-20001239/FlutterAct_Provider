import 'package:acti_provider/providers/provider.dart';
import 'package:acti_provider/routes/app_routes.dart';
import 'package:acti_provider/themes/app_theme.dart';
import 'package:acti_provider/util/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PokemonProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.lightThemeData,
        initialRoute: AppRoutes.initialRoute,
        routes: AppRoutes.routes,
        scaffoldMessengerKey: NotificationsService.messengerKey,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
