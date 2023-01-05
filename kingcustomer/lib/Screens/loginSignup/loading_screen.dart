// ignore_for_file: empty_catches

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../providers/agreement_provider.dart';
import '../../providers/chat_provider.dart';
import '../../providers/inventory_provider.dart';
import '../../providers/message_provider.dart';
import '../../providers/service_log_provider.dart';
import '../../providers/order_provider.dart';
import '../../providers/story_provider.dart';
import '../Dashboard/dashboard.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key, this.userID}) : super(key: key);
  final String? userID;
  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
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
        final ordersProvider =
            Provider.of<OrdersProvider>(context, listen: false);
        await ordersProvider.fetch();
        Provider.of<ServiceLogsProvider>(context, listen: false);

        Provider.of<InventoryProvider>(context, listen: false);
      } catch (e) {}

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
