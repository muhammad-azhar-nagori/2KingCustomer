import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kingcustomer/Screens/loginSignup/login.dart';
import 'package:kingcustomer/Screens/profile/edit_profile.dart';
import 'package:kingcustomer/Screens/profile/edit_services.dart';
import 'package:kingcustomer/providers/authentication_provider.dart';
import 'package:kingcustomer/providers/message_provider.dart';
import 'package:provider/provider.dart';
import '../../helper/size_configuration.dart';
import '../../providers/chat_provider.dart';
import '../../providers/current_user_provider.dart';
import '../../providers/customer_provider.dart';
import '../../providers/order_provider.dart';
import '../../providers/service_provider.dart';
import '../../providers/contractor_provider.dart';
import '../../providers/worker_provider.dart';
import '../profile/my_profile_view.dart';
import 'aboutus/aboutus.dart';

class Menu extends StatelessWidget {
  const Menu({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<ServiceProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    final currentProvider = Provider.of<CustomerProvider>(context);

    final userProvider = Provider.of<ContractorsProvider>(context);
    final orderstProvider = Provider.of<OrdersProvider>(context);
    final messageProvider = Provider.of<MessageProvider>(context);

    final loggedInUser = currentProvider
        .getUserByID(FirebaseAuth.instance.currentUser!.uid.trim());
    return Scaffold(
      appBar: AppBar(
        leadingWidth: getProportionateScreenWidth(40),
        leading: Image.asset(
          "assets/images/logo-black-half.png",
          fit: BoxFit.contain,
        ),
        title: Text(
          "Menu",
          style: TextStyle(
            color: Colors.black,
            fontSize: getProportionateScreenWidth(20),
          ),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: [
          InkWell(
            child: ListTile(
              visualDensity: const VisualDensity(vertical: 4),
              dense: true,
              leading: CircleAvatar(
                child: ClipOval(
                  child: Image.network(
                    loggedInUser.profileImageURL!,
                    fit: BoxFit.fill,
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
              title: Text(
                loggedInUser.name!,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              subtitle: const Text("View profile"),
            ),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyProfileView(
                          title: loggedInUser.name!,
                        ))),
          ),
          const Divider(
            thickness: 0.05,
            indent: 0,
            endIndent: 0,
            color: Colors.black,
            height: 0,
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: 4),
            dense: true,
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: const Text(
              "Edit Profile",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EditProfilePage(),
              ),
            ),
          ),
          const Divider(
            thickness: 0.05,
            indent: 0,
            endIndent: 0,
            color: Colors.black,
            height: 0,
          ),
          // ListTile(
          //   visualDensity: const VisualDensity(vertical: 4),
          //   dense: true,
          //   leading: const CircleAvatar(
          //     child: Icon(Icons.construction),
          //   ),
          //   title: const Text(
          //     "Edit Services",
          //     style: TextStyle(
          //       fontSize: 18,
          //     ),
          //   ),
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => const EditServices(),
          //         ));
          //   },
          // ),
          const Divider(
            thickness: 0.05,
            indent: 0,
            endIndent: 0,
            color: Colors.black,
            height: 0,
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: 4),
            dense: true,
            leading: const CircleAvatar(
              child: Icon(Icons.construction),
            ),
            title: const Text(
              "About us",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutUs(),
                  ));
            },
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: 4),
            dense: true,
            leading: const CircleAvatar(
              child: Icon(Icons.logout),
            ),
            title: const Text(
              "Logout",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () async {
              await context.read<AuthenticationService>().signOut();
              chatProvider.clearList();
              messageProvider.clearList();
              serviceProvider.clearList();
              currentProvider.clearList();
              orderstProvider.clearList();
              userProvider.clearList();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
            },
          ),
          const Divider(
            thickness: 0.05,
            indent: 0,
            endIndent: 0,
            color: Colors.black,
            height: 0,
          ),
        ],
      ),
    );
  }
}
