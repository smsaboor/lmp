import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.green),
      home: FirebaseCRUDPage(title: 'News CRUD'),
    );
  }
}

class FirebaseCRUDPage extends StatefulWidget {
  FirebaseCRUDPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _FirebaseCRUDPageState createState() => _FirebaseCRUDPageState();
}

class _FirebaseCRUDPageState extends State<FirebaseCRUDPage> {
  final db = Firestore.instance;
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  String _title;
  String _description;
  String _reference;
//  String _imgUrl;
  String _date;
  bool isUpdate = false;
  String docIdToUpdate;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _referenceController = TextEditingController();
//  final _imgUrlController = TextEditingController();
  final _dateController = TextEditingController();

  clearForm() {
    setState(() {
      isUpdate = false;
      docIdToUpdate = null;
      _titleController.text = "";
      _descriptionController.text = "";
      _referenceController.text = "";
//      _imgUrlController.text = "";
      _dateController.text = "";
    });
  }

  Future<void> addStudent() async {
    await db.collection("news").add({
      'title': _title,
      'description': _description,
      'reference': _reference,
      'date': _date,
//      'image_url': _imgUrl,

    }).then((documentReference) {
      print(documentReference.documentID);
      clearForm();
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> editStudent() async {
    await db.collection("news").document(docIdToUpdate).updateData({
      'title': _title,
      'description': _description,
      'reference': _reference,
      'date': _date,
//      'image_url': _imgUrl,
    }).then((documentReference) {
      clearForm();
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> deleteStudent(DocumentSnapshot doc) async {
    db.collection("news").document(doc.documentID).delete();
    clearForm();
  }

  generateStudentList(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map<Widget>(
          (doc) => new ListTile(
        title: new Text(doc["title"]),
        subtitle: Column(children:<Widget>[
          new Text(doc["description"]),
          new Text(doc["reference"].toString()),
//          new Text(doc["image_url"]),
          new Text(doc["date"]),
        ]),
        trailing: Container(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  setState(() {
                    _titleController.text = doc["title"];
                    _descriptionController.text = doc["description"];
                    _referenceController.text = doc["reference"].toString();
//                    _imgUrlController.text = doc["image_url"];
                    _dateController.text = doc["date"];
                    docIdToUpdate = doc.documentID;
                    isUpdate = true;
                  });
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
              ),
              IconButton(
                onPressed: () {
                  deleteStudent(doc);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              )
            ],
          ),
        ),
      ),
    )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Form(
            key: _formStateKey,
            autovalidate: true,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  child: TextFormField(
                    onSaved: (value) {
                      _title = value;
                    },
                    controller: _titleController,
                    decoration: InputDecoration(
                        focusedBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Colors.green,
                                width: 2,
                                style: BorderStyle.solid)),
                        labelText: "News Title",
                        icon: Icon(
                          Icons.business_center,
                          color: Colors.green,
                        ),
                        fillColor: Colors.white,
                        labelStyle: TextStyle(
                          color: Colors.green,
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  child: TextFormField(
                    onSaved: (value) {
                      _description = value;
                    },
                    controller: _descriptionController,
                    decoration: InputDecoration(
                        focusedBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Colors.green,
                                width: 2,
                                style: BorderStyle.solid)),
                        labelText: "News Description",
                        icon: Icon(
                          Icons.business_center,
                          color: Colors.green,
                        ),
                        fillColor: Colors.white,
                        labelStyle: TextStyle(
                          color: Colors.green,
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  child: TextFormField(
                    onSaved: (value) {
                      _reference = value;
                    },
                    controller: _referenceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        focusedBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Colors.green,
                                width: 2,
                                style: BorderStyle.solid)),
                        labelText: "News Reference",
                        icon: Icon(
                          Icons.dialpad,
                          color: Colors.green,
                        ),
                        fillColor: Colors.white,
                        labelStyle: TextStyle(
                          color: Colors.green,
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  child: TextFormField(
                    onSaved: (value) {
                      _date = value;
                    },
                    controller: _dateController,
                    decoration: InputDecoration(
                        focusedBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Colors.green,
                                width: 2,
                                style: BorderStyle.solid)),
                        labelText: "News Date",
                        icon: Icon(
                          Icons.business_center,
                          color: Colors.green,
                        ),
                        fillColor: Colors.white,
                        labelStyle: TextStyle(
                          color: Colors.green,
                        )),
                  ),
                ),
//                Padding(
//                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
//                  child: TextFormField(
//                    validator: (value) {
//                      if (value.isEmpty) {
//                        return 'Please Enter News Image';
//                      }
//                      if (value.trim() == "")
//                        return "Only Space is Not Valid!!!";
//                      return null;
//                    },
//                    onSaved: (value) {
//                      _imgUrl = value;
//                    },
//                    controller: _imgUrlController,
//                    decoration: InputDecoration(
//                        focusedBorder: new UnderlineInputBorder(
//                            borderSide: new BorderSide(
//                                color: Colors.green,
//                                width: 2,
//                                style: BorderStyle.solid)),
//                        labelText: "Image Url",
//                        icon: Icon(
//                          Icons.business_center,
//                          color: Colors.green,
//                        ),
//                        fillColor: Colors.white,
//                        labelStyle: TextStyle(
//                          color: Colors.green,
//                        )),
//                  ),
//                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                color: Colors.green,
                child: Text(
                  (isUpdate ? 'UPDATE NEWS' : 'ADD NEW NEWS'),
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (isUpdate) {
                    if (_formStateKey.currentState.validate()) {
                      _formStateKey.currentState.save();
                      editStudent();
                    }
                  } else {
                    if (_formStateKey.currentState.validate()) {
                      _formStateKey.currentState.save();
                      addStudent();
                    }
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              RaisedButton(
                color: Colors.red,
                child: Text(
                  (isUpdate ? 'CANCEL UPDATE' : 'CLEAR'),
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  clearForm();
                },
              ),
            ],
          ),
          const Divider(
            height: 5.0,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: db.collection("news").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return new Text("There is no expense");
              return Expanded(
                child: new ListView(
                  children: generateStudentList(snapshot),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
