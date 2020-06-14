import 'package:ex4_tp_mobile/models/student.dart';
import 'package:ex4_tp_mobile/services/students_provider.dart';
import 'package:ex4_tp_mobile/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageAbsencesScreen extends StatefulWidget {
  static const routeName = 'ManageAbs';
  @override
  _ManageAbsencesScreenState createState() => _ManageAbsencesScreenState();
}

class _ManageAbsencesScreenState extends State<ManageAbsencesScreen> {
  List<Student> _students;
  bool _isProcessing = false;

  @override
  void initState() {
    _students = Provider.of<StudentsProvider>(context, listen: false).students;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gestion des absences'),),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _students.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final std = _students[index];
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
                  trailing: Container(
                    width: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          std.nombreAbs.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        IconButton(
                          color: Colors.cyan,
                          icon: Icon(Icons.add),
                          onPressed: _isProcessing
                              ? null
                              : () async {
                                  setState(() {
                                    _isProcessing = true;
                                    std.nombreAbs = std.nombreAbs++;
                                  });
                                  try {
                                    await Provider.of<StudentsProvider>(context,
                                            listen: false)
                                        .addAbsence(std);
                                  } catch (e) {
                                    print(e);
                                    setState(() {
                                      std.nombreAbs = std.nombreAbs--;
                                    });
                                  }
                                  setState(() {
                                    _isProcessing = false;
                                  });
                                },
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
