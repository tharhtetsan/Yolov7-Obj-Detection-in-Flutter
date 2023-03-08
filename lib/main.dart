import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yolov7_flutter/recognition.dart';
import 'classifier.dart';
import 'package:logger/logger.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Classification',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'yolov7 testing'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Classifier _classifier;

  var logger = Logger();

  File? _image;
  final picker = ImagePicker();

  Image? _imageWidget;
  Recognition? _pred_data;
  img.Image? fox;

  @override
  void initState() {
    super.initState();
    _classifier = Classifier();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);
      _imageWidget = Image.file(_image!);

      _predict();
    });
  }

  void _predict() async {
    img.Image imageInput = img.decodeImage(_image!.readAsBytesSync())!;
    List<Recognition> recognition = _classifier.predict(imageInput);

    setState(() {
      this._pred_data = recognition[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yolov7 testing', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: _image == null
                ? Text('gg No image selected.')
                : Container(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height / 2),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: _imageWidget,
                  ),
          ),
          SizedBox(
            height: 36,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            ' ${_pred_data?.id.toString()} : ${_pred_data?.label} : ${_pred_data?.score.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
