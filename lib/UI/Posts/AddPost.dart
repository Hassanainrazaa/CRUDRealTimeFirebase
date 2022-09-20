import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
// for File

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController onMindCtrl = TextEditingController();
  bool loading = false;
  final DataBaseRef = FirebaseDatabase.instance.ref("Post");
  XFile? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = XFile(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
  // XFile? _image;
  // XFile? imagefile;
  // Future getImageCamera() async {
  //   final ImagePicker picker = ImagePicker();
  //   final ImageCam = await picker.pickImage(source: ImageSource.camera);
  //   print(imagefile);
  //   setState(() {
  //     imagefile = File(ImageCam!.path);
  //     _image = ImageCam;
  //   });
  //   //imagefile = File(ImageCam!.path);
  // }

  // Future getImageGallery() async {
  //   final ImagePicker picker = ImagePicker();
  //   final ImageCam = await picker.pickImage(source: ImageSource.gallery);
  //   print(imagefile);
  //   setState(() {
  //     imagefile = File(ImageCam!.path);
  //     _image = ImageCam;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Post")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  pickImage();
                },
                child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.add_a_photo)),
              ),
            ),
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
