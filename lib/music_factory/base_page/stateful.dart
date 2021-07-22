import 'package:flutter/material.dart';

abstract class StatefulBase extends StatefulWidget {
  const StatefulBase({Key? key}) : super(key: key);
}

abstract class StatefulBaseState<Page extends StatefulBase> extends State<Page>{
  String screenName();
  bool addAppBar();
  List<Widget>? appBarActions();
}

mixin BasicPage<Page extends StatefulBase> on StatefulBaseState<Page> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.primary,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: addAppBar()? AppBar(
              title: Text(screenName()),
              actions: appBarActions(),
              backgroundColor: Theme.of(context).colorScheme.background,
            ) : null,
            body: body(context),
          ),
        ),
      ),
    );
  }

  Widget body(BuildContext context);
}
