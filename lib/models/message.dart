class Message {
  String id;
  String senderId;
  String receiverId;
  DateTime datetime;
  String message;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.datetime,
    required this.message,
  });
}
