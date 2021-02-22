class Article {
  //defining field names for code
  String id;
  String name;
  String image;
  String pdf;

  //setting field names to fields in firebase
  Article.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    image = data['image'];
    pdf = data['pdf'];
  }
}

class Exercise {
  String id;
  String name;
  String video;
  String image;

  Exercise.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    image = data['image'];
    video = data['video'];
  }
}

//other collections will be defined when added in future
