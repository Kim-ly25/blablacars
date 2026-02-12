import 'package:flutter/material.dart';

import '../ride_prefs_screen.dart';
import '../../../widgets/actions/bla_button.dart';
import '../../../../services/locations_service.dart';
import '../../../theme/theme.dart';
import '../../../../utils/date_time_util.dart';
import '../../../widgets/display/bla_divider.dart';
import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import 'location_picker.dart' as location_picker;
import 'from_picker.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;
  bool swapOnDeparture = true;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    // TODO
    departure = widget.initRidePref?.departure;
    arrival = widget.initRidePref?.arrival;
    departureDate = widget.initRidePref?.departureDate ?? DateTime.now();
    requestedSeats = widget.initRidePref?.requestedSeats ?? 1;
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  void _selectDeparture() async {
    final Location? pickedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => location_picker.LocationPicker(
          locations: LocationsService.availableLocations,
          selected: departure,
        ),
      ),
    );
    if (pickedLocation != null) {
      setState(() {
        departure = pickedLocation;
      });
    }
  }

  // Open a location picker to select the arrival location
  void _selectArrival() async {
    final Location? pickedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => location_picker.LocationPicker(
          locations: LocationsService.availableLocations,
          selected: arrival,
        ),
      ),
    );

    if (pickedLocation != null) {
      setState(() {
        arrival = pickedLocation;
      });
    }
  }

  // Open a pop up date picker
  // just a mock test
  void _onDatePressed() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: departureDate,
      firstDate: DateTime(2026),
      lastDate: DateTime(2027),
    );

    if (pickedDate != null) {
      setState(() {
        departureDate = pickedDate;
      });
    }
  }

  void _selectSeats() {
    // TODO: Show seats picker
  }

  /// Swap the departure and arrival locations
  void _swapLocations() {
    if (departure != null || arrival != null) {
      setState(() {
        final temp = departure;
        departure = arrival;
        arrival = temp;

        // move swap icon to other picker
        swapOnDeparture = !swapOnDeparture;
      });
    }
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  String get date => DateTimeUtils.formatDateTime(departureDate);
  // ----------------------------------
  // Build the widgets
  // ----------------------------------

  Widget buildFormRow({
    required IconData leadingIcon,
    required String placeholder,
    String? selectedValue,
    required VoidCallback onPressed,
    bool enableSwap = false,
    VoidCallback? onSwapPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        child: Row(
          children: [
            Icon(leadingIcon, color: Colors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                selectedValue ?? placeholder,
                style: TextStyle(
                  color: selectedValue != null ? Colors.black : Colors.grey,
                ),
              ),
            ),
            if (enableSwap)
              IconButton(
                icon: const Icon(Icons.swap_vert),
                onPressed: onSwapPressed,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Departure
          buildFormRow(
            leadingIcon: Icons.circle_outlined,
            placeholder: 'Leaving from',
            selectedValue: departure?.name,
            onPressed: _selectDeparture,
            enableSwap:
                swapOnDeparture && (departure != null || arrival != null),
            onSwapPressed: _swapLocations,
          ),
          BlaDivider(),

          // Arrival Location
          buildFormRow(
            leadingIcon: Icons.circle_outlined,
            placeholder: 'Going to',
            selectedValue: arrival?.name,
            onPressed: _selectArrival,
            enableSwap:
                !swapOnDeparture && (departure != null || arrival != null),
            onSwapPressed: _swapLocations,
          ),

          BlaDivider(),

          // Date just a test
          buildFormRow(
            leadingIcon: Icons.calendar_month,
            placeholder: date,
            selectedValue: null,
            onPressed: _onDatePressed,
          ),
          BlaDivider(),
          // Seat not implemented now
          buildFormRow(
            leadingIcon: Icons.person_outline,
            placeholder: requestedSeats.toString(),
            selectedValue: null,
            onPressed: _selectSeats,
          ),
          const SizedBox(height: BlaSpacings.s),
          // search button not implemented yet
          BlaButton(text: 'Search', isPrimary: true, onPressed: () => {}),
        ],
      ),
    );
  }
}
