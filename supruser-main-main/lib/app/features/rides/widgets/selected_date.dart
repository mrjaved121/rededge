import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/features/rides/provider/date_provider.dart';

class PickupTimeSheet extends StatefulWidget {
  const PickupTimeSheet({super.key});

  @override
  State<PickupTimeSheet> createState() => _PickupTimeSheetState();
}

class _PickupTimeSheetState extends State<PickupTimeSheet> {
  String selectedDay = 'Today';
  String selectedTime = '06:20 - 06:30';
  String selectedPeriod = 'PM';

  final List<String> days = [
    'Today',
    'Tomorrow',
    "Monday",
    "tuesday",
    "Wednessday",
    "Thursday",
    "Friday",
  ];
  final List<String> timeRanges = [
    '06:20 - 06:30',
    '06:30 - 06:40',
    '7:30- 7:40',
    '8:00- 8:10',
    '9:30- 9:40',
    '10:20- 10:30',
  ];
  final List<String> periods = ['AM', 'PM'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Select your pickup time',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildOptionSelector(days, selectedDay, (val) {
                setState(() => selectedDay = val);
              }),
              _buildOptionSelector(timeRanges, selectedTime, (val) {
                setState(() => selectedTime = val);
              }),
              _buildOptionSelector(periods, selectedPeriod, (val) {
                setState(() => selectedPeriod = val);
              }),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[800],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              context.read<PickupTimeProvider>().setPickupTime(
                    selectedDay,
                    selectedTime,
                    selectedPeriod,
                  );
              Navigator.pop(context);
            },
            child: const Text('Select this date & time'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionSelector(
    List<String> items,
    String selected,
    Function(String) onSelected,
  ) {
    return Column(
      children: items.map((item) {
        final isSelected = item == selected;
        return GestureDetector(
          onTap: () => onSelected(item),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              item,
              style: TextStyle(
                color: isSelected ? Colors.green : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
