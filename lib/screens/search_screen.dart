// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';


// class SearchScreen extends StatefulWidget {
//   const SearchScreen({Key? key}) : super(key: key);

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController searchController = TextEditingController();
//   bool isShowUsers = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: mobileBackgroundColor,
//         title: Form(
//           child: TextFormField(
//             controller: searchController,
//             decoration:
//                 const InputDecoration(labelText: 'Search for a user...'),
//             onFieldSubmitted: (String _) {
//               setState(() {
//                 isShowUsers = true;
//               });
//               print(_);
//             },
//           ),
//         ),
//       ),
//       body: isShowUsers
//           ?
//           //means user sekected the search and searches something
//           // now we need to seacrch that particular profile
//           // future builder used when there is chnage occurs only once  and takes some times
//           // after using future builder chnages not apppear immediately but
//           // in streambuilder it can apppear immediate
//           FutureBuilder(
//               future: FirebaseFirestore.instance
//                   // we search a user by their username in fiekds of user
//                   .collection('users')
//                   // where used to search a user name which name is
//                   //eqaul or greater than this search controller textfeild
//                   //which is present in the all the documents
//                   .where(
//                     'username',
//                     isGreaterThanOrEqualTo: searchController.text,
//                   )
//                   .get(),
//               builder: (context, snapshot) {
//                 // if snap shot has no data
//                 if (!snapshot.hasData) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//                 // means have any data
//                 return ListView.builder(
//                   // below line is same as querysnapshot , we can also use it oin our strwemabuilder
//                   itemCount: (snapshot.data! as dynamic)
//                       .docs
//                       .length, // calculating teh length of
//                   //the document whcih specify the given condition of future
//                   itemBuilder: (context, index) {
//                     // below --> how Ui will look like if it matches with username or greater
//                     //than, then we need profile pic and some stuufs to show into our ui
//                     return InkWell(
//                       // after clinking it move onto profile page
//                       onTap: () => Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => ProfileScreen(
//                             uid: (snapshot.data! as dynamic).docs[index]['uid'],
//                           ),
//                         ),
//                       ),
//                       /////////////////////////////
//                       /////ui after search appear
//                       //////////////////////////
//                       child: ListTile(
//                         leading: CircleAvatar(
//                           backgroundImage: NetworkImage(
//                             (snapshot.data! as dynamic).docs[index]['photoUrl'],
//                           ),
//                           radius: 16,
//                         ),
//                         title: Text(
//                           (snapshot.data! as dynamic).docs[index]['username'],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             )
//           :
//           // means if it is not then we need  to just show the posts images of the users oerder by date
//           FutureBuilder(
//               // future and streams will take he query snapshot<map> type
//               future: FirebaseFirestore.instance
//                   .collection('posts')
//                   .orderBy('datePublished')
//                   .get(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }

//                 return StaggeredGridView.countBuilder(
//                   crossAxisCount: 3,
//                   // counting all the indexes of doc
//                   // note : there is no any condition given int his future builder
//                   //it is pure new future buider part after search tile
//                   itemCount: (snapshot.data! as dynamic).docs.length,
//                   itemBuilder: (context, index) => Image.network(
//                     (snapshot.data! as dynamic).docs[index]['postUrl'],
//                     fit: BoxFit.cover,
//                   ),
//                   staggeredTileBuilder: (index) =>
//                       MediaQuery.of(context).size.width > webScreenSize
//                           // for web
//                           ? StaggeredTile.count(
//                               // crossaxis count
//                               (index % 7 == 0) ? 1 : 1,
//                               // main axisxcount
//                               (index % 7 == 0) ? 1 : 1)
//                           // fir mobile
//                           : StaggeredTile.count((index % 7 == 0) ? 2 : 1,
//                               (index % 7 == 0) ? 2 : 1),
//                   mainAxisSpacing: 8.0,
//                   crossAxisSpacing: 8.0,
//                 );
//               },
//             ),
//     );
//   }
// }
