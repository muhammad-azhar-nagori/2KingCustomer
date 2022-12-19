// ignore_for_file: empty_catches

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kingcustomer/Screens/loginSignup/login.dart';
import 'package:kingcustomer/providers/agreement_provider.dart';
import 'package:kingcustomer/providers/customer_provider.dart';
import 'package:kingcustomer/providers/inventory_provider.dart';
import 'package:kingcustomer/providers/message_provider.dart';
import 'package:kingcustomer/providers/post_provider.dart';
import 'package:kingcustomer/providers/worker_provider.dart';
import 'package:provider/provider.dart';
import '../../providers/chat_provider.dart';
import '../../providers/current_user_provider.dart';
import '../../providers/service_log_provider.dart';
import '../../providers/order_provider.dart';
import '../../providers/service_provider.dart';
import '../../providers/story_provider.dart';
import '../../providers/contractor_provider.dart';
import '../Dashboard/dashboard.dart';
import '../loginSignup/verify_email.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen({Key? key}) : super(key: key);

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {
  @override
  void initState() {
    try {
      loadData();
    } catch (e) {}
    super.initState();
  }

  loadData() async {
    await Future.delayed(const Duration(milliseconds: 0)).then((value) async {
      try {
        final workersProvider =
            Provider.of<WorkerProvider>(context, listen: false);
        await workersProvider.fetch();
      } catch (e) {}
      final postProvider = Provider.of<PostProvider>(context, listen: false);
      await postProvider.fetch();
      try {
        final userProvider =
            Provider.of<ContractorsProvider>(context, listen: false);
        await userProvider.fetch();
      } catch (e) {}
      try {
        final cProvider = Provider.of<CustomerProvider>(context, listen: false);
        await cProvider.fetch();
      } catch (e) {}

      final serviceProvider =
          Provider.of<ServiceProvider>(context, listen: false);
      await serviceProvider.fetch();
      final ordersProvider =
          Provider.of<OrdersProvider>(context, listen: false);
      await ordersProvider.fetch();
      try {
        final chatProvider = Provider.of<ChatProvider>(context, listen: false);
        await chatProvider.fetch();
      } catch (e) {}
      final storyProvider = Provider.of<StoryProvider>(context, listen: false);
      await storyProvider.fetch();

      try {
        final messageProvider =
            Provider.of<MessageProvider>(context, listen: false);

        await messageProvider.fetch();
      } catch (e) {}
      try {
        final aggrementProvider =
            Provider.of<AgreementProvider>(context, listen: false);

        await aggrementProvider.fetch();
      } catch (e) {}
      try {
        final ordersProvider =
            Provider.of<OrdersProvider>(context, listen: false);
        ordersProvider.fetch();

        Provider.of<ServiceLogsProvider>(context, listen: false);

        Provider.of<InventoryProvider>(context, listen: false);
      } catch (e) {}
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const AuthenticationWrapper()));
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

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        return const Dashboard();
      } else {
        return const VerifyEmail();
      }
    } else {
      return const Login();
    }
  }
}
