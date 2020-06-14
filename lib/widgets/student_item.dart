import 'package:ex4_tp_mobile/models/student.dart';
import 'package:flutter/material.dart';

class StudentItem extends StatelessWidget {
  final Student std;
  StudentItem(this.std);
  
  @override
  Widget build(BuildContext context) {
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
  }
}
