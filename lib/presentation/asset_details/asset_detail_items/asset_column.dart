import 'package:flutter/material.dart';

class AssetColumn extends StatelessWidget {
  final Widget child1;
  final Widget child2;
  const AssetColumn({
    required this.child1,
    required this.child2,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 30,
          child: child1,
        ),
        const SizedBox(height: 3),
        Container(
          height: 20,
          child: Align(
            alignment: Alignment.centerLeft,
            child: child2,
          ),
        ),
      ],
    );
  }
}
