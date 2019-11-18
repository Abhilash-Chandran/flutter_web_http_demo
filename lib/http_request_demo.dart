import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpRequestDemo extends StatefulWidget {
  @override
  _HttpRequestDemoState createState() => _HttpRequestDemoState();
}

class _HttpRequestDemoState extends State<HttpRequestDemo> {
  String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Center(
          child: imageUrl == null
              ? Container(
                  child: Container(
                      color: Colors.black,
                      child: Text(
                          'Press the Image Icon below to fetch a new image.')),
                )
              : Image.network(
                  imageUrl,
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width / 3,
                ),
        ),
        FloatingActionButton(
          child: Icon(Icons.photo_size_select_actual),
          onPressed: () {
            fetchData();
          },
        )
      ],
    ));
  }

  fetchData() async {
    final res = await http.get("https://dog.ceo/api/breeds/image/random");

    if (res.statusCode == 200) {
      var v = json.decode(res.body);
      setState(() {
        imageUrl = v['message'];
      });
    }
  }
}
