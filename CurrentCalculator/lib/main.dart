import 'package:flutter/material.dart';
import './phase3wire4/currentCalculatorForm.dart';
import './phase3wire4/currentCalculatePage2.dart';
import './phase3wire3/currentCalculatorForm2.dart';
import './phase3wire3/currentCalculatePage3.dart';
import 'circuitTypeList.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(
          seconds: 5,
          // the widget to run after running your splashscreen for 1 sec
          navigateAfterSeconds: CircuitType(),//CurrentCalculator_2(),
          title: Text(' '),
          image: Image.asset('assets/h1.png'),
          backgroundColor: Colors.white,
          styleTextUnderTheLoader: TextStyle(),
          photoSize: 100.0,
          loaderColor: Colors.red),
      onGenerateRoute: (RouteSettings settings) {
        // /detailId/5
        final List<String> pathElements = settings.name.split("/");

        if (pathElements[0] != "") {
          return null;
        }

        switch (pathElements[1]) {
          case "3Phase4Wire":
              return MaterialPageRoute(
              builder: (BuildContext) =>CurrentCalculator());
             break;
            case "3Phase3Wire":
              return MaterialPageRoute(
              builder: (BuildContext) =>CurrentCalculator_2());
             break;        
          case "current_3phase_4wire":
            final String current = pathElements[2];
            return MaterialPageRoute(
              builder: (BuildContext) => CC_Page2(pathElements[2],
                  pathElements[3], pathElements[4], pathElements[5],pathElements[6],pathElements[7]),
            );
            break;
          case "current_3phase_3wire":
            final String current2 = pathElements[2];
            return MaterialPageRoute(
              builder: (BuildContext) => CC_Page3(pathElements[2],
                  pathElements[3], pathElements[4], pathElements[5],pathElements[6],pathElements[7]),
            );
            break;

          default:
            return null;
          //  case "feed" :
          //          return MaterialPageRoute(
          //            builder: (BuildContext) => FeedPage(),
          //          );

          //  case "detailId":
          //        final String detailId = pathElements[2];
          //        // /detailId/5
          //        // [0]/[1]/[2]
          //        print("DetailId: $detailId")  ;

          //        String itemName = "Item Detail: $detailId";

          //        if(detailId.isEmpty)
          //        {return MaterialPageRoute(
          //          builder: (BuildContext)=> DetailPage("No Detail"));
          //          }
          //          return MaterialPageRoute(
          //          builder: (BuildContext)=> DetailPage(itemName));

        }
      },
    );
  }
}
