import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:dream_home/dream/drawer.dart';

/// https://flutterchina.club/get-started/codelab/#第1步-创建-flutter-app
void main() {
//  debugPaintSizeEnabled = true;
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
  static final _suggestions = new List<String>();

  final _saved = new Set<String>();

  final random = new Random();

  final _dreamList = <String>[
    "开一家店一定要有奶茶店",
    "学会弹钢琴",
    "学会英语并熟练交流和运用",
    "去看大海并且在里面游泳= =",
    "会很熟练的溜冰像飞一样",
    "去爬上一座很高的山看日落",
    "有一个自己的工作室做设计装帧的",
    "学好计算机并且可以处理任何的故障和维修",
    "好好珍惜自己买过的书",
    "有一面墙都是书，是那种木头架子的带梯子可以爬上去的那种",
    "有一栋自己的房子，并且是带院子的 自己装修",
    "一定要有自己很爱的一只猫啊~~必须的啊",
    "院子里一定要有一个很高很高的秋千",
    "每年都和家人一起去出游开开心心的",
    "让自己的亲人能够享受到因自己而带来的幸福",
    "去看自己喜欢的人的音乐会和喜欢的人一起",
    "去月球旅游",
    "和亲爱的手牵手到爱情海散步",
    "把北京逛遍",
    "参与一次敬老院志愿者",
    "月薪十万",
    "学会游泳",
    "每天11点睡觉",
    "学会跳舞、交际",
    "生个女孩",
    "把女孩打扮成小公主",
    "把男孩打扮成小公主",
    "把媳妇打扮成小公主",
    "带她去看漫展",
    "去爬高山看日出日落",
    "xxx",
  ];

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
          new IconButton(icon: new Icon(Icons.keyboard_arrow_right), onPressed: _pushSaved),
        ],
      ),
      drawer: new Drawer(
        child: new DrawerPage(),
      ),
      body: _buildSuggestions(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Fade',
        child: Icon(Icons.brush),
        onPressed: _goTextFidld,
      ),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.only(bottom: 100),
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
          if (index >= _suggestions.length && index < 5) {
            _suggestions.add(_dreamList[random.nextInt(_dreamList.length)]);
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
                    imgName: "img/a" + random.nextInt(9).toString() + ".jpg",
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
                title: Text(
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

  void _goTextFidld() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new Scaffold(
            body: new TextInput(),
          );
        },
      ),
    );
  }
}

/// 淡入
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
        child: _showImg(),
      ))),
    );
  }

  _showImg() {
    controller.forward();
    return Image.asset(widget.imgName);
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }
}

/// 文本输入框
class TextInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TextInputState();
  }
}

class TextInputState extends State<TextInput> {
//用户名输入框的控制器
  TextEditingController _dreamController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("添加一个梦想"),
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new TextField(
              controller: _dreamController,
              decoration: new InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 10.0),
                  icon: new Icon(Icons.add_to_queue),
                  labelText: "请输入",
                  helperText: "你的梦想"),
              onSubmitted: (String str) {
                // 保存信息并且返回前一页
                _popPage(str);
              },
            ),
            new Builder(builder: (BuildContext context) {
              //监听RaisedButton的点击事件，并做相应的处理
              return new RaisedButton(
                  onPressed: () {
                    _popPage(_dreamController.text.toString());
                  },
                  color: Colors.blue,
                  highlightColor: Colors.lightBlueAccent,
                  disabledColor: Colors.lightBlueAccent,
                  child: new Text(
                    "添加",
                    style: new TextStyle(color: Colors.white),
                  ));
            }),
          ],
        ),
      ),
    );
  }

  void _popPage(String str) {
    if (str == null || str.length == 0) {
      return;
    }
    RandomWordsState._suggestions.add(str);
    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("添加成功")));
    new Future.delayed(
        const Duration(seconds: 1), () => Navigator.of(context).pop());
  }
}
