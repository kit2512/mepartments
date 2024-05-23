import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: _ChatBody(),
    );
  }
}

class _ChatBody extends StatelessWidget {
  const _ChatBody({super.key});



  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

