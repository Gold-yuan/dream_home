import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// https://flutterchina.club/get-started/codelab/#第1步-创建-flutter-app
void main() {
  //debugPaintSizeEnabled = true;
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'dream',
      home: new Scaffold(
        body: new Center(
          child: new RandomWords(),
        ),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = new List<String>();

  final _saved = new Set<String>();

  final _biggerFont = const TextStyle(fontSize: 18.0);

  final _biggerFontGreen = const TextStyle(
      fontSize: 18.0,
      color: Colors.green,
      decoration: TextDecoration.lineThrough,
      decorationColor: Colors.red);

  @override
  Widget build(BuildContext context) {
    //final wordPair = new WordPair.random();
    //return new Text(wordPair.asPascalCase);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('dream list'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(10.0),
        // 对于每个建议的单词对都会调用一次itemBuilder，然后将单词对添加到ListTile行中
        // 在偶数行，该函数会为单词对添加一个ListTile row.
        // 在奇数行，该行书湖添加一个分割线widget，来分隔相邻的词对。
        // 注意，在小屏幕上，分割线看起来可能比较吃力。
        itemBuilder: (context, i) {
          print(i);
          // 在每一列之前，添加一个1像素高的分隔线widget
          if (i.isOdd) return new Divider();

          // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
          // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
          final index = i ~/ 2;
          // 如果是建议列表中最后一个单词对
//          if (index >= _suggestions.length) {
//            // ...接着再生成10个单词对，然后添加到建议列表
//            print(index.toString() + " " + _suggestions.length.toString());
//            _suggestions.addAll(generateWordPairs().take(3));
//            print(index.toString() + " " + _suggestions.length.toString());
//          }
          if (_suggestions.length == 0) {
            _suggestions.add("去月球旅游");
            _suggestions.add("和亲爱的手牵手到爱情海散步");
            _suggestions.add("把北京逛遍");
            _suggestions.add("参与一次敬老院志愿者");
            _suggestions.add("给爸妈买个好的医疗、养老险");
            _suggestions.add("月薪十万");
            _suggestions.add("学会游泳");
            _suggestions.add("每天11点睡觉");
            _suggestions.add("学会跳舞、交际");
          }
          if (index >= _suggestions.length) return null;
          return _buildRow(_suggestions[index]);
        });
  }

  ///给一行文字添加样式
  Widget _buildRow(String pair) {
    final alreadySaved = _saved.contains(pair);

    return new ListTile(
      title: new Container(
        // grey box
        child: new Text(
          pair,
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
        color: alreadySaved ? Colors.green : Colors.white,
      ),
      leading: new Icon(
        Icons.assignment_turned_in,
        color: alreadySaved ? Colors.green : Colors.grey,
      ),
      trailing: new IconButton(
        icon: new Icon(
          Icons.file_upload,
          color: Colors.blue,
        ),
        onPressed: () {
          Navigator.of(context).push(
            new MaterialPageRoute(
              builder: (context) {
                return new Scaffold(
                  body: new MyFadeTest(
                    title: pair,
                    imgName: "img/a" +
                        _suggestions.indexOf(pair).toString() +
                        ".jpg",
                  ),

                  // Image.asset("img/a" + _suggestions.indexOf(pair).toString() + ".jpg"),
                );
              },
            ),
          );
        },
      ),
      onTap: () {
        // 提示: 在Flutter的响应式风格的框架中，调用setState() 会为State对象触发build()方法，从而导致对UI的更新
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              //return _buildRow(pair);
              return new ListTile(
                title: new Text(
                  pair,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return new Scaffold(
            appBar: new AppBar(
              title: new Text('finished'),
            ),
            body: new ListView(children: divided),
            // body:new Text("aaa"),
          );
        },
      ),
    );
  }
}

class MyFadeTest extends StatefulWidget {
  MyFadeTest({Key key, this.title, this.imgName}) : super(key: key);

  final String title;
  final String imgName;
  bool click = false;

  @override
  _MyFadeTest createState() => _MyFadeTest();
}

class _MyFadeTest extends State<MyFadeTest> with TickerProviderStateMixin {
  AnimationController controller;
  CurvedAnimation curve;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    curve = CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Container(
              child: FadeTransition(
        opacity: curve,
        child: Image.asset(widget.imgName),
      ))),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Fade',
        child: Icon(Icons.brush),
        onPressed: () {
          controller.forward();
        },
      ),
    );
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }
}
