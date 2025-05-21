import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(MaterialApp(
  title: 'Meeting Room App',
  theme: ThemeData(primarySwatch: Colors.blue),
  home: HomeScreen(),
));