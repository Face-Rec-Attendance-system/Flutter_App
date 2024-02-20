// // ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:file_picker/file_picker.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Classroom App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: ClassroomScreen(),
//     );
//   }
// }

// class ClassroomScreen extends StatefulWidget {
//   const ClassroomScreen({super.key});

//   @override
//   _ClassroomScreenState createState() => _ClassroomScreenState();
// }

// class FileEntry {
//   final String fileName;
//   final String fileUrl;
//   List<String> comments = [];

//   FileEntry(this.fileName, this.fileUrl);
// }

// class _ClassroomScreenState extends State<ClassroomScreen> {
//   List<FileEntry> files = [];
//   TextEditingController commentController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Classroom App'),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: () async {
//               var result = await FilePicker.platform.pickFiles();
//               if (result != null) {
//                 PlatformFile file = result.files.first;
//                 var response = await _uploadFile(file);
//                 if (response != null) {
//                   setState(() {
//                     files.add(FileEntry(response.fileName, response.fileUrl));
//                   });
//                 }
//               }
//             },
//             child: Text('Upload File'),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: files.length,
//               itemBuilder: (context, index) {
//                 return FileItem(files[index], (text) {
//                   _addComment(files[index].fileName, text);
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<FileEntry?> _uploadFile(PlatformFile file) async {
//     var request = http.MultipartRequest(
//       'POST',
//       Uri.parse('https://example.com/upload'), // Replace with your backend URL
//     );
//     request.files.add(
//       http.MultipartFile.fromBytes(
//         'file',
//         file.bytes!,
//         filename: file.name,
//       ),
//     );
//     var streamedResponse = await request.send();
//     if (streamedResponse.statusCode == 200) {
//       var response = await http.Response.fromStream(streamedResponse);
//       if (response.statusCode == 200) {
//         return FileEntry(file.name, response.body); // Assuming the response contains the file URL
//       }
//     }
//     return null;
//   }

//   void _addComment(String fileName, String commentText) {
//     for (var file in files) {
//       if (file.fileName == fileName) {
//         file.comments.add(commentText);
//         setState(() {
//           commentController.clear();
//         });
//         break;
//       }
//     }
//   }
// }

// class FileItem extends StatelessWidget {
//   final FileEntry file;
//   final Function(String) onCommentAdded;

//   FileItem(this.file, this.onCommentAdded, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Column(
//         children: [
//           ListTile(
//             title: Text(file.fileName),
//           ),
//           Image.network(file.fileUrl),
//           Column(
//             children: file.comments.map((comment) {
//               return ListTile(
//                 title: Text(comment),
//               );
//             }).toList(),
//           ),
//           TextField(
//             decoration: const InputDecoration(
//               hintText: 'Add a comment...',
//             ),
//             onSubmitted: onCommentAdded,
//           ),
//         ],
//       ),
//     );
//   }
// }
// notes.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

class ClassroomScreen extends StatefulWidget {
  const ClassroomScreen({super.key});

  @override
  _ClassroomScreenState createState() => _ClassroomScreenState();
}

class FileEntry {
  final String fileName;
  final String fileUrl;
  List<String> comments = [];

  FileEntry(this.fileName, this.fileUrl);
}

class _ClassroomScreenState extends State<ClassroomScreen> {
  List<FileEntry> files = [];
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classroom App'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              var result = await FilePicker.platform.pickFiles();
              if (result != null) {
                PlatformFile file = result.files.first;
                var response = await _uploadFile(file);
                if (response != null) {
                  setState(() {
                    files.add(FileEntry(response.fileName, response.fileUrl));
                  });
                }
              }
            },
            child: Text('Upload File'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                return FileItem(files[index], (text) {
                  _addComment(files[index].fileName, text);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<FileEntry?> _uploadFile(PlatformFile file) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://example.com/upload'), // Replace with your backend URL
    );
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        file.bytes!,
        filename: file.name,
      ),
    );
    var streamedResponse = await request.send();
    if (streamedResponse.statusCode == 200) {
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        return FileEntry(file.name, response.body); // Assuming the response contains the file URL
      }
    }
    return null;
  }

  void _addComment(String fileName, String commentText) {
    for (var file in files) {
      if (file.fileName == fileName) {
        file.comments.add(commentText);
        setState(() {
          commentController.clear();
        });
        break;
      }
    }
  }
}

class FileItem extends StatelessWidget {
  final FileEntry file;
  final Function(String) onCommentAdded;

  FileItem(this.file, this.onCommentAdded, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(file.fileName),
          ),
          Image.network(file.fileUrl),
          Column(
            children: file.comments.map((comment) {
              return ListTile(
                title: Text(comment),
              );
            }).toList(),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Add a comment...',
              ),
              onSubmitted: onCommentAdded,
            ),
          ),
        ],
      ),
    );
  }
}

