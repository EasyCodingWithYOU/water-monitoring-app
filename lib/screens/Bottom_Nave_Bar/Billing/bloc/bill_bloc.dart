import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pro/screens/Bottom_Nave_Bar/Billing/Bill_Repository/Bill_Rep.dart';
import 'package:new_pro/screens/Bottom_Nave_Bar/Billing/bloc/bill_event.dart';
import 'package:new_pro/screens/Bottom_Nave_Bar/Billing/bloc/bill_state.dart';
import 'package:new_pro/screens/Models/Users_Bill_Model/User_Bill_Model.dart';

class BillingBloc extends Bloc<BillingEvent, BillingState> {
  final BillingRepository repository;

  BillingBloc(this.repository) : super(BillingInitial()) {
    on<LoadBillingRecords>((event, emit) async {
      emit(BillingLoading());
      try {
        final recordsStream = repository.getBillingRecords();
        await emit.forEach<List<BillingRecord>>(
          recordsStream,
          onData: (records) => BillingLoaded(records),
          onError: (error, stackTrace) => BillingError(error.toString()),
        );
      } catch (e) {
        emit(BillingError(e.toString()));
      }
    });

    on<AddBillingRecord>((event, emit) async {
      try {
        await repository.addBillingRecord(event.record);
      } catch (e) {
        emit(BillingError(e.toString()));
      }
    });

    on<UpdateBillingRecord>((event, emit) async {
      try {
        await repository.updateBillingRecord(event.record);
      } catch (e) {
        emit(BillingError(e.toString()));
      }
    });

    on<DeleteBillingRecord>((event, emit) async {
      try {
        await repository.deleteBillingRecord(event.id);
      } catch (e) {
        emit(BillingError(e.toString()));
      }
    });
  }
}
