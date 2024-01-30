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
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//アニメーションを使用するためTickerProviderStateMixinを使用
class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  //AnimationControllerをインスタンス化
  //lateは非同期の初期化
  late AnimationController _animationController;

//実行
  _forward() async {
    setState(() {
      _animationController.forward();
    });
  }

//停止
  _stop() async {
    setState(() {
      _animationController.stop();
    });
  }

//逆再生
  _reverse() async {
    setState(() {
      _animationController.reverse();
    });
  }

  //生成
  //読み込み時に読み込まれる(公式のメソッド)
  @override
  void initState() {
    //親クラスが継承しているinitStateを実行する
    super.initState();
    //thisは現在のインスタンスを指している
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
  }

  //破棄
  //ウィジェットが削除された際に動作する(公式のメソッド)
  @override
  void dispose() {
    //インスタンス化したクラスと継承元のクラスから破棄する
    //必ずインスタンス化したクラスから破棄する必要がある
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //ウィジェットのサイズをアニメーション化するために使われるウィジェット
            SizeTransition(
              //sizeFactorにAnimationControllerを指定することで操作が可能
              sizeFactor: _animationController,
              //横を拡大、収縮させたい場合は下記を追加(縦はデフォルトのため記述不要)
              axis: Axis.horizontal,
              child: Center(
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: Container(color: Colors.green),
                ),
              ),
            )
          ],
        )),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
                onPressed: _forward, child: const Icon(Icons.arrow_forward)),
            FloatingActionButton(
                onPressed: _stop, child: const Icon(Icons.pause)),
            FloatingActionButton(
                onPressed: _reverse, child: const Icon(Icons.arrow_back))
          ],
        ));
  }
}
