import 'package:flutter/material.dart';

extension TextThemeExtension on BuildContext {
  // * (default) TextTheme
  TextStyle? get displayLarge => Theme.of(this).textTheme.displayLarge;
  TextStyle? get displayMedium => Theme.of(this).textTheme.displayMedium;
  TextStyle? get displaySmall => Theme.of(this).textTheme.displaySmall;

  TextStyle? get titleLarge => Theme.of(this).textTheme.titleLarge;
  TextStyle? get titleMedium => Theme.of(this).textTheme.titleMedium;
  TextStyle? get titleSmall => Theme.of(this).textTheme.titleSmall;

  TextStyle? get headlineLarge => Theme.of(this).textTheme.headlineLarge;
  TextStyle? get headlineMedium => Theme.of(this).textTheme.headlineMedium;
  TextStyle? get headlineSmall => Theme.of(this).textTheme.headlineSmall;

  TextStyle? get bodyL => Theme.of(this).textTheme.bodyLarge;
  TextStyle? get bodyM => Theme.of(this).textTheme.bodyMedium;
  TextStyle? get bodyS => Theme.of(this).textTheme.bodySmall;

  TextStyle? get labelLarge => Theme.of(this).textTheme.labelLarge;
  TextStyle? get labelMedium => Theme.of(this).textTheme.labelMedium;
  TextStyle? get labelSmall => Theme.of(this).textTheme.labelSmall;

  // * PrimaryTextTheme
  // TextStyle? get pH1 => Theme.of(this).primaryTextTheme.displayLarge;
  // TextStyle? get pH2 => Theme.of(this).primaryTextTheme.displayMedium;
  // TextStyle? get pH3 => Theme.of(this).primaryTextTheme.displaySmall;
  // TextStyle? get pH4 => Theme.of(this).primaryTextTheme.headlineMedium;
  // TextStyle? get pH5 => Theme.of(this).primaryTextTheme.headlineSmall;
  // TextStyle? get pH6 => Theme.of(this).primaryTextTheme.titleLarge;
  //
  // TextStyle? get pSub1 => Theme.of(this).primaryTextTheme.titleMedium;
  // TextStyle? get pSub2 => Theme.of(this).primaryTextTheme.titleSmall;
  //
  // TextStyle? get pBody1 => Theme.of(this).primaryTextTheme.bodyLarge;
  // TextStyle? get pBody2 => Theme.of(this).primaryTextTheme.bodyMedium;

  // TextStyle? get pButton => Theme.of(this).primaryTextTheme.labelLarge;

  // // * AccentTextTheme
  // TextStyle? get aH1 => Theme.of(this).accentTextTheme.headline1;
  // TextStyle? get aH2 => Theme.of(this).accentTextTheme.headline2;
  // TextStyle? get aH3 => Theme.of(this).accentTextTheme.headline3;
  // TextStyle? get aH4 => Theme.of(this).accentTextTheme.headline4;
  // TextStyle? get aH5 => Theme.of(this).accentTextTheme.headline5;
  // TextStyle? get aH6 => Theme.of(this).accentTextTheme.headline6;
  //
  // TextStyle? get aSub1 => Theme.of(this).accentTextTheme.subtitle1;
  // TextStyle? get aSub2 => Theme.of(this).accentTextTheme.subtitle2;
  //
  // TextStyle? get aBody1 => Theme.of(this).accentTextTheme.bodyText1;
  // TextStyle? get aBody2 => Theme.of(this).accentTextTheme.bodyText2;
  //
  // TextStyle? get aButton => Theme.of(this).accentTextTheme.button;
  //
}
