import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HotelsDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.green),
      home: FirebaseCRUDPage(title: 'Hotels CRUD'),
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
  String _name;
  String _about;
  String _location;
//  String _imgUrl;
  String _contact;
  String _type;
  String _area;

  bool isUpdate = false;
  String docIdToUpdate;
  final _nameController = TextEditingController();
  final _aboutController = TextEditingController();
  final _locationController = TextEditingController();
//  final _imgUrlController = TextEditingController();
  final _contactController = TextEditingController();
  final _typeController = TextEditingController();
  final _areaController = TextEditingController();


  clearForm() {
    setState(() {
      isUpdate = false;
      docIdToUpdate = null;
      _nameController.text = "";
      _aboutController.text = "";
      _locationController.text = "";
//      _imgUrlController.text = "";
      _contactController.text = "";
      _typeController.text = "";
      _areaController.text = "";
    });
  }

  Future<void> addStudent() async {
    await db.collection("shops").add({
      'name': _name,
      'about': _about,
      'location': _location,
      'contact': int.parse(_contact),
      'area': int.parse(_area),
      'type': _type,
//      'image_url': _imgUrl,

    }).then((documentReference) {
      print(documentReference.documentID);
      clearForm();
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> editStudent() async {
    await db.collection("shops").document(docIdToUpdate).updateData({
      'name': _name,
      'about': _about,
      'location': _location,
      'contact': int.parse(_contact),
      'area': int.parse(_area),
      'type': _type,
//      'image_url': _imgUrl,
    }).then((documentReference) {
      clearForm();
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> deleteStudent(DocumentSnapshot doc) async {
    db.collection("shops").document(doc.documentID).delete();
    clearForm();
  }

  generateStudentList(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map<Widget>(
          (doc) => new ListTile(
        title: new Text(doc["name"]),
        subtitle: Column(children:<Widget>[
          new Text(doc["about"]),
          new Text(doc["location"]),
//          new Text(doc["image_url"]),
          new Text(doc["contact"].toString()),
        ]),
        trailing: Container(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  setState(() {
                    _nameController.text = doc["name"];
                    _aboutController.text = doc["about"];
                    _locationController.text = doc["location"];
//                    _imgUrlController.text = doc["image_url"];
                    _contactController.text = doc["contact"].toString();
                    _areaController.text=doc["area"].toString();
                    _typeController.text=doc["type"];
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
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 1),
                  child: TextFormField(
                    onSaved: (value) {
                      _name = value;
                    },
                    controller: _nameController,
                    decoration: InputDecoration(
                        focusedBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Colors.green,
                                width: 2,
                                style: BorderStyle.solid)),
                        labelText: "Shop Name",
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
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 1),
                  child: TextFormField(
                    onSaved: (value) {
                      _about = value;
                    },
                    controller: _aboutController,
                    decoration: InputDecoration(
                        focusedBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Colors.green,
                                width: 2,
                                style: BorderStyle.solid)),
                        labelText: "About",
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
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 1),
                  child: TextFormField(
                    onSaved: (value) {
                      _location = value;
                    },
                    controller: _locationController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        focusedBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Colors.green,
                                width: 2,
                                style: BorderStyle.solid)),
                        labelText: "Loaction",
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
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 1),
                  child: TextFormField(
                    onSaved: (value) {
                      _contact = value;
                    },
                    controller: _contactController,
                    decoration: InputDecoration(
                        focusedBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Colors.green,
                                width: 2,
                                style: BorderStyle.solid)),
                        labelText: "Contact",
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
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 1),
                  child: TextFormField(
                    onSaved: (value) {
                      _type = value;
                    },
                    controller: _typeController,
                    decoration: InputDecoration(
                        focusedBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Colors.green,
                                width: 2,
                                style: BorderStyle.solid)),
                        labelText: "Type",
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
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 1),
                  child: TextFormField(
                    onSaved: (value) {
                      _area = value;
                    },
                    controller: _areaController,
                    decoration: InputDecoration(
                        focusedBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Colors.green,
                                width: 2,
                                style: BorderStyle.solid)),
                        labelText: "Area",
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
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                color: Colors.green,
                child: Text(
                  (isUpdate ? 'UPDATE SHOP' : 'ADD NEW SHOP'),
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
            height: 2.0,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: db.collection("shops").snapshots(),
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
