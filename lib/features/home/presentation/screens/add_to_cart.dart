import 'package:flutter/material.dart';

class AddToCart extends StatelessWidget {
  const AddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Add to cart'),
        centerTitle: true,
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('Add to Cart'),
          )
        ],
      ),
    );
  }
}
