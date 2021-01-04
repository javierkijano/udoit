/*import 'package:flutter/material.dart';
import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';
import 'package:easy_web_view/src/web.dart';

class HtmlEditor extends StatefulWidget {
  HtmlEditor({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HtmlEditorState createState() => _HtmlEditorState();
}

class _HtmlEditorState extends State<HtmlEditor> {
  String result = "";
  EasyWebView _webView;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //_webView.s
    _webView = EasyWebView(
      onLoaded: () {
        int a = 0;
      },
      onLoaded2: (BuildContext context2) {
        int a = 0;
        //context2.widget.
      },
      src: src,
      isHtml: true, // Use Html syntax
      isMarkdown: false, // Use markdown syntax
      convertToWidgets: false, // Try to convert to flutter widgets
      width: MediaQuery.of(context).size.width * 0.8,
      height: 300,
    );
    return _webView;
  }
}
/*
Widget editor1() {
return FlutterSummernote(
        hint: "Your text here...",
        key: _keyEditor,
        hasAttachment: false,
        customToolbar: """
          [
            ['style', ['bold', 'italic', 'underline', 'clear']],
            ['font', ['strikethrough', 'superscript', 'subscript']],
            ['insert', ['link', 'table', 'hr']]
          ]
        """,
      );
}
*/

/*
Widget editor(BuildContext context) {
  context.findAncestorStateOfType('HtmlEditor'). = EasyWebView(
    onLoaded: () {
      int a = 0;
    },
    src: src,
    isHtml: true, // Use Html syntax
    isMarkdown: false, // Use markdown syntax
    convertToWidgets: false, // Try to convert to flutter widgets
    width: MediaQuery.of(context).size.width * 0.8,
    height: 400,
  );
  //print(_webView.headers);
  //_webView.debugDescribeChildren();
  return _webView;
}
*/

String toolbar = """
    [
      ['style', ['bold', 'italic', 'underline', 'clear']],
      ['font', ['strikethrough', 'superscript', 'subscript']],
      ['font', ['fontsize', 'fontname']],
      ['color', ['forecolor', 'backcolor']],
      ['para', ['ul', 'ol', 'paragraph']],
      ['height', ['height']],
      ['view', ['fullscreen']]
    ]
  """;

String src = '''
    <!DOCTYPE html>
    <html lang="en">
    <head>
    <meta name="viewport" content="user-scalable=no">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Summernote</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
    </head>
    <body>
    <div id="summernote" contenteditable="true"></div>
    <script type="text/javascript">
      \$("#summernote").summernote({
        placeholder: 'Your text here...',
        tabsize: 2,
        toolbar: $toolbar
      });
    </script>
    </body>
    </html>
    ''';

*/
