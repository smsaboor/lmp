import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/widgets.dart' as prefix1;
import 'package:image_picker/image_picker.dart';
import 'package:lakhimpur_kheri/screens/dashboard/offerEdit.dart';
import 'package:lakhimpur_kheri/screens/offers/offerEdit.dart';
import 'package:path/path.dart' as Path;
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:core';
import 'package:flutter/widgets.dart';
import 'package:lakhimpur_kheri/localisation/localization_two/app_translations.dart';
import 'package:lakhimpur_kheri/localisation/localization_two/application.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Offers extends StatefulWidget {
  final SharedPreferences prefs;
  Offers({this.prefs});
  @override
  _OffersState createState() => _OffersState(prefs: prefs);
}

class _OffersState extends State<Offers> {
  final SharedPreferences prefs;
  _OffersState({this.prefs});
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
        title: Text(AppTranslations.of(context).text("key_offers_title"),),
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
                  if (snapshot.connectionState ==
                      ConnectionState.done)
                    return Expanded(
                    child: new ListView(
                      children: generateStudentList(snapshot),
                    ));
                  if (snapshot.hasData)
                    return Expanded(
                        child: new ListView(
                          children: generateStudentList(snapshot),
                        ));
                  if (snapshot.connectionState ==
                      ConnectionState.waiting)
                    return Container(
                        child: CircularProgressIndicator());
                  if (!snapshot.hasData) return new Text(AppTranslations.of(context).text("key_offers_noData"));
                  return Container(
                    child:Text(AppTranslations.of(context).text("key_offers_somethingWrong"),),
                  );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.green,
          icon: Icon(Icons.add),
          label: Text(AppTranslations.of(context).text("key_offers_button_float"),),
          onPressed: () {
            Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (_) => OffersEdit(widget.prefs.getString("email"),
                      '', '', '', '', '', '', false)),
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
                          color: Colors.red,
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
//                      Positioned(
//                        bottom: 20.0,
//                        right: 10.0,
//                        child: Container(
//                          padding: EdgeInsets.all(10.0),
//                          color: Colors.white,
//                          child: Text("\$40"),
//                        ),
//                      )
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),),
        ),
      ),
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
