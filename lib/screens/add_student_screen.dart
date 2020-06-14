import 'package:ex4_tp_mobile/models/student.dart';
import 'package:ex4_tp_mobile/services/students_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddStudentScreen extends StatefulWidget {
  static const routeName = '/student/add';

  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _key = GlobalKey<FormState>();
  final values = {};
  String dropdownValue = 'Génie informatique A';
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    Student dummyStudent = Student(
      avatarurl:
          'https://instagram.ftun2-1.fna.fbcdn.net/v/t51.2885-19/s150x150/97959376_953836195036824_5726570480912039936_n.jpg?_nc_ht=instagram.ftun2-1.fna.fbcdn.net&_nc_ohc=C-iGWdTDa1QAX_nIQEf&oh=bfdf8dca7cca9897b35badb6c028007b&oe=5F0ABD53',
      email: 'omarmach@gmail.com',
      id: DateTime.now().toString(),
      firstName: 'Omar',
      lastName: 'YES',
      nombreAbs: 0,
      option: dropdownValue,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un étudiant'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTLXh6kRdJTpxK7YYEvBnG9des7z9b-ORZITemppwo8dcFIJVg0&usqp=CAU',
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                      "Veuillez remplir ce formulaire afin d'ajouter un étudiant"),
                  SizedBox(height: 5),
                  TextFormField(
                    onSaved: (value) {
                      setState(() {
                        values['firstName'] = value.trim();
                      });
                    },
                    decoration: buildInputDecoration('Nom..'),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    onFieldSubmitted: (value) => values['lastName'] = value,
                    onSaved: (value) {
                      setState(() {
                        values['lastName'] = value.trim();
                      });
                    },
                    decoration: buildInputDecoration('Prenom..'),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value.contains('@')
                        ? null
                        : 'Veuillez entrer un email valide..',
                    onFieldSubmitted: (value) => values['email'] = value,
                    onSaved: (value) {
                      setState(() {
                        values['email'] = value.trim();
                      });
                    },
                    decoration: buildInputDecoration('Email..'),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (value) => values['avatarUrl'] = value,
                    onSaved: (value) {
                      setState(() {
                        values['avatarUrl'] = value.trim();
                      });
                    },
                    decoration: buildInputDecoration('Photo (en URL)..'),
                  ),
                  SizedBox(height: 10),
                  InputDecorator(
                    decoration: buildInputDecoration('Option'),
                    child: DropdownButtonHideUnderline(
                      child: _buildDropdownButton(),
                    ),
                  ),
                  SizedBox(height: 50),
                  RaisedButton(
                    onPressed: () async {
                      if (_key.currentState.validate()) {
                        _key.currentState.save();
                        setState(() {
                          _isProcessing = true;
                        });
                        await Provider.of<StudentsProvider>(context,
                                listen: false)
                            .addStudent(Student(
                          avatarurl:
                              'https://instagram.ftun2-1.fna.fbcdn.net/v/t51.2885-19/s150x150/97959376_953836195036824_5726570480912039936_n.jpg?_nc_ht=instagram.ftun2-1.fna.fbcdn.net&_nc_ohc=C-iGWdTDa1QAX_nIQEf&oh=bfdf8dca7cca9897b35badb6c028007b&oe=5F0ABD53',
                          email: values['email'],
                          id: DateTime.now().toString(),
                          firstName: values['firstName'],
                          lastName: values['lastName'],
                          nombreAbs: 0,
                          option: dropdownValue,
                        ));
                        setState(() {
                          _isProcessing = false;
                        });
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    padding: EdgeInsets.all(0.0),
                    child: _buildGradient(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DropdownButton<String> _buildDropdownButton() {
    return DropdownButton<String>(
      value: dropdownValue,
      isDense: true,
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>[
        'Génie informatique A',
        'Génie informatique B',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Ink _buildGradient() {
    return Ink(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.cyan, Colors.blueAccent],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
        alignment: Alignment.center,
        child: _isProcessing
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              )
            : Text(
                "Ajouter",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
      ),
    );
  }
}

InputDecoration buildInputDecoration(String hint) {
  return InputDecoration(
    labelText: hint,
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    fillColor: Colors.white,
    border: new OutlineInputBorder(
      borderSide: new BorderSide(),
    ),
  );
}
