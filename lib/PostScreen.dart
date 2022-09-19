import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'AddPost.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final ref = FirebaseDatabase.instance.ref("Post");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Screen"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPost()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Expanded(
          //   child: FirebaseAnimatedList(
          //       query: ref,
          //       defaultChild: const Text("Loading"),
          //       itemBuilder: (context, snapshot, animation, index) {
          //         return ListTile(
          //           title: Text(snapshot.child("Title").value.toString()),
          //           subtitle: Text(snapshot.child("id").value.toString()),
          //         );
          //       }),
          // ),
          TextFormField(
            decoration: const InputDecoration(
                hintText: "Search", border: OutlineInputBorder()),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(ref.child("Title").toString()),
                  subtitle: Text(ref.child("id").toString()),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> assigingData() async {}
}
