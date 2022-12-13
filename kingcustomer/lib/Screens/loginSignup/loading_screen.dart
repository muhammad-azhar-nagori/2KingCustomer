// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kingcustomer/providers/current_user_provider.dart';
import 'package:provider/provider.dart';
import '../../providers/worker_provider.dart';
import '../Dashboard/dashboard.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    try {
      loadData();
    } catch (e) {
      print("cannot load data");
    }
    super.initState();
  }

  loadData() async {
    await Future.delayed(const Duration(milliseconds: 0)).then((value) async {
      try {
        final currentUserProvider =
            Provider.of<CurrentUserProvider>(context, listen: false);
        currentUserProvider
            .fetch(FirebaseAuth.instance.currentUser!.uid.trim());
      } catch (e) {
        print(e);
      }
      try {
        final workersProvider =
            Provider.of<WorkerProvider>(context, listen: false);
        workersProvider.fetch();
      } catch (e) {
        print(e);
      }

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Dashboard()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child:
            Image.asset('assets/images/logo-black-full.png', fit: BoxFit.fill),
      ),
    );
  }
}
