import 'dart:async';

import 'package:flutter/material.dart';

class NeoDigitalScreen extends StatelessWidget {
  const NeoDigitalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(217, 230, 243, 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
                height: constraints.maxHeight * 0.9,
                width: constraints.maxWidth * 0.95,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: const Color.fromRGBO(160, 168, 168, 1),
                        width: 2),
                    gradient: const LinearGradient(colors: [
                      Color.fromRGBO(203, 211, 196, 1),
                      Color.fromRGBO(176, 188, 165, 1)
                    ])),
                child: Center(
                  child: DigitalClock(
                    maxHeight: constraints.maxHeight,
                    maxWidth: constraints.maxWidth,
                  ),
                ));
          },
        ),
      ),
    );
  }
}

class DigitalClock extends StatefulWidget {
  final double maxHeight;
  final double maxWidth;

  const DigitalClock({
    super.key,
    required this.maxHeight,
    required this.maxWidth,
  });

  @override
  State<DigitalClock> createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  late Timer timer;
  Duration duration = Duration.zero;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        duration = Duration(seconds: DateTime.now().second);
      });
    });
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hours = createNumberTime(duration.inHours);
    final minutes = createNumberTime(duration.inMinutes);
    final seconds = createNumberTime(duration.inSeconds);

    return Container(
        height: widget.maxHeight * 0.5,
        width: widget.maxWidth * 0.7,
        decoration: const BoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...hours,
            DigitalColon(
              height: widget.maxHeight * 0.3,
              color: Colors.black87,
            ),
            ...minutes,
            DigitalColon(
              height: widget.maxHeight * 0.3,
              color: Colors.black87,
            ),
            ...seconds
          ],
        ));
  }

  List<ClockNumberWithBG> createNumberTime(int numberTime) {
    final int parsedNumber = numberTime % 60;
    final bool isTwoDigit = parsedNumber.toString().length == 2;
    final int firstDigit =
        isTwoDigit ? int.parse(parsedNumber.toString()[0]) : 0;
    final int secondDigit =
        isTwoDigit ? int.parse(parsedNumber.toString()[1]) : numberTime % 60;

    return [
      ClockNumberWithBG(
        height: widget.maxHeight,
        value: firstDigit,
      ),
      ClockNumberWithBG(
        height: widget.maxHeight,
        value: secondDigit,
      )
    ];
  }
}

class ClockNumberWithBG extends StatelessWidget {
  final double height;

  final int value;

  const ClockNumberWithBG(
      {super.key, required this.height, required this.value});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        DigitalNumber(
          value: value,
          height: height * 0.4,
          color: Colors.black,
        ),
        DigitalNumber(
          value: 8,
          height: height * 0.4,
          color: Colors.black12,
        ),
      ],
    );
  }
}

class DigitalNumber extends StatelessWidget {
  final int value;
  final int padLeft;
  final double height;
  final Color color;

  const DigitalNumber({
    super.key,
    required this.value,
    required this.height,
    required this.color,
    this.padLeft = 0,
  });

  @override
  Widget build(BuildContext context) {
    Widget digitPainter(int digit) {
      return CustomPaint(
        size: Size(height / 2.0, height),
        painter: _DigitalDigitPainter(digit, height, color),
      );
    }

    final Widget digitPadding = SizedBox(width: height / 10.0);

    List<Widget> children = [];

    int digits = 0;
    int remaining = value;
    // do-while required for when [value] is 0
    do {
      int digit = remaining.remainder(10);
      // If this is not our first entry, add padding
      if (remaining != value) {
        children.add(digitPadding);
      }
      children.add(digitPainter(digit));
      remaining ~/= 10;
      digits++;
    } while (remaining > 0);

    // If need to pad this number with zeros
    while (digits < padLeft) {
      children.add(digitPadding);
      children.add(digitPainter(0));
      digits++;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.from(children.reversed),
    );
  }
}

class _DigitalDigitPainter extends CustomPainter {
  final int value;
  final double height;
  final Color color;

  _DigitalDigitPainter(this.value, this.height, this.color)
      : assert(value >= 0),
        assert(value < 10);

  @override
  bool shouldRepaint(_DigitalDigitPainter oldDelegate) {
    return value != oldDelegate.value ||
        height != oldDelegate.height ||
        color != oldDelegate.color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final double width = height / 2; // Digits are half as wide as they are tall
    final double thickness = width / 5; // Arbitrary thickness that looks good

    final double bigGap = thickness * 2 / 3; // Inside angle for outer pixels
    final double midGap = thickness / 2; // Angle for middle bar
    final double smallGap = thickness / 3; // Outside angle for outer pixels

    final double smallPad = thickness / 10; // Spacing for middle bar
    final double bigPad = smallGap + smallPad; // Spacing for outer pixels

    // Alias/pre-calculate convenient locations
    final double top = size.height - height;
    final double left = size.width - width;
    final double right = size.width;
    final double bottom = size.height;
    final double middle = size.height - width;

    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    /// Build a polygon for the left side of the digit
    List<Offset> leftPolygon(top, bottom) {
      return [
        Offset(left + smallGap, top),
        Offset(left, top + smallGap),
        Offset(left, bottom - smallGap),
        Offset(left + smallGap, bottom),
        Offset(left + thickness, bottom - bigGap),
        Offset(left + thickness, top + bigGap),
      ];
    }

    /// Build a polygon for the right side of the digit
    List<Offset> rightPolygon(top, bottom) {
      return [
        Offset(right - smallGap, top),
        Offset(right - thickness, top + bigGap),
        Offset(right - thickness, bottom - bigGap),
        Offset(right - smallGap, bottom),
        Offset(right, bottom - smallGap),
        Offset(right, top + smallGap),
        Offset(right - smallGap, top),
      ];
    }

    Path p = Path();
    // Top
    if (value != 1 && value != 4) {
      final tleft = left + bigPad;
      final tright = right - bigPad;
      p.addPolygon([
        Offset(tleft, top + smallGap),
        Offset(tleft + smallGap, top),
        Offset(tright - smallGap, top),
        Offset(tright, top + smallGap),
        Offset(tright - bigGap, top + thickness),
        Offset(tleft + bigGap, top + thickness),
      ], true);
    }
    // Left Top
    if (value == 0 || (value > 3 && value != 7)) {
      p.addPolygon(leftPolygon(top + bigPad, middle - smallPad), true);
    }
    // Right Top
    if (value != 5 && value != 6) {
      p.addPolygon(rightPolygon(top + bigPad, middle - smallPad), true);
    }
    // Middle
    if (value > 1 && value != 7) {
      final mleft = left + bigPad;
      final mright = right - bigPad;
      final halfThick = thickness / 2;
      p.addPolygon([
        Offset(mleft, middle),
        Offset(mleft + midGap, middle - halfThick),
        Offset(mright - midGap, middle - halfThick),
        Offset(mright, middle),
        Offset(mright - midGap, middle + halfThick),
        Offset(mleft + midGap, middle + halfThick),
        Offset(mleft, middle),
      ], false);
    }
    // Left Bottom
    if (value == 0 || value == 2 || value == 6 || value == 8) {
      p.addPolygon(leftPolygon(middle + smallPad, bottom - bigPad), true);
    }
    // Right bottom
    if (value != 2) {
      p.addPolygon(rightPolygon(middle + smallPad, bottom - bigPad), true);
    }
    // Bottom
    if (value != 1 && value != 4 && value != 7) {
      final bleft = left + bigPad;
      final bright = right - bigPad;
      p.addPolygon([
        Offset(bleft, bottom - smallGap),
        Offset(bleft + bigGap, bottom - thickness),
        Offset(bright - bigGap, bottom - thickness),
        Offset(bright, bottom - smallGap),
        Offset(bright - smallGap, bottom),
        Offset(bleft + smallGap, bottom),
        Offset(bleft, bottom - smallGap),
      ], false);
    }

    canvas.drawPath(p, paint);
  }
}

class DigitalColon extends StatelessWidget {
  final double height;
  final Color color;

  const DigitalColon({super.key, required this.height, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(height / 2.0, height),
      painter: _DigitalColonPainter(height, color),
    );
  }
}

class _DigitalColonPainter extends CustomPainter {
  final double height;
  final Color color;

  _DigitalColonPainter(this.height, this.color);

  @override
  bool shouldRepaint(_DigitalColonPainter oldDelegate) {
    return height != oldDelegate.height || color != oldDelegate.color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final double width = height / 2;
    final double thickness = width / 5;

    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Top dot
    canvas.drawRect(
        Rect.fromLTWH(
          width / 2 - thickness / 2,
          height / 3 - thickness / 2,
          thickness,
          thickness,
        ),
        paint);
    // Bottom dot
    canvas.drawRect(
        Rect.fromLTWH(
          width / 2 - thickness / 2,
          height * 2 / 3 - thickness / 2,
          thickness,
          thickness,
        ),
        paint);
  }
}
