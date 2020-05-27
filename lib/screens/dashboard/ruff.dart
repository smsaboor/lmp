//import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'dart:io';
//import 'package:firebase_storage/firebase_storage.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/material.dart' as prefix0;
//import 'package:image_picker/image_picker.dart';
//import 'package:lakhimpur_kheri/dashboard/offerEdit.dart';
//import 'package:path/path.dart' as Path;
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
//
//class OffersDashboard extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      theme: ThemeData(primaryColor: Colors.green),
//      home: FirebaseCRUDPage(title: 'Firestore CRUD'),
//    );
//  }
//}
//
//class FirebaseCRUDPage extends StatefulWidget {
//  FirebaseCRUDPage({Key key, this.title}) : super(key: key);
//  final String title;
//
//  @override
//  _FirebaseCRUDPageState createState() => _FirebaseCRUDPageState();
//}
//
//class _FirebaseCRUDPageState extends State<FirebaseCRUDPage> {
//  File _image;
//  var _imgURL;
//  String _uploadedFileURL;
//  final db = Firestore.instance;
//  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
//  String _title;
//  String _description;
//  String _reference;
//  String _hTitle;
//  String _hDescription;
//  String _hReference;
//  bool isUpdate = false;
//  String docIdToUpdate;
//  String _editImgURL;
//  final _titleController = TextEditingController();
//  final _descriptionController = TextEditingController();
//  final _referenceController = TextEditingController();
//  final _hTitleController = TextEditingController();
//  final _hDescriptionController = TextEditingController();
//  final _hReferenceController = TextEditingController();
//  final _uploadedFileURLController = TextEditingController();
//
//  clearForm() {
//    setState(() {
//      isUpdate = false;
//      docIdToUpdate = null;
//      _titleController.text = "";
//      _descriptionController.text = "";
//      _referenceController.text = "";
//      _hTitleController.text = "";
//      _hDescriptionController.text = "";
//      _hReferenceController.text = "";
//      _uploadedFileURLController.text = "";
//    });
//  }
//
//  Future getImage() async {
//    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//    setState(() {
//      _image = image;
//      print('Image Path $_image');
//    });
//    uploadPic();
//  }
//
//  Future uploadPic() async {
////    String fileName = basename(_image.path);
//    StorageReference ref = FirebaseStorage.instance
//        .ref()
//        .child('offers/${Path.basename(_image.path)}}');
//    StorageUploadTask uploadTask = ref.putFile(_image);
//
//    var downURL = await (await uploadTask.onComplete).ref.getDownloadURL();
//    var url = downURL.toString();
//    print("Download URl: $url");
////    StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
//    setState(() {
//      debugPrint("Set State............................ : $url");
//      _imgURL = url;
//      debugPrint("Set State.._imgURL.......................... : $_imgURL");
//      _editImgURL = url;
//      debugPrint(
//          "Set State..._editImgURL......................... : $_editImgURL");
//      print("Profile Picture uploaded");
////      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
//    });
//    return url;
//  }
//
//  Future<void> addStudent() async {
//    await db.collection("offers").add({
//      'title': _title,
//      'description': _description,
//      'reference': _reference,
//      'h_title': _hTitle,
//      'h_description': _hDescription,
//      'h_reference': _hReference,
//      'varified': true,
//      'varified_by': 'me',
//      'email': 'saboor@',
//      'img_url_1': _imgURL,
//    }).then((documentReference) {
//      print(documentReference.documentID);
//      clearForm();
//    }).catchError((e) {
//      print(e);
//    });
//  }
//
//  Future<void> editStudent() async {
//    await db.collection("offers").document(docIdToUpdate).updateData({
//      'title': _title,
//      'description': _description,
//      'reference': _reference,
//      'h_title': _hTitle,
//      'h_description': _hDescription,
//      'h_reference': _hReference,
//      'img_url_1': _editImgURL,
//      'varified': true,
//      'varified_by': 'me',
//      'email': 'saboor@',
//    }).then((documentReference) {
//      clearForm();
//    }).catchError((e) {
//      print(e);
//    });
//  }
//
//  Future<void> deleteStudent(DocumentSnapshot doc) async {
//    db.collection("offers").document(doc.documentID).delete();
//    clearForm();
//  }
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
//      body: Column(
//        children: <Widget>[
//          const Divider(
//            height: 5.0,
//          ),
//          StreamBuilder<QuerySnapshot>(
//            stream: db.collection("offers").snapshots(),
//            builder:
//                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//              if (!snapshot.hasData) return new Text("There is no expense");
//              return Expanded(
//                child: new ListView(
//                  children: generateStudentList(snapshot),
//                ),
//              );
//            },
//          ),
//        ],
//      ),
//    );
//  }
//  generateStudentList(AsyncSnapshot<QuerySnapshot> snapshot) {
//    return snapshot.data.documents
//        .map<Widget>(
//          (doc) => Card(
//        elevation: 6,
//        margin: new EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
//        color: Colors.white,
//        child: new ListTile(
//          contentPadding:
//          EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
//          leading: Container(
//            padding: EdgeInsets.only(right: 6.0),
//            decoration: new BoxDecoration(
//                border: new Border(
//                    right:
//                    new BorderSide(width: 1.0, color: Colors.black26))),
//            child: prefix0.SizedBox(
//              width: 60,
//              height: 60,
//              child: (doc["img_url_1"] != null)
//                  ? Image.network(
//                doc["img_url_1"],
//                fit: BoxFit.fill,
//              )
//                  : Image.network(
//                " https://firebasestorage.googleapis.com/v0/b/lakhimpur-kheri-9307b.appspot.com/o/offers%2Fimage_picker4740279598125528080.jpg%7D?alt=media&token=f7a1af65-07d5-4e22-82b5-12a3907487dd",
//                fit: BoxFit.fill,
//              ),
//            ),
//          ),
//          title: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceAround,
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Expanded(
//                  child: new Text(doc["title"],
//                      style: new TextStyle(
//                          color: Colors.black54,
//                          fontWeight: FontWeight.w700,
//                          fontSize: 15)),
//                ),
//              ]),
//          dense: true,
//          subtitle: Column(
//              mainAxisAlignment: MainAxisAlignment.spaceAround,
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                new Text(doc["description"],
//                    style: new TextStyle(
//                        fontSize: 15.0,
//                        fontWeight: FontWeight.bold,
//                        color: Colors.black54)),
//                new Text(doc["reference"].toString()),
//                new Text(doc["h_title"].toString()),
//                new Text(doc["h_description"]),
//                new Text(doc["h_reference"]),
//              ]),
//          onTap: () {
//            debugPrint("ListTile Tapped");
//          },
//          trailing: Container(
//            width: 100,
//            child: Row(
//              children: <Widget>[
//                IconButton(
//                  onPressed: () {
//                    setState(() {
//                      _titleController.text = doc["title"];
//                      _descriptionController.text = doc["description"];
//                      _referenceController.text =
//                          doc["reference"].toString();
//                      _hTitleController.text = doc["h_title"];
//                      _hDescriptionController.text =
//                          doc["h_description"].toString();
//                      _hReferenceController.text =
//                          doc["h_reference"].toString();
//                      _uploadedFileURLController.text = doc["img_url_1"];
//                      _editImgURL = doc["img_url_1"];
//                      docIdToUpdate = doc.documentID;
//                      isUpdate = true;
//                    });
//                  },
//                  icon: Icon(
//                    Icons.edit,
//                    color: Colors.blue,
//                  ),
//                ),
//                IconButton(
//                  onPressed: () {
//                    deleteStudent(doc);
//                  },
//                  icon: Icon(
//                    Icons.delete,
//                    color: Colors.red,
//                  ),
//                )
//              ],
//            ),
//          ),
//        ),
//      ),
//    )
//        .toList();
//  }
//}
