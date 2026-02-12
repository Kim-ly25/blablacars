import 'package:flutter/material.dart';
import '../../../../model/ride/locations.dart';
import '../../../theme/theme.dart';

/// Screen used to find and choose a location
class LocationSelector extends StatefulWidget {
  
  /// All locations available
  final List<Location> allLocations;
  /// Currently selected location (optional)
  final Location? currentLocation;
  const LocationSelector({super.key, required this.allLocations, this.currentLocation,});

  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}
class _LocationSelectorState extends State<LocationSelector> {
  /// List after applying search filter
  late List<Location> visibleLocations;
  /// Current text typed by user
  String queryText = '';

  @override
  void initState() {
    super.initState();
    // Initially show all locations
    visibleLocations = widget.allLocations;
  }

  /// Called when search input changes
  void _handleSearch(String text) {
    setState(() {
      queryText = text;
      visibleLocations = widget.allLocations.where((location) {
        return location.name.toLowerCase().contains(text.toLowerCase());})
        .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: BlaColors.greyLight,
            borderRadius: BorderRadius.circular(10),
          ),

          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 18),
                onPressed: () { Navigator.pop(context);
                },
              ),
              SizedBox(width: BlaSpacings.s),
              Expanded(
                child: TextField(
                  onChanged: _handleSearch,

                  decoration: const InputDecoration(
                    hintText: "Find a location...",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      body: ListView.builder(
        itemCount: visibleLocations.length,
        itemBuilder: (context, index) {
          final Location item = visibleLocations[index];

          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: BlaColors.greyLight,
                  width: 1,
                ),
              ),
            ),

            child: ListTile(
              title: Text(item.name),
              subtitle: Text(
                item.country.name,
                style: BlaTextStyles.label.copyWith(
                  color: BlaColors.textLight,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios,size: 16,color: BlaColors.iconLight,
              ),
              onTap: () {Navigator.pop(context, item);
              },
            ),
          );
        },
      ),
    );
  }
}
