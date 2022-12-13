import 'package:flutter/material.dart';
import 'package:kingcustomer/providers/service_log_provider.dart';
import 'package:provider/provider.dart';
import '../../../helper/size_configuration.dart';
import '../../../models/orders_model.dart';
import 'add_service.dart';

class ViewServicesLogs extends StatelessWidget {
  const ViewServicesLogs({
    required this.ordersModel,
    Key? key,
    this.tog = false,
  }) : super(key: key);

  final bool? tog;

  final OrdersModel ordersModel;

  TableRow addTableRow(
    String serviceName,
    String noOfDays,
    String perDay,
    String charges,
  ) {
    return TableRow(
      children: <Widget>[
        TableCell(
          child: SizedBox(
            height: setHeight(5),
            width: setWidth(40),
            child: Center(
              child: Text(
                serviceName,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(20),
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
                noOfDays,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(20),
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
                perDay,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(20),
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
                charges,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(18),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<ServiceLogsProvider>(context);
    final serviceList = serviceProvider.getServicelist;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: setHeight(5),
              child: const ServicesTableRow(
                  serviceName: "Service",
                  perDay: "Per Day",
                  noOfDays: "Total Days",
                  totalCharge: "Charges"),
            ),
            SizedBox(
              height: setHeight(80),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: serviceList.length,
                itemBuilder: (context, index) => ChangeNotifierProvider.value(
                  value: serviceList[index],
                  builder: (context, child) => InkWell(
                    onLongPress: () {},
                    child: ServicesTableRow(
                        serviceName: serviceList[index].serviceName!,
                        perDay: serviceList[index].perDay!,
                        noOfDays: serviceList[index].noOfDays!,
                        totalCharge: serviceList[index].total!),
                  ),
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
          height: setHeight(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: setHeight(7),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(setWidth(40), setHeight(5)),
                        side: const BorderSide(
                          width: 0,
                        ),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => const AddServiceItem());
                      },
                      child: const Text("Add Service")),
                ),
              ),
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
                        "Services Total: ",
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

class ServicesTableRow extends StatelessWidget {
  const ServicesTableRow(
      {Key? key,
      this.serviceName,
      this.noOfDays,
      this.perDay,
      this.totalCharge})
      : super(key: key);
  final String? serviceName;
  final String? noOfDays;
  final String? perDay;
  final String? totalCharge;
  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        1: FixedColumnWidth(50),
        2: FixedColumnWidth(70)
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
                    serviceName!,
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
                    noOfDays!,
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
                    perDay!,
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
                    totalCharge!,
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
