import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../theme/utils/my_colors.dart';
import '../../main/main_controller.dart';

class ChatItemMessegerWidget extends StatelessWidget {
  const ChatItemMessegerWidget({
    super.key,
    required this.isSender,
    required this.msg,
    required this.time,
  });
  final bool isSender;
  final String msg;
  final String time;

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.put(MainController());
    return Obx(
      () => Align(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment:
              isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: MyColors.bone,
                  borderRadius: isSender
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        )
                      : const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        )),
              child: Text(
                msg,
                style: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: MyColors.onPrimary),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              DateFormat.jm().format(DateTime.parse(time)),
              style: GoogleFonts.urbanist(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: mainController.isPrimaryDark.value,
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
