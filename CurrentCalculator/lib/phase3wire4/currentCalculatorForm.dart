import 'package:flutter/material.dart';
import 'dart:math';

class CurrentCalculator extends StatefulWidget {
  State<StatefulWidget> createState() {
    return CurrentCalculatorState();
  }
}

class CurrentCalculatorState extends State<CurrentCalculator> {
  String _power;
  String _voltage;
  String _voltage_string;
  String _pf;
  String _meterType;

  List<String> primary_selected = <String>[
    '',
    '27.6/16 KV',
    '8.32/4.8 KV',
    '13.8/8 KV'
  ];
  List<String> secondary_selected = <String>['', '120/208 V', '347/600 V'];

  List<String> _voltage_3phase4wire = <String>[''];
  List<String> _secondary_voltage_3phase4wire = <String>[
    '',
    '120/208 V',
    '347/600 V'
  ];
  String _selected_voltage = '';

  List<String> _meterType_3phase4wire = <String>['', 'Primary', 'Secondary'];
  String _selected_meterType = '';

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget _buildPower() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Power in KW:"),
      maxLength: 10,
      keyboardType: TextInputType.number,
      validator: (String value) {
        double power = double.tryParse(value);

        if (power == null || power <= 0) {
          return 'Power Must be greater than 0';
        }

        return null;
      },
      onSaved: (String value) {
        _power = value;
      },
    );
  }

  Widget _buildPf() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Power Factor (0,1] :"),
      maxLength: 10,
      keyboardType: TextInputType.number,
      validator: (String value) {
        double pf = 0;
         print ("in pf validator $value");
        if (value == null || value == "") {
          return 'Enter a Number greater than 0';
        } else {
          double pf = double.tryParse(value);
          if (pf <= 0 || pf > 1) {
            return 'Power Factor Must be between 0 and 1';
          }
        }

        return null;
      },
      onSaved: (String value) {
        _pf = value;
      },
    );
  }

  int _radioValue1 = -1;

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;

      switch (_radioValue1) {
        case 0:
          print("in flutter radio func $_radioValue1");
          _selected_meterType = "Primary";
          // _voltage_3phase4wire = primary_selected;
          setState(() {
            // _selected_meterType = newValue;

            print("radio new value:$_selected_meterType");
            print("in radio set state of prim/secondary");

            _voltage_3phase4wire = primary_selected;

            _selected_voltage = "";
            // state.didChange(newValue);
          });
          break;
        case 1:
          print("in flutter radio func $_radioValue1");
          _selected_meterType = "Secondary";
          // _voltage_3phase4wire = secondary_selected;

          // _voltage_3phase4wire = secondary_selected;

          setState(() {
            // _selected_meterType = newValue;

            print("radio new value:$_selected_meterType");
            print("in radio set state of prim/secondary");

            _voltage_3phase4wire = secondary_selected;

            _selected_voltage = "";
            //state.didChange(newValue);
          });
          //Fluttertoast.showToast(msg: 'Try again !',toastLength: Toast.LENGTH_SHORT);
          break;
      }
    });
  }

  Widget _radioMeterType() {
    return new FormField<String>(builder: (FormFieldState<String> state) {
      return InputDecorator(
          decoration: InputDecoration(
            //icon: const Icon(Icons.power),
            //contentPadding: EdgeInsets.all(10),
            labelText: 'Meter Type',
            errorText: state.hasError ? state.errorText : null,
          ),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Radio(
                value: 0,
                groupValue: _radioValue1,
                onChanged: _handleRadioValueChange1,
              ),
              new Text(
                'Primary',
                style: new TextStyle(fontSize: 16.0),
              ),
              new Radio(
                value: 1,
                groupValue: _radioValue1,
                onChanged: _handleRadioValueChange1,
              ),
              new Text(
                'Secondary',
                style: new TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ));
    }, validator: (val) {
      print("in radio validator $val");
      if (_selected_meterType == null || _selected_meterType == "") {
        return 'Please select a Meter type';
      }
      return null;
    }, onSaved: (String value) {
      //'120/121', '120/240'
      print("in saved with value $value");
      //_meterType = value;
    });
  }

  Widget _buildVoltage2() {
    return new FormField<String>(builder: (FormFieldState<String> state) {
      return InputDecorator(
        decoration: InputDecoration(
          //icon: const Icon(Icons.power),
          labelText: 'Voltage',
          errorText: state.hasError ? state.errorText : null,
        ),
        isEmpty: _selected_voltage == '',
        child: new DropdownButtonHideUnderline(
          child: new DropdownButton<String>(
            value: _selected_voltage,
            isDense: true,
            onChanged: (String newValue) {
              setState(() {
                _selected_voltage = newValue;
                state.didChange(_selected_voltage);
              });
            },
            items: _voltage_3phase4wire.map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
          ),
        ),
      );
    }, validator: (val) {
      double vol_val = 0;
      print("in validator _buildVoltage2 with $val");
      if (val == null || val == "") {
        return 'Please select a Voltage';
      } 
      // else {
      //   vol_val = double.tryParse(val);
      //   if (vol_val <= 0) {
      //     return 'Voltage Must be greater than 0';
      //   }
      // }

      // else if (val == '' || val == null) {
      //   return 'Please select a Voltage';
      // }
      return null;
    }, onSaved: (String value) {
      //'120/121', '120/240'
      print("in saved");
      if (_selected_meterType == "Secondary") {
        if (value == "120/208 V") {
          _voltage = "208";
          _voltage_string = "120 | 208 V";
        } else if (value == "347/600 V") {
          _voltage = "600";
          _voltage_string = "347 | 600 V";
        }
      } else if (_selected_meterType == "Primary") {
        if (value == "27.6/16 KV") {
          _voltage = "27600";
          _voltage_string = "27.6 | 16 KV";
        } else if (value == "8.32/4.8 KV") {
          _voltage = "8320";
          _voltage_string = "8.32 | 4.8 KV";
        } else if (value == "13.8/8 KV") {
          _voltage = "13800";
          _voltage_string = "13.8 | 8 KV";
        }
      }
    });
  }

  Widget _buildVoltage() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Enter Voltage:"),
      maxLength: 10,
      keyboardType: TextInputType.number,
      validator: (String value) {
        double pf = double.tryParse(value);

        if (pf == null || pf <= 0) {
          return 'Voltage Must be greater than 0';
        }

        return null;
      },
      onSaved: (String value) {
        _voltage = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("in build method");
    //_voltage_3phase4wire = primary_selected;

    return Scaffold(
        appBar: AppBar(
          title: Text("Current Calculator"),
        ),
        body: ListView(children: [
          Container(
              margin: EdgeInsets.all(20),
              width: 4.0,
              child: Form(
                key: _formkey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildPower(),
                      _radioMeterType(),
                      _buildVoltage2(),
                      _buildPf(),
                      SizedBox(
                        height: 100,
                      ),
                      RaisedButton(
                          child: Text("Submit",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 16)),
                          onPressed: () {
                            if (!_formkey.currentState.validate()) {
                              return;
                            }

                            _formkey.currentState.save();

                            print("power is $_power ");
                            print("pf is $_pf ");
                            print("voltage is $_voltage ");
                            print("meter type is $_selected_meterType");
                            double power = double.parse(_power);
                            double voltage = double.parse(_voltage);
                            double pf = double.parse(_pf);

                            double current =
                                (power * 1000) / (sqrt(3) * voltage * pf);
                            String result_current = current.toStringAsFixed(2);
                            Navigator.pushNamed(context,
                                "/current_3phase_4wire/$result_current/$power/$voltage/$pf/$_selected_meterType/$_voltage_string").then( (_) => {_formkey.currentState.reset()});
                          })
                    ]),
              )),
        ]));
  }
}

