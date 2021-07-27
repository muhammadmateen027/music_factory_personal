import 'package:flutter/material.dart';

// Write a mixin for a stateful widget to access in the app and can be used
// rather than writing again and again.
abstract class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);
}

abstract class BaseState<Page extends BasePage> extends State<Page> {
  // pass the screenName to show in appbar
  String screenName();

  // set appbar either true or false
  bool addAppBar();

  // If appbar is available, add App bar action icons
  List<Widget>? appBarActions();
}

// A mixin that will be shared in different page
mixin BasicPage<Page extends BasePage> on BaseState<Page> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.primary,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.onBackground,
            appBar: addAppBar()? AppBar(
              elevation: 0.0,
              title: Text(screenName()),
              actions: appBarActions(),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ) : null,
            body: body(context),
          ),
        ),
      ),
    );
  }

  // Add body of the screen
  Widget body(BuildContext context);
}
