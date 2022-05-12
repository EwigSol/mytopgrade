
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/models/messages_model.dart';

import '../../../helpers/text_helper.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/values_manager.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final TextEditingController messageController = TextEditingController(text: '');
  final ScrollController _scrollController = ScrollController();
  List<MessagesModel> messages = [];
  String? senderId;

  @override
  initState() {
    super.initState();
    senderId = "1";
    getData();
  }

  getData() {
    setState(() {
      messages.add(MessagesModel(id: 1, type: "Text", fromID: 1, toID: 2, body: "Hello", seen: 0, createdAt: "2022-12-06 05:10:20"));
      messages.add(MessagesModel(id: 2, type: "Text", fromID: 2, toID: 1, body: "Hello", seen: 1, createdAt: "2022-12-06 05:10:20"));
      messages.add(MessagesModel(id: 3, type: "Text", fromID: 1, toID: 2, body: "How are you", seen: 1, createdAt: "2022-12-06 05:10:20"));
      messages.add(MessagesModel(id: 4, type: "Text", fromID: 2, toID: 1, body: "Fine", seen: 0, createdAt: "2022-12-06 05:10:20"));
      messages.add(MessagesModel(id: 5, type: "Text", fromID: 1, toID: 2, body: "What about you", seen: 0, createdAt: "2022-12-06 05:10:20"));
      messages.add(MessagesModel(id: 6, type: "Text", fromID: 2, toID: 1, body: "I am fine", seen: 0, createdAt: "2022-12-06 05:10:20"));
      messages.add(MessagesModel(id: 7, type: "Text", fromID: 1, toID: 2, body: "What's next", seen: 1, createdAt: "2022-12-06 05:10:20"));
      messages.add(MessagesModel(id: 8, type: "Text", fromID: 2, toID: 1, body: "Nothing", seen: 1, createdAt: "2022-12-06 05:10:20"));
      messages.add(MessagesModel(id: 9, type: "Text", fromID: 1, toID: 2, body: "Are you Free", seen: 0, createdAt: "2022-12-06 05:10:20"));
      messages.add(MessagesModel(id: 10, type: "Text", fromID: 2, toID: 1, body: "Yes", seen: 0, createdAt: "2022-12-06 05:10:20"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: Column(
        children: [
          buildSpaceVertical(2.h),
          Expanded(
              child: messages.isNotEmpty ?
              ListView.builder(
                  controller: _scrollController,
                  itemCount: messages.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final message = messages.elementAt(index);
                    bool isMe = senderId == message.fromID.toString();
                    return Directionality(
                      textDirection: isMe ? TextDirection.ltr : TextDirection.rtl,
                      child: Container(
                        margin: isMe ?  EdgeInsets.only(right: 35.w, left: 10, bottom: 10) :  EdgeInsets.only(left: 35.w, right: 10, bottom: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppPadding.p28),
                          color: isMe ? ColorManager.redColor : ColorManager.halfWhiteColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${message.body}",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: isMe ? ColorManager.whiteColor : ColorManager.blackColor),
                            ),
                            buildSpaceVertical(2.h),
                            Row(
                              mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                              children: [
                                Text(
                                  message.createdAt.toString().substring(11, 19),
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      color: isMe ? ColorManager.whiteColor : ColorManager.blackColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  })
                  : Center(child: textStyle2(text: "No Messages"),)
          ),
        ],
      ),
    );
  }
  AppBar buildAppBar() {
    return AppBar(
      title: Row(
        children: [
          Container(
            height: 5.h,
            width: 5.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s30),
                color: ColorManager.pinkColor),
            child: const Icon(Icons.person_sharp),
          ),
          buildSpaceHorizontal(3.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textStyle2(text: "Wade Warren"),
              textStyle00(text: "Active", color: ColorManager.grayColor)
            ],
          )
        ],
      ),
      backgroundColor: ColorManager.whiteColor,
      elevation: 0,
      iconTheme: const IconThemeData(color: ColorManager.blackColor),
    );
  }
}
