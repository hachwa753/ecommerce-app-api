import 'package:flutter/material.dart';

class MyListContainer extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  const MyListContainer({super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepOrangeAccent,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
