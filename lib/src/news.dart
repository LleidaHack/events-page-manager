import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';




class AddNewNew extends StatefulWidget {
  const AddNewNew({
    required this.save,
  });

  final void Function(String title) save;

  @override
  _AddNewNewState createState() => _AddNewNewState();
}

class _AddNewNewState extends State<AddNewNew> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('events')
      .orderBy('date')
      .snapshots();
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _topdescController = TextEditingController();
  final _botdescController = TextEditingController();
  final _dateController = TextEditingController();
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog<Widget>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Stack(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            TextFormField(
                              controller: _titleController,
                              decoration: const InputDecoration(
                                hintText: 'Nombre del evento',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Introduce un titulo';
                                }
                                return null;
                              },
                            ),
                            MaterialButton(
                              color: Colors.blue,
                              child: Text(
                                "Seleccionar una miniatura",
                                style: TextStyle(
                                    color: Colors.white70, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                XFile? image = await picker.pickImage(source: ImageSource.gallery);
                              },
                            ),

                            TextFormField(
                              controller: _dateController,
                              decoration: const InputDecoration(
                                hintText: 'Fecha del evento',
                              ),
                              onTap: () async {
                                await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2015),
                                  lastDate: DateTime(2025),
                                ).then((selectedDate) {
                                  if (selectedDate != null) {
                                    _dateController.text =
                                        DateFormat('dd-MM-yyyy').format(selectedDate);
                                  }
                                });
                              },
                            ),
                            TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: _topdescController,
                              decoration: const InputDecoration(
                                hintText:
                                    'Descripcion superior (antes de la foto)',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Introduce una descripcion';
                                }
                                return null;
                              },
                            ),
                            MaterialButton(
                              color: Colors.blue,
                              child: Text(
                                "Seleccionar una foto de noticia",
                                style: TextStyle(
                                    color: Colors.white70, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                XFile? image = await picker.pickImage(source: ImageSource.gallery);
                              },
                            ),
                            TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: _botdescController,
                              decoration: const InputDecoration(
                                hintText:
                                    'Descripción inferor (despues de la foto)',
                              ),
                              validator: (value) {
                                return null;
                              },
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                    child: Text("Submit"),
                                    onPressed: () {
                                      widget.save('casa');
                                    })),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
      },
      child: Text('Añadir noticia nueva!'),
    );
  }
}

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('events')
      .orderBy('order')
      .snapshots();

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
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(data['image']),
                  ),
                  title: Text(data['name']),
                  subtitle: Text(data['topDescription']),
                );
              }).toList(),
            ));
      },
    );
  }
}
