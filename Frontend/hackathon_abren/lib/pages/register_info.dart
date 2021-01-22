import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackathonabren/pages/register_preference.dart';
import 'package:image_picker/image_picker.dart';

class RegisterInfo extends StatefulWidget {
  final String role;
  const RegisterInfo({Key key, this.role}) : super(key: key);
  @override
  _RegisterInfoState createState() => _RegisterInfoState();
}

class _RegisterInfoState extends State<RegisterInfo> {
  TextEditingController _phoneNumberController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _fathersNameController = new TextEditingController();
  TextEditingController _idCardController = new TextEditingController();
  TextEditingController _emergencyContactController =
      new TextEditingController();
  TextEditingController _licensePlateController = new TextEditingController();
  TextEditingController _carTypeController = new TextEditingController();
  TextEditingController _carColorController = new TextEditingController();

  String _currentSelectedGender, _currentSelectedAgeGroup;
  List _genderMenuItems, _ageGroupMenuItems;
  List<String> _genders = ["Female", "Male"];
  List<String> _ageGroups = ["18 - 25", "25 - 50", "> 50"];

  final picker = ImagePicker();
  Future<PickedFile> pickedFile;
  String image = "";

  Future getImage() async {
    setState(() {
      pickedFile = picker.getImage(source: ImageSource.camera);
    });
  }


  @override
  void initState() {
    _currentSelectedGender = _genders[0];
    _currentSelectedAgeGroup = "18 - 25";
    _genderMenuItems = buildDropdownMenuItems(_genders);
    _ageGroupMenuItems = buildDropdownMenuItems(_ageGroups);
    super.initState();
  }

  Widget textField(TextEditingController controller, String hint,
      [bool isNumber = false, Icon icon]) {
    return Material(
      elevation: 1,
      child: TextFormField(
        controller: controller,
        keyboardType: (() {
          if (isNumber) return TextInputType.number;
        })(),
        inputFormatters: (() {
          if (isNumber)
            return <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly];
        })(),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[500], fontSize: 15),
            fillColor: Colors.white,
            filled: true,
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor)),
            prefixIcon: icon),
      ),
    );
  }

  List<DropdownMenuItem<String>> buildDropdownMenuItems(List options) {
    List<DropdownMenuItem<String>> items = List();
    for (String option in options) {
      items.add(
        DropdownMenuItem(
          value: option,
          child: Text(option),
        ),
      );
    }
    return items;
  }

  Widget dropdownField(String type, List<String> list) {
    return Material(
      elevation: 1,
      child: InputDecorator(
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            value: type == "Gender"
                ? _currentSelectedGender
                : _currentSelectedAgeGroup,
            items: type == "Gender" ? _genderMenuItems : _ageGroupMenuItems,
            onChanged: (newValue) {
              setState(() {
                type == "Gender"
                    ? _currentSelectedGender = newValue
                    : _currentSelectedAgeGroup = newValue;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget driverInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 20),
        Text(
          "Vehicle Information",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        textField(_licensePlateController, "License Plate Number"),
        SizedBox(height: 20),
        textField(_carTypeController, "Car Type"),
        SizedBox(height: 20),
        textField(_carColorController, "Car Color"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColor,
          ),
          title: Text(
            'Register',
            style: TextStyle(color: Theme.of(context).primaryColor),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Personal Information",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Expanded(
                      child: Material(
                        elevation: 1,
                        child: TextFormField(
                          initialValue: "+251",
                          readOnly: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                        flex: 4,
                        child:
                            textField(_phoneNumberController, "Phone Number", true)),
                  ],
                ),
              ),
              SizedBox(height: 20),
              textField(_nameController, "Name"),
              SizedBox(height: 20),
              textField(_fathersNameController, "Father's Name"),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                Expanded(child: textField("Name")),
//                SizedBox(width: 10),
//                Expanded(child: textField("Father's Name"))
//              ],
//            ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Gender",
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Age Group",
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(child: dropdownField("Gender", _genders)),
                  SizedBox(width: 10),
                  Expanded(child: dropdownField("Age Group", _ageGroups)),
                ],
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: getImage,
                child: Card(
                  elevation: 1,
                  margin: EdgeInsets.zero,
                  child: Column(
                    children: [
                      ListTile(
                        leading:  Icon(
                            Icons.camera_alt,
                            color: Colors.grey[500]
                        ),
                        title: Text(
                            "Select Image of Kebele Id", //TODO: Edit icon
                            style: TextStyle(color: Colors.grey[500], fontSize: 15),
                        )
                      ),
                      FutureBuilder<PickedFile>(
                        future: pickedFile,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done &&
                              null != snapshot.data) {
                            File file = File(snapshot.data.path);
                            image = base64Encode(file.readAsBytesSync());
                            return  ClipRRect(
                              child: Image.file(
                                file,
                                fit: BoxFit.contain,
                                height: screenWidth * 1 / 3,
                                width: screenWidth,
                              ),
                            );
                          } else if (null != snapshot.error) {
                            return Text(
                              'Error Picking Image',
                              textAlign: TextAlign.center,
                            );
                          } else {
                            return Text(
                              'No Image Selected',
                              style: TextStyle(color: Colors.grey[500], fontSize: 15),
                              textAlign: TextAlign.center,
                            );
                          }
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 20),

//              widget.user.role == "DRIVER"
//                  ? textField(
//                      _idCardController,
//                      "Picture of Kebele ID or Driver's License",
//                      false,
//                      Icon(Icons.camera_alt))
//                  : textField(_idCardController, "Picture of Kebele ID",
//                      false,
//                      Icon(Icons.camera_alt)),
              SizedBox(height: 30),
              Text(
                "Emergency Contact Information",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Expanded(
                      child: Material(
                        elevation: 1,
                        child: TextFormField(
                          initialValue: "+251",
                          readOnly: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                        flex: 4,
                        child: textField(
                            _emergencyContactController, "Phone Number", true)),
                  ],
                ),
              ),
              if (widget.role == "DRIVER") driverInfo(),
              SizedBox(height: 30),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_ios),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child:
                                Text("Back", overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                      child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RegisterPreference()),
                      );
                    },
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Flexible(
                          child:
                              Text("Continue", overflow: TextOverflow.ellipsis),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
