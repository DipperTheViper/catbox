import 'package:flutter/material.dart';
import '../widgets/cat.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double>? catAnimation;
  AnimationController? catController;

  @override
  void initState() {
    super.initState();
    catController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    catAnimation = Tween(begin: 0.0, end: 100.0).animate(
      CurvedAnimation(
        parent: catController!,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );
  }

  onTap() {
    if (catController!.status == AnimationStatus.completed) {
      catController!.reverse();
    } else if (catController!.status == AnimationStatus.dismissed) {
      catController!.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat Box'),
        backgroundColor: Colors.greenAccent,
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            children: [
              buildCatAnimation(),
              buildBox(),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation!,
      builder: (context, child) {
        return Container(
          child: child,
          margin: EdgeInsets.only(top: catAnimation!.value),
        );
      },
      child: const Cat(),
    );
  }

  Widget buildBox() {
    return Center(
      child: Container(
        child: const Center(
          child: Text('Tap on me!',
          style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,),),
        ),
        height: 375.0,
        width: 300.0,
        color: Colors.lightGreenAccent,
      ),
    );
  }
}
