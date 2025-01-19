import 'package:flutter/material.dart';
import 'package:school/data/models/subjectModel/subject_model.dart';

class SubjectSearchDelegate extends SearchDelegate<String> {
  final List<SubjectModel> subjects;

  SubjectSearchDelegate(this.subjects);

  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions for the search bar (e.g., clear or cancel)
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear the search query
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon (e.g., back button)
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Filter subjects based on the search query and return matching results
    final filteredSubjects = subjects.where((subject) {
      return subject.subjectName!.toLowerCase().contains(query.toLowerCase()) ||
          subject.teacherName!.toLowerCase().contains(query.toLowerCase()) ||
          subject.className.toString().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: filteredSubjects.length,
      itemBuilder: (context, index) {
        final subject = filteredSubjects[index];
        return ListTile(
          title: Text(subject.subjectName ?? "No Subject Name"),
          subtitle: Text("${subject.teacherName ?? 'No Teacher'} - ${subject.className}"),
          onTap: () {
            close(context, subject.subjectID.toString());
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Display suggestions while typing
    final filteredSubjects = subjects.where((subject) {
      return subject.subjectName!.toLowerCase().contains(query.toLowerCase()) ||
          subject.teacherName!.toLowerCase().contains(query.toLowerCase()) ||
          subject.className.toString().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: filteredSubjects.length,
      itemBuilder: (context, index) {
        final subject = filteredSubjects[index];
        return ListTile(
          title: Text(subject.subjectName ?? "No Subject Name"),
          subtitle: Text("${subject.teacherName ?? 'No Teacher'} - ${subject.className}"),
          onTap: () {
            query = subject.subjectName ?? ''; // Set the query to the selected suggestion
            showResults(context);
          },
        );
      },
    );
  }
}
