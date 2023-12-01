import 'package:flutter/material.dart';

import '../constraints.dart';

class SharedAppBar extends StatelessWidget {
  const SharedAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: const Text(
        'Resturant App',
      ),
      centerTitle: true,
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart))
      ],
    );
  }
}
