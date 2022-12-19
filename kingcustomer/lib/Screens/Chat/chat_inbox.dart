import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kingcustomer/Screens/Chat/fill_aggrement_form.dart';
import 'package:kingcustomer/Screens/Chat/aggrement_message.dart';
import 'package:kingcustomer/Screens/loginSignup/mytextfield.dart';
import 'package:kingcustomer/models/contractor_model.dart';
import 'package:kingcustomer/providers/message_provider.dart';
import 'package:provider/provider.dart';
import '../../helper/size_configuration.dart';
import '../../providers/chat_provider.dart';
import '../../widgets/are_you_sure.dart';
import 'my_messages.dart';
import 'opposite_messages.dart';

class Inbox extends StatefulWidget {
  const Inbox({super.key, required this.user});
  final ContractorsModel user;

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  final TextEditingController _textController = TextEditingController();

  final bool isOpposite = true;

  @override
  Widget build(BuildContext context) {
    // Future<void>.delayed(const Duration(seconds: 1))
    //     .then((value) => _onRefresh());
    final messageProvider = Provider.of<MessageProvider>(context);
    final messageList = messageProvider.getSortedList(widget.user.userID);
    messageProvider.fetch();
    final chatProvider = Provider.of<ChatProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              "${widget.user.name}",
              style: const TextStyle(
                color: Colors.black,
                fontSize: (kToolbarHeight / 100) * 40,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => AreYouSure(
                        title: "Delete this Conversation?",
                        onPressed: () async {
                          await messageProvider.deleteAllMessages(
                              otherID: widget.user.userID);

                          Navigator.pop(context);
                        }),
                  );
                },
              ),
            ]),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            reverse: true,
            separatorBuilder: (context, index) => SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            scrollDirection: Axis.vertical,
            itemCount: messageList.length,
            itemBuilder: (context, int index) => ChangeNotifierProvider.value(
              value: messageList[index],
              child: messageList[index].agreementID == ""
                  ? messageList[index].type!
                      ? GestureDetector(
                          onLongPress: () => showDialog(
                            context: context,
                            builder: (context) => AreYouSure(
                                title: "Delete this message?",
                                onPressed: () async {
                                  await messageProvider.deleteMessage(
                                      messageID: messageList[index].messageID,
                                      messagetxt:
                                          messageList[index].messageTxt);
                                  Navigator.pop(context);
                                }),
                          ),
                          child: MyMessages(
                            text: messageList[index].messageTxt!,
                          ),
                        )
                      : GestureDetector(
                          onLongPress: () => showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => AreYouSure(
                                    title: "Delete this message? ",
                                    onPressed: () async {
                                      await messageProvider.deleteMessage(
                                          messageID:
                                              messageList[index].messageID,
                                          messagetxt:
                                              messageList[index].messageTxt);
                                      Navigator.pop(context);
                                    }),
                              ),
                          child: OppositeMessages(
                              text: messageList[index].messageTxt!))
                  : GestureDetector(
                      onLongPress: () => showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => AreYouSure(
                            title: "Delete this Agreement? ",
                            onPressed: () async {
                              await messageProvider.deleteMessage(
                                  messageID: messageList[index].messageID,
                                  messagetxt: messageList[index].messageTxt);
                              Navigator.pop(context);
                            }),
                      ),
                      child:
                          AgreementMsg(text: messageList[index].agreementID!),
                    ),
            ),
            physics: const BouncingScrollPhysics(),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: BottomAppBar(
            child: Container(
              height: setHeight(8),
              color: const Color.fromARGB(255, 239, 203, 0),
              child: Row(
                children: [
                  SizedBox(
                    height: setHeight(7),
                    width: setWidth(10),
                    child: const Icon(Icons.camera_alt),
                  ),
                  SizedBox(
                    height: setHeight(7),
                    width: setWidth(14),
                    child: const Icon(Icons.image),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 10),
                    child: MyTextField(
                      width: setWidth(70),
                      height: setHeight(3),
                      radius: 20,
                      controller: _textController,
                      hintText: "Message",
                      leading: GestureDetector(
                        onTap: () async {
                          if (_textController.text.isNotEmpty) {
                            messageProvider.uploadMessageDataToFireStore(
                                chatWith: widget.user.userID,
                                createdAt: DateTime.now(),
                                messagetxt: _textController.text,
                                agreementID: "",
                                type: true);
                            _textController.clear();
                            await chatProvider.createOtherChat(
                                otherID: widget.user.userID);
                          }
                        },
                        child: const Icon(Icons.send),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
