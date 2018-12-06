import 'package:flutter/material.dart';

/*
 * 枚举类，标签演示样式
 *  图标和文本
 *  仅图标
 *  仅文本
 */
enum TabsDemoStyle { iconsAndText, iconsOnly, textOnly }

/*
 * 页面类
 *  图标
 *  文本
 */
class _Page {
  _Page({
    this.icon,
    this.text,
  });

  final IconData icon;
  final String text;
}

// 存储所有页面的列表
final List<_Page> _allPages = <_Page>[
  new _Page(icon: Icons.event, text: 'EVENT'),
  new _Page(icon: Icons.home, text: 'HOME'),
  new _Page(icon: Icons.android, text: 'ANDROID'),
  new _Page(icon: Icons.alarm, text: 'ALARM'),
  new _Page(icon: Icons.face, text: 'FACE'),
  new _Page(icon: Icons.language, text: 'LANGUAGE'),
];

class ScrollableTabsDemo extends StatefulWidget {
  @override
  _ScrollableTabsDemoState createState() => new _ScrollableTabsDemoState();
}

// 继承SingleTickerProviderStateMixin，提供单个Ticker（每个动画帧调用它的回调一次）
class _ScrollableTabsDemoState extends State<ScrollableTabsDemo>
    with SingleTickerProviderStateMixin {
  /*
   * 在TabBar和TabBarView之间的坐标选项卡选择
   *  TabBar：质感设计控件，显示水平的一行选项卡
   *  TabBarView：可分布列表，显示与当前所选标签对应的控件
   */
  TabController _controller;
  TabsDemoStyle _demoStyle = TabsDemoStyle.iconsAndText;

  @override
  void initState() {
    super.initState();
    /*
     * 创建一个对象，用于管理TabBar和TabBarView所需的状态
     *  length：选项卡的总数，存储所有页面的列表中的元素个数
     */
    _controller = new TabController(vsync: this, length: _allPages.length);
  }

  // 释放对象使用的资源
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void changeDemoStyle(TabsDemoStyle style) {
    setState(() {
      _demoStyle = style;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 获取当前主题的控件前景色
    final Color iconColor = Theme.of(context).accentColor;
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('可滚动的标签页'),
          actions: <Widget>[
            new PopupMenuButton<TabsDemoStyle>(
                onSelected: changeDemoStyle,
                itemBuilder: (BuildContext context) =>
                    <PopupMenuItem<TabsDemoStyle>>[
                      new PopupMenuItem<TabsDemoStyle>(
                          value: TabsDemoStyle.iconsAndText,
                          child: new Text('图标和文本')),
                      new PopupMenuItem<TabsDemoStyle>(
                          value: TabsDemoStyle.iconsOnly,
                          child: new Text('仅图标')),
                      new PopupMenuItem<TabsDemoStyle>(
                          value: TabsDemoStyle.textOnly, child: new Text('仅文本'))
                    ]),
          ],
          bottom: new TabBar(
            // 控件的选择和动画状态
            controller: _controller,
            // 标签栏是否可以水平滚动
            isScrollable: true,
            // 标签控件的列表
            tabs: _allPages.map((_Page page) {
              switch (_demoStyle) {
                case TabsDemoStyle.iconsAndText:
                  return new Tab(text: page.text, icon: new Icon(page.icon));
                case TabsDemoStyle.iconsOnly:
                  return new Tab(icon: new Icon(page.icon));
                case TabsDemoStyle.textOnly:
                  return new Tab(text: page.text);
              }
            }).toList(),
          ),
        ),
        body: new TabBarView(
          // 控件的选择和动画状态
          controller: _controller,
          // 每个标签一个控件
          children: _allPages.map((_Page page) {
            // ignore: case_expression_type_implements_equals
            switch (page.icon) {
              case Icons.home:
                return new MyPage(title: 'page B');
            }
            return new MyPage(title: 'page A');
          }).toList(),
        ));
  }
}

void main() {
  runApp(new MaterialApp(
    title: 'Flutter教程',
    home: new ScrollableTabsDemo(),
  ));
}

class MyPage extends StatefulWidget {
  MyPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  createState() => new MyPageState();
}

class MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
    );
  }
}
