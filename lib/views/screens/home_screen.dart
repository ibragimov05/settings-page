import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:settings_page/utils/app_constants.dart';
import 'package:settings_page/views/screens/main_screen/main_screen.dart';
import 'package:settings_page/views/screens/profile_screen.dart';
import 'package:settings_page/views/screens/results_screen.dart';
import 'package:settings_page/views/screens/todo_screen/todo_screen.dart';
import 'package:settings_page/views/widgets/custom_drawer.dart';
import 'package:settings_page/views/widgets/custom_inkwell_button.dart';

class HomeScreen extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> onBackgroundChanged;
  final ValueChanged<String> onLanguageChanged;
  final ValueChanged<Color> onColorChanged;
  final Function(Color, double) onTextChanged;

  const HomeScreen({
    super.key,
    required this.onThemeChanged,
    required this.onBackgroundChanged,
    required this.onLanguageChanged,
    required this.onColorChanged,
    required this.onTextChanged,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = <Widget>[
    MainScreen(),
    const ResultsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isMobile = constraints.maxWidth < 600;
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              AppConstants.imageUrl,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              "Main page",
              style: TextStyle(
                color: AppConstants.textColor,
                fontSize: AppConstants.textSize,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(AppConstants.language),
              ),
            ],
          ),
          body: Row(
            children: [
              if (!isMobile)
                NavigationRail(
                  backgroundColor: Colors.amber,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Main'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.auto_graph_outlined),
                      label: Text('Results'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person),
                      label: Text('Profile'),
                    ),
                  ],
                  labelType: NavigationRailLabelType.selected,
                  onDestinationSelected: (int value) =>
                      setState(() => _currentIndex = value),
                  selectedIndex: _currentIndex,
                ),
              Expanded(child: _pages[_currentIndex])
            ],
          ),
          drawer: CustomDrawer(
            onThemeChanged: widget.onThemeChanged,
            onBackgroundChanged: widget.onBackgroundChanged,
            onLanguageChanged: widget.onLanguageChanged,
            onColorChanged: widget.onColorChanged,
            onTextChanged: widget.onTextChanged,
          ),
          bottomNavigationBar: isMobile
              ? SalomonBottomBar(
                  backgroundColor: Colors.amber,
                  currentIndex: _currentIndex,
                  onTap: (i) => setState(() => _currentIndex = i),
                  items: [
                    SalomonBottomBarItem(
                      icon: const Icon(Icons.home),
                      title: const Text("Main"),
                      selectedColor: Colors.purple,
                    ),
                    SalomonBottomBarItem(
                      icon: const Icon(Icons.auto_graph_outlined),
                      title: const Text("Results"),
                      selectedColor: Colors.pink,
                    ),
                    SalomonBottomBarItem(
                      icon: const Icon(Icons.person),
                      title: const Text("Profile"),
                      selectedColor: Colors.orange,
                    ),
                  ],
                )
              : null,
        ),
      );
    });
  }
}
