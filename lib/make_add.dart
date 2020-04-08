import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:search_india/add_mid.dart';
import 'package:search_india/register_page.dart';

class CreateAdd extends StatefulWidget {
  @override
  _CreateAddState createState() => _CreateAddState();
}

class _CreateAddState extends State<CreateAdd> {
  int a = 0;
  int b = 0;
  bool val = false;
  String reward = "0";
  String cityname;
  String desc;
  String selectedCurrency = 'Select a Category';
  final currenciesList = [
    'Select a Category',
    'MOBILE',
    'PEOPLE',
    'BAGS',
    'PETS',
    'VEHICLES',
    'DOCUMENTS'
  ];
  Position _currentPosition;
  _getCurrentLocation() {
    geoLocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position p) {
      setState(() {
        _currentPosition = p;
      });
      _getAddress();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddress() async {
    try {
      List<Placemark> p = await geoLocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      Placemark place = p[0];

      setState(() {
       cityname = "${place.locality}";
       print(cityname);
      });
    } catch (e) {
      print(e);
    }
  }


  DropdownButton<String> androidDropdown(currenciesList) {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      isExpanded: true,
      style: TextStyle(color: Colors.black),
      value: selectedCurrency,
      items: dropdownItems,
      focusColor: Colors.black,
      dropdownColor: Colors.white,
      iconEnabledColor: Colors.black,
      onChanged: (value) {
        if (mounted)
          setState(() {
            selectedCurrency = value;
          });
      },
    );
  }

  String subcategory = 'Select a SubCategory';
  final ist = ['Select a SubCategory', 'car', 'bike', 'cycle', 'scooty'];

  final ist1 = [
    'Select a SubCategory',
    'girl',
    'boy',
    'child',
    'senior citizen'
  ];

  DropdownButton<String> androidDropdown2(currenciesList) {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    

    return DropdownButton<String>(
      isExpanded: true,
      value: subcategory,
      style: TextStyle(color: Colors.black),
      items: dropdownItems,
      focusColor: Colors.black,
      dropdownColor: Colors.white,
      iconEnabledColor: Colors.black,
      onChanged: (value) {
        setState(() {
          subcategory = value;
        });
      },
    );
  }
  @override
  void initState() {
    super.initState();
  _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text("Create Report"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 10.0),
              child: Text(
                'Category *',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: androidDropdown(currenciesList),
            ),
            (selectedCurrency == 'VEHICLES')
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: androidDropdown2(ist),
                  )
                : Container(),
            (selectedCurrency == 'PEOPLE')
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: androidDropdown2(ist1),
                  )
                : Container(),
            Row(children: <Widget>[
              Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    'Post Type',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Text(
                      '*',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Colors.red,
                      ),
                  ),
                   ),
                ],
              ),
            ),
            SizedBox(width: 80.0,),
            Column(
              children: <Widget>[
               Row(children: <Widget>[
                  Radio(
                  value: 0,
                  activeColor: Colors.black,
                  onChanged: (i) {
                    setState(() {
                      a = i;
                    });
                  },
                  groupValue: a,
                ),
                Text(
                  'Lost',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
               ],),
                Container(child: Divider(color: Colors.blue,thickness: 2.0,)),
                Row(children: <Widget>[
                  Radio(
                  value: 1,
                  activeColor: Colors.black,
                  onChanged: (i) {
                    setState(() {
                      a = i;
                    });
                  },
                  groupValue: a,
                ),
                Text(
                  'Found',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                )
                ],)
              ],
            ),
            ],),
            Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
              ),
              child: Text(
                'Emergency',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: 0,
                  activeColor: Colors.black,
                  onChanged: (i) {
                    setState(() {
                      b = i;
                    });
                  },
                  groupValue: b,
                ),
                Text(
                  'Yes',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                SizedBox(
                  width: 30,
                ),
                Radio(
                  value: 1,
                  activeColor: Colors.black,
                  onChanged: (i) {
                    setState(() {
                      b = i;
                    });
                  },
                  groupValue: b,
                ),
                Text(
                  'No',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
            Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    'Title ',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Text(
                      '*',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Colors.red,
                      ),
                  ),
                   )
                ],
              ),
            ),
            TextField(
              style: TextStyle(fontSize: 16, color: Colors.black),
              textCapitalization: selectedCurrency == "VEHICLES"
                  ? TextCapitalization.characters
                  : TextCapitalization.words,
              decoration: InputDecoration(
                hintText: 'Atleast 60 characters needed',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Text(
                      '*',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Colors.red,
                      ),
                  ),
                   )
                ],
              ),
            ),
            TextField(
              onChanged: (val){
                desc=val;
              },
              style: TextStyle(fontSize: 16, color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Important Information',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
              ),
              child: Wrap(
                children: <Widget>[
                  Text(

                    'Last Location of Lost and',
                    style: TextStyle(
                      
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                       'Found',
                       style: TextStyle(
                         fontSize: 22,
                         fontWeight: FontWeight.w400,
                         color: Colors.black,
                       ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                         '*',
                         style: TextStyle(
                           fontSize: 22,
                           fontWeight: FontWeight.w400,
                           color: Colors.red,
                         ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            TextField(
              onChanged: (val) {
                //reward = val;
              },
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 16, color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Eg. Delhi',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
              ),
              child: Text(
                'Reward',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            TextField(
              onChanged: (val) {
                reward = val;
              },
              keyboardType: TextInputType.numberWithOptions(),
              style: TextStyle(fontSize: 16, color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Enter Reward in ₹ if applicable',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Text(
                'City *',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            TextField(
              style: TextStyle(fontSize: 16, color: Colors.black),
              onChanged: (val) {
                if(val!=""|| val!=null)
                cityname = val;
              },
              decoration: InputDecoration(
                hintText: cityname==null? 'City': cityname,
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MakeAdd(
                      map: {
                        'reward': reward==null? "0": reward,
                        'category': selectedCurrency,
                        'subcategory': subcategory,
                        'posttype': a.toString(),
                        'city': cityname,
                        'desc': desc
                      },
                    ),
                  ),
                );
              },
              child: Center(
                child: Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Colors.black),
                  child: Center(
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
