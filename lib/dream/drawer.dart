import 'package:flutter/material.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new DrawerWeiget(),
    );
  }
}

class DrawerWeiget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _DrawerWeigetState();
  }
}

class _DrawerWeigetState extends State<DrawerWeiget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView(
      padding: const EdgeInsets.only(),
      children: <Widget>[
        new UserAccountsDrawerHeader(
          accountName: new Text('小娇娇'),
          accountEmail: new Text('1061235334@qq.com'),
          currentAccountPicture: new CircleAvatar(
            backgroundImage: new NetworkImage(
                'https://ws1.sinaimg.cn/large/006dYkwHgy1fxy5swxd72j30hs0hranx.jpg'),
          ),
        ),
        new ListTile(
            title: new Text('设置头像'),
            trailing: new Icon(Icons.arrow_right),
            onTap: () {
              Navigator.of(context).pop();

              Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) {
                  return new Scaffold(
                    appBar: new AppBar(
                      title: new Text('用户信息'),
                    ),
                    body: new DrawerPage(),
                    // body:new Text("aaa"),
                  );
                },
              ));
              Navigator.pushNamed(context, '/LifecyclePage');
            }),
        new Divider(),
        new ListTile(
            title: new Text('设置基本信息'),
            trailing: new Icon(Icons.arrow_right),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/RoutePage');
            }),
        new Divider(),
      ],
    );
  }
}
