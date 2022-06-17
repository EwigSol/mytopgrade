import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:topgrade/controllers/lesson_byId_controller.dart';
import 'package:topgrade/models/lesson_byID_model.dart';
import 'package:topgrade/utils/color_manager.dart';
import '../../../../helpers/helper.dart';
import '../../../../helpers/text_helper.dart';
import '../../../../utils/values_manager.dart';
import '../lesson_view_screen.dart';
import 'package:get/get.dart';

class LessonCard extends StatefulWidget {
  var title;
  var duration;
  var index;
  var id;
  bool? isLocked;
  LessonCard(
      {Key? key,
      required this.id,
      required this.title,
      required this.duration,
      required this.isLocked,
      required this.index})
      : super(key: key);

  @override
  State<LessonCard> createState() => _LessonCardState();
}

class _LessonCardState extends State<LessonCard> {
  final LessonByIDController lessonByIDController =
      Get.put(LessonByIDController());
  late LessonByIdModel lessonModelList = LessonByIdModel();
  String? url;
  String? name;

  @override
  void initState() {
    super.initState();
    lessonModelList;
    getLessonByIdData();
  }

  getLessonByIdData() async {
    lessonModelList =
        (await lessonByIDController.fetchLessonByID(widget.id.toString()))!;
    url = _parseHtmlString(lessonModelList.content!);

    name = lessonModelList.name!;
    print(widget.id);
    print(url);
    print(name);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppPadding.p4, horizontal: AppPadding.p16),
      child: InkWell(
          onTap: () {
            if (widget.isLocked == false) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LessonViewScreen(
                            id: widget.id.toString(),
                            url: url,
                            name: name,
                          )));
            }
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.08,
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s16),
                color: ColorManager.halfWhiteColor),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          width: MediaQuery.of(context).size.width * 0.08,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s28),
                              color: ColorManager.whiteColor),
                          child: Center(
                              child: textStyle0_5(text: "${widget.index + 1}")),
                        ),
                        buildSpaceHorizontal(
                            MediaQuery.of(context).size.width * 0.02),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.title,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              widget.duration != null
                                  ? textStyle00(
                                      text: widget.duration.toString(),
                                      color: ColorManager.grayColor)
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.04,
                    width: MediaQuery.of(context).size.width * 0.08,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s28),
                        color: ColorManager.whiteColor),
                    child: widget.isLocked!
                        ? const Icon(Icons.lock,
                            color: ColorManager.redColor, size: 20)
                        : const Icon(Icons.check,
                            color: ColorManager.greenColor, size: 20),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;
    return parsedString;
  }
}
