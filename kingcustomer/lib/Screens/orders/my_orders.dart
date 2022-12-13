import 'package:flutter/material.dart';
import 'package:kingcustomer/Screens/orders/active_orders.dart';
import 'package:kingcustomer/Screens/orders/pending_orders.dart';
import 'package:kingcustomer/models/orders_model.dart';

import '../../helper/size_configuration.dart';
import 'completed_orders.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders>
    with SingleTickerProviderStateMixin {
  final List<Widget> _tabBarViews = const [
    ActiveOrders(),
    PendingOrders(),
    CompletedOrders(),
  ];
  TabController? _tabController;
  int tabBarIndex = 0;

  @override
  void initState() {
    _tabController = TabController(
      length: _tabBarViews.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  List<OrdersModel> activeOrders(List<OrdersModel> ordersList) {
    return ordersList.where((element) => 'status' == 'Active').toList();
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          leadingWidth: getProportionateScreenWidth(40),
          leading: Image.asset(
            "assets/images/logo-black-half.png",
            fit: BoxFit.contain,
          ),
          title: const Text(
            "My Orders",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          elevation: 1,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          bottom: TabBar(
            indicatorColor: const Color.fromARGB(255, 255, 230, 0),
            controller: _tabController,
            labelColor: const Color.fromARGB(255, 255, 230, 0),
            unselectedLabelColor: Colors.black87,
            tabs: [
              _tabBarOptionWidget(
                  icon: Icons.home_repair_service, label: "Active "),
              _tabBarOptionWidget(
                  icon: Icons.pending_actions, label: "Pending"),
              _tabBarOptionWidget(icon: Icons.done_all, label: "Completed"),
            ],
            onTap: (newTabIndex) {
              setState(() {
                tabBarIndex = newTabIndex;
              });
            },
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: _tabBarViews,
        ),
      ),
    );
  }

  Widget _tabBarOptionWidget(
      {required IconData? icon, required String? label}) {
    return Column(
      children: [
        Icon(icon),
        Text(
          label!,
          style: const TextStyle(fontSize: 15),
        ),
        SizedBox(height: getProportionateScreenHeight(5)),
      ],
    );
  }
}
