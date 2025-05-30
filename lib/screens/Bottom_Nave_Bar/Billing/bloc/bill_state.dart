import 'package:equatable/equatable.dart';
import 'package:new_pro/screens/Models/Users_Bill_Model/User_Bill_Model.dart';

abstract class BillingState extends Equatable {
  const BillingState();

  @override
  List<Object?> get props => [];
}

class BillingInitial extends BillingState {}

class BillingLoading extends BillingState {}

class BillingLoaded extends BillingState {
  final List<BillingRecord> records;

  const BillingLoaded(this.records);

  @override
  List<Object?> get props => [records];
}

class BillingError extends BillingState {
  final String message;

  const BillingError(this.message);

  @override
  List<Object?> get props => [message];
}
