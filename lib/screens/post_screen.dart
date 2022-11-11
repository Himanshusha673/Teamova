import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class PostPage extends StatefulWidget {
  const PostPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PostPage> createState() => _postState();
}

class _postState extends State<PostPage> {
  setCamOn(ImageSource source) async {
    try {
      //picking image from camera  and gallery
      XFile? imageXfile = await ImagePicker().pickImage(
        source: source,
        imageQuality: 50,
      );
      if (imageXfile == null) {
        return null;
      }
    } catch (e) {
      debugPrint('error Message is ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Share Post'), backgroundColor: Colors.grey),
        body: SnappingSheet(
          child: Container(
              child: Column(
            children: [
              Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://imgs.search.brave.com/l9toJFYP4qiYHuIQWiz6ruxyIV56P1xwyaV-ybwpYk8/rs:fit:900:900:1/g:ce/aHR0cHM6Ly95dDMu/Z2dwaHQuY29tL2Ev/QUFUWEFKeTAwX05s/cGFvbjVOenBBdzF5/NVNLMEkzRjNSd3po/S2x2S0dRPXM5MDAt/Yy1rLWMweGZmZmZm/ZmZmLW5vLXJqLW1v')
                      //radius: 20,
                      ),
                  SizedBox(width: 15),
                  Text('Username', style: TextStyle())
                ]),
              ),
            ],
          )),
          grabbingHeight: 75,
          // TODO: Add your grabbing widget here,
          grabbing: GrabbingWidget(),
          sheetBelow: SnappingSheetContent(
            draggable: true,
            // childScrollController: listViewController,
            child: Container(
                color: Colors.white,
                child: ListView(children: [
                  IconButton(
                    icon: Icon(Icons.camera, size: 48),
                    onPressed: () {
                      setCamOn(ImageSource.camera);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.image, size: 48),
                    onPressed: () {
                      setCamOn(ImageSource.gallery);
                    },
                  )
                ])),
          ),
        ));
  }
}

class GrabbingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(blurRadius: 25, color: Colors.black.withOpacity(0.2)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            width: 100,
            height: 7,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Container(
            color: Colors.grey[200],
            height: 2,
            margin: EdgeInsets.all(15).copyWith(top: 0, bottom: 0),
          )
        ],
      ),
    );
  }
}
