import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebasetasks/Utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'AddPost.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final ref = FirebaseDatabase.instance.ref("Post");
  TextEditingController SearchController = TextEditingController();
  TextEditingController EditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Screen"),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddPost()),
                );
                utils().toasteMessage("Add Contacts Selected");
              },
              child: const Icon(
                Icons.contact_page,
                color: Colors.white,
              ),
              label: "Add Contacts",
              backgroundColor: Colors.black),
          SpeedDialChild(
              child: const Icon(
                Icons.meeting_room,
                color: Colors.white,
              ),
              label: "Schecdual meeting",
              backgroundColor: Colors.black),
          SpeedDialChild(
              child: const Icon(
                Icons.light,
                color: Colors.white,
              ),
              label: "To DO s ",
              backgroundColor: Colors.black)
        ],
        // // onPressed: () {
        // //   Navigator.push(
        // //     context,
        // //     MaterialPageRoute(builder: (context) => const AddPost()),
        // //   );
        // },
        // child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              onChanged: (String value) {
                setState(() {});
              },
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
                      trailing: PopupMenuButton(
                        icon: const Icon(Icons.more),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              child: ListTile(
                                onTap: () {
                                  ShowUpdateDia("title",
                                      snapshot.child("id").value.toString());
                                },
                                leading: const Icon(Icons.edit),
                                title: const Text("Edit"),
                              ),
                            ),
                            PopupMenuItem(
                              child: ListTile(
                                onTap: () {
                                  ref
                                      .child(
                                          snapshot.child("id").value.toString())
                                      .remove();
                                },
                                leading: const Icon(Icons.delete),
                                title: const Text("Delete"),
                              ),
                            )
                          ];
                        },
                      ),
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

  Future<void> ShowUpdateDia(String title, String id) {
    EditController.text = title;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add Text to Update"),
            content: Container(
              child: TextFormField(
                controller: EditController,
                decoration: const InputDecoration(
                    hintText: "Add the value", border: OutlineInputBorder()),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    ref.child(id).update({
                      "Title": EditController.text.toLowerCase()
                    }).then((value) {
                      Fluttertoast.showToast(msg: "value updated");
                    }).onError((error, stackTrace) {
                      Fluttertoast.showToast(msg: "Something wrong$error");
                    });
                  },
                  child: const Text("Update"))
            ],
          );
        });
  }
}
