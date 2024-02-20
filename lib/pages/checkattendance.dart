import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// void main() {
//   runApp(MyApp());
// }

class CheckAttendance extends StatelessWidget {
  @override
Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Student Information'),
        ),
        body: FutureBuilder(
          // Replace 'fetchData()' with the actual function that fetches your data
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<Map<String, dynamic>>? studentData = snapshot.data;
              return studentData != null
                  ? ListView.builder(
                      itemCount: studentData.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text('Name: ${studentData[index]['Name']}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Roll no: ${studentData[index]['Roll no']}'),
                                Text('Date: ${studentData[index].keys.elementAt(2)}'),
                                Text('Status: ${studentData[index][studentData[index].keys.elementAt(2)] == 1 ? 'Present' : 'Absent'}'),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Container();
            }
          },
        ),
      ),
    );
  }


Future<List<Map<String, dynamic>>> fetchData() async {
    final response =
        await http.get(Uri.parse('http://100.112.247.145:8000/api/records/'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load data');
    }
  }
}