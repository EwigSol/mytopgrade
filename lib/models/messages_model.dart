

class MessagesModel {

  int? id;
  String? type;
  int? fromID;
  int? toID;
  String? body;
  int? seen;
  String? createdAt;

  MessagesModel({this.id, this.type, this.fromID, this.toID, this.body, this.seen, this.createdAt});


  factory MessagesModel.fromJson(Map<String, dynamic> data) {
    return MessagesModel(
      id: data['id'],
      type: data['type'],
      fromID: data['from_id'],
      toID: data['to_id'],
      body: data['body'],
      seen: data['seen'],
      createdAt: data['created_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {type!: type, 'from_id': fromID, 'to_id': toID, 'body': body, 'created_at': createdAt};
  }


}