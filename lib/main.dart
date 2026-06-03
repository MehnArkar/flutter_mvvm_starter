import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_starter/app/app.dart';
import 'package:flutter_mvvm_starter/core/di/service_locator.dart';
import 'package:flutter_mvvm_starter/core/local/local_data_source.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase — wrapped so the app runs without google-services.json during dev.
  try {
    await Firebase.initializeApp();
  } catch (_) {
    // TODO: add firebase_options.dart and GoogleService-Info.plist / google-services.json
    debugPrint('Firebase init skipped — missing config files.');
  }

  await ServiceLocator.injectDependencies();
  await LocalDataSource().init();

  runApp(const MyApp());
}

