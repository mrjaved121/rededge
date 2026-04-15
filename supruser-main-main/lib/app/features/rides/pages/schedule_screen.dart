import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/utils/responsive_utils.dart';
import '../controller/schedule_provider.dart';

// ✅ MAIN WRAPPER - Provider setup ke saath
class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ScheduleProvider(),
      child: const _ScheduleScreenContent(),
    );
  }
}

// ✅ ACTUAL SCREEN CONTENT
class _ScheduleScreenContent extends StatefulWidget {
  const _ScheduleScreenContent();

  @override
  State<_ScheduleScreenContent> createState() => _ScheduleScreenContentState();
}

class _ScheduleScreenContentState extends State<_ScheduleScreenContent> {
  bool _isAnimatingForward = true;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ScheduleProvider>(context);
    final selectedDate = provider.selectedDate;
    final selectedTime = provider.selectedTime;
    final arrival = provider.estimatedArrival;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, {
          'date': provider.selectedDate,
          'time': provider.selectedTime,
        });
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 12)),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context, {
                  'date': provider.selectedDate,
                  'time': provider.selectedTime,
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  borderRadius: BorderRadius.circular(
                    ResponsiveUtils.getBorderRadius(context, 12),
                  ),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: ResponsiveUtils.getIconSize(context, base: 24),
                ),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 12)),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                    borderRadius: BorderRadius.circular(
                      ResponsiveUtils.getBorderRadius(context, 3),
                    ),
                  ),
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.black,
                    size: ResponsiveUtils.getIconSize(context, base: 24),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.getSpacing(context, 24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),
                _buildCalendarIcon(context, provider),

                Text(
                  'When would you like to be\npicked up in Abu Dhabi?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: ResponsiveUtils.sp(context, 22.5),
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: ResponsiveUtils.getSpacing(context, 6)),

                Text(
                  'Free cancellation up to 1 hour before pickup',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: ResponsiveUtils.sp(context, 10.5),
                  ),
                ),

                SizedBox(height: ResponsiveUtils.getSpacing(context, 24)),

                _buildDateNavigator(context, provider),

                SizedBox(height: ResponsiveUtils.getSpacing(context, 55)),

                _buildTimePickerWheel(context, provider),

                SizedBox(height: ResponsiveUtils.getSpacing(context, 60)),

                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        'Estimated arrival time is ${DateFormat('h:mm a').format(arrival)} local time (GMT+4)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: ResponsiveUtils.sp(context, 12.5),
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.getSpacing(context, 3)),
                      Text(
                        'About 99 mins trip',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: ResponsiveUtils.sp(context, 9.75),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: ResponsiveUtils.getSpacing(context, 15)),

                SizedBox(
                  width: double.infinity,
                  height: ResponsiveUtils.getButtonHeight(context, base: 55),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, {
                        'date': provider.selectedDate,
                        'time': provider.selectedTime,
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          ResponsiveUtils.getBorderRadius(context, 8),
                        ),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Confirm date and time',
                      style: TextStyle(
                        fontSize: ResponsiveUtils.sp(context, 16),
                        color: AppColors.lightGreen,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: ResponsiveUtils.getSpacing(context, 9)),

                SizedBox(
                  width: double.infinity,
                  height: ResponsiveUtils.getButtonHeight(context, base: 55),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context, {
                        'date': DateTime.now(),
                        'time': TimeOfDay.now(),
                        'bookNow': true,
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          ResponsiveUtils.getBorderRadius(context, 8),
                        ),
                      ),
                    ),
                    child: Text(
                      'Book ride for now',
                      style: TextStyle(
                        fontSize: ResponsiveUtils.sp(context, 16),
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: ResponsiveUtils.getSpacing(context, 15)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarIcon(BuildContext context, ScheduleProvider provider) {
    final bool isAnimatingForward = provider.selectedDate.isAfter(provider.previousDate);
    final curve = isAnimatingForward ? Curves.easeIn : Curves.easeOut;

    return Transform.scale(
      scale: 0.65,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: ClipRect(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                switchInCurve: curve,
                switchOutCurve: curve,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  final Offset beginOffset =
                  isAnimatingForward ? const Offset(0.0, 1.0) : const Offset(0.0, -1.0);
                  final Offset endOffset =
                  isAnimatingForward ? const Offset(0.0, -1.0) : const Offset(0.0, 1.0);

                  final tween = Tween<Offset>(begin: beginOffset, end: Offset.zero);

                  return SlideTransition(
                    position: tween.animate(animation),
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: Text(
                  DateFormat('MMM').format(provider.selectedDate),
                  key: ValueKey('${provider.selectedDate.month}-${provider.selectedDate.year}'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 80,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
            ),
            child: ClipRect(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                switchInCurve: curve,
                switchOutCurve: curve,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  final Offset beginOffset =
                  isAnimatingForward ? const Offset(0.0, 1.0) : const Offset(0.0, -1.0);
                  final tween = Tween<Offset>(begin: beginOffset, end: Offset.zero);

                  return SlideTransition(
                    position: tween.animate(animation),
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: Text(
                  DateFormat('d').format(provider.selectedDate),
                  key: ValueKey(provider.selectedDate),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showAppDatePicker(
      BuildContext context, ScheduleProvider provider) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: provider.selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      cancelText: 'Cancel',
      confirmText: 'OK',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.darkGreen,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.darkGreen,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: AppColors.darkGreen, width: 1),
                ),
                overlayColor: Colors.grey.shade200,
              ),
            ),
          ),
          child: child ?? const SizedBox(),
        );
      },
    );

    if (pickedDate != null && pickedDate != provider.selectedDate) {
      setState(() {
        _isAnimatingForward = pickedDate.isAfter(provider.selectedDate);
      });
      provider.updateDate(pickedDate);
    }
  }

  Widget _buildDateNavigator(BuildContext context, ScheduleProvider provider) {
    final today = DateTime.now();
    final startOfToday = DateTime(today.year, today.month, today.day);
    final bool isToday = provider.selectedDate.isAtSameMomentAs(startOfToday);

    return GestureDetector(
      onTap: () => _showAppDatePicker(context, provider),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 1,
              color: Colors.grey.shade300,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: ResponsiveUtils.getSpacing(context, 6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (isToday)
                    SizedBox(width: ResponsiveUtils.getIconSize(context, base: 21) + 12)
                  else
                    IconButton(
                      onPressed: () {
                        final newDate = provider.selectedDate.subtract(Duration(days: 1));
                        if (newDate.isAfter(startOfToday) || newDate.isAtSameMomentAs(startOfToday)) {
                          setState(() {
                            _isAnimatingForward = false;
                          });
                          provider.updateDate(newDate);
                        }
                      },
                      icon: Icon(
                        Icons.chevron_left,
                        color: Colors.black,
                        size: ResponsiveUtils.getIconSize(context, base: 21),
                      ),
                    ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          DateFormat('EEEE').format(provider.selectedDate),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: ResponsiveUtils.sp(context, 13.5),
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: ResponsiveUtils.getSpacing(context, 3)),
                        Text(
                          DateFormat('MMMM d').format(provider.selectedDate),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: ResponsiveUtils.sp(context, 10.5),
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isAnimatingForward = true;
                      });
                      final newDate = provider.selectedDate.add(Duration(days: 1));
                      provider.updateDate(newDate);
                    },
                    icon: Icon(
                      Icons.chevron_right,
                      color: Colors.black,
                      size: ResponsiveUtils.getIconSize(context, base: 21),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey.shade300,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePickerWheel(BuildContext context, ScheduleProvider provider) {
    final double itemExtent = ResponsiveUtils.adaptive(
      context,
      small: 30.0,
      medium: 33.75,
      large: 37.5,
    );
    final double containerHeight = ResponsiveUtils.adaptive(
      context,
      small: 120.0,
      medium: 135.0,
      large: 150.0,
    );
    final double lineTopPosition = (containerHeight / 2) - (itemExtent / 2);
    final double lineBottomPosition = (containerHeight / 2) + (itemExtent / 2);

    final double mainFontSize = ResponsiveUtils.sp(context, 15);
    final double otherFontSize = ResponsiveUtils.sp(context, 13.5);

    final hourController = FixedExtentScrollController(
      initialItem: provider.selectedTime.hour % 12,
    );
    final minuteController = FixedExtentScrollController(
      initialItem: provider.selectedTime.minute,
    );
    final ampmController = FixedExtentScrollController(
      initialItem: provider.selectedTime.hour >= 12 ? 1 : 0,
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: containerHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: ResponsiveUtils.adaptive(
                  context,
                  small: 48.75,
                  medium: 52.5,
                  large: 56.25,
                ),
                child: ListWheelScrollView.useDelegate(
                  controller: hourController,
                  itemExtent: itemExtent,
                  physics: FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    int newHour;
                    final isPM = provider.selectedTime.hour >= 12;
                    if (isPM) {
                      newHour = (index == 0 ? 12 : index) + 12;
                      if (newHour == 24) newHour = 12;
                    } else {
                      newHour = index;
                    }
                    provider.updateTime(TimeOfDay(
                        hour: newHour, minute: provider.selectedTime.minute));
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: 12,
                    builder: (context, index) {
                      final displayHour = (index == 0) ? 12 : index;
                      final selectedHour = provider.selectedTime.hour % 12;
                      final isSelected = selectedHour == index;

                      return Center(
                        child: Text(
                          displayHour.toString(),
                          style: TextStyle(
                            fontSize: isSelected ? mainFontSize : otherFontSize,
                            fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? Colors.black : Colors.grey.shade400,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                width: ResponsiveUtils.adaptive(
                  context,
                  small: 48.75,
                  medium: 52.5,
                  large: 56.25,
                ),
                child: ListWheelScrollView.useDelegate(
                  controller: minuteController,
                  itemExtent: itemExtent,
                  physics: FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    provider.updateTime(TimeOfDay(
                        hour: provider.selectedTime.hour, minute: index));
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: 60,
                    builder: (context, index) {
                      final isSelected = index == provider.selectedTime.minute;
                      return Center(
                        child: Text(
                          index.toString().padLeft(2, '0'),
                          style: TextStyle(
                            fontSize: isSelected ? mainFontSize : otherFontSize,
                            fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? Colors.black : Colors.grey.shade400,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                width: ResponsiveUtils.adaptive(
                  context,
                  small: 48.75,
                  medium: 52.5,
                  large: 56.25,
                ),
                child: ListWheelScrollView.useDelegate(
                  controller: ampmController,
                  itemExtent: itemExtent,
                  physics: FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    final currentHour = provider.selectedTime.hour;
                    int newHour = currentHour;
                    if (index == 0 && currentHour >= 12) {
                      newHour -= 12;
                    } else if (index == 1 && currentHour < 12) {
                      newHour += 12;
                    }
                    provider.updateTime(TimeOfDay(
                        hour: newHour, minute: provider.selectedTime.minute));
                  },
                  childDelegate: ListWheelChildListDelegate(
                    children: ['AM', 'PM'].map((text) {
                      final isSelected = (text == 'AM' &&
                          provider.selectedTime.hour < 12) ||
                          (text == 'PM' && provider.selectedTime.hour >= 12);
                      return Center(
                        child: Text(
                          text,
                          style: TextStyle(
                            fontSize: isSelected ? mainFontSize : otherFontSize,
                            fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? Colors.black : Colors.grey.shade400,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: lineTopPosition,
          left: ResponsiveUtils.getSpacing(context, 30),
          right: ResponsiveUtils.getSpacing(context, 30),
          child: Container(
            height: 1,
            color: Colors.grey.shade300,
          ),
        ),
        Positioned(
          top: lineBottomPosition - 1,
          left: ResponsiveUtils.getSpacing(context, 30),
          right: ResponsiveUtils.getSpacing(context, 30),
          child: Container(
            height: 1,
            color: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }
}