import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'collection_name.dart';

class ArticleNotifier with ChangeNotifier {
  List<Article> _articleList = [];
  Article _currentArticle;

  UnmodifiableListView<Article> get articleList =>
      UnmodifiableListView(_articleList);

  Article get currentArticle => _currentArticle;

  set articleList(List<Article> articleList) {
    _articleList = articleList;
    notifyListeners();
  }

  set currentArticle(Article article) {
    _currentArticle = article;
    notifyListeners();
  }
}

class ExerciseNotifier with ChangeNotifier {
  List<Exercise> _exerciseList = [];
  Exercise _currentExercise;

  UnmodifiableListView<Exercise> get exerciseList =>
      UnmodifiableListView(_exerciseList);

  Exercise get currentExercise => _currentExercise;

  set exerciseList(List<Exercise> exerciseList) {
    _exerciseList = exerciseList;
    notifyListeners();
  }

  set currentExercise(Exercise exercise) {
    _currentExercise = exercise;
    notifyListeners();
  }
}
