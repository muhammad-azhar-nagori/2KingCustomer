
import 'package:flutter/material.dart';
import 'package:kingcustomer/helper/size_configuration.dart';

class AreYouSure extends StatelessWidget {
  const AreYouSure({
    Key? key,
    required this.title,
    this.onPressed,
  }) : super(key: key);
  final String title;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: Colors.yellow,
        ),
        height: setHeight(12),
        width: setWidth(70),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Text(title,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 0, 0, 0),
                )),
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
                  child: const Text("No",
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
                  onPressed: onPressed,
                  child: const Text("Yes",
                      style: TextStyle(fontSize: 18, color: Colors.black87)),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
