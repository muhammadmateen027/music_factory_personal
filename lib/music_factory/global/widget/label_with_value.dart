import 'package:flutter/material.dart';

class LabelWithValueView extends StatelessWidget {
  const LabelWithValueView({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return RichText(
      text: TextSpan(
        text: '$label: ',
        style: textTheme.bodyText1,
        children: <TextSpan>[
          TextSpan(
            text: value,
            style: textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
