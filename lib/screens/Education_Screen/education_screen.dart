import 'package:flutter/material.dart';
import 'package:hand_app/components/collection_api.dart';
import 'package:hand_app/components/collection_notifier.dart';
import 'package:hand_app/screens/Education_Screen/current_article.dart';
import 'package:provider/provider.dart';

void main() => runApp(EducationScreen());

class EducationScreen extends StatefulWidget {
  @override
  _EducationScreenState createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  void initState() {
    //article collection is called
    ArticleNotifier articleNotifier =
        Provider.of<ArticleNotifier>(context, listen: false);
    getArticles(articleNotifier);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ArticleNotifier articleNotifier = Provider.of<ArticleNotifier>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.lightBlueAccent[200],
        appBar: AppBar(
          leading: SizedBox(),
          backgroundColor: Colors.white,
          centerTitle: true,
          actions: <Widget>[
            Icon(
              Icons.school,
              color: Colors.black,
            ),
            Icon(
              Icons.school,
              color: Colors.white,
            ),
          ],
          title: Text(
            'Education',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.all(20),
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        articleNotifier.currentArticle =
                            articleNotifier.articleList[index];
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return CurrentArticle();
                        }));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 2.0,
                              spreadRadius: 1,
                              offset: Offset(
                                3.0,
                                3.0,
                              ),
                            ),
                          ],
                          border: Border.all(color: Colors.black),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Container(
                                margin: EdgeInsets.all(5),
                                child: Image.network(
                                  articleNotifier.articleList[index].image,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      articleNotifier.articleList[index].name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: articleNotifier.articleList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
