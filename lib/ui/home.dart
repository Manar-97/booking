import 'package:booking/ui/screens/auth/login/login_screen.dart';
import 'package:booking/ui/screens/auth/user_cubit.dart';
import 'package:booking/ui/screens/cart/cart.dart';
import 'package:booking/ui/screens/category/category.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [
    const CategoriesScreen(),
    const CartScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UserCubit>();
    return SafeArea(
        child: Scaffold(
      appBar: buildAppBar(context, userCubit),
      body: BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              // Show error message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            } else if (!state.isLoading) {
              // Navigate to login screen on successful logout
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            }
          },
          child: tabs[currentIndex]),
      bottomNavigationBar: buildCircleNavBar(context),
    ));
  }

  AppBar buildAppBar(BuildContext context, UserCubit userCubit) {
    return AppBar(
      toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      actions: [
        IconButton(
            onPressed: () {
              userCubit.logout();
            },
            icon: const Icon(Icons.logout))
      ],
      title: const Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              size: 40,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text("Hello Manar"),
        ],
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF008c62), Color(0xFF24C690)],
          ),
        ),
      ),
    );
  }

  CircleNavBar buildCircleNavBar(BuildContext context) {
    return CircleNavBar(
      activeIcons: const [
        Icon(Icons.list, color: Colors.black),
        Icon(Icons.shopping_cart, color: Colors.black),
      ],
      inactiveIcons: const [
        Text("Category"),
        Text("Cart"),
      ],
      color: const Color(0xFF24C690),
      circleColor: Colors.white,
      height: MediaQuery.of(context).size.height * 0.085,
      circleWidth: 50,
      // tabCurve: ,
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      cornerRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
      ),
      shadowColor: Colors.black,
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF24C690), Color(0xFF008c62)],
      ),
      circleGradient: const LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        // colors: [Colors.grey.shade500, Colors.white24],
        colors: [Colors.transparent, Colors.transparent],
      ),
      // circleShadowColor: Color(0xFF24C690),
      elevation: 2,
      activeIndex: currentIndex,
      onTap: (tappedIndex) {
        setState(() {
          currentIndex = tappedIndex;
        });
      },
    );
  }

  // BottomNavigationBar buildBottomNavigationBar() {
  //   return BottomNavigationBar(
  //     selectedItemColor: const Color(0xFF24C690),
  //     currentIndex: currentIndex,
  //     onTap: (tappedIndex) {
  //       setState(() {
  //         currentIndex = tappedIndex;
  //       });
  //     },
  //     items: const [
  //       BottomNavigationBarItem(icon: Icon(Icons.list), label: "Category"),
  //       BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
  //     ],
  //   );
  // }
  ///================================
  // AppBar buildAppBar(BuildContext context) {
  //   final userCubit = context.read<UserCubit>();
  //   return AppBar(
  //     toolbarHeight: MediaQuery.of(context).size.height * 0.1,
  //     actions: [
  //       IconButton(
  //           onPressed: () {
  //             userCubit.logout();
  //           },
  //           icon: const Icon(Icons.logout))
  //     ],
  //     title: const Row(
  //       children: [
  //         CircleAvatar(
  //           backgroundColor: Colors.white,
  //           child: Icon(
  //             Icons.person,
  //             size: 40,
  //             color: Colors.black,
  //           ),
  //         ),
  //         SizedBox(
  //           width: 10,
  //         ),
  //         Text("Hello Manar"),
  //       ],
  //     ),
  //     flexibleSpace: Container(
  //       decoration: const BoxDecoration(
  //         borderRadius: BorderRadius.only(
  //             bottomLeft: Radius.circular(50),
  //             bottomRight: Radius.circular(50)),
  //         gradient: LinearGradient(
  //           begin: Alignment.topLeft,
  //           end: Alignment.bottomRight,
  //           colors: [Color(0xFF008c62), Color(0xFF24C690)],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
