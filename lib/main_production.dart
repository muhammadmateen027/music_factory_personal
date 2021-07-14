// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:music_factory/app/app.dart';
import 'package:music_factory/app/app_bloc_observer.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {

  Bloc.observer = AppBlocObserver();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await Sentry.init((options) => options.dsn = dotenv.env['SENTRY_IO']);

  runZonedGuarded(
    () => runApp(const App()),
    (error, stackTrace) async {
      await Sentry.captureException(error, stackTrace: stackTrace);
    },
  );
}
