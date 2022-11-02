import 'package:flutter/material.dart';

class TwoToneText extends StatelessWidget {
  const TwoToneText({
    required Key key,
    required this.firstText,
    required this.secondText,
    required this.fontSize,
    required this.thirdText,
  }) : super(key: key);

  final String firstText;
  final String secondText;
  final String thirdText;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: firstText,
        style: Theme.of(context).textTheme.headline6!.copyWith(
              fontSize: fontSize,
              height: 1,
              color: Theme.of(context).textTheme.headline6!.color,
            ),
        children: [
          TextSpan(
            text: secondText,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF5e17Eb),
                  height: 1,
                ),
          ),
          TextSpan(
            text: thirdText,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.headline6!.color,
                  height: 1,
                ),
          )
        ],
      ),
    );
  }
}
