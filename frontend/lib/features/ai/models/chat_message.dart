class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});

  Map<String, dynamic> toJson() {
    return {"role": isUser ? "user" : "assistant", "content": text};
  }
}
