import 'package:flutter/material.dart';
import 'package:kingcustomer/Screens/orders/Logs/view_inventory_log.dart';
import 'package:kingcustomer/Screens/orders/Logs/view_services_logs.dart';
import 'package:kingcustomer/models/orders_model.dart';
import 'package:provider/provider.dart';
import '../../../helper/size_configuration.dart';
import '../../../providers/inventory_provider.dart';
import '../../../providers/service_log_provider.dart';

class Logs extends StatelessWidget {
  const Logs({
    super.key,
    required this.title,
    required this.ordersModel,
  });
  final String title;
  final OrdersModel ordersModel;

  @override
  Widget build(BuildContext context) {
    ServiceLogsProvider servicelogsProvider =
        Provider.of<ServiceLogsProvider>(context);
    servicelogsProvider.fetchServiceLog(ordersModel.logsID!);
    InventoryProvider inventoryProvider =
        Provider.of<InventoryProvider>(context);
    inventoryProvider.fetchInventory(ordersModel.logsID!);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Logs",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: setWidth(2), vertical: setHeight(0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Divider(
                  thickness: 0.2,
                  color: Colors.black,
                ),
                GestureDetector(
                  child: Column(
                    children: [
                      Text(
                        "Inventory",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: setHeight(4),
                        ),
                      ),
                      const Divider(
                        thickness: 0.2,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: setHeight(33),
                        child: ViewInventoryLogs(ordersModel: ordersModel),
                      ),
                    ],
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                        appBar: AppBar(
                          title: const Text(
                            "Inventory logs",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: (kToolbarHeight / 100) * 50,
                            ),
                          ),
                          centerTitle: true,
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                        ),
                        body: ViewInventoryLogs(
                          ordersModel: ordersModel,
                          tog: true,
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 0,
                  thickness: 0.3,
                  color: Colors.black,
                ),
                GestureDetector(
                  child: Column(
                    children: [
                      Text(
                        "Services ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: setHeight(4),
                        ),
                      ),
                      const Divider(
                        thickness: 0.2,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: setHeight(33),
                        child: ViewServicesLogs(ordersModel: ordersModel),
                      ),
                    ],
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                        appBar: AppBar(
                          title: const Text(
                            "Services logs",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: (kToolbarHeight / 100) * 50,
                            ),
                          ),
                          centerTitle: true,
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                        ),
                        body: ViewServicesLogs(
                          tog: true,
                          ordersModel: ordersModel,
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 0,
                  thickness: 0.3,
                  color: Colors.black,
                ),
                const Divider(
                  thickness: 0.2,
                  color: Colors.black,
                  height: 0,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: BottomAppBar(
          color: Colors.amberAccent,
          child: SizedBox(
            height: setHeight(7),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(getProportionateScreenHeight(8)),
                      height: 50,
                      child: const Text(
                        "Grand Total: ",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(getProportionateScreenHeight(8)),
                      height: 50,
                      child: Text(
                        ordersModel.grandTotal!,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                    const Spacer(),
                    const VerticalDivider(color: Colors.black),
                    Container(
                      padding: EdgeInsets.all(getProportionateScreenHeight(8)),
                      height: 50,
                      child: const Text(
                        "PKR",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
