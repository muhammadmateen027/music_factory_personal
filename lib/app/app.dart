import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:music_factory/config/config.dart';
import 'package:music_factory/l10n/l10n.dart';
import 'package:music_factory/music_factory/music_factory.dart';
import 'package:music_factory/routes/routes.dart';
import 'package:music_repository/repository.dart';
import 'package:storage/storage.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeGenerator = RouteGenerator(locator<MusicService>());
    return RepositoryProvider.value(
      value: [
        locator<MusicService>(),
        locator<StorageService>()
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<DashboardBloc>(
            create: (_) {
              return DashboardBloc(musicService: locator<MusicService>())
                ..add(LoadAlbums());
            },
          ),
          BlocProvider<AlbumsBloc>(
            create: (_) => AlbumsBloc(
              musicService: locator<MusicService>(),
              storageService: locator<StorageService>()
            ),
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
