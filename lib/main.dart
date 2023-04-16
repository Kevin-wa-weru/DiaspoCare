import 'dart:developer';

import 'package:diasporacare/bootstrap.dart';
import 'package:diasporacare/diaspocare/diaspocare.dart';
import 'package:diasporacare/utils/_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  Bloc.observer = AppBlocObserver();
  runApp(MultiBlocProvider(
    providers: Singletons.registerCubits(),
    child: const Diaspocare(),
  ));
}
