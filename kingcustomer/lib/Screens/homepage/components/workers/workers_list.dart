import 'package:flutter/material.dart';
import 'package:kingcustomer/Screens/homepage/components/workers/add_workers.dart';
import 'package:kingcustomer/helper/size_configuration.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../../providers/worker_provider.dart';
import 'worker_list_tile.dart';

class WorkersList extends StatelessWidget {
  const WorkersList({super.key, required this.serviceName});
  final String serviceName;

  @override
  Widget build(BuildContext context) {
    final workerProvider = Provider.of<WorkerProvider>(context);
    final workerList = workerProvider.getWorkerByserviceName(serviceName);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          serviceName,
          style:const  TextStyle(
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
          itemCount: workerList.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, int index) => ChangeNotifierProvider.value(
                value: workerList[index],
                child: WorkerTile(serviceName: serviceName),
              )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.scale,
                alignment: Alignment.bottomRight,
                child: AddWorker(title: serviceName),
                duration: const Duration(milliseconds: 550),
                inheritTheme: true,
                ctx: context),
          );
        },
        tooltip: 'Add Workers',
        child: const Icon(Icons.add),
      ), // This,
    );
  }
}
