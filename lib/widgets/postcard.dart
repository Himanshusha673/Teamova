// import 'package:flutter/material.dart';
// import 'package:team_builder/utils/colors.dart';

// class PostCard extends StatefulWidget {
//   final String userName;
//   final String userImagePath;
//   final String teamName;
//   final String description;
//   final List<String> postImagesPaths;
//   final List<String> teamLinks;

//   const PostCard({
//     Key? key,
//     required this.userName,
//     required this.userImagePath,
//     required this.teamName,
//     required this.description,
//     this.postImagesPaths = const [],
//     this.teamLinks = const [],
//   }) : super(key: key);

//   @override
//   State<PostCard> createState() => _PostCardState();
// }

// class _PostCardState extends State<PostCard> {
//   @override
//   Widget build(BuildContext context) {
//     Widget getHeader = Container(
//       // margin: EdgeInsets.all(5.0),
//       decoration: const BoxDecoration(
//         color: mainColor,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
//       ),
//       padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               CircleAvatar(
//                 radius: 19,
//                 backgroundImage: NetworkImage(widget.userImagePath),
//               ),
//               const SizedBox(
//                 width: 10.0,
//               ),
//               Text(
//                 widget.userName,
//                 style: const TextStyle(
//                   color: primaryColor,
//                   fontSize: 17.0,
//                 ),
//               ),
//             ],
//           ),
//           Text(
//             widget.teamName,
//             style: const TextStyle(color: primaryColor),
//           ),
//           IconButton(
//             onPressed: (() {}),
//             icon: const Icon(Icons.link_outlined),
//             color: primaryColor,
//           )
//         ],
//       ),
//     );
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.blue, // remove later
//         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//       ),
//       margin: const EdgeInsets.all(10.0),
//       child: Column(
//         children: [
//           getHeader,
//         ],
//       ),
//     );
//   }
// }
