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

    // get a variable instance of the AlbumsBloc and pass to the providers
    final bloc = AlbumsBloc(
      musicService: locator<MusicService>(),
      storageService: locator<StorageService>(),
    );
    return RepositoryProvider.value(
      value: [locator<MusicService>(), locator<StorageService>()],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => DashboardBloc(
              albumsBloc: bloc,
              service: locator<StorageService>(),
            )..add(LoadAlbums()),
          ),
          // Provide bloc so it can be accessed anywhere in the application
          BlocProvider<AlbumsBloc>(create: (_) => bloc),
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
          debugShowCheckedModeBanner: false,
          // Added builder for toast and loading indicator
          builder: EasyLoading.init(builder: BotToastInit()),
          supportedLocales: AppLocalizations.supportedLocales,
          // Set initial route name
          initialRoute: RoutesName.initial,
          //register navigator key to access in the app
          navigatorKey: navigationService.navigationKey,
          onGenerateRoute: routeGenerator.generateRoute,
        ),
      ),
    );
  }
}
