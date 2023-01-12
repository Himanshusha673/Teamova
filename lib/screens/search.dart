import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_builder/screens/profile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../utils/constant.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Form(
          child: TextFormField(
            controller: searchController,
            decoration:
                const InputDecoration(labelText: 'Search for a user...'),
            onFieldSubmitted: (String _) {
              setState(() {
                isShowUsers = true;
              });
              print(_);
            },
          ),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       // method to show the search bar
        //       showSearch(
        //           context: context,
        //           // delegate to customize the search bar
        //           delegate: CustomSearchDelegate());
        //     },
        //     icon: const Icon(Icons.search),
        //   )
        // ],
      ),
      body: isShowUsers
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  // we search a user by their username in fiekds of user
                  .collection('users')
                  // where used to search a user name which name is
                  //eqaul or greater than this search controller textfeild
                  //which is present in the all the documents

                  .where("name", isGreaterThanOrEqualTo: searchController.text)
                  .orderBy("name")
                  .get(),
              builder: (context, snapshot) {
                // if snap shot has no data
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                // means have any data
                return ListView.builder(
                  // below line is same as querysnapshot , we can also use it oin our strwemabuilder
                  itemCount: (snapshot.data! as dynamic)
                      .docs
                      .length, // calculating teh length of
                  //the document whcih specify the given condition of future
                  itemBuilder: (context, index) {
                    // below --> how Ui will look like if it matches with username or greater
                    //than, then we need profile pic and some stuufs to show into our ui
                    return InkWell(
                      // after clinking it move onto profile page
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(
                            uid: (snapshot.data! as dynamic).docs[index]['uid'],
                          ),
                        ),
                      ),
                      /////////////////////////////
                      /////ui after search appear
                      //////////////////////////
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            (snapshot.data! as dynamic).docs[index]['photoUrl'],
                          ),
                          radius: 16,
                        ),
                        title: Text(
                          (snapshot.data! as dynamic).docs[index]['name'],
                        ),
                      ),
                    );
                  },
                );
              },
            )
          : FutureBuilder(
              // future and streams will take he query snapshot<map> type
              future: FirebaseFirestore.instance
                  .collection('posts')
                  .orderBy('datePublished')
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return StaggeredGridView.countBuilder(
                  crossAxisCount: 3,
                  // counting all the indexes of doc
                  // note : there is no any condition given int his future builder
                  //it is pure new future buider part after search tile
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) => Image.network(
                    (snapshot.data! as dynamic).docs[index]['postUrl'],
                    fit: BoxFit.cover,
                  ),
                  staggeredTileBuilder: (index) =>
                      MediaQuery.of(context).size.width > webScreenSize
                          // for web
                          ? StaggeredTile.count(
                              // crossaxis count
                              (index % 7 == 0) ? 1 : 1,
                              // main axisxcount
                              (index % 7 == 0) ? 1 : 1)
                          // fir mobile
                          : StaggeredTile.count((index % 7 == 0) ? 2 : 1,
                              (index % 7 == 0) ? 2 : 1),
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                );
              },
            ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
// Demo list to show querying
  List<String> searchTerms = [
    "Apple",
    "Banana",
    "Mango",
    "Pear",
    "Watermelons",
    "Blueberries",
    "Pineapples",
    "Strawberries"
  ];

// first overwrite to
// clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var toSearchTarget in searchTerms) {
      if (toSearchTarget.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(toSearchTarget);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var toSearchTarget in searchTerms) {
      if (toSearchTarget.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(toSearchTarget);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}
