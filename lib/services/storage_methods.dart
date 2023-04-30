import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

// just for putting images ans post to our firebase storage
class StorageMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // adding image to firebase storage
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    // creating location to our firebase storage
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
    // wehen it is a post then just add a new folder with each user uid that
    //contains the their respective posts
    if (isPost) {
      // below line is used for generate a random uid
      //means it is a post not a profile picture
      String id = const Uuid().v1();
      // below code is used when it ia a post then we need to
      // just create an another file with this named id
      //posts(folder)->folder(currentUserUid)->child(id ) it is file with this id name
      ref = ref.child(id);
    }

    // putting in uint8list format -> Upload task like a future but not future
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
