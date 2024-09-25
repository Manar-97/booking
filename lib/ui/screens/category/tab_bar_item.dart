import 'package:flutter/material.dart';

class CategoriesItem extends StatelessWidget {
   CategoriesItem({super.key, required this.name});

   final String name;
   bool isSelected = false;

  // late final String name;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){print('======================Home');},
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: const Color(0xFF39A552), width: 2),
            color: isSelected ? const Color(0xFF39A552) : Colors.white),
        child: Text(
          name,
          style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF39A552),),textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class Category {
  String name;
  Category({required this.name});
}
