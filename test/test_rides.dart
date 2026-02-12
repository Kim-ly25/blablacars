// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:blablacars/model/ride/locations.dart';
import 'package:blablacars/services/rides_service.dart';


void main() {
  RidesService.filterBy(
    departure: Location(name: "Dijon", country: Country.france),
    seatRequested: 2,
  ); // Shall return 1 ride
  
}
