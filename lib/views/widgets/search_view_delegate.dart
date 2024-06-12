import 'package:flutter/material.dart';
import 'package:settings_page/models/course_model.dart';

class SearchViewDelegate extends SearchDelegate<String> {
  final List<Course> data;

  SearchViewDelegate({required this.data});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSuggestionList(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSuggestionList(query);
  }

  Widget _buildSuggestionList(String query) {
    List<Course> suggestionList = [];
    suggestionList = query.isEmpty
        ? data
        : data
            .where(
              (Course element) => element.courseTitle
                  .toLowerCase()
                  .toString()
                  .contains(query.toLowerCase()),
            )
            .toList();
    return suggestionList.isEmpty
        ? const Center(
            child: Text('No cars founds'),
          )
        : ListView.builder(
            itemCount: suggestionList.length,
            itemBuilder: (BuildContext context, int index) => ListTile(
              title: Text(suggestionList[index].courseTitle),
              subtitle: Text(suggestionList[index].coursePrice.toString()),
              onTap: () => close(
                context,
                suggestionList[index].courseTitle,
              ),
            ),
          );
  }
}
