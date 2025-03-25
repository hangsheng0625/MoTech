import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  final int index;

  const Navbar({Key? key, this.index = 0}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Navbar();
}

class _Navbar extends State<Navbar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(103, 158, 158, 158).withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
          switch (newIndex) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/order');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/crop');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/support');
              break;
            case 4:
              Navigator.pushReplacementNamed(context, '/profile');
              break;
          }
        },
        selectedItemColor: const Color.fromARGB(255, 23, 116, 41),
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        items: [
          BottomNavigationBarItem(
            icon: _currentIndex == 0
                ? const Icon(Icons.home)
                : const Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 1
                ? const Icon(Icons.shopping_bag)
                : const Icon(Icons.shopping_bag_outlined),
            label: "Sales",
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 2
                ? const Icon(Icons.eco)
                : const Icon(Icons.eco_outlined),
            label: "Farm",
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 3
                ? const Icon(Icons.build_circle)
                : const Icon(Icons.build_circle_outlined),
            label: "Support Hub",
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 4
                ? const Icon(Icons.account_circle)
                : const Icon(Icons.account_circle_outlined),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
