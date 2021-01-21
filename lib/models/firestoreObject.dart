abstract class FirestoreObject {
  void fromFirestoreDoc(dynamic doc);
  Map<String, dynamic> asFirestoreData();
}
