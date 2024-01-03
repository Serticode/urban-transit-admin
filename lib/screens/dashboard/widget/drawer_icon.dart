import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrawerIcon extends ConsumerWidget {
  final String imageURL;
  const DrawerIcon({
    super.key,
    required this.imageURL,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageURL),
        ),
      ),
    );
  }
}
