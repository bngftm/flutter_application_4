// ignore_for_file: deprecated_member_use, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: ThemeTestRoute(),
    );
  }
}

class ThemeTestRoute extends StatefulWidget {
  @override
  _ThemeTestRouteState createState() => _ThemeTestRouteState();
}

class _ThemeTestRouteState extends State<ThemeTestRoute> {
  var _themeColor = Colors.yellow; //当前路由主题色
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    ThemeData themeData = Theme.of(context);
    return Theme(
      data: ThemeData(
          primarySwatch: _themeColor, //用于导航栏、FloatingActionButton的背景色等
          iconTheme: IconThemeData(color: _themeColor) //用于Icon颜色
      ),
      child: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("计数器"),
        ),
                bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
          child: Row(
            children: [
              // ignore: unnecessary_new
              new IconButton(
                icon: Icon(Icons.home),
                iconSize: 60.0,
                onPressed: (){
                  setState(() {
                    _counter = 0;
                  });
                },
              ),
              SizedBox(), //中间位置空出
              // ignore: unnecessary_new
              new IconButton(
                icon: Icon(Icons.business),
                iconSize: 60.0,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ScaleAnimationRoute()));
                },
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
          ),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
              new IconButton(
                icon: new Icon(
                  _counter != 0 ? Icons.favorite: Icons.favorite_border,
                  color: Colors.red,
                ),
                iconSize: 100.0,
                onPressed: (){
                  setState(() {
                    _counter = 0;
                  });
                },
              ),
              
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
          
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

class ScaleAnimationRoute extends StatefulWidget {
  const ScaleAnimationRoute({Key? key}) : super(key: key);
  
  @override
  _ScaleAnimationRouteState createState() => _ScaleAnimationRouteState();
}

//需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  
  @override
  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(seconds: 3), vsync: this);
    //使用弹性曲线
    animation=CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    //图片宽高从0变到300
    animation = Tween(begin: 0.0, end: 400.0).animate(animation)
      ..addListener(() {
        setState(() => {});
      });
    //启动动画
    controller.forward();
  }


  @override
  Widget build(BuildContext context) {
    var _themeColor = Colors.yellow; 
    ThemeData themeData = Theme.of(context);
    return Theme(
      data: ThemeData(
          primarySwatch: _themeColor, //用于导航栏、FloatingActionButton的背景色等
          iconTheme: IconThemeData(color: _themeColor) //用于Icon颜色
      ),
      child: Scaffold(
        appBar:AppBar(title:Text('动画')),
        
        body:Center(
          
          
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Image.network(
                "https://p2.ssl.qhimgs1.com/sdr/400__/t01eef41fecd78bc0c8.jpg",
                width: animation.value,
                height: animation.value,
              ),
              RaisedButton(
                child:RaisedButton(
                  child:Text('返回'),
                  color:  Color.fromARGB(255, 248, 237, 17),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
                onPressed: (){
                    Navigator.pop(context);
                  },
              ),
            ],
        )
      ),
    ),
   );
  }
  
  @override
  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}



