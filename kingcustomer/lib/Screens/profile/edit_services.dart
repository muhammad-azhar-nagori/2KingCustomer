import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kingcustomer/models/current_user.dart';
import 'package:provider/provider.dart';

import '../../helper/size_configuration.dart';
import '../../models/service_model.dart';
import '../../providers/current_user_provider.dart';
import '../../providers/service_provider.dart';

class EditServices extends StatelessWidget {
  const EditServices({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          "Edit Services",
          style: TextStyle(
            color: Colors.black,
            fontSize: getProportionateScreenWidth(20),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          const MyServices(),
          const Spacer(),
          Row(
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
                child: const Text("Discard",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 255, 210, 32),
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
                    builder: ((context) =>
                        const Center(child: CircularProgressIndicator())),
                  );
                  final userProvider =
                      Provider.of<CurrentUserProvider>(context, listen: false);
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc("Y1DImckjzK5z2khAEi7o")
                      .collection("contractors")
                      .doc(FirebaseAuth.instance.currentUser!.uid.trim())
                      .update({"services": list});

                  await userProvider.fetch(FirebaseAuth.instance.currentUser!.uid.trim());
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text("Save",
                    style: TextStyle(fontSize: 18, color: Colors.black87)),
              ),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          )
        ],
      ),
    ));
  }
}

class MyServices extends StatefulWidget {
  const MyServices({Key? key}) : super(key: key);

  @override
  State<MyServices> createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServices> {
  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<ServiceProvider>(context);
    final serviceList = serviceProvider.getList;

    List<ServiceModel> _allService() {
      List<ServiceModel> tempList = List<ServiceModel>.generate(
        0,
        (index) => serviceList.first,
      );

      for (int i = 0; i < serviceList.length; i++) {
        tempList.add(serviceList[i]);
      }
      return tempList;
    }

    return SizedBox(
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _allService().length,
          itemBuilder: (context, int index) => ChangeNotifierProvider.value(
                value: _allService()[index],
                child: const ServiceSlide(),
              )),
    );
  }
}

class ServiceSlide extends StatefulWidget {
  const ServiceSlide({
    Key? key,
  }) : super(key: key);

  @override
  State<ServiceSlide> createState() => _ServiceSlideState();
}

class _ServiceSlideState extends State<ServiceSlide> {
  bool isCheck = false;
  bool isCheck1 = true;
  @override
  Widget build(BuildContext context) {
    final serviceModel = Provider.of<ServiceModel>(context);
    final userProvider = Provider.of<CurrentUserProvider>(context);
    CurrentUserModel user = userProvider.getCurrentUser(FirebaseAuth.instance.currentUser!.uid.trim());
    bool initialValue =
        user.services!.contains(serviceModel.serviceName!) ? true : false;
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: getProportionateScreenHeight(70),
            child: Image(
              image: CachedNetworkImageProvider(serviceModel.serviceimageURL!),
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: getProportionateScreenHeight(10),
                left: getProportionateScreenHeight(10)),
            child: Text(
              serviceModel.serviceName!,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: getProportionateScreenHeight(17),
              ),
            ),
          ),
          const Spacer(),
          Checkbox(
            value: isCheck1 ? initialValue : isCheck,
            onChanged: (value) {
              setState(() {
                isCheck = value!;
                isCheck1 = false;
                if (list.contains(serviceModel.serviceName!) == false &&
                    value == true) {
                  list.add(serviceModel.serviceName!);
                } else if (list.contains(serviceModel.serviceName!) == true &&
                    value == false) {
                  list.remove(serviceModel.serviceName!);
                }
              });
            },
          )
        ],
      ),
    );
  }
}

List<String> list = [];
