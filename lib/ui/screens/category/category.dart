import 'package:booking/ui/screens/category/item.dart';
import 'package:booking/ui/screens/category/tab_bar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Expanded(
        //   flex: 10,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     children: [
        //       CategoriesItem(
        //         name: "Hotels",
        //       ),
        //       CategoriesItem(
        //         name: "Houses",
        //       ),
        //       CategoriesItem(
        //         name: "Villas",
        //       ),
        //     ],
        //   ),
        // ),
        Expanded(
          child: GridView.builder(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => const Item(),
            itemCount: 3,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 3 / 1.7,
                mainAxisSpacing: 15),
          ),
        ),
      ],
    );
  }
}
