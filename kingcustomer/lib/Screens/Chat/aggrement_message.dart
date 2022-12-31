import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kingcustomer/helper/size_configuration.dart';
import 'package:kingcustomer/models/agreement_model.dart';
import 'package:kingcustomer/models/contractor_model.dart';
import 'package:kingcustomer/models/customer_model.dart';
import 'package:kingcustomer/providers/customer_provider.dart';
import 'package:kingcustomer/providers/inventory_provider.dart';
import 'package:kingcustomer/providers/order_provider.dart';
import 'package:kingcustomer/providers/service_log_provider.dart';
import 'package:kingcustomer/widgets/mycontainer.dart';
import 'package:provider/provider.dart';
import '../../providers/agreement_provider.dart';

import '../../providers/contractor_provider.dart';

class AgreementMsg extends StatelessWidget {
  const AgreementMsg({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    AgreementProvider agreementProvider =
        Provider.of<AgreementProvider>(context);
    AgreementModel agreementModel = agreementProvider.getAgreementByID(text);
    bool agreementStatus = agreementModel.status!;
    return Padding(
      padding: const EdgeInsets.only(right: 100.0),
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ReceiveAgreement(agreementID: text))),
        child: SizedBox(
          height: setHeight(30),
          width: setWidth(100),
          child: Scaffold(
            body: Container(
              padding: const EdgeInsets.all(10),
              height: setHeight(30),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 123, 178, 214),
                border: Border.all(),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: ReceiveAgreement(
                agreementID: text,
              ),
            ),
            bottomSheet: Container(
              height: setHeight(5),
              color: const Color.fromARGB(255, 123, 178, 214),
              child: Center(
                  child: Text(
                !agreementStatus ? "View" : "Accepted",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
            ),
          ),
        ),
      ),
    );
  }
}

class ReceiveAgreement extends StatelessWidget {
  const ReceiveAgreement({super.key, required this.agreementID});
  final String agreementID;

  @override
  Widget build(BuildContext context) {
    AgreementProvider agreementProvider =
        Provider.of<AgreementProvider>(context);
    AgreementModel agreementModel =
        agreementProvider.getAgreementByID(agreementID);
    OrdersProvider ordersProvider = Provider.of<OrdersProvider>(context);
    ServiceLogsProvider servicelogsProvider =
        Provider.of<ServiceLogsProvider>(context);
    InventoryProvider inventoryProvider =
        Provider.of<InventoryProvider>(context);
    CustomerProvider userProvider = Provider.of<CustomerProvider>(context);
    CustomerModel customerModel =
        userProvider.getUserByID(agreementModel.customerID!);

    ContractorsProvider currentUserProvider =
        Provider.of<ContractorsProvider>(context);
    ContractorsModel contractorModel =
        currentUserProvider.getUserByID(agreementModel.contractorID!);
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              leadingWidth: getProportionateScreenWidth(40),
              leading: Image.asset(
                "assets/images/logo-black-half.png",
                fit: BoxFit.contain,
              ),
              title: const Text(
                "Agreement",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: (kToolbarHeight / 100) * 40,
                ),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: SizedBox(
              height: setHeight(100),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(
                            thickness: 0.4,
                          ),
                          const Center(
                            child: Text(
                              "Customer details",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            softWrap: true,
                            "Name: " + customerModel.name!,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                          Text(
                            softWrap: true,
                            "ID: " + customerModel.userID!,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                          Text(
                            softWrap: true,
                            "CNIC: " + customerModel.cnic!,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                          const Divider(thickness: 0.4),
                          const Center(
                            child: Text(
                              "Contractor details",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(10)),
                          Text(
                            softWrap: true,
                            "Name: " + contractorModel.name!,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                          Text(
                            softWrap: true,
                            "ID: " + contractorModel.userID!,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                          Text(
                            softWrap: true,
                            "CNIC: " + contractorModel.cnic!,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                          const Divider(thickness: 0.4),
                          Text(
                            "Start Date:" + agreementModel.startDate.toString(),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                          Text(
                            "End Date: " + agreementModel.startDate.toString(),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                          const Divider(thickness: 0.4),
                          const Center(
                            child: Text(
                              "Services",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                          const Divider(thickness: 0.4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Name",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 11),
                              ),
                              Text(
                                "Estimated Days",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 11),
                              ),
                              Text(
                                "Estimated Charges",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 11),
                              ),
                            ],
                          ),
                          const Divider(thickness: 0.4),
                          SizedBox(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  agreementModel.services!.toList().length,
                              itemBuilder: (context, int index) => Text(
                                (index + 1).toString() +
                                    ".  " +
                                    agreementModel.services!.elementAt(index),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                            ),
                          ),
                          const Divider(thickness: 0.4),
                          const SizedBox(
                            height: 50,
                            child: Center(
                              child: Text(
                                "Agreement details",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                          ),
                          Text(
                            agreementModel.details!,
                            softWrap: true,
                          ),
                          Visibility(
                            visible: !agreementModel.status!,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 18, 18, 18),
                                    ),
                                    fixedSize: MaterialStateProperty.all(
                                      Size(setWidth(30), setHeight(6)),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Decline",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(255, 255, 210, 32),
                                      )),
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 255, 210, 32),
                                    ),
                                    fixedSize: MaterialStateProperty.all(
                                      Size(setWidth(30), setHeight(6)),
                                    ),
                                  ),
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: ((context) => WillPopScope(
                                            onWillPop: () async => false,
                                            child: const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                          )),
                                    );
                                    try {
                                      final doc = await FirebaseFirestore
                                          .instance
                                          .collection("orders")
                                          .doc(customerModel.userID!)
                                          .collection("logs")
                                          .add({});
                                      await inventoryProvider
                                          .uploadItemDataToFireStore(
                                              itemName: "",
                                              perItem: "",
                                              qty: "",
                                              total: "",
                                              logsID: doc.id,
                                              contractorID:
                                                  contractorModel.userID);
                                      await servicelogsProvider
                                          .uploadItemDataToFireStore(
                                              noOfDays: "",
                                              perDay: "",
                                              serviceName: "",
                                              total: "",
                                              logsID: doc.id,
                                              contractorID:
                                                  contractorModel.userID);
                                      await ordersProvider.uploadData(
                                          contractorID: contractorModel.userID!,
                                          aggrementID: agreementID,
                                          grandTotal: "",
                                          inventoryTotal: "",
                                          logsID: doc.id,
                                          serviceTotal: "",
                                          status: "Pending");
                                      await inventoryProvider
                                          .fetchInventory(doc.id);
                                      await agreementProvider.updateStatus(
                                          agreementID,
                                          true,
                                          contractorModel.userID!);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    } catch (e) {
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        builder: (context) => Center(
                                            child: MyContainer(
                                          height: setHeight(10),
                                          width: setWidth(50),
                                          child: Text("Error Accepting Order " +
                                              e.toString()),
                                        )),
                                      );
                                    }
                                  },
                                  child: const Text("Accept",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black87)),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            )));
  }
}
