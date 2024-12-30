import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:virtual_tours_bloc/app/view/view.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (AppEnvironment.current.isDev) {
      log('Bloc Change: $change');
      log('Current State: ${change.currentState}');
      log('Next State: ${change.nextState}');
    }
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    bloc.$debugPrint('($error, $stackTrace)', tag: 'onError');
    super.onError(bloc, error, stackTrace);
  }
}

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

Future<void> initializeApp(Callback<FutureOr<void>> config) async {
  WidgetsFlutterBinding.ensureInitialized();
  // await CacheStorage.initialize();
  // CachedBloc.initialize();

  // await Firebase.initializeApp();

  // await AssetImages.preloadLogoBackground();
  await config();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Bloc.observer = AppBlocObserver();

  // const AndroidInitializationSettings initializationSettingsAndroid =
  //     AndroidInitializationSettings('@mipmap/ic_launcher');
  // final InitializationSettings initializationSettings =
  //     InitializationSettings(android: initializationSettingsAndroid);

  // await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(const App());
}
