import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BillingRecord extends Equatable {
  final String id;
  final String UserId;
  final double usageLiters;
  final double estimatedBill;
  final DateTime timestamp;

  const BillingRecord({
    required this.UserId,
    required this.id,
    required this.usageLiters,
    required this.estimatedBill,
    required this.timestamp,
  });

  factory BillingRecord.fromMap(String id, Map<String, dynamic> data) {
    return BillingRecord(
      UserId: data['UserId'],
      id: id,
      usageLiters: data['usageLiters'],
      estimatedBill: data['estimatedBill'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'UserId': UserId,
      'usageLiters': usageLiters,
      'estimatedBill': estimatedBill,
      'timestamp': timestamp,
    };
  }

  @override
  List<Object?> get props => [
    id,
    usageLiters,
    estimatedBill,
    timestamp,
    UserId,
  ];
}
