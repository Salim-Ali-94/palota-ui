import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spotify_africa_assessment/providers/screen_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';


Future<void> main() async {
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();
  var box = await Hive.openBox("collection");
  runApp(ChangeNotifierProvider<ScreenProvider>(create: (_) => ScreenProvider(),
                                                child: const PalotaAssessmentApp(), ), );
}

class PalotaAssessmentApp extends StatelessWidget {
  const PalotaAssessmentApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Palota Spotify Africa Assessment',
      theme: ThemeData.dark(useMaterial3: true),
      initialRoute: AppRoutes.startUp,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
