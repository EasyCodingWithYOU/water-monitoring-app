import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_pro/screens/Models/Users_Bill_Model/User_Bill_Model.dart';

class BillingRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  BillingRepository(this._firestore, this._auth);

  CollectionReference get _userBillingCollection {
    final userId = _auth.currentUser?.uid;
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('billingRecords');
  }

  Future<void> addBillingRecord(BillingRecord record) {
    return _userBillingCollection.add(record.toMap());
  }

  Stream<List<BillingRecord>> getBillingRecords() {
    return _userBillingCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map(
                    (doc) => BillingRecord.fromMap(
                      doc.id,
                      doc.data() as Map<String, dynamic>,
                    ),
                  )
                  .toList(),
        );
  }

  Future<void> updateBillingRecord(BillingRecord record) {
    return _userBillingCollection.doc(record.id).update(record.toMap());
  }

  Future<void> deleteBillingRecord(String id) {
    return _userBillingCollection.doc(id).delete();
  }
}
