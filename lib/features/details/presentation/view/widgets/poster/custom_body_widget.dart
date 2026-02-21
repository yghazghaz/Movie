import 'package:flutter/material.dart';


class CustomBodyWidget extends StatelessWidget {
  const CustomBodyWidget({super.key, required this.child, required this.title});

  final Widget child;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 29, vertical: 12),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          Transform.translate(
            offset: Offset(0, -375 / 5.5),
            child: Align(
              alignment: .topCenter,
              heightFactor: 0,
              child: ClipRRect(
                borderRadius: .circular(16),
                child: child,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(child: title),
        ],
      ),
    );
  }
}
