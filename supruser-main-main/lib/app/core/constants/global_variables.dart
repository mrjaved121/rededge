import 'package:flutter/material.dart';

TextTheme textTheme(BuildContext context) => Theme.of(context).textTheme;
ColorScheme colorScheme(BuildContext context) => Theme.of(context).colorScheme;

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
