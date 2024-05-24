import 'package:flutter/material.dart';
import 'package:settings_page/utils/app_constants.dart';
import 'package:settings_page/views/widgets/custom_drawer.dart';

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
  @override
  Widget build(BuildContext context) {
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
        // Make Scaffold background transparent
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
        drawer: CustomDrawer(
          onThemeChanged: widget.onThemeChanged,
          onBackgroundChanged: widget.onBackgroundChanged,
          onLanguageChanged: widget.onLanguageChanged,
          onColorChanged: widget.onColorChanged,
          onTextChanged: widget.onTextChanged,
        ),
      ),
    );
  }
}
