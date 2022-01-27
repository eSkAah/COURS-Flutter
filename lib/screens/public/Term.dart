import 'package:flutter/material.dart';

class TermScreen extends StatefulWidget {
  final Function(int) nextStep;
  final String terms;

   const TermScreen({Key? key,
     required this.terms,
     required this.nextStep}) : super(key: key);

  @override
  _TermScreenState createState() => _TermScreenState();
}

class _TermScreenState extends State<TermScreen> {

  late ScrollController _scrollController;
  bool _terms = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if(_scrollController.offset >= _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange){
        setState(() => _terms = true);
      }

    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0.0,
          title: const Text('Terms & Conditions',
            style: TextStyle(
                color: Colors.black),),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () => widget.nextStep(0),
          )
        ),

        body:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child:
                SingleChildScrollView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(widget.terms),
                      ]
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: !_terms ? null : () {
                  print('accept');
                  widget.nextStep(2);
                },
                child: const Text('Read & Accepted',
                  style: TextStyle(
                    color: Colors.white),))
            ],
          ),
        )
      ),
    );
  }
}
