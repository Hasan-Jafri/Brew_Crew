import "package:brew__crew/models/brew.dart";
import "package:brew__crew/models/user.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class DataBaseService {
  String uid = "uid";
  DataBaseService({uid}) {
    this.uid = uid;
  }
  //Collection Reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');
  Future UpdateUserData(String name, String sugar, int strength) async {
    return await brewCollection.doc(uid).set({
      'name': name,
      'sugar': sugar,
      'strength': strength,
    });
  }

  //Brew list from snapshot.
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Brew(
          name: data['name'] ?? '',
          strength: data['strength'] ?? 100,
          sugar: data['sugar'] ?? '0');
    }).toList();
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return UserData(
        uid: uid,
        name: data['name'],
        sugars: data['sugar'],
        strength: data['strength']
    );
  }

  //Get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map((_brewListFromSnapshot));
  }

  //Get User doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
