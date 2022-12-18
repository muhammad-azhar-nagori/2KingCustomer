import 'package:flutter/material.dart';
import 'package:kingcustomer/models/contractor_model.dart';
import 'package:kingcustomer/providers/contractor_provider.dart';
import 'package:provider/provider.dart';
import '../../../../helper/size_configuration.dart';
import '../../../../models/service_model.dart';

import 'worker_list_tile.dart';

class WorkersList extends StatelessWidget {
  const WorkersList({super.key, required this.serviceName});

  final String serviceName;

  @override
  Widget build(BuildContext context) {
    final contractorsProvider = Provider.of<ContractorsProvider>(context);
    contractorsProvider.fetch();
    List<ContractorsModel> contractorsList = contractorsProvider.getList;
    List<ContractorsModel> _contractorsList() {
      List<ContractorsModel> temp = [];
      for (final val in contractorsList) {
        if (val.services!.contains(serviceName)) {
          temp.add(val);
        }
      }
      return temp;
    }
    // List<ContractorsModel> _allHomeService() {
    //   for (int i = 0; i < contractorsList.length; i++) {
    //     if (contractorsList[i].serviceCategroy == true) {
    //       tempList.add(contractorsList[i]);
    //     }
    //   }
    //   return tempList;
    // }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          serviceName,
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: (kToolbarHeight / 100) * 40,
          ),
        ),
        actions: [
          IconButton(
            color: Colors.black,
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
          ),
        ],
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
                height: setHeight(2),
              ),
          scrollDirection: Axis.vertical,
          itemCount: _contractorsList() .length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, int index) => ChangeNotifierProvider.value(
                value: _contractorsList() [index],
                child: WorkerTile(serviceName: serviceName),
              )),
    );
  }
}
