import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:new_pro/firebase_options.dart';
import 'package:new_pro/screens/Auth/AuthRepository/Auth_Repository.dart';
import 'package:new_pro/screens/Auth/Login_Screen.dart';
import 'package:new_pro/screens/Auth/bloc/auth_bloc.dart';
import 'package:new_pro/screens/Bottom_Nave_Bar/Billing/Bill_Repository/Bill_Rep.dart';
import 'package:new_pro/screens/Bottom_Nave_Bar/Billing/bloc/bill_bloc.dart';
import 'package:new_pro/screens/Bottom_Nave_Bar/Billing/bloc/bill_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  runApp(MyApp(firestore: firestore, auth: auth));
}

class MyApp extends StatelessWidget {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  const MyApp({super.key, required this.firestore, required this.auth});
  @override
  Widget build(BuildContext context) {
    final billingRepository = BillingRepository(firestore, auth);
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => AuthBloc(AuthRepository())),
            BlocProvider<BillingBloc>(
              create:
                  (_) =>
                      BillingBloc(billingRepository)..add(LoadBillingRecords()),
            ),
          ],

          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
              useMaterial3: true,
            ),
            home: const AuthScreen(),
          ),
        );
      },
    );
  }
}
