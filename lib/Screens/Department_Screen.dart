import "package:flutter/material.dart";
import "package:routemaster/routemaster.dart";

class DepartmentScreen extends StatelessWidget {
  const DepartmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<String>> departmentSeries = const {
      'cse': ['1-1', '1-2', '2-1', '2-2'],
      'ece': ['1-1', '1-2', '2-1', '2-2'],
      'ee': ['1-1', '1-2', '2-1', '2-2'],
      'mech': ['1-1', '1-2'],
      'civil': ['1-1', '1-2'],
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text("Materials"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: ListView(
        children: departmentSeries.entries.map((entry) {
          String branch = entry.key;
          List<String> semesters = entry.value;
          return ExpansionTile(
            title: Text(branch),
            children: semesters.map((sem) {
              return ListTile(
                title: Text(sem),
                onTap: (){
                  Routemaster.of(context).push("/materials/$branch/$sem");
                },
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}
