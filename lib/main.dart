import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "BMI Calculator",
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double bmi;
  final TextEditingController feetHeightController = TextEditingController();
  final TextEditingController inchHeightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  displaySnackBar(String msg, GlobalKey<ScaffoldState> _scaffoldKey,
      [Color color = Colors.black87]) {
    final snackBar = SnackBar(
      content: Text(msg),
      backgroundColor: color,
      duration: Duration(milliseconds: 1200),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("BMI Calculator"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                print("Icon Pressed");
              }),
          IconButton(
              icon: Icon(
                Icons.arrow_downward,
                color: Colors.white,
              ),
              onPressed: () {
                print("Second Icon Pressed");
              })
        ],
      ),
      body: Container(
        child: Form(
            child: Container(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 50, top: 30),
                child: Align(
                  alignment: Alignment.center,
                  child: Material(
                    elevation: 4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/logo.png',
                        width: 100,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30.0, right: 8),
                      child: TextFormField(
                        controller: feetHeightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "Feets",
                            labelText: 'Feets',
                            suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  feetHeightController.text = '';
                                }),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3))),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30.0, left: 8),
                      child: TextFormField(
                        controller: inchHeightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "Inches",
                            labelText: 'Inches',
                            suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  inchHeightController.text = '';
                                }),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3))),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: TextFormField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Enter Weight in KG",
                      labelText: 'Enter Weight',
                      prefixIcon: Icon(Icons.ac_unit),
                      suffixIcon: IconButton(
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            weightController.text = '';
                          }),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3))),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: RaisedButton(
                          elevation: 5,
                          child: Text(
                            "Clear",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.red,
                          onPressed: () {
                            weightController.text = '';
                            feetHeightController.text = '';
                            inchHeightController.text = '';
                          }),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: RaisedButton(
                          elevation: 5,
                          child: Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.deepPurple,
                          onPressed: () {
                            if (weightController.text == '' ||
                                feetHeightController.text == '' ||
                                inchHeightController.text == '') {
                              displaySnackBar(
                                  'Please Enter All Values', _scaffoldKey);
                            } else {
                              double feet =
                                  double.parse(feetHeightController.text);
                              double inch =
                                  double.parse(inchHeightController.text);
                              double totalHeight = feet * 12 + inch;
                              double meter = totalHeight * 0.0254;
                              bmi = double.parse(weightController.text) /
                                  (meter * meter);
                              setState(() {
                                bmi = double.parse(bmi.toStringAsFixed(3));
                              });
                            }
                          }),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 30),
                child: Center(
                    child: bmi == null || bmi <= 0
                        ? Container()
                        : Text(
                            "Result - $bmi",
                            style: TextStyle(fontSize: 30),
                          )),
              )
            ],
          ),
        )),
      ),
    );
  }
}
