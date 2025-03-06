import 'package:flutter/material.dart';
import 'package:growmind_admin/core/utils/constants.dart';
import 'package:growmind_admin/features/category/presentation/pages/category_page.dart';
import 'package:growmind_admin/features/profile/presentation/pages/admin_profile_page.dart';
import 'package:growmind_admin/features/tutors/presentation/pages/tutors_page.dart';
import 'package:growmind_admin/features/home/presentation/pages/home.dart';

final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

class TabBarPagesAdmin extends StatefulWidget {
  const TabBarPagesAdmin({super.key});

  @override
  State<TabBarPagesAdmin> createState() => _TabBarPagesAdminState();
}

class _TabBarPagesAdminState extends State<TabBarPagesAdmin> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const Home(),
    const TutorsPage(),
    const CategoryPage(),
    const AdminProfilePage(),
  ];

  void setPage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      appBar: isWideScreen
          ? null
          : AppBar(
              title: const Text('GrowMind',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 66),),
              leading: IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.menu),
              ),
            ),
      drawer: !isWideScreen ? buildDrawer() : null,
      body: isWideScreen
          ? Row(
              children: [
                Container(
                  width: 300,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(234, 31, 98, 1),
                        Color.fromRGBO(28, 36, 52, 1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: PresistentState(
                    currentIndex: currentIndex,
                    onMenuSelected: setPage,
                  ),
                ),
                Expanded(
                  child: IndexedStack(
                    index: currentIndex,
                    children: screens,
                  ),
                ),
              ],
            )
          : screens[currentIndex],
    );
  }
}

Widget buildDrawer() {
  return Drawer(
    child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(35, 74, 203, 1),
            Color.fromRGBO(28, 36, 52, 1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          const DrawerHeader(
            child: Center(
              child: Text(
                'GrowMind',
                style: TextStyle(fontSize: 24, color: Colors.orangeAccent),
              ),
            ),
          ),
          buildListTile(0, 'Home', const Icon(Icons.home)),
          buildListTile(1, 'Tutors', const Icon(Icons.school)),
          buildListTile(2, 'Categories', const Icon(Icons.category)),
          buildListTile(3, 'Profile', const Icon(Icons.person)),
        ],
      ),
    ),
  );
}

class PresistentState extends StatefulWidget {
  final Function(int) onMenuSelected;
  final int currentIndex;

  const PresistentState({
    super.key,
    required this.currentIndex,
    required this.onMenuSelected,
  });

  @override
  State<PresistentState> createState() => _PresistentStateState();
}

class _PresistentStateState extends State<PresistentState> {
  int? hoverIndex;

  final Color hoverColor = const Color.fromRGBO(35, 74, 207, 1);
  final Color selectedColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 80,
            child: const Center(
              child: Text(
                'GrowMind',
                style: TextStyle(fontSize: 24, color: Colors.orangeAccent),
              ),
            ),
          ),
          AppHeight().kheight,
          buildListTile(0, 'Home', const Icon(Icons.home)),
          buildListTile(1, 'Tutors', const Icon(Icons.school)),
          buildListTile(2, 'Categories', const Icon(Icons.category)),
          buildListTile(3, 'Profile', const Icon(Icons.person)),
        ],
      ),
    );
  }

 Widget buildListTile(int index, String title, Icon icon) {
  final isSelected = widget.currentIndex == index;

  return GestureDetector(
    onTap: () {
      widget.onMenuSelected(index);
    },
   
    child: Container(
      color: isSelected
          ? selectedColor
          : (hoverIndex == index ? hoverColor : Colors.transparent),
      child: ListTile(
        leading: icon,
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}


}

Widget buildListTile(int index, String title, Icon icon) {
  return ListTile(
    leading: icon,
    title: Text(
      title,
      style: const TextStyle(color: Colors.white),
    ),
  );
}
