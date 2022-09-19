import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController onMindCtrl = TextEditingController();
  bool loading = false;
  final DataBaseRef = FirebaseDatabase.instance.ref("Post");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Post")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              maxLines: 4,
              controller: onMindCtrl,
              decoration: const InputDecoration(
                  hintText: "What is in your mind",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    loading = true;
                  });
                  String id = DateTime.now().microsecondsSinceEpoch.toString();
                  DataBaseRef.child(id).set({
                    "id": id,
                    "no": "03352588084",
                    "Title": onMindCtrl.text
                  }).then((value) {
                    Fluttertoast.showToast(msg: "Post added");
                    setState(() {
                      loading = false;
                    });
                  }).onError((error, stackTrace) {
                    Fluttertoast.showToast(msg: error.toString());
                    setState(() {
                      loading = false;
                    });
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text('Add'))
          ],
        ),
      ),
    );
  }
}
