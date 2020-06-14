import 'package:ex4_tp_mobile/models/student.dart';
import 'package:ex4_tp_mobile/screens/add_student_screen.dart';
import 'package:ex4_tp_mobile/screens/exercice_5_screen.dart';
import 'package:ex4_tp_mobile/screens/manage_abs_screen.dart';
import 'package:ex4_tp_mobile/screens/students_list_screen.dart';
import 'package:ex4_tp_mobile/services/students_provider.dart';
import 'package:ex4_tp_mobile/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: StudentsProvider()),
      ],
      child: MaterialApp(
        routes: {
          AddStudentScreen.routeName: (context) => AddStudentScreen(),
          ManageAbsencesScreen.routeName: (context) => ManageAbsencesScreen(),
          StudentsListScreen.routeName: (context) => StudentsListScreen(),
          Exercice5Screen.routeName: (context) => Exercice5Screen(),
        },
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.cyan,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Student> studentList;
  bool _isLoading = false;
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<StudentsProvider>(context, listen: false)
        .fetchStudents()
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    studentList = Provider.of<StudentsProvider>(context).students;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Gestion de présence des étudiants'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
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
