import 'package:expense/app/constants/color.dart';
import 'package:flutter/material.dart';

extension TextX on Text {
  Text primaryText18() => Text(
        data.toString(),
        style: TextStyle(
            fontSize: 18.0, color: textColor, fontWeight: FontWeight.w600),
      );

  Text primaryText16({Color? color, TextAlign? align}) => Text(
        data.toString(),
        textAlign: align,
        style: TextStyle(
            fontSize: 16.0,
            color: color ?? textColor,
            fontWeight: FontWeight.w500),
      );

  Text secondaryText14(
          {Color? color, TextOverflow? overflow, TextAlign? align}) =>
      Text(
        data.toString(),
        overflow: overflow,
        textAlign: align,
        style: TextStyle(
            fontSize: 14.0,
            color: color ?? textSoftColor,
            fontWeight: FontWeight.w500),
      );
}
