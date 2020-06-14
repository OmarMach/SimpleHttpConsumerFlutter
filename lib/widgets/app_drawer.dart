import 'package:ex4_tp_mobile/screens/exercice_5_screen.dart';
import 'package:ex4_tp_mobile/screens/manage_abs_screen.dart';
import 'package:ex4_tp_mobile/screens/students_list_screen.dart';
import 'package:ex4_tp_mobile/services/students_provider.dart';
import 'package:flutter/material.dart';
import 'package:ex4_tp_mobile/screens/add_student_screen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
                child: Row(
              children: <Widget>[
                Container(
                  width: 70,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(
                              'https://i.ya-webdesign.com/images/transparent-teacher-flat-design-5.png'))),
                ),
                SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Nom professeur',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Text(
                      "ENSIT",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            )),
            decoration: BoxDecoration(
              color: Colors.cyan,
            ),
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Ajouter un étudiant'),
            onTap: () {
              Navigator.pushNamed(context, AddStudentScreen.routeName);
            },
          ),
          Divider(
            thickness: 1,
            color: Colors.cyanAccent,
            indent: 22,
            endIndent: 22,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Text('Mes classes'),
          ),
          ListTile(
            leading: Icon(Icons.assignment_ind),
            title: Text('Génie Informatique A'),
            onTap: () async {
              await Provider.of<StudentsProvider>(context, listen: false)
                  .fetchStudents('Génie informatique A');
              Navigator.of(context).pop();
              Navigator.of(context)
                  .pushReplacementNamed(StudentsListScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment_ind),
            title: Text('Génie Informatique B'),
            onTap: () async {
              await Provider.of<StudentsProvider>(context, listen: false)
                  .fetchStudents('Génie informatique A');

              Navigator.of(context).pop();
              Navigator.of(context)
                  .pushReplacementNamed(StudentsListScreen.routeName);
            },
          ),
          Divider(
            thickness: 1,
            color: Colors.cyanAccent,
            indent: 22,
            endIndent: 22,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Text('Saisie des absences'),
          ),
          ListTile(
            leading: Icon(Icons.assignment_ind),
            title: Text('Génie Informatique A'),
            onTap: () async {
              await Provider.of<StudentsProvider>(context, listen: false)
                  .fetchStudents('Génie informatique A');
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(ManageAbsencesScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment_ind),
            title: Text('Génie Informatique B'),
            onTap: () async {
              await Provider.of<StudentsProvider>(context, listen: false)
                  .fetchStudents("Génie informatique B");

              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(ManageAbsencesScreen.routeName);
            },
          ),
          Divider(
            thickness: 1,
            color: Colors.cyanAccent,
            indent: 22,
            endIndent: 22,
          ),
          ListTile(
            leading: Icon(Icons.assignment_ind),
            title: Text('Exercice 5'),
            onTap: () async {
              await Provider.of<StudentsProvider>(context, listen: false)
                  .fetchDataFromReddit();
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(Exercice5Screen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
