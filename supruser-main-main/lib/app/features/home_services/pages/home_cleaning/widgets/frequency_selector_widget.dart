import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive_utils.dart';
import '../provider/home_cleaing_provider.dart';

class FrequencySelectorWidget extends StatelessWidget {
  final BookingProvider? provider;
  final Function(String)? onFrequencyChanged;

  const FrequencySelectorWidget({
    super.key,
    this.provider,
    this.onFrequencyChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bookingProvider = provider ?? Provider.of<BookingProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Frequency",
          style: TextStyle(
            fontSize: ResponsiveUtils.sp(context, 18),
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
        SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),
        InkWell(
          onTap: () => _showFrequencyModal(context, bookingProvider),
          child: Container(
            padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                ResponsiveUtils.getBorderRadius(context, 12),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.darkGrey.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: Colors.black,
                  size: ResponsiveUtils.getIconSize(context, base: 20),
                ),
                SizedBox(width: ResponsiveUtils.getSpacing(context, 12)),
                Text(
                  "${bookingProvider.frequency} Service",
                  style: TextStyle(
                    fontSize: ResponsiveUtils.sp(context, 14),
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black,
                  size: ResponsiveUtils.getIconSize(context, base: 22),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showFrequencyModal(BuildContext context, BookingProvider provider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _FrequencyModalContent(
        provider: provider,
        onFrequencyChanged: onFrequencyChanged,
      ),
    );
  }
}

// Modal Content Widget
class _FrequencyModalContent extends StatefulWidget {
  final BookingProvider provider;
  final Function(String)? onFrequencyChanged;

  const _FrequencyModalContent({
    required this.provider,
    required this.onFrequencyChanged,
  });

  @override
  State<_FrequencyModalContent> createState() => _FrequencyModalContentState();
}

class _FrequencyModalContentState extends State<_FrequencyModalContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.72,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(ResponsiveUtils.getBorderRadius(context, 20)),
          topRight: Radius.circular(ResponsiveUtils.getBorderRadius(context, 20)),
        ),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 24)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Choose your frequency",
                  style: TextStyle(
                    fontSize: ResponsiveUtils.sp(context, 20),
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.close,
                    color: AppColors.darkGrey,
                    size: ResponsiveUtils.getIconSize(context, base: 24),
                  ),
                ),
              ],
            ),
          ),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.getSpacing(context, 24),
                ),
                child: Column(
                  children: [
                    _FrequencyOption(
                      provider: widget.provider,
                      frequency: "One time",
                      onTap: () {
                        widget.provider.setFrequency("One time");
                        if (widget.onFrequencyChanged != null) {
                          widget.onFrequencyChanged!("One time");
                        }
                        setState(() {});
                      },
                    ),
                    _FrequencyOption(
                      provider: widget.provider,
                      frequency: "Every 2 weeks",
                      discount: "5% Off",
                      onTap: () {
                        widget.provider.setFrequency("Every 2 weeks");
                        if (widget.onFrequencyChanged != null) {
                          widget.onFrequencyChanged!("Every 2 weeks");
                        }
                        setState(() {});
                      },
                    ),
                    _FrequencyOption(
                      provider: widget.provider,
                      frequency: "Once a week",
                      discount: "10% Off",
                      isPopular: true,
                      onTap: () {
                        widget.provider.setFrequency("Once a week");
                        if (widget.onFrequencyChanged != null) {
                          widget.onFrequencyChanged!("Once a week");
                        }
                        setState(() {});
                      },
                    ),
                    _FrequencyOption(
                      provider: widget.provider,
                      frequency: "Multiple times a week",
                      discount: "Up to 25% off",
                      showDaySelector: true,
                      onTap: () {
                        widget.provider.setFrequency("Multiple times a week");
                        if (widget.onFrequencyChanged != null) {
                          widget.onFrequencyChanged!("Multiple times a week");
                        }
                        setState(() {});
                      },
                    ),
                    SizedBox(height: ResponsiveUtils.getSpacing(context, 24)),
                    _JustLifePromise(),
                    SizedBox(height: ResponsiveUtils.getSpacing(context, 24)),
                  ],
                ),
              ),
            ),
          ),

          // Select Button
          Padding(
            padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 24)),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkGreen,
                  padding: EdgeInsets.symmetric(
                    vertical: ResponsiveUtils.getSpacing(context, 16),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      ResponsiveUtils.getBorderRadius(context, 12),
                    ),
                  ),
                ),
                child: Text(
                  "Select",
                  style: TextStyle(
                    fontSize: ResponsiveUtils.sp(context, 18),
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Frequency Option Widget
class _FrequencyOption extends StatefulWidget {
  final BookingProvider provider;
  final String frequency;
  final String? discount;
  final bool isPopular;
  final bool showDaySelector;
  final VoidCallback onTap;

  const _FrequencyOption({
    required this.provider,
    required this.frequency,
    this.discount,
    this.isPopular = false,
    this.showDaySelector = false,
    required this.onTap,
  });

  @override
  State<_FrequencyOption> createState() => _FrequencyOptionState();
}

class _FrequencyOptionState extends State<_FrequencyOption> {
  bool _isExpanded = false;

  @override
  void didUpdateWidget(_FrequencyOption oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.provider.frequency == widget.frequency && widget.showDaySelector) {
      _isExpanded = true;
    } else if (widget.provider.frequency != widget.frequency) {
      _isExpanded = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSelected = widget.provider.frequency == widget.frequency;

    return Padding(
      padding: EdgeInsets.only(bottom: ResponsiveUtils.getSpacing(context, 12)),
      child: GestureDetector(
        onTap: () {
          widget.onTap();
          if (widget.showDaySelector && isSelected) {
            setState(() {
              _isExpanded = true;
            });
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.white : AppColors.white,
            border: Border.all(
              color: isSelected ? AppColors. darkGreens: AppColors.appGrey,
              width: isSelected ? 0.8 : 0.5,
            ),
            borderRadius: BorderRadius.circular(
              ResponsiveUtils.getBorderRadius(context, 12),
            ),
          ),
          child: Column(
            children: [
              // Main Content
              Padding(
                padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.frequency,
                            style: TextStyle(
                              fontSize: ResponsiveUtils.sp(context, 16),
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          if (widget.discount != null) ...[
                            SizedBox(height: ResponsiveUtils.getSpacing(context, 4)),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: ResponsiveUtils.getSpacing(context, 8),
                                vertical: ResponsiveUtils.getSpacing(context, 4),
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEF4444),
                                borderRadius: BorderRadius.circular(
                                  ResponsiveUtils.getBorderRadius(context, 4),
                                ),
                              ),
                              child: Text(
                                widget.discount!,
                                style: TextStyle(
                                  fontSize: ResponsiveUtils.sp(context, 12),
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Container(
                      width: ResponsiveUtils.wp(context, 6),
                      height: ResponsiveUtils.wp(context, 6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? AppColors.appGreen : AppColors.appGrey,
                          width: 2,
                        ),
                        color: isSelected ? AppColors.appGreen : AppColors.white,
                      ),
                      child: isSelected
                          ? Icon(
                        Icons.check,
                        color: AppColors.white,
                        size: ResponsiveUtils.getIconSize(context, base: 12),
                      )
                          : null,
                    ),
                  ],
                ),
              ),

              // Day Selector (conditionally shown)
              if (isSelected && widget.showDaySelector && _isExpanded)
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    ResponsiveUtils.getSpacing(context, 16),
                    0,
                    ResponsiveUtils.getSpacing(context, 16),
                    ResponsiveUtils.getSpacing(context, 16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(color: AppColors.appGrey),
                      SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),
                      Text(
                        "Which days do you prefer?",
                        style: TextStyle(
                          fontSize: ResponsiveUtils.sp(context, 14),
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),
                      GridView.count(
                        crossAxisCount: 4,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio: 1.8,
                        mainAxisSpacing: ResponsiveUtils.getSpacing(context, 8),
                        crossAxisSpacing: ResponsiveUtils.getSpacing(context, 8),
                        children: const [
                          _DayButton("Mon"),
                          _DayButton("Tue"),
                          _DayButton("Wed"),
                          _DayButton("Thu"),
                          _DayButton("Fri"),
                          _DayButton("Sat"),
                          _DayButton("Sun"),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Day Button Widget
class _DayButton extends StatefulWidget {
  final String day;

  const _DayButton(this.day);

  @override
  State<_DayButton> createState() => _DayButtonState();
}

class _DayButtonState extends State<_DayButton> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: _isSelected ? AppColors.darkGreens : AppColors.appGrey,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
          color: _isSelected ? AppColors.darkGreens : Colors.white,
        ),
        child: Center(
          child: Text(
            widget.day,
            style: TextStyle(
              fontSize: ResponsiveUtils.sp(context, 12),
              fontWeight: FontWeight.w600,
              color: _isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

// JustLife Promise Widget
class _JustLifePromise extends StatelessWidget {
  const _JustLifePromise();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getBorderRadius(context, 12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "just",
                style: TextStyle(
                  fontSize: ResponsiveUtils.sp(context, 16),
                  fontWeight: FontWeight.w700,
                  color: Colors.blue,
                ),
              ),
              Text(
                "life",
                style: TextStyle(
                  fontSize: ResponsiveUtils.sp(context, 16),
                  fontWeight: FontWeight.w700,
                  color: Colors.blue,
                ),
              ),
              Text(
                " Promise",
                style: TextStyle(
                  fontSize: ResponsiveUtils.sp(context, 16),
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),
          const _PromiseItem(
            icon: Icons.local_offer,
            title: "More Days, More Savings!",
            subtitle: "Select more days to save up to 25%.",
          ),
          SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),
          const _PromiseItem(
            icon: Icons.event_available,
            title: "Same Professional Guaranteed",
            subtitle: "No changes, no excuses, same professional every time.",
          ),
        ],
      ),
    );
  }
}

// Promise Item Widget
class _PromiseItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _PromiseItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: AppColors.darkGrey,
          size: ResponsiveUtils.getIconSize(context, base: 20),
        ),
        SizedBox(width: ResponsiveUtils.getSpacing(context, 12)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: ResponsiveUtils.sp(context, 14),
                  fontWeight: FontWeight.w600,
                    color: Colors.black,
                ),
              ),
              SizedBox(height: ResponsiveUtils.getSpacing(context, 4)),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: ResponsiveUtils.sp(context, 12),
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}