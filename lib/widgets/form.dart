// ignore_for_file: prefer_const_constructors, unnecessary_nullable_for_final_variable_declarations, use_key_in_widget_constructors, library_private_types_in_public_api, unused_import
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(
    home: MyFormPage(),
  ));
}

class MyFormPage extends StatefulWidget {
  @override
  _MyFormPageState createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  String? selectedYear;
  String? selectedSemester;
  String? selectedSubject;

  List<String> years = ['First Year', 'Second Year', 'Third Year'];

  Map<String, List<String>> semesterOptions = {
    'First Year': ['Sem 1', 'Sem 2'],
    'Second Year': ['Sem 3', 'Sem 4'],
    'Third Year': ['Sem 5', 'Sem 6'],
  };

  Map<String, List<String>> subjectOptions = {
    'Sem 1': ['Sem 1 Subject 1', 'Sem 1 Subject 2', 'Sem 1 Subject 3', 'Sem 1 Subject 4', 'Sem 1 Subject 5'],
    'Sem 2': ['Sem 2 Subject 1', 'Sem 2 Subject 2', 'Sem 2 Subject 3', 'Sem 2 Subject 4', 'Sem 2 Subject 5'],
    'Sem 3': ['Sem 3 Subject 1', 'Sem 3 Subject 2', 'Sem 3 Subject 3', 'Sem 3 Subject 4', 'Sem 3 Subject 5'],
    'Sem 4': ['Sem 4 Subject 1', 'Sem 4 Subject 2', 'Sem 4 Subject 3', 'Sem 4 Subject 4', 'Sem 4 Subject 5'],
    'Sem 5': ['Sem 5 Subject 1', 'Sem 5 Subject 2', 'Sem 5 Subject 3', 'Sem 5 Subject 4', 'Sem 5 Subject 5'],
    'Sem 6': ['Sem 6 Subject 1', 'Sem 6 Subject 2', 'Sem 6 Subject 3', 'Sem 6 Subject 4', 'Sem 6 Subject 5'],
  };

  final ImagePicker _imagePicker = ImagePicker();
  List<XFile>? _imageList;

  Future<void> _openCamera() async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _imageList = [image];
      });
    }
  }

  Future<void> _openGallery() async {
    final List<XFile>? images = await _imagePicker.pickMultiImage();
    if (images != null) {
      setState(() {
        _imageList = images;
      });
    }
  }

  bool isAllDropdownSelected() {
    return selectedYear != null && selectedSemester != null && selectedSubject != null;
  }

  Future<void> _submitPhotos() async {
    if (_imageList == null || _imageList!.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please select at least one photo.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    // Perform face detection and recognition with the selected photos and send to server
    // Write your code here to process the images and communicate with the server

    // Clear the selected images after submission
    setState(() {
      _imageList = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Choose a Year:',
                style: TextStyle(fontSize: 18.0),
              ),
              DropdownButtonFormField<String>(
                value: selectedYear,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedYear = newValue;
                    selectedSemester = null;
                    selectedSubject = null;
                  });
                },
                items: years.map((String year) {
                  return DropdownMenuItem<String>(
                    value: year,
                    child: Text(year),
                  );
                }).toList(),
              ),
              SizedBox(height: 20.0),
              if (selectedYear != null)
                Column(
                  children: [
                    Text(
                      'Choose a Semester:',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedSemester,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedSemester = newValue;
                          selectedSubject = null;
                        });
                      },
                      items: semesterOptions[selectedYear]!.map((String semester) {
                        return DropdownMenuItem<String>(
                          value: semester,
                          child: Text(semester),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              SizedBox(height: 20.0),
              if (selectedSemester != null)
                Column(
                  children: [
                    Text(
                      'Choose a Subject:',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedSubject,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedSubject = newValue;
                        });
                      },
                      items: subjectOptions[selectedSemester]!.map((String subject) {
                        return DropdownMenuItem<String>(
                          value: subject,
                          child: Text(subject),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              SizedBox(height: 20.0),
              if (isAllDropdownSelected())
                Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: _openCamera,
                      icon: Icon(Icons.camera),
                      label: Text('Take Photo'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(150, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton.icon(
                      onPressed: _openGallery,
                      icon: Icon(Icons.photo_library),
                      label: Text('Select Photos'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(150, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    if (_imageList != null)
                      Column(
                        children: _imageList!.map((XFile image) {
                          return Container(
                            width: 200.0,
                            height: 200.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(File(image.path)),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: _submitPhotos,
                      child: Text('Submit'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
