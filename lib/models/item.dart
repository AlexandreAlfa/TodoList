class Item {
  String title;
  bool done;
  DateTime date;

  Item({this.title, this.done, this.date});

  Item.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    done = json['done'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map();
    data['title'] = this.title;
    data['done'] = this.done;
    data['date'] = this.date;
    return data;
  }
}
