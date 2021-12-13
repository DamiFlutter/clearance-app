import 'package:cloud_firestore/cloud_firestore.dart';

class Reference {
  CollectionReference category = FirebaseFirestore.instance.collection("Sends");
  CollectionReference sends = FirebaseFirestore.instance.collection('recentactivies');
}
