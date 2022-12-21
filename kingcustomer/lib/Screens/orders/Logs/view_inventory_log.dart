import 'package:flutter/material.dart';
import 'package:kingcustomer/models/orders_model.dart';
import 'package:kingcustomer/providers/inventory_provider.dart';
import 'package:provider/provider.dart';
import '../../../helper/size_configuration.dart';

class ViewInventoryLogs extends StatelessWidget {
  const ViewInventoryLogs({
    Key? key,
    required this.ordersModel,
    this.tog = false,
  }) : super(key: key);

  final OrdersModel ordersModel;
  final bool? tog;

  @override
  Widget build(BuildContext context) {
    final inventoryProvider = Provider.of<InventoryProvider>(context);
    final inventoryList = inventoryProvider.getInventoryList;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: setHeight(5),
              child: const InventoryTableRow(
                  itemName: "Items",
                  perUnit: "P/Unit",
                  price: "Price",
                  qty: "Qty"),
            ),
            SizedBox(
              height: setHeight(80),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: inventoryList.length,
                itemBuilder: (context, index) => ChangeNotifierProvider.value(
                  value: inventoryList[index],
                  builder: (context, child) => InventoryTableRow(
                      itemName: inventoryList[index].itemName!,
                      perUnit: inventoryList[index].perItem!,
                      price: inventoryList[index].total!,
                      qty: inventoryList[index].qty!),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Visibility(
        visible: tog!,
        child: BottomAppBar(
            child: Container(
          color: Colors.yellow,
          height: setHeight(7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: setHeight(7),
                child: Row(
                  children: [
                    const Divider(
                      thickness: 0.3,
                      color: Colors.black,
                      height: 0,
                    ),
                    Container(
                      padding: EdgeInsets.all(getProportionateScreenHeight(8)),
                      height: 50,
                      child: const Text(
                        "Inventory Total: ",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(getProportionateScreenHeight(8)),
                      height: 50,
                      child: Text(
                        ordersModel.inventoryTotal!,
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
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class InventoryTableRow extends StatelessWidget {
  const InventoryTableRow({
    Key? key,
    required this.itemName,
    required this.qty,
    required this.perUnit,
    required this.price,
  }) : super(key: key);
  final String itemName;
  final String qty;
  final String perUnit;
  final String price;
  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(100),
        1: FixedColumnWidth(50),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            TableCell(
              child: SizedBox(
                height: setHeight(5),
                width: setWidth(40),
                child: Center(
                  child: Text(
                    itemName,
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(20),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            TableCell(
              child: SizedBox(
                height: setHeight(5),
                width: setWidth(10),
                child: Center(
                  child: Text(
                    qty,
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(20),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            TableCell(
              child: SizedBox(
                height: setHeight(5),
                width: setWidth(10),
                child: Center(
                  child: Text(
                    perUnit,
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(20),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            TableCell(
              child: SizedBox(
                height: setHeight(5),
                width: setWidth(10),
                child: Center(
                  child: Text(
                    price,
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(20),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
