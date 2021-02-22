import 'package:cloud_firestore/cloud_firestore.dart';
import 'collection_name.dart';
import 'collection_notifier.dart';

getArticles(ArticleNotifier articleNotifier) async {
  //retrieve article collection
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Articles')
      //order by id field
      .orderBy("id")
      .getDocuments();

  List<Article> _articleList = [];

  snapshot.documents.forEach((document) {
    Article article = Article.fromMap(document.data);
    _articleList.add(article);
  });
  articleNotifier.articleList = _articleList;
}

getExercises(ExerciseNotifier exerciseNotifier) async {
  //retrieve exercise collection

  QuerySnapshot snapshot = await Firestore.instance
      .collection('Exercises')
      .orderBy("id")
      .getDocuments();

  List<Exercise> _exerciseList = [];

  snapshot.documents.forEach((document) {
    Exercise exercise = Exercise.fromMap(document.data);
    _exerciseList.add(exercise);
  });
  exerciseNotifier.exerciseList = _exerciseList;
}
//retrieve other collections when app is full with videos
