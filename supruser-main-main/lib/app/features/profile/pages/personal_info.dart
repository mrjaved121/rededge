import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/core/constants/static_data.dart';
import 'package:suprapp/app/features/auth/provider/auth_provider.dart';
import 'package:suprapp/app/features/profile/model/setting_model.dart';
import 'package:suprapp/app/features/profile/widgets/custom_arrow_back.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  Widget build(BuildContext context) {
    final myprofile = buildProfileList(context);
    return Scaffold(
      appBar: AppBar(
        leading: const CustomArrowBack(),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Profile",
                style: textTheme(context)
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: myprofile.length,
                itemBuilder: (context, index) => customTile(
                    myprofile[index].name, context, myprofile[index].yourName,
                    () {
                  if (myprofile[index].routename != null) {
                    context.pushNamed(myprofile[index].routename!);
                  } else if (myprofile[index].showBottomSheet != null) {
                    myprofile[index].showBottomSheet!(context);
                  }
                }),
              ),
            ],
          )),
    );
  }

  Widget customTile(
      String title, BuildContext context, String subtitle, VoidCallback onTap) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: textTheme(context)
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle,
            style: textTheme(context)
                .bodyLarge
                ?.copyWith(color: AppColors.blackGrey.withOpacity(0.4))),
        trailing: const Icon(Icons.arrow_forward_ios, size: 15),
      ),
    );
  }
}
