import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'AddPost.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final ref = FirebaseDatabase.instance.ref("Post");
  TextEditingController SearchController = TextEditingController();

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
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              onChanged: (value) {},
              controller: SearchController,
              decoration: const InputDecoration(
                  hintText: "Search",
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder()),
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                defaultChild: const Text("Loading"),
                itemBuilder: (context, snapshot, animation, index) {
                  final title = snapshot.child("Title").value.toString();

                  if (SearchController.text.isEmpty) {
                    return ListTile(
                      title: Text(snapshot.child("Title").value.toString()),
                      subtitle: Text(snapshot.child("id").value.toString()),
                    );
                  } else if (title.toLowerCase().contains(
                      SearchController.text.toLowerCase().toLowerCase())) {
                    return ListTile(
                      title: Text(snapshot.child("Title").value.toString()),
                      subtitle: Text(snapshot.child("id").value.toString()),
                    );
                  } else {
                    Container();
                  }
                  return Container();
                }),
          ),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: 20,
          //     shrinkWrap: true,
          //     primary: false,
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         title: Text(ref.child("Title").toString()),
          //         subtitle: Text(ref.child("id").toString()),
          //       );
          //     },
          //   ),
          // )
        ],
      ),
    );
  }

  Future<dynamic> assigingData() async {}
}
