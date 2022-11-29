// ignore_for_file: public_member_api_docs, sort_constructors_first
class Mood {
  String amount;
  String category;
  String date;
  String description;

  Mood(
      {required this.amount,
      required this.category,
      required this.date,
      required this.description});

  factory Mood.fromJson(Map<String, dynamic> json) {
    return Mood(
      amount: json['creator'],
      category: json['mood'],
      date: json['title'],
      description: json['description'],
    );
  }
}

class Usermodel {
  int fpid;
  String email;
  DateTime date;
  String mood;

  Usermodel({
    required this.fpid,
    required this.email,
    required this.date,
    required this.mood,
  });
}

class Post {
  String content;
  String mood;
  String date;

  Post({
    required this.content,
    required this.mood,
    required this.date,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      mood: json['mood'],
      content: json['content'],
      date: json['created'].toString(),
    );
  }
}
