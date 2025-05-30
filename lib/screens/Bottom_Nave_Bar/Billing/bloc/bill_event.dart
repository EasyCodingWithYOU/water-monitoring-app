import 'package:equatable/equatable.dart';
import 'package:new_pro/screens/Models/Users_Bill_Model/User_Bill_Model.dart';

abstract class BillingEvent extends Equatable {
  const BillingEvent();

  @override
  List<Object?> get props => [];
}

class LoadBillingRecords extends BillingEvent {}

class AddBillingRecord extends BillingEvent {
  final BillingRecord record;

  const AddBillingRecord(this.record);

  @override
  List<Object?> get props => [record];
}

class UpdateBillingRecord extends BillingEvent {
  final BillingRecord record;

  const UpdateBillingRecord(this.record);

  @override
  List<Object?> get props => [record];
}

class DeleteBillingRecord extends BillingEvent {
  final String id;

  const DeleteBillingRecord(this.id);

  @override
  List<Object?> get props => [id];
}
