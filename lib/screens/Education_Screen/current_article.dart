import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:hand_app/components/collection_notifier.dart';
import 'package:provider/provider.dart';

class CurrentArticle extends StatefulWidget {
  @override
  _CurrentArticleState createState() => _CurrentArticleState();
}

class _CurrentArticleState extends State<CurrentArticle> {
  bool _isLoading = true;
  PDFDocument document;
  void initState() {
    _loadPdf() async {
      ArticleNotifier articleNotifier = Provider.of<ArticleNotifier>(context);

      //pdf document is set to URL of article in collection entry
      document = await PDFDocument.fromURL(articleNotifier.currentArticle.pdf);
      setState(() {
        _isLoading = false;
      });
    }

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadPdf());
  }

  @override
  @override
  Widget build(BuildContext context) {
    ArticleNotifier articleNotifier = Provider.of<ArticleNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent[400],
        centerTitle: true,
        actions: <Widget>[
          Icon(
            Icons.picture_as_pdf,
            color: Colors.black,
          ),
          Icon(
            Icons.school,
            color: Colors.lightBlueAccent[400],
          ),
        ],
        title: Text(
          articleNotifier.currentArticle.name,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        //check if PDF has loaded, circular loading widget used whilst retrieving PDF file
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : PDFViewer(
                document: document,
                showPicker: true,
              ),
      ),
    );
  }
}
