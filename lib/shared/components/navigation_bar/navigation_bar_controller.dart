import 'package:flutter/material.dart';

enum ScreenOptionsEnum { home, reviews, create, profile }

class NavigationBarController extends ValueNotifier<int> {
  NavigationBarController() : super(ScreenOptionsEnum.home.index);

  void navigateTo(ScreenOptionsEnum destination) {
    value = destination.index;
  }
}
