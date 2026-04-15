import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/models/get_all_chats/get_all_chats_response.dart';

class ChatBubble extends StatelessWidget {
  final String? userImageUrl;
  final String message;
  final bool isMe;
  final String time;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.time,
    this.userImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              time,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment:
          isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            if (!isMe)
               CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey,
                 backgroundImage: (userImageUrl != null && userImageUrl!.isNotEmpty)
                     ? NetworkImage(userImageUrl!)
                     : null,
                 child: (userImageUrl == null || userImageUrl!.isEmpty)
                     ? const Icon(Icons.person, size: 18, color: Colors.white)
                     : null,
               ),

            if (!isMe) const SizedBox(width: 8),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              constraints: const BoxConstraints(maxWidth: 260),
              decoration: BoxDecoration(
                color: isMe ? Colors.orange : Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft:
                  Radius.circular(isMe ? 16 : 0),
                  bottomRight:
                  Radius.circular(isMe ? 0 : 16),
                ),
              ),
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),

            if (isMe) const SizedBox(width: 8),

            if (isMe)
               CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey,
                   backgroundImage: (userImageUrl != null && userImageUrl!.isNotEmpty)
                       ? NetworkImage(userImageUrl!)
                       : null,
                   child: (userImageUrl == null || userImageUrl!.isEmpty)
                       ? const Icon(Icons.person, size: 18, color: Colors.white)
                       : null,
              ),
          ],
        ),
      ],
    );
  }
}
