import 'package:flutter/material.dart';

class CircuitType extends StatefulWidget {
  State<StatefulWidget> createState() {
    return CircuitTypeState();
  }
}

class CircuitTypeState extends State<CircuitType> {

  List<String> circuitTypeList = ["3Phase4Wire","3Phase3Wire"];

  @override
  Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(
          title: Text("Choose Circuit"),
        ),
        body: _buildCircuitTypeList(),
        );
  }



      Widget _buildCircuitTypeList() {
  return ListView.builder(
  itemBuilder: (context, position) {
    var item = circuitTypeList[position];
    return _buildTile(item);
    
  },
  itemCount: circuitTypeList.length,
 
);
}

Widget _buildTile(String str) {
  return ListTile(
    title: Text(str),
    onTap: () => Navigator.pushNamed(context,"/$str")
                // Padding(
                //   padding:
                //       const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                //   child: Text(
                //     str,
                //     style: TextStyle(
                //         fontSize: 22.0, fontWeight: FontWeight.bold),
                //   ),
                // ),
                // Padding(
                //   padding:
                //       const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                //   child: Text(
                //     circuitTypeList[position],
                //     style: TextStyle(fontSize: 18.0),
                //   ),
                // ),
            //  ],
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: <Widget>[
            //       // Text(
            //       //   "5m",
            //       //   style: TextStyle(color: Colors.grey),
            //       // ),
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Icon(
            //           Icons.arrow_forward,
            //           size: 35.0,
            //           color: Colors.grey,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          //],
       // ),
        // Divider(
        //   height: 2.0,
        //   color: Colors.grey,
        // ),
   //   ],
   // ),
    
  );
}



}