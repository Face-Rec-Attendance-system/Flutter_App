// ignore_for_file: prefer_const_constructors, unnecessary_nullable_for_final_variable_declarations, use_key_in_widget_constructors, library_private_types_in_public_api, unused_import, use_build_context_synchronously, prefer_const_declarations, avoid_print, unused_field, prefer_final_fields
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
   bool _isLoading = false;
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
  List<XFile> _imageList = []; // Initialize as an empty list

  Future<void> _openCamera() async {
    List<XFile> images = []; // Change to non-nullable XFile list
    int maxImages = 3; // Maximum number of images to select

    for (int i = 0; i < maxImages; i++) {
      XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);

      if (image != null) {
        images.add(image);
      } else {
        break; // Exit loop if no image is selected
      }
    }

    setState(() {
      _imageList = images; // Update state with the selected images
    });
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
  try {
    // Show loading screen
    setState(() {
      _isLoading = true;
    });

    for (var image in _imageList!) {
      // Read the image file
      final File file = File(image.path);
      List<int> imageBytes = await file.readAsBytes();

      // Build the multipart request
      final String url = 'http://100.112.247.145:8000/api/upload_image/'; // Replace with your server's endpoint
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Attach the image file as a multipart file
      request.files.add(http.MultipartFile.fromBytes('image', imageBytes, filename: image.path));

      // Add additional attributes to the request
      request.fields['year'] = selectedYear!;
      request.fields['semester'] = selectedSemester!;
      request.fields['subject'] = selectedSubject!;

      // Send the request
      var response = await request.send();

      // Check the response status
      if (response.statusCode == 200) {
        // Image uploaded successfully
        print('Image uploaded successfully');
      } else {
        // Handle the error case
        print('Image upload failed with status code ${response.statusCode}');
      }
    }

    // Clear the selected images after successful submission
    setState(() {
  _imageList = []; // Assign an empty list to clear the selected images
});
    // Hide loading screen
    setState(() {
      _isLoading = false;
    });

    // Show a pop-up message for successful submission
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Image submitted successfully.'),
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
  } catch (e) {
    print('Error uploading image: $e');
    // Hide loading screen
    setState(() {
      _isLoading = false;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Failed to submit image.'),
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
  }
}

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        SingleChildScrollView(
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
        if (_isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: SpinKitFadingCube(
                color: Colors.blue[300],
                size: 50.0,
              ),
            ),
          ),
      ],
    ),
  );
}

}
