import 'package:ex4_tp_mobile/models/student.dart';
import 'package:ex4_tp_mobile/services/students_provider.dart';
import 'package:ex4_tp_mobile/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentsListScreen extends StatefulWidget {
  static const routeName = '/List';

  @override
  _StudentsListScreenState createState() => _StudentsListScreenState();
}

class _StudentsListScreenState extends State<StudentsListScreen> {
  List<Student> studentList;
  @override
  void initState() {
    studentList = Provider.of<StudentsProvider>(context, listen: false).students;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Liste des étudiants par groupe'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListView.builder(
                itemCount: studentList.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  Student std = studentList[index];
                  return Card(
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(std.avatarurl),
                      ),
                      title: Text(std.firstName + ' ' + std.lastName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Email : ' + std.email),
                          Text('Option : ' + std.option),
                        ],
                      ),
                      trailing: Text(
                        std.nombreAbs.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