// prevous approach for Drop down for Meter Type  and chaging voltage setting

// Widget _buildMeterType() {
//   return new FormField<String>(
//     builder: (FormFieldState<String> state) {
//       return InputDecorator(
//         //baseStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 25.0),
//         decoration: InputDecoration(
//           //icon: const Icon(Icons.power),
//           //contentPadding: EdgeInsets.all(10),
//           labelText: 'Meter Type',
//           errorText: state.hasError ? state.errorText : null,
//         ),
//         isEmpty: _selected_voltage == '',
//         child: new DropdownButtonHideUnderline(
//           child: new DropdownButton<String>(
//             isExpanded: true,
//             value: _selected_meterType,
//             isDense: true,
//             onChanged: (String newValue) {
//               setState(() {
//                 _selected_meterType = newValue;

//                 print("new value:$newValue");
//                 print("in set state of prim/secondary");
//                 if (newValue == "Primary") {
//                   _voltage_3phase4wire = primary_selected;
//                 } else if (newValue == "Secondary") {
//                   _voltage_3phase4wire = secondary_selected;
//                 }
//                 _selected_voltage = "";
//                 state.didChange(newValue);
//               });
//             },
//             items: _meterType_3phase4wire.map((String value) {
//               return new DropdownMenuItem<String>(
//                 value: value,
//                 child: new Text(value),
//               );
//             }).toList(),
//           ),
//         ),
//       );
//     },
//     validator: (val) {
//       print("in validator");
//       return val != '' ? null : 'Please select a Meter Type';
//     },
//     // onSaved: (String value){
//     //   //'120/121', '120/240'
//     //   print("in saved");
//     //     if(value == "Primary")
//     //      { _voltage_3phase4wire = primary_selected;}
//     //       else if(value == "Secondary")
//     //       { _voltage_3phase4wire = secondary_selected;}
//     //     }
//   );
// }
