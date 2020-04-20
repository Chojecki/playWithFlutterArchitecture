import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_horses/models/horse_model.dart';
import 'package:my_horses/state_models/horse_list_model.dart';
import 'package:provider/provider.dart';

class AddHorseScreen extends StatefulWidget {
  final bool testImage;
  const AddHorseScreen({Key key, this.testImage = false}) : super(key: key);

  @override
  _AddHorseScreenState createState() => _AddHorseScreenState();
}

class _AddHorseScreenState extends State<AddHorseScreen> {
  String _image;
  final _formKey = GlobalKey<FormState>();
  final _nameEditingController = TextEditingController();
  final _noteEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _image = widget.testImage ? '' : null;
  }

  @override
  void dispose() {
    _nameEditingController.dispose();
    _noteEditingController.dispose();
    super.dispose();
  }

  void getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    final imagePath = image.path;
    setState(() {
      _image = imagePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new Horse"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidate: false,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  key: Key('__nameTextField__'),
                  controller: _nameEditingController,
                  decoration: InputDecoration(hintText: 'Horse name'),
                  style: textTheme.headline,
                  autofocus: true,
                  validator: (val) {
                    return val.trim().isEmpty ? 'empty error' : null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  key: Key('__noteTextField__'),
                  controller: _noteEditingController,
                  style: textTheme.subhead,
                  decoration: InputDecoration(hintText: 'note'),
                  maxLines: 5,
                ),
                SizedBox(height: 20.0),
                _image != null
                    ? Image.file(File(_image))
                    : FlatButton(onPressed: getImage, child: Text('Get Image')),
                SizedBox(height: 20.0),
                MaterialButton(
                  key: Key('__submitFormButton__'),
                  child: _image != null ? Text('Button') : Container(),
                  onPressed: () {
                    if (_formKey.currentState.validate() && _image != null) {
                      Provider.of<HorseListModel>(context, listen: false)
                          .addHorse(Horse(_nameEditingController.text,
                              note: _noteEditingController.text,
                              image: _image));
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
