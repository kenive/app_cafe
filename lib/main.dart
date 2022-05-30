import 'package:app_cafe/auth_loading/auth_loading.dart';

import 'package:app_cafe/screen/categories/categories.dart';
import 'package:app_cafe/screen/categories_detail/categories_detail.dart';
import 'package:app_cafe/services/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'screen/categories_detail/categories__detail_study/study_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    LocalStorage.init();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthLogic(context: context)),
        ChangeNotifierProvider(
            create: (_) => CategoriesLogic(context: context)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App_Cafe',
        initialRoute: '/',
        routes: {
          '/': (context) => const AuthLoading(),
          'catagories': (context) => const Categories(),
          'catagories_detail': (context) => const CategoriesDetail(),
          'study_detail': (context) => const StudyDetail(),
        },
      ),
    );
  }
}
