import 'package:flutter/material.dart';

class DataContainerWidget extends StatelessWidget {
  final MainAxisAlignment rowMainAccess;
  final int index;
  final String headerTitle;
  final double? width;
  final Color? color;
  final double? height;
  final Icon? icon;
  

  const DataContainerWidget({
    required this.index,
    this.icon,
    this.color,
    this.width,
    this.height,
    required this.headerTitle,
    super.key,
    required this.rowMainAccess,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: width,
      decoration: BoxDecoration(
        color: color == null
            ? null
            : index % 2 == 0
                ? const Color.fromARGB(255, 246, 246, 246)
                : Colors.blue[50],
      ),
      child: SingleChildScrollView(scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: rowMainAccess,
          children: [
            Text(
              headerTitle,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.5,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }
}
