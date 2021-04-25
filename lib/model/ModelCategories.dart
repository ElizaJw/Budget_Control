import 'package:cloud_firestore/cloud_firestore.dart';

class ModelCategories {
  final String tope;
  final String descripcion;
  final DocumentReference reference;

  ModelCategories.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['tope'] != null),
        assert(map['descripcion'] != null),
        tope = map['tope'],
        descripcion = map['descripcion'];

  ModelCategories.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
