import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kingcustomer/helper/size_configuration.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../models/contractor_model.dart';
import '../../../providers/contractor_provider.dart';
import '../../../providers/service_provider.dart';
import 'workers/worker_list_tile.dart';

class ConstructionServices extends StatelessWidget {
  const ConstructionServices({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: setHeight(20),
        width: setWidth(100),
        child: const WorkerSlide());
    // SizedBox(
    //   child: GridView.builder(
    //       physics: const NeverScrollableScrollPhysics(),
    //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //         crossAxisCount: 4,
    //         crossAxisSpacing: getProportionateScreenWidth(0),
    //         mainAxisSpacing: getProportionateScreenHeight(0),
    //         mainAxisExtent: getProportionateScreenHeight(120),
    //       ),
    //       shrinkWrap: true,
    //       itemCount: _allHomeService().length,
    //       itemBuilder: (context, int index) => ChangeNotifierProvider.value(
    //             value: _allHomeService()[index],
    //             child: const WorkerSlide(),
    //           )),
    // );
  }
}

class WorkerSlide extends StatelessWidget {
  const WorkerSlide({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.scale,
            alignment: Alignment.center,
            child: const ContractorsList(),
            duration: const Duration(milliseconds: 550),
            inheritTheme: true,
            ctx: context),
      ),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: setHeight(20),
              width: setWidth(100),
              child: const Image(
                image: CachedNetworkImageProvider(
                    "https://firebasestorage.googleapis.com/v0/b/kings-9b7d2.appspot.com/o/images%2Fservices%2Ffullhouse.jpg?alt=media&token=7405a255-1ee4-4f2d-abd7-59b8585768db"),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: getProportionateScreenHeight(10),
                  left: getProportionateScreenHeight(10)),
              child: Text(
                " Full House Consruction",
                style: TextStyle(
                  backgroundColor: Colors.white,
                  color: Color.fromARGB(255, 56, 47, 47),
                  fontWeight: FontWeight.w700,
                  fontSize: getProportionateScreenHeight(26),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContractorsList extends StatelessWidget {
  const ContractorsList({super.key});

  @override
  Widget build(BuildContext context) {
    final contractorsProvider = Provider.of<ContractorsProvider>(context);
    contractorsProvider.fetch();
    final serviceProvider = Provider.of<ServiceProvider>(context);
    final serviceList = serviceProvider.getList;

    List<ContractorsModel> contractorsList = contractorsProvider.getList;
    List<ContractorsModel> _contractorsList() {
      List<ContractorsModel> temp = [];
      for (final val in contractorsList) {
        if (val.services!.length == serviceList.length) {
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
        title: const Text(
          "Full House Contractor",
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: (kToolbarHeight / 100) * 40,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
                height: setHeight(2),
              ),
          scrollDirection: Axis.vertical,
          itemCount: _contractorsList().length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, int index) => ChangeNotifierProvider.value(
                value: _contractorsList()[index],
                child: const WorkerTile(serviceName: "Full House Contractor"),
              )),
    );
  }
}
