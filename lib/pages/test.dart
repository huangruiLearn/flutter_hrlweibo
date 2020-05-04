import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'showModalBottomSheet',
      home: BasicPage(),
    );
  }
}

class BasicPage extends StatefulWidget {
  @override
  _BasicPageState createState() => _BasicPageState();
}

class _BasicPageState extends State<BasicPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("showModalBottomSheet"),
      ),
      body: Center(

      ),
      bottomNavigationBar: BottomAppBar(
        child: bottomNewCommentButton(),
      ),
    );
  }

  Container bottomNewCommentButton(){
    return Container(
      child: RaisedButton(
        child: Text("Publish", style: TextStyle(fontSize: 20.0, color: Colors.white)),
        color: Colors.blue[300],
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context){
                return new AnimatedPadding(
                  padding: MediaQuery.of(context).viewInsets,
                  duration: const Duration(milliseconds: 100),
                  child: Container(
                    child: textField(),
                    padding: EdgeInsets.all(7),
                  ),
                );
              }
          );
        },
      ),
      height: 50,
    );
  }

  Row textField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: new TextField(
            decoration: InputDecoration(
              hintText: 'Say something here...',
              border: null,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue[300]),
              ),
            ),
            keyboardType: TextInputType.text,
            maxLength: 250,
            maxLines: 10,
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

}