import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/widgets.dart' as prefix1;
import 'package:image_picker/image_picker.dart';
import 'package:lakhimpur_kheri/screens/dashboard/offerEdit.dart';
import 'package:path/path.dart' as Path;
import 'dart:async';

import 'dart:core';
import 'package:flutter/widgets.dart';

//class OffersDashboard extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      theme: ThemeData(primaryColor: Colors.green),
//      home: FirebaseCRUDPage(title: 'Firestore CRUD'),
//    );
//  }
//}

class OffersDashboard extends StatefulWidget {
  OffersDashboard();

  @override
  _OffersDashboardState createState() => _OffersDashboardState();
}

class _OffersDashboardState extends State<OffersDashboard> {
  File _image;
  var _imgURL;
  String _uploadedFileURL;
  final db = Firestore.instance;
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  String _title;
  String _description;
  String _reference;
  String _hTitle;
  String _hDescription;
  String _hReference;
  bool isUpdate = false;
  String docIdToUpdate;
  String _editImgURL;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _referenceController = TextEditingController();
  final _hTitleController = TextEditingController();
  final _hDescriptionController = TextEditingController();
  final _hReferenceController = TextEditingController();
  final _uploadedFileURLController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _editImgURL = '';
    // TODO: implement dispose
    super.dispose();
  }

  clearForm() {
    setState(() {
      isUpdate = false;
      docIdToUpdate = null;
      _titleController.text = "";
      _descriptionController.text = "";
      _referenceController.text = "";
      _hTitleController.text = "";
      _hDescriptionController.text = "";
      _hReferenceController.text = "";
      _uploadedFileURLController.text = "";
    });
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      print('Image Path $_image');
    });
    uploadPic();
  }

  Future uploadPic() async {
//    String fileName = basename(_image.path);
    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child('offers/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = ref.putFile(_image);

    var downURL = await (await uploadTask.onComplete).ref.getDownloadURL();
    var url = downURL.toString();
    print("Download URl: $url");
//    StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
    setState(() {
      debugPrint("Set State............................ : $url");
      _imgURL = url;
      debugPrint("Set State.._imgURL.......................... : $_imgURL");
      _editImgURL = url;
      debugPrint(
          "Set State..._editImgURL......................... : $_editImgURL");
      print("Profile Picture uploaded");
//      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
    });
    return url;
  }

  Future<void> addStudent() async {
    await db.collection("offers").add({
      'title': _title,
      'description': _description,
      'reference': _reference,
      'h_title': _hTitle,
      'h_description': _hDescription,
      'h_reference': _hReference,
      'varified': true,
      'varified_by': 'me',
      'email': 'saboor@',
      'img_url_1': _imgURL,
    }).then((documentReference) {
      print(documentReference.documentID);
      clearForm();
      moveToLastScreen();
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> editStudent() async {
    await db.collection("offers").document(docIdToUpdate).updateData({
      'title': _title,
      'description': _description,
      'reference': _reference,
      'h_title': _hTitle,
      'h_description': _hDescription,
      'h_reference': _hReference,
      'img_url_1': _editImgURL,
      'varified': true,
      'varified_by': 'me',
      'email': 'saboor@',
    }).then((documentReference) {
      clearForm();
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> deleteStudent(DocumentSnapshot doc) async {
    db.collection("offers").document(doc.documentID).delete();
    clearForm();
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Write some code to control things, when user press back button in AppBar
              moveToLastScreen();
            }),
        title: Text("Offers"),
      ),
      body: Column(
        children: <Widget>[
          const Divider(
            height: 5.0,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: db.collection("offers").snapshots(),
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
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.green,
          icon: Icon(Icons.add),
          label: Text("Add Offer"),
          onPressed: () {
            Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (_) => OffersEditDashboard(
                      '', '', '', '', '', '', '', '', '', false)),
            );
          }),
    );
  }

  generateStudentList(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map<Widget>(
        (doc)=>Container(
          margin: EdgeInsets.all(20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: prefix0.GestureDetector(child:Container(
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        (doc["img_url_1"] != null)
                            ? Image.network(
                          doc["img_url_1"],
                          fit: BoxFit.fill,
                        )
                            : Image.asset(
                          "assets/hotel/room1.jpg"         ,                 fit: BoxFit.fill,
                        ),
                        Positioned(
                          right: 10,
                          top: 10,
                          child: Icon(
                            Icons.star,
                            color: Colors.grey.shade800,
                            size: 20.0,
                          ),
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Icon(
                            Icons.star_border,
                            color: Colors.white,
                            size: 24.0,
                          ),
                        ),
                        Positioned(
                          bottom: 20.0,
                          right: 10.0,
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            color: Colors.white,
                            child: Text("\$40"),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            doc["title"],
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            doc["description"],
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                  doc["reference"],
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Padding(
                                padding: const EdgeInsets.only(left: 180.0),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _title = doc["title"];
                                    _description = doc["description"];
                                    _reference = doc["reference"].toString();
                                    _hTitle = doc["h_title"];
                                    _hDescription = doc["h_description"].toString();
                                    _hReference = doc["h_reference"].toString();
                                    _uploadedFileURL = doc["img_url_1"];
                                    _editImgURL = doc["img_url_1"];
                                    docIdToUpdate = doc.documentID;
                                    isUpdate = true;
                                    navigateToRR();
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
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

              onTap:() {
                debugPrint("ListTile Tapped");
                _title = doc["title"];
                _description = doc["description"];
                _reference = doc["reference"].toString();
                _hTitle = doc["h_title"];
                _hDescription = doc["h_description"].toString();
                _hReference = doc["h_reference"].toString();
                _uploadedFileURL = doc["img_url_1"];
                _editImgURL = doc["img_url_1"];
                docIdToUpdate = doc.documentID;
                isUpdate = true;
                navigateToRR();
              },),
          ),
        ),
//          (doc) => Card(
//            elevation: 8.0,
//            shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(10.0)),
//            color: Colors.white,
//            child: new ListTile(
////              contentPadding:
////                  EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
//              leading: Container(
//                padding: EdgeInsets.only(right: 6.0),
//                decoration: new BoxDecoration(
//                    border: new Border(
//                        right:
//                            new BorderSide(width: 1.0, color: Colors.black26))),
//                child: SizedBox(
//                  width: 60,
//                  height: 60,
//                  child: (doc["img_url_1"] != null)
//                      ? Image.network(
//                          doc["img_url_1"],
//                          fit: BoxFit.fill,
//                        )
//                      : Image.network(
//                          " https://firebasestorage.googleapis.com/v0/b/lakhimpur-kheri-9307b.appspot.com/o/offers%2Fimage_picker4740279598125528080.jpg%7D?alt=media&token=f7a1af65-07d5-4e22-82b5-12a3907487dd",
//                          fit: BoxFit.fill,
//                        ),
//                ),
//              ),
//              title: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceAround,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Expanded(
//                      child: new Text(doc["title"],
//                          style: new TextStyle(
//                              color: Colors.black54,
//                              fontWeight: FontWeight.w700,
//                              fontSize: 15)),
//                    ),
//                  ]),
//              dense: true,
//              subtitle: Column(
//                  mainAxisAlignment: MainAxisAlignment.spaceAround,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    new Text(doc["description"],
//                        style: new TextStyle(
//                            fontSize: 15.0,
//                            fontWeight: FontWeight.bold,
//                            color: Colors.black54)),
//                    new Text(doc["reference"].toString()),
//                    new Text(doc["h_title"].toString()),
//                    new Text(doc["h_description"]),
//                    new Text(doc["h_reference"]),
//                  ]),
//              onTap: () {
//                debugPrint("ListTile Tapped");
//                _title = doc["title"];
//                _description = doc["description"];
//                _reference = doc["reference"].toString();
//                _hTitle = doc["h_title"];
//                _hDescription = doc["h_description"].toString();
//                _hReference = doc["h_reference"].toString();
//                _uploadedFileURL = doc["img_url_1"];
//                _editImgURL = doc["img_url_1"];
//                docIdToUpdate = doc.documentID;
//                isUpdate = true;
//                navigateToRR();
//              },
//              trailing: Container(
//                width: 100,
//                child: Row(
//                  children: <Widget>[
//                    IconButton(
//                      onPressed: () {
//                        setState(() {
//                          _title = doc["title"];
//                          _description = doc["description"];
//                          _reference = doc["reference"].toString();
//                          _hTitle = doc["h_title"];
//                          _hDescription = doc["h_description"].toString();
//                          _hReference = doc["h_reference"].toString();
//                          _uploadedFileURL = doc["img_url_1"];
//                          _editImgURL = doc["img_url_1"];
//                          docIdToUpdate = doc.documentID;
//                          isUpdate = true;
//                          navigateToRR();
//                        });
//                      },
//                      icon: Icon(
//                        Icons.edit,
//                        color: Colors.blue,
//                      ),
//                    ),
//                    IconButton(
//                      onPressed: () {
//                        deleteStudent(doc);
//                      },
//                      icon: Icon(
//                        Icons.delete,
//                        color: Colors.red,
//                      ),
//                    )
//                  ],
//                ),
//              ),
//            ),
//          ),
        )
        .toList();
  }

  void navigateToRR() async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return OffersEditDashboard(
          _title,
          _description,
          _reference,
          _hTitle,
          _hDescription,
          _hReference,
          _uploadedFileURL,
          _editImgURL,
          docIdToUpdate,
          isUpdate);
    }));
  }
}
