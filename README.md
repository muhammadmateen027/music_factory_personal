# Music Factory

![coverage][flutter_version]
![coverage][dart_version]
![coverage][bloc_version]
![coverage][override_bloc_version]
![coverage][database] ![coverage][hive]
![coverage][sentry_io]
![coverage][dio]
![coverage][development] ![coverage][staging] ![coverage][production]
![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
---

# Getting Started 🚀

In this project we will discuss:

- ✅ [Problem](#problem)
- ✅ [Solution](#solution)
- ✅ [Flavours](#flavours-)
- ✅ [Dependencies](#dependencies)
- ✅ [Translation](#working-with-translations-)
- 🔲  [Tests](#tests-)

---

## Problem 💥

Develop a music management app with Flutter (iOS and Android) based on the LastFM API. With the help of the app the user
should be able to search for artists, pick one of their top albums and save it locally.

This application should have four (4) screens

- [x] Dashboard
- [x] Search (Search artists and show in the list)
- [x] Albums (Load albums that related to artist)
- [x] Album detail (It should show Album detail, either fetched from api or loaded from local). There should an option
  to delete or save album locally.

You can create your API key on the following website:
https://www.last.fm/api/authentication

---

## Solution 💪

The solution is designed so a user can access saved albums without internet. The detail is given below:

- `lib` will contains view(pages, widgets, components), BLoC, configuration, etc.
- `packages` will keep network, database, and repository layer

### State management

![coverage][state_management] ![coverage][bloc_version] ![coverage][override_bloc_version]

- We have used `BLoC's 7.0.0` version as State management library. But as `Bloc` team is working
  on [newer version](https://github.com/felangel/bloc/tree/feat/replace-mapEventToState-with-on%3CE%3E)
  that will help to remove boilerplate of writing `mapEventsToSate` and bloc will look like this:
  ```dart 
  class AlbumsBloc extends Bloc<AlbumsEvent, AlbumsState> {
      AlbumsBloc(): super(AlbumsInitial()) {
          // Load top album event
          on<LoadTopAlbums>(_loadTopAlbums);
      }
      
      // perform your action here
      void _loadTopAlbums(LoadTopAlbums event, Emit<AlbumsState> emit) async {
          // your business logic will be here to handle state and event
      }
  }
  ```

### Offline storage

![coverage][database] ![coverage][hive]

- We have used [Hive](https://docs.hivedb.dev/#/) as a local storage because it's light weight offline storage.
    * Hive requires a `key` and `value` to save a value.
        * We used `url` as a `key` because it seems unique rather then `mbid`.
        * Why can't use `mbid` as a key? There were number of cases where `mbid` was `null` or `empty` so we can't relay
          on
          `mbid` as a key. Apart from that, if we load detail on basis of the `mbid`, figured out that in detail `json`
          the
          `mbid` is different.
    * You will see a number of line in `config` folder regarding `registerAdapter()`. That's the method you need to
      register each adapter that is connected with nested models. I have already raised a question, how we can reduce
      this code rather than writing number of lines of code.

> 😐The question will be here, how did you save the `Image` in the database for offline usage❓
> Well the solution is there, and I have 2 choices to save images:
>- ❗ Load image from the `url` and convert into `Unit8List` (in different isolates) and save as a `BLOB`. `SQflite` also allows few data types
   > and to save images you can use only `Blob`. 👎
>
>
>- ✅ I preferred to save `images` as a string. It'll keep the same URL as we load from the detail api.
>
>
>- Used [cached_network_image: ^3.1.0](https://pub.dev/packages/cached_network_image) to load images. It is the wrapper of [flutter_cache_manager](https://pub.dev/packages/flutter_cache_manager) library. Each file have a
   `stalePeriod` and we can increase as per our requirement. We can update the maxAge by overriding `BaseCacheManager`
   but it already has `maxAge = const Duration(days: 30),`.

> If user don't have internet, the app will load image from local cache and if there's internet,
> url will be refreshed.

---

### Log controller

![coverage][sentry_io]

- We have used [Sentry.io](https://sentry.io/welcome/) to log all errors and issues in a server.

---

### Flavours 🚀

This project contains 3 flavors:

![coverage][development] ![coverage][staging] ![coverage][production]

Before run application you need to create `.env` file in app directory and add these varaibles:

```dotenv
#Logs Controller --  create your key (https://sentry.io/welcome/) and add
SENTRY_IO=

#Las FM credentials -- create your key (http://ws.audioscrobbler.com) and add
API_KEY=
API_URL=http://ws.audioscrobbler.com/2.0/
```

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*Music Factory works on iOS, Android, and Web._

---

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows
the [official internationalization guide for Flutter][internationalization_link].

> In this project we ignored this part but how to use is described below.

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

2. Then add a new key/value and description

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    },
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Hello World Text"
    }
}
```

3. Use the new string

```dart
import 'package:music_factory/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

<key>CFBundleLocalizations</key>
<array>
<string>en</string>
<string>es</string>
</array>

        ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_es.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

`app_es.arb`

```arb
{
    "@@locale": "es",
    "counterAppBarTitle": "Contador",
    "@counterAppBarTitle": {
        "description": "Texto mostrado en la AppBar de la página del contador"
    }
}
```

[flutter_version]: https://img.shields.io/badge/flutter-2.2.3-1389FD.svg

[dart_version]: https://img.shields.io/badge/Dart-2.13.4-1389FD.svg

[state_management]: https://img.shields.io/badge/State_Management-42b983.svg

[bloc_version]: https://img.shields.io/badge/BLoC-7.0.0-42b983.svg

[override_bloc_version]: https://img.shields.io/badge/Override_BLoC-upcoming_version-42b983.svg

[sentry_io]: https://img.shields.io/badge/Sentry-5.1.0-362d59.svg

[database]: https://img.shields.io/badge/database-66ffff.svg

[hive]: https://img.shields.io/badge/hive-2.0.4-66ffff.svg

[dio]: https://img.shields.io/badge/dio-4.0.0-4334eb.svg

[production]: https://img.shields.io/badge/Production-0bbf5c.svg

[development]: https://img.shields.io/badge/Development-b6d91c.svg

[staging]: https://img.shields.io/badge/Staging-edd013.svg

[coverage_badge]: coverage_badge.svg

[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html

[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization

[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg

[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis

---

## Tests 🧪

This section is under development and will be continue after a break.
