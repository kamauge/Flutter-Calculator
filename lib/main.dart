import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple Interest Flutter App',
    home: SIForm(),
    theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formKey = GlobalKey<FormState>();
  var _currencies = ['Dollars', 'Euro', 'Pounds'];
  final _minimumPadding = 5.0;
  var _currentSelectedItem = '';

  @override
  void initState(){
    _currentSelectedItem = _currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController rosController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: Form(
        key: _formKey,
        //margin: EdgeInsets.all(_minimumPadding * 2),
        child:Padding(
        padding: EdgeInsets.all(_minimumPadding * 2),
        child: ListView(
          children: <Widget>[
            getImageAsset(),
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: principalController,
                  validator: (String value){
                    if(value.isEmpty){
                      return 'Please enter Principle Amount';
                    }
                    },
                  decoration: InputDecoration(
                      labelText: 'Principal',
                      labelStyle: textStyle,
                      hintText: 'Enter Principle',
                      errorStyle: TextStyle(
                        color: Colors.yellow,
                        fontSize: 15.0
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: rosController,
                  validator: (String value){
                    if(value.isEmpty){
                      return 'Please enter the rate of interest';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Rate of Interest',
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0
                      ),
                      hintText: 'In Percent',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: termController,
                      validator: (String value){
                        if(value.isEmpty){
                          return 'Please input number of years';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Term',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 15.0
                          ),

                          hintText: 'Time in years',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                    Container(width: _minimumPadding * 5),
                    Expanded(
                        child: DropdownButton<String>(
                      items: _currencies.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      value: _currentSelectedItem,
                      onChanged: (String newValueSelected) {
                        _onDropDownItemSelected(newValueSelected);
                      },
                    ))
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      textColor: Theme.of(context).primaryColorDark,
                      child: Text(
                        'Calculate',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          if(_formKey.currentState.validate()){
                          this.displayResult = _calculateTotalReturns();
                        }});
                      },
                    )),
                    Expanded(
                        child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Reset',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          _reset();
                        });
                      },
                    ))
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(top: _minimumPadding,bottom: _minimumPadding),
              child: Text(this.displayResult, style: textStyle,),
            )
          ],
        )),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );

    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentSelectedItem = newValueSelected;
    });
  }

  String _calculateTotalReturns() {

    double principal = double.parse(principalController.text);
    double roi = double.parse(rosController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal + (principal * roi * term) /100;
    String result = 'After $term years, your investment will be worth $totalAmountPayable $_currentSelectedItem';
    return result;

  }

  void _reset() {
    principalController.text ='';
    rosController.text='';
    termController.text='';
    displayResult = '';
    _currentSelectedItem = _currencies[0];
  }
}
