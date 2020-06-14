import 'dart:convert';

import 'package:ex4_tp_mobile/models/ex5.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ex4_tp_mobile/models/student.dart';

class StudentsProvider with ChangeNotifier {
  final List<Student> students = [];

  Future<List<Student>> fetchStudents([String option]) async {
    students.clear();
    String url;
    if (option != null)
      url =
          'https://tp3mobileensit.firebaseio.com//students.json?orderBy="option"&equalTo="$option"';
    else
      url = 'https://tp3mobileensit.firebaseio.com//students.json';
    try {
      final response = await http.get(url);
      print(response.request);
      final loadedData = json.decode(response.body) as Map<String, dynamic>;
      loadedData.forEach((id, std) {
        students.add(
          Student(
            id: id,
            avatarurl: std['avatarurl'],
            email: std['email'],
            firstName: std['firstName'],
            lastName: std['lastName'],
            option: std['option'],
            nombreAbs: std['nombreAbs'] ?? 0,
          ),
        );
      });
    } catch (error) {
      print(error.toString());
      throw error;
    }
    notifyListeners();
    return students;
  }

  Future addAbsence(Student student) async {
    final id = student.id;
    print(id);
    final url = 'https://tp3mobileensit.firebaseio.com//students/$id.json';
    print(url);
    try {
      final response = await http.patch(
        url,
        body: json.encode(
          {
            'nombreAbs': ++student.nombreAbs,
          },
        ),
      );
      print(response.body);
      print(response.statusCode.toString());
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future addStudent(Student student) async {
    final url = 'https://tp3mobileensit.firebaseio.com//students.json';
    try {
      print('Adding student');
      final response = await http.post(url,
          body: json.encode({
            'id': student.id,
            'nombreAbs': student.nombreAbs,
            'email': student.email,
            'option': student.option,
            'avatarurl': student.avatarurl,
            'firstName': student.firstName,
            'lastName': student.lastName,
          }));
      if (response.statusCode == 200)
        print('Student ${student.email} added to the database.');
      else if (response.statusCode >= 400) print('Error while adding student.');
    } catch (error) {
      print('Error while adding a student :' + error.toString());
      throw error;
    }
  }

  List<Ex5Model> redditItems = [];

  Future fetchDataFromReddit() async {
    final url = 'https://www.reddit.com/r/Android/new.json';
    try {
      final response = await http.get(url);
      // print(json.decode(response.body)['data']['children']);
      // print('\n');
      if (json.decode(response.body)['data']['children'] != null) {
        final loadedData =
            json.decode(response.body)['data']['children'] as List<dynamic>;
      //   for (var i = 0; i < 3; i++) {
      //     final item = loadedData[i]['data'];
      //     print(item);
      //     print('\n\n');
      //     if (item["preview"] != null) {
      //       redditItems.add(
      //         Ex5Model(
      //           authorName: item["author"] ?? 'name',
      //           title: item["title"],
      //           imageURL: item["preview"]["images"][0]["source"]["url"],
      //         ),
      //       );
      //     } else {
      //       redditItems.add(Ex5Model(
      //         authorName: item["author"] ?? 'name',
      //         title: item["title"],
      //         imageURL:
      //             'https://www.ajactraining.org/wp-content/uploads/2019/09/image-placeholder.jpg',
      //       ));
      //     }
      //   }
        loadedData.forEach((value) {
          final item = value['data'];
          print(item);
          print('\n\n');
          if (item["preview"] != null) {
            redditItems.add(
              Ex5Model(
                authorName: item["author"] ?? 'name',
                title: item["title"],
                // imageURL: item["preview"]["images"][0]["source"]["url"],
                imageURL:
                  'https://www.ajactraining.org/wp-content/uploads/2019/09/image-placeholder.jpg',
              ),
            );
          } else {
            redditItems.add(Ex5Model(
              authorName: item["author_fullname"] ?? 'name',
              title: item["title"],
              imageURL:
                  'https://www.ajactraining.org/wp-content/uploads/2019/09/image-placeholder.jpg',
            ));
          }
        });
      }
    } catch (error) {
      print('Error while fetchin from reddit:\n' + error.toString());
      throw error;
    }
  }
}
