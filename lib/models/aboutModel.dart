class AboutYourModel {
  final bool isLeader;
  final List skills;
  final String uid;
  final String objective;
  final String link;

  const AboutYourModel({
    required this.isLeader,
    required this.skills,
    required this.uid,
    required this.objective,
    required this.link,
  });

  static AboutYourModel fromSnap(snap) {
    //converting jason from firebase in snap  to User form feilds
    var snapshot = snap.data() as Map<String, dynamic>;
    // debugPrint(snapshot.toString());

    return AboutYourModel(
      isLeader: snapshot["isLeader"],
      skills: snapshot["skills"],
      uid: snapshot["uid"],
      objective: snapshot["objective"],
      link: snapshot["link"],
    );
  }

//file for converting user fields to json for uplodaing on firebase
  Map<String, dynamic> toJson() => {
        "isLeader": isLeader,
        "skills": skills,
        "uid": uid,
        "objective": objective,
        "link": link,
      };
}
