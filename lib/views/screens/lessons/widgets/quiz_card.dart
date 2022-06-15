

import 'package:flutter/material.dart';
import 'package:topgrade/utils/color_manager.dart';
import 'package:topgrade/views/screens/lessons/quiz_view_screen.dart';
import '../../../../helpers/helper.dart';
import '../../../../helpers/text_helper.dart';
import '../../../../utils/values_manager.dart';
import '../lesson_view_screen.dart';

class QuizCard extends StatelessWidget {
  var title;
  var duration;
  var index;
  var id;
  bool? isLocked;
  QuizCard({Key? key, required this.id, required this.title, required this.duration, required this.isLocked, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p4, horizontal: AppPadding.p16),
      child: InkWell(
          onTap: () {
            if(isLocked == false){
              Navigator.push(context, MaterialPageRoute(builder: (context) => QuizViewScreen(id: id.toString())));
            }
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.08,
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s16),
                color: ColorManager.redColor
            ),
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
                              color: ColorManager.whiteColor
                          ),
                          child: Center(child: textStyle0_5(text: "${index+1}")),
                        ),
                        buildSpaceHorizontal(MediaQuery.of(context).size.width * 0.02),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(title, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorManager.whiteColor),),
                              duration != null ?
                              textStyle00(text: duration.toString(), color: ColorManager.grayColor)
                                  :const SizedBox.shrink(),
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
                        color: ColorManager.whiteColor
                    ),
                    child: isLocked! ? const Icon(Icons.lock, color: ColorManager.redColor, size: 20) :
                    const Icon(Icons.check, color: ColorManager.greenColor, size: 20),
                  ),
                ],
              ),
            ),
          )

      ),
    );
  }
}
