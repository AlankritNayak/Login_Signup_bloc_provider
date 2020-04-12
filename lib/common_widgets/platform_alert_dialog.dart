import 'package:flutter/material.dart';
import 'package:time_tracker/common_widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';


class PlatformAlertDialog extends PlatformWidget {
  PlatformAlertDialog(
      {this.cancelActionText,
      @required this.content,
      @required this.defaultActionText,
      @required this.title})
      : assert(title != null),
        assert(defaultActionText != null),
        assert(content != null);

  final String cancelActionText;
  final String defaultActionText;
  final String content;
  final String title;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context){
    final actions = <Widget>[];
    if (cancelActionText != null) {
      actions.add(
        PlatformAlertDialogAction(
          child: Text(cancelActionText),
          onPressedCallback: () => Navigator.of(context).pop(false),
        ),
      );
    }
    actions.add(
      PlatformAlertDialogAction(
        child: Text(defaultActionText),
        onPressedCallback: () => Navigator.of(context).pop(true),
      ),
    );
    return actions;
  }

  Future<bool> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog<bool>(
            context: context,
            builder: this.build
          )
        : await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: this.build,
          );
  }
}

class PlatformAlertDialogAction extends PlatformWidget{
  PlatformAlertDialogAction({this.child, this.onPressedCallback});
  final Widget child;
  final VoidCallback onPressedCallback;

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return FlatButton(
      child: this.child,
      onPressed: onPressedCallback,
    );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoDialogAction(
      child: this.child,
      onPressed: onPressedCallback,
    );
  }
}
