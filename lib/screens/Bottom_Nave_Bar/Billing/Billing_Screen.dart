import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pro/screens/Auth/bloc/auth_bloc.dart';
import 'package:new_pro/screens/Auth/bloc/auth_state.dart';
import 'package:new_pro/screens/Bottom_Nave_Bar/Billing/bloc/bill_bloc.dart';
import 'package:new_pro/screens/Bottom_Nave_Bar/Billing/bloc/bill_event.dart';
import 'package:new_pro/screens/Bottom_Nave_Bar/Billing/bloc/bill_state.dart';
import 'package:new_pro/screens/Models/Users_Bill_Model/User_Bill_Model.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BillingBloc>().add(LoadBillingRecords());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Water Bill Estimation')),
      body: BlocBuilder<BillingBloc, BillingState>(
        builder: (context, state) {
          if (state is BillingLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BillingLoaded) {
            final records = state.records;
            if (records.isEmpty) {
              return const Center(child: Text('No billing records found.'));
            }
            return ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                final record = records[index];
                return Dismissible(
                  key: Key(record.id),
                  background: _updateBackground(),
                  secondaryBackground: _deleteBackground(),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      _showUpdateDialog(context, record);
                      return false; // Don't dismiss, just update
                    } else {
                      context.read<BillingBloc>().add(
                        DeleteBillingRecord(record.id),
                      );
                      return true;
                    }
                  },
                  child: ListTile(
                    title: Text('Usage: ${record.usageLiters} Liters'),
                    subtitle: Text(
                      'Estimated Bill: PKR ${record.estimatedBill}',
                    ),
                    trailing: Text('${record.timestamp.toLocal()}'),
                  ),
                );
              },
            );
          } else if (state is BillingError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('Please wait...'));
        },
      ),
      floatingActionButton: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          if (authState is AuthSuccess) {
            final user = authState.User;
            return FloatingActionButton(
              onPressed: () {
                _showAddDialog(context, user.uid); // Pass user ID to the dialog
              },
              child: const Icon(Icons.add),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  /// Swipe update background
  Widget _updateBackground() => Container(
    color: Colors.blue,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.only(left: 20),
    child: const Icon(Icons.edit, color: Colors.white),
  );

  /// Swipe delete background
  Widget _deleteBackground() => Container(
    color: Colors.red,
    alignment: Alignment.centerRight,
    padding: const EdgeInsets.only(right: 20),
    child: const Icon(Icons.delete, color: Colors.white),
  );

  /// Show update dialog
  void _showUpdateDialog(BuildContext context, BillingRecord record) {
    final usageController = TextEditingController(
      text: record.usageLiters.toString(),
    );
    final billController = TextEditingController(
      text: record.estimatedBill.toString(),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Update Billing Record"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: usageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Usage (Liters)"),
              ),
              TextField(
                controller: billController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Estimated Bill (PKR)",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // cancel
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final updatedRecord = BillingRecord(
                  id: record.id,
                  usageLiters: double.parse(usageController.text),
                  estimatedBill: double.parse(billController.text),
                  timestamp: DateTime.now(),
                  UserId: record.UserId,
                );
                context.read<BillingBloc>().add(
                  UpdateBillingRecord(updatedRecord),
                );
                Navigator.pop(context);
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }
}

/// Show update dialog
void _showAddDialog(BuildContext context, String userId) {
  final usageController = TextEditingController();
  final billController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Add Billing Record"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: usageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Usage (Liters)"),
            ),
            TextField(
              controller: billController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Estimated Bill (PKR)",
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              final usage = double.tryParse(usageController.text);
              final bill = double.tryParse(billController.text);

              if (usage == null || bill == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Enter valid numbers")),
                );
                return;
              }

              final newRecord = BillingRecord(
                id: '',
                usageLiters: usage,
                estimatedBill: bill,
                timestamp: DateTime.now(),
                UserId: userId,
              );

              context.read<BillingBloc>().add(AddBillingRecord(newRecord));
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      );
    },
  );
}
