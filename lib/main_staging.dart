import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:music_factory/app/app.dart';

import 'config/config.dart';

void main() async{
  await Initialization.init();

  runZonedGuarded(
    () => runApp(const App()),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
