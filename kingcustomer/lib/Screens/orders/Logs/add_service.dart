// import 'package:flutter/material.dart';
// import 'package:kingcustomer/Screens/loginSignup/mytextfield.dart';
// import 'package:kingcustomer/providers/service_log_provider.dart';
// import 'package:provider/provider.dart';
// import '../../../helper/size_configuration.dart';

// class AddServiceItem extends StatefulWidget {
//   const AddServiceItem({
//     Key? key,
//   }) : super(key: key);
//   @override
//   State<AddServiceItem> createState() => _AddItemState();
// }

// class _AddItemState extends State<AddServiceItem> {
//   final TextEditingController nameController = TextEditingController();

//   final TextEditingController daysController = TextEditingController();

//   final TextEditingController priceController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final serviceProvider = Provider.of<ServiceLogsProvider>(context);

//     bool _isButtonDisabled = nameController.text.isNotEmpty &&
//         daysController.text.isNotEmpty &&
//         priceController.text.isNotEmpty;
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           leadingWidth: getProportionateScreenWidth(40),
//           leading: Image.asset(
//             "assets/images/logo-black-half.png",
//             fit: BoxFit.contain,
//           ),
//           title: const Text(
//             "Add Item",
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 20,
//             ),
//           ),
//           centerTitle: true,
//           elevation: 1,
//           backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SizedBox(
//               height: setHeight(50),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Row(
//                     children: [
//                       const Text(
//                         "Item Name: ",
//                         style: TextStyle(fontSize: 24),
//                       ),
//                       const Spacer(),
//                       MyTextField(
//                         color: const Color.fromARGB(255, 255, 239, 63),
//                         width: setWidth(65),
//                         radius: 20,
//                         controller: nameController,
//                         onChanged: (p0) {
//                           setState(() {});
//                         },
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       const Text(
//                         "Quantity: ",
//                         style: TextStyle(fontSize: 24),
//                       ),
//                       const Spacer(),
//                       MyTextField(
//                         color: const Color.fromARGB(255, 255, 239, 63),
//                         width: setWidth(65),
//                         radius: 20,
//                         controller: daysController,
//                         inputType: TextInputType.number,
//                         onChanged: (p0) {
//                           setState(() {});
//                         },
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       const Text(
//                         "Per Item: ",
//                         style: TextStyle(fontSize: 24),
//                       ),
//                       const Spacer(),
//                       MyTextField(
//                         color: const Color.fromARGB(255, 255, 239, 63),
//                         width: setWidth(65),
//                         radius: 20,
//                         controller: priceController,
//                         inputType: TextInputType.number,
//                         onChanged: (p0) {
//                           setState(() {});
//                         },
//                       ),
//                     ],
//                   ),
//                   ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         fixedSize: Size(getProportionateScreenWidth(200),
//                             getProportionateScreenHeight(50)),
//                         side: const BorderSide(
//                           width: 0,
//                         ),
//                         elevation: 3,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30)),
//                       ),
//                       onPressed: _isButtonDisabled
//                           ? () async {
//                               await serviceProvider.uploadItemDataToFireStore(
//                                   serviceName: nameController.text,
//                                   perDay: priceController.text,
//                                   noOfDays: daysController.text,
//                                   total: (int.parse(daysController.text) *
//                                           int.parse(priceController.text))
//                                       .toString());
//                               Navigator.pop(context);
//                             }
//                           : null,
//                       child: const Text("Add")),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
