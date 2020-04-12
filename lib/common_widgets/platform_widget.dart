import 'package:flutter/material.dart';
import 'dart:io';

abstract class PlatformWidget extends StatelessWidget {

  Widget buildCupertinoWidget(BuildContext context);
  Widget buildMaterialWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? buildCupertinoWidget(context) : buildMaterialWidget(context);
  }
}