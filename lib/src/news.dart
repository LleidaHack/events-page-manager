import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNewNew extends StatefulWidget {
  @override
  _AddNewNewState createState() => _AddNewNewState();
}

class _AddNewNewState extends State<AddNewNew> {
  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('events').orderBy('date').snapshots();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {

      },
      child: Text('Añadir noticia nueva!'),);
  }
}


class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('events').orderBy('order').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
            child: ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['name']),
                  subtitle: Text(data['topDescription']),
                );
              }).toList(),
            ));
      },
    );
  }
}
