// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:music_factory/config/config.dart';
import 'package:music_factory/l10n/l10n.dart';
import 'package:music_factory/music_factory/music_factory.dart';
import 'package:music_factory/repository/repository.dart';
import 'package:music_factory/routes/routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeGenerator = RouteGenerator(locator<MusicService>());
    return RepositoryProvider.value(
      value: locator<MusicService>(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<DashboardBloc>(
            create: (_) => DashboardBloc(musicService: locator<MusicService>()),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            accentColor: const Color(0xFF13B9FF),
            appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          builder: EasyLoading.init(builder: BotToastInit()),
          supportedLocales: AppLocalizations.supportedLocales,
          initialRoute: RoutesName.initial,
          navigatorKey: navigationService.navigationKey,
          onGenerateRoute: routeGenerator.generateRoute,
        ),
      ),
    );
  }
}
