import 'package:flutter/material.dart';

abstract class BasePage extends StatefulWidget {
  BasePage({Key? key}) : super(key: key);
}

abstract class BaseState<Page extends BasePage> extends State<Page> {
  String screenName();
  bool addAppBar();
  List<Widget>? appBarActions();
}

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
              title: Text(screenName()),
              actions: appBarActions(),
              backgroundColor: Theme.of(context).colorScheme.background,
            ) : null,
            bottomNavigationBar: BottomAppBar(
              color: Colors.transparent,
              elevation: 0.0,
              child: Text(
                'ABCDEFGH',
                style: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: 10.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            body: body(context),
          ),
        ),
      ),
    );
  }

  Widget body(BuildContext context);
}
