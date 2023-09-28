import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      forceElevated: true,
      shadowColor: Colors.black54,
      elevation: 10,
      flexibleSpace: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: TabBar(
          unselectedLabelColor: Colors.black54,
          labelColor: Theme.of(context).primaryColor,
          indicatorColor: Theme.of(context).primaryColor,
          indicatorWeight: 3,
          // isScrollable: true,
          tabs: [
            Tab(
              child: Text(
                "item".toCapitalize(),
                style: GoogleFonts.lato(
                  fontSize: 14
                ),
              ),
            ),
            Tab(
              child: Text(
                "payment".tr.toCapitalize(),
                style: GoogleFonts.lato(
                  fontSize: 14
                ),
              ),
            ),
            Tab(
              child: Text(
                "sale".tr.toCapitalize(),
                style: GoogleFonts.lato(
                  fontSize: 14
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}