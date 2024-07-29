import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class FbCollections {
  static CollectionReference users = db.collection("users");
  static CollectionReference stats = db.collection("stats");
  static CollectionReference projects = db.collection("projects");
  static CollectionReference experiences = db.collection("experiences");
  static CollectionReference awardsAndRecognitions =
      db.collection("awardsAndRecognitions");
  static CollectionReference clientReviews = db.collection("clientReviews");
}
