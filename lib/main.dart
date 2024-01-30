import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//1. エントリーポイントのmain関数
void main() {
  //2. runApp関数でMyAppを実行
  runApp(const MyApp());
}

//MyAppクラス
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //3. タイトルとテーマを設定。画面の本体はMyHomePageクラスで定義
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _flag = false;

  _click() async {
    setState(() {
      _flag = !_flag;
    });
  }

  @override
  Widget build(BuildContext context) {
    //4. MyHomePageの画面を構築する部分
    return Scaffold(
      // 画面上部のタイトル部分
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.create),
            Text("初めてのFlutter"),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
          //Columnだと縦方向、rowだと横方向が主軸となる
          child: Column(
        // 主軸を元に各要素をどこにどのように配置するか指定する 今回は中央位置に配置
        mainAxisAlignment: MainAxisAlignment.center,
        //Widget型配列をchildrenに格納する
        //今回はWidgetを複数使用するためchildrenとなっている
        children: <Widget>[
          //図形表示
          AnimatedContainer(
            //アニメーションの持続時間
            duration: const Duration(seconds: 3),
            width: _flag ? 100 : 50,
            height: _flag ? 50 : 100,
            //flagがfalseの場合、上下左右にpadding30を追加する
            padding: _flag ? const EdgeInsets.all(0) : const EdgeInsets.all(30),
            //flagがfalseの場合、上下左右にmargin30を追加する
            margin: _flag ? const EdgeInsets.all(0) : const EdgeInsets.all(30),
            //X軸方向の歪みを設定する
            transform: _flag ? Matrix4.skewX(0.0) : Matrix4.skewX(0.3),
            color: _flag ? Colors.blue : Colors.grey,
          ),
          AnimatedSwitcher(
            //アニメーションの持続時間
            duration: const Duration(seconds: 3),
            child: _flag
                ? const Text("何もない")
                : const Icon(Icons.favorite, color: Colors.pink),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _click(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
