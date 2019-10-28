import 'package:cloud_firestore/cloud_firestore.dart';
import 'Product.dart';
dynamic getFirebase(){
  return Firestore.instance.collection('featured').snapshots().toList();
}