import 'package:flutter/material.dart';
import 'dart:math';

class CC_Page3 extends StatefulWidget {
  final String current;
  final String power;
  final String voltage;
  final String pf;
  final String meterType;
  final String _voltage_string;

  CC_Page3(this.current, this.power, this.voltage, this.pf, this.meterType,this._voltage_string);

  @override
  State<StatefulWidget> createState() {
    return _CC_Page3_State();
  }
}

class _CC_Page3_State extends State<CC_Page3> {
  
  TextEditingController voltscontroller = new TextEditingController();
  TextEditingController currentcontroller = new TextEditingController();
  TextEditingController purposedServiceSizeController =
      new TextEditingController();
  TextEditingController transformerSizeController = new TextEditingController();
  TextEditingController proposedPtSizeController = new TextEditingController();
  TextEditingController proposedCtSizeController = new TextEditingController();

  int proposed_service_size(double current_val, String meterType) {
    if (meterType == "Primary") {
      return -3;
    } else if (meterType == "Secondary") {
      double i = 110;
      int proposed_service_size = 100;
      if (current_val <= 110) {
        print(
            "returning from if proposed_service_size = $proposed_service_size");
        return proposed_service_size;
      }

      for (;; i = i + 100) {
        print("in loop of proposed_service_size i= $i");
        print("in loop of proposed_service_size = $proposed_service_size");
        proposed_service_size = proposed_service_size + 100;

        if ((current_val > i) && (current_val <= (i + 100))) {
          print(
              "returning from loop proposed_service_size = $proposed_service_size");
          return proposed_service_size;
        }
      }
    }
  }

  int transformerSize(
      double current_val, double voltage_val, String meterType) {
    if (meterType == "Primary") {
      return -3;
    } else if (meterType == "Secondary") {
      return ((sqrt(3) * voltage_val * current_val)/1000).round();
    }
  }

  String purposedPtSize(double voltage_val, String meterType) {
    print("--------in purposedPtSize $voltage_val");
    if (meterType == "Primary") {
      if (voltage_val == 44000.0) {
        return "44000:120 PT";
      }
      // } else if (voltage_val == 8320.0) {
      //   return "4800:120 PT";
      // } else if (voltage_val == 13800.0) {
      //   return "8000:120 PT";
      // }
    } else if (meterType == "Secondary") {
      if (voltage_val == 600.0) {
        return "600:120 PT";
      } 
      // else if (voltage_val == 600.0) {
      //   return "360:120 PT";
      // }
    }
  }

  String purposedCTSize(double current_val, String meterType) {
    if (meterType == "Primary") {
      if (current_val <= 15) {
        return "10:5";
      } else if (current_val <= 22 && current_val > 15) {
        return "15:5";
      }
      else if (current_val <= 30 && current_val > 22) {
        return "20:5";
      }
      else if (current_val <= 38 && current_val > 30) {
        return "25:5";
      }
      else if (current_val <= 75 && current_val > 38) {
        return "50:5";
      }
      else if (current_val <= 112 && current_val > 75) {
        return "75:5";
      }
      else if (current_val <= 150 && current_val > 112) {
        return "100:5";
      }
      else if (current_val <= 300 && current_val > 150) {
        return "200:5";
      }
      else if (current_val <= 450 && current_val > 300) {
        return "300:5";
      }
      else if (current_val <= 600 && current_val > 450) {
        return "400:5";
      }
      else if (current_val <= 750 && current_val > 600) {
        return "500:5";
      }
      else if (current_val <= 900 && current_val > 750) {
        return "600:5";
      }
      else if (current_val > 900) {
        return "Contact Meter Tech";
      }
    } else if (meterType == "Secondary") {
      if (current_val <= 405) {
        return "200:5";
      } else if (current_val <= 450 && current_val > 405) {
        return "300:5";
      } else if (current_val <= 800 && current_val > 450) {
        return "400:5";
      } else if (current_val <= 900 && current_val > 800) {
        return "600:5";
      } else if (current_val <= 1600 && current_val > 900) {
        return "800:5";
      } else if (current_val <= 3000 && current_val > 1600) {
        return "1500:5";
      } else {
        return "Please Contact Meter Tech";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print("#####Voltage String######");
    print(widget._voltage_string.toString());
    voltscontroller.text = widget._voltage_string.toString();


    //voltscontroller.text = widget.voltage.toString();
    String meterType = widget.meterType.toString();
    print("******in screen 2 3 phase 3 wire***** $meterType");
    double current_val = double.parse(widget.current.toString());
    double voltage_val = double.parse(widget.voltage.toString());

    int pss = proposed_service_size(current_val, meterType);
    if (pss < 0) {
      purposedServiceSizeController.text = "N/A primary metering";
    } else {
      purposedServiceSizeController.text = pss.toString();
    }
    purposedServiceSizeController.text = pss.toString();
    String current_value =widget.current.toString();
    currentcontroller.text = "$current_value Amps";

    int ts = transformerSize(current_val, voltage_val, meterType);
    if (ts < 0) {
      transformerSizeController.text = "Customer Owned";
    } else {
       transformerSizeController.text = "$ts KVA";
      //transformerSizeController.text = ts.toString();
    }

    proposedPtSizeController.text = purposedPtSize(voltage_val, meterType);
    proposedCtSizeController.text = purposedCTSize(current_val,meterType);

    ThemeData theme = Theme.of(context);
    if (meterType == "Primary") {
      return for_primaryMetering();
    } else if (meterType == "Secondary") {
      return for_secondaryMetering();
    }

    // return Scaffold(
    //     appBar: AppBar(
    //       title: Text("Current Calculator"),
    //       leading: IconButton(
    //           icon: Icon(Icons.arrow_back),
    //           onPressed: () => Navigator.pop(context, false)),
    //     ),
    //     body: ListView(children: [
    //       Container(
    //           margin: EdgeInsets.all(20),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: <Widget>[
    //               TextField(
    //                   decoration: InputDecoration(
    //                       labelText: "Current ",
    //                       labelStyle: TextStyle(
    //                           color: Colors.blue, fontWeight: FontWeight.w400)),
    //                   style: TextStyle(
    //                       color: Colors.black,
    //                       fontWeight: FontWeight.w600,
    //                       fontSize: 25.0),
    //                   controller: currentcontroller,
    //                   enabled: false),
    //               TextField(
    //                   decoration: InputDecoration(
    //                       labelText: "Voltage ",
    //                       labelStyle: TextStyle(
    //                           color: Colors.blue, fontWeight: FontWeight.w400)),
    //                   style: TextStyle(
    //                       color: Colors.black,
    //                       fontWeight: FontWeight.w600,
    //                       fontSize: 25.0),
    //                   controller: voltscontroller,
    //                   enabled: false),
    //               TextField(
    //                   decoration: InputDecoration(
    //                       labelText: "Purposed Service Size ",
    //                       labelStyle: TextStyle(
    //                           color: Colors.blue, fontWeight: FontWeight.w400)),
    //                   style: TextStyle(
    //                       color: Colors.black,
    //                       fontWeight: FontWeight.w600,
    //                       fontSize: 25.0),
    //                   controller: purposedServiceSizeController,
    //                   enabled: false),
    //               TextField(
    //                   decoration: InputDecoration(
    //                       labelText: "Transformer Size",
    //                       labelStyle: TextStyle(
    //                           color: Colors.blue, fontWeight: FontWeight.w400)),
    //                   style: TextStyle(
    //                       color: Colors.black,
    //                       fontWeight: FontWeight.w600,
    //                       fontSize: 25.0),
    //                   controller: transformerSizeController,
    //                   enabled: false),
    //               TextField(
    //                   decoration: InputDecoration(
    //                       labelText: "Purposed PT Size",
    //                       labelStyle: TextStyle(
    //                           color: Colors.blue, fontWeight: FontWeight.w400)),
    //                   style: TextStyle(
    //                       color: Colors.black,
    //                       fontWeight: FontWeight.w600,
    //                       fontSize: 25.0),
    //                   controller: proposedPtSizeController,
    //                   enabled: false),
    //               TextField(
    //                   decoration: InputDecoration(
    //                       labelText: "Purposed CT Size",
    //                       labelStyle: TextStyle(
    //                           color: Colors.blue, fontWeight: FontWeight.w400)),
    //                   style: TextStyle(
    //                       color: Colors.black,
    //                       fontWeight: FontWeight.w600,
    //                       fontSize: 25.0),
    //                   controller: proposedCtSizeController,
    //                   enabled: false)
    //             ],
    //           ))
    //     ]));
  }

  Widget for_primaryMetering() {
    return Scaffold(
        appBar: AppBar(
          title: Text("Current Calculator"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false)),
        ),
        body: ListView(children: [
          Container(
              margin: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                      decoration: InputDecoration(
                          labelText: "Current ",
                          labelStyle: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w400)),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 25.0),
                      controller: currentcontroller,
                      enabled: false),
                  TextField(
                      decoration: InputDecoration(
                          labelText: "Voltage ",
                          labelStyle: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w400)),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 25.0),
                      controller: voltscontroller,
                      enabled: false),
                  TextField(
                      decoration: InputDecoration(
                          labelText: "Min. Transformer Kva Reqd.",
                          labelStyle: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w400)),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 25.0),
                      controller: transformerSizeController,
                      enabled: false),
                  TextField(
                      decoration: InputDecoration(
                          labelText: "Purposed PT Size",
                          labelStyle: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w400)),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 25.0),
                      controller: proposedPtSizeController,
                      enabled: false),
                  TextField(
                      decoration: InputDecoration(
                          labelText: "Purposed CT Size",
                          labelStyle: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w400)),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 25.0),
                      controller: proposedCtSizeController,
                      enabled: false)
                ],
              ))
        ]));
  }

  Widget for_secondaryMetering() {
    return Scaffold(
        appBar: AppBar(
          title: Text("Current Calculator"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false)),
        ),
        body: ListView(children: [
          Container(
              margin: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                      decoration: InputDecoration(
                          labelText: "Current ",
                          labelStyle: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w400)),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 25.0),
                      controller: currentcontroller,
                      enabled: false),
                  TextField(
                      decoration: InputDecoration(
                          labelText: "Voltage ",
                          labelStyle: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w400)),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 25.0),
                      controller: voltscontroller,
                      enabled: false),
                  TextField(
                      decoration: InputDecoration(
                          labelText: "Purposed Service Size ",
                          labelStyle: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w400)),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 25.0),
                      controller: purposedServiceSizeController,
                      enabled: false),
                  TextField(
                      decoration: InputDecoration(
                          labelText: "Min. Transformer Kva Reqd.",
                          labelStyle: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w400)),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 25.0),
                      controller: transformerSizeController,
                      enabled: false),
                  TextField(
                      decoration: InputDecoration(
                          labelText: "Purposed PT Size",
                          labelStyle: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w400)),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 25.0),
                      controller: proposedPtSizeController,
                      enabled: false),
                  TextField(
                      decoration: InputDecoration(
                          labelText: "Purposed CT Size",
                          labelStyle: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w400)),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 25.0),
                      controller: proposedCtSizeController,
                      enabled: false)
                ],
              ))
        ]));
  }
}
