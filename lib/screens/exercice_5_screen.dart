import 'package:ex4_tp_mobile/models/ex5.dart';
import 'package:ex4_tp_mobile/services/students_provider.dart';
import 'package:ex4_tp_mobile/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Exercice5Screen extends StatefulWidget {
  static const routeName = 'ex5';
  @override
  _Exercice5ScreenState createState() => _Exercice5ScreenState();
}

class _Exercice5ScreenState extends State<Exercice5Screen> {
  bool _isloading = true;
  List<Ex5Model> items;

  @override
  void initState() {
    items = Provider.of<StudentsProvider>(context, listen: false).redditItems;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Exercice 5'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(150),
                  child: Image.network(
                    'https://styles.redditmedia.com/t5_2qlqh/styles/image_widget_l8h7m6apyv921.jpg?format=pjpg&s=c560445a99edcb29814890cc04731775ad0eeb2d',
                    fit: BoxFit.cover,
                    width: 175,
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      Ex5Model item = items[index];
                      return Container(
                        color: Colors.cyanAccent[50],
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.cyanAccent[50],
                          border: Border.all(
                              color: Colors.cyanAccent.shade100, width: 0.5),
                        ),
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          title: Text('Author: ' + item.authorName),
                          trailing: ClipRRect(
                            child: Image.network(item.imageURL),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          subtitle: Text(
                            item.title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
