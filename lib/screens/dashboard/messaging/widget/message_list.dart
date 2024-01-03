import "package:flutter/material.dart";
import 'package:urban_transit_admin/screens/dashboard/messaging/widget/my_message_card.dart';

import 'sender_message_card.dart';

class MessageList extends StatelessWidget {
  final bool? isNotificationScreen;
  const MessageList({Key? key, this.isNotificationScreen}) : super(key: key);

  static const List<Map<String, dynamic>> sampleMessages = [
    {
      "isMe": false,
      "text": "Hey! Gimme a simple statement about Flutter",
      "time": "10:00 am"
    },
    {
      "isMe": true,
      "text": "It's the BEST THING since DODO!",
      "time": "11:00 am"
    }
  ];

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: sampleMessages.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) =>
            sampleMessages[index]["isMe"] == true
                //! I SENT THIS MESSAGE
                ? MyMessageCard(
                    isNotificationScreen: isNotificationScreen ?? false,
                    message: isNotificationScreen != null &&
                            isNotificationScreen == true
                        ? "Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Aenean lacinia bibendum nulla sed consectetur.Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Aenean lacinia bibendum nulla sed consectetur."
                        : sampleMessages[index]["text"].toString(),
                    date: sampleMessages[index]["time"].toString(),
                  )

                //! I RECEIVED THIS MESSAGE
                : SenderMessageCard(
                    isNotificationScreen: isNotificationScreen ?? false,
                    message: isNotificationScreen != null &&
                            isNotificationScreen == true
                        ? "Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Aenean lacinia bibendum nulla sed consectetur.Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Aenean lacinia bibendum nulla sed consectetur."
                        : sampleMessages[index]["text"].toString(),
                    date: sampleMessages[index]["time"].toString(),
                  ),
      );
}
