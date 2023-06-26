import 'package:expense/app/constants/assets.dart';
import 'package:expense/app/constants/color.dart';
import 'package:expense/app/extensions/text.dart';
import 'package:expense/app/modules/home/views/chart.dart';
import 'package:expense/app/modules/home/views/expandable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:nil/nil.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              toolbarHeight: 300.0,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                      bottomRight: Radius.circular(32.0))),
              flexibleSpace: PreferredSize(
                  preferredSize: const Size.fromHeight(300.0),
                  child: Container(
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              yellowSoftColor,
                              yellowSoftColor.withOpacity(0.3)
                            ])),
                    child: Column(children: [
                      SizedBox(
                        height: 64.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 32.0,
                              // maxRadius: 32.0,
                              backgroundColor: Colors.transparent,
                              child: Image.asset(
                                Assets.avatar,
                                // width: 32.0,
                              ),
                            ),
                            dropdownWidget(),
                            IconButton(
                                onPressed: null,
                                icon: SvgPicture.asset(
                                  Assets.notification,
                                  colorFilter: ColorFilter.mode(
                                      primaryColor, BlendMode.color),
                                  width: 24.0,
                                ))
                          ],
                        ),
                      ),
                      const Text("Account Balance").secondaryText14(),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        "\$9400",
                        style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.w600,
                            color: textColor),
                      ),
                      const SizedBox(
                        height: 26.0,
                      ),
                      Wrap(
                        spacing: 16.0,
                        children: [
                          for (int i = 0; i < 2; i++)
                            infoBalance(
                                title: ["Income", "Expenses"][i],
                                ammount: ["\$5000", "\$1200"][i],
                                color: [greenColor, redColor][i],
                                icon: [Assets.expense, Assets.expense][i])
                        ],
                      )
                    ]),
                  )),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 24.0, 0, 0),
                    child: const Text("Spend Frequency").primaryText18(),
                  ),
                  const SizedBox(
                    height: 185.0,
                    child: Chart(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: DefaultTabController(
                        length: controller.transaction.length,
                        child: Column(
                          children: [
                            TabBar(
                              splashFactory: NoSplash.splashFactory,
                              indicatorPadding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              indicator: ShapeDecoration(
                                  shape: const StadiumBorder(),
                                  color: yellowSoftColor),
                              labelColor: yellowColor,
                              unselectedLabelColor: textSoftColor,
                              labelStyle: const TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                              unselectedLabelStyle:
                                  const TextStyle(fontWeight: FontWeight.w500),
                              tabs: List.generate(controller.transaction.length,
                                  (x) => Tab(text: controller.transaction[x])),
                            ),
                            SizedBox(
                              height: controller.transaction.length * 90,
                              child: TabBarView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: List.generate(
                                    controller.transaction.length,
                                    (i) => Column(
                                      children: [
                                        const SizedBox(
                                          height: 16.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Recent Transaction")
                                                .primaryText18(),
                                            Chip(
                                              label: const Text("See All")
                                                  .secondaryText14(
                                                      color: primaryColor),
                                              backgroundColor: violetSoftColor,
                                              surfaceTintColor: violetSoftColor,
                                            )
                                          ],
                                        ),
                                        ListView.separated(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: 3,
                                          separatorBuilder: (_, index) =>
                                              const SizedBox(
                                            height: 4.0,
                                          ),
                                          itemBuilder: (context, t) =>
                                              transactiontile(
                                                  title: [
                                                    "Shopping",
                                                    "Subcription",
                                                    "Food"
                                                  ][t],
                                                  subtite: [
                                                    "Buy some grocery",
                                                    "Disney+ Annuall Subcriptionxnnnnnnnnnn",
                                                    "Buy a ramen"
                                                  ][t],
                                                  price: [
                                                    "-\$120",
                                                    "-\$80",
                                                    "-\$32"
                                                  ][t],
                                                  time: [
                                                    "10:00 AM",
                                                    "03:00 PM",
                                                    "07:30 PM"
                                                  ][t],
                                                  icon: [
                                                    Assets.shoppingBag,
                                                    Assets.recurringBill,
                                                    Assets.restaurant
                                                  ][t],
                                                  colorIcon: [
                                                    yellowSoftColor,
                                                    violetSoftColor,
                                                    redSoftColor
                                                  ][t]),
                                        )
                                      ],
                                    ),
                                  )),
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: BottomNavigationBar(
              currentIndex: controller.bottomNavIndex.value,
              selectedItemColor: primaryColor,
              unselectedItemColor: const Color(0xffC6C6C6),
              // unselectedLabelStyle: TextStyle(color: light80Color),
              showSelectedLabels: true,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              items: List.generate(
                  5,
                  (b) => BottomNavigationBarItem(
                      icon: b == 2
                          ? nil
                          : SvgPicture.asset(
                              [
                                Assets.home,
                                Assets.transaction,
                                "",
                                Assets.pieCart,
                                Assets.user
                              ][b],
                              colorFilter: const ColorFilter.mode(
                                  Color(0xffC6C6C6), BlendMode.lighten),
                            ),
                      activeIcon: b == 2
                          ? nil
                          : SvgPicture.asset(
                              [
                                Assets.home,
                                Assets.transaction,
                                "",
                                Assets.pieCart,
                                Assets.user
                              ][b],
                              colorFilter: ColorFilter.mode(
                                  primaryColor, BlendMode.color),
                            ),
                      label: [
                        "Home",
                        "Transaction",
                        "",
                        "Budget",
                        "Profile"
                      ][b])),
              onTap: (int selectedIndex) =>
                  controller.bottomNavIndex(selectedIndex),
            ),
          )),
      floatingActionButton: ExpandableFab(
          distance: 90,
          children: List.generate(
              3,
              (f) => ActionButton(
                    color: [greenColor, blueColor, redColor][f],
                    onPressed: null,
                    icon: SvgPicture.asset(
                      [
                        Assets.income,
                        Assets.currencyExchange,
                        Assets.expense
                      ][f],
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ))),
      // InkWell(
      //   // onPressed: null,
      //   // backgroundColor: primaryColor,
      //   // foregroundColor: Colors.white,
      //   // shape: CircleBorder(side: BorderSide(color: Colors.white, width: 4),),
      //   // elevation: 0,
      //   child: Container(
      //     width: 60.0,
      //     // padding: const EdgeInsets.all(16.0),
      //     decoration:
      //         ShapeDecoration(shape: CircleBorder(), color: primaryColor),
      //     child: SvgPicture.asset(
      //       Assets.add,
      //       // width: 32.0,
      //     ),
      //   ),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget transactiontile(
      {required String title,
      required String subtite,
      required String price,
      required String time,
      required String icon,
      required Color colorIcon}) {
    return ListTile(
      tileColor: light80Color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      contentPadding: const EdgeInsets.all(16.0),
      leading: Container(
        height: 60.0,
        width: 60.0,
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: colorIcon,
        ),
        child: SvgPicture.asset(
          icon,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(child: Text(title).primaryText16()),
              Text(price).primaryText16(color: redColor),
              const SizedBox(
                height: 12.0,
              ),
            ],
          ),
          const SizedBox(
            height: 12.0,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  subtite,
                ).secondaryText14(overflow: TextOverflow.ellipsis),
              ),
              Text(time).secondaryText14()
            ],
          ),
        ],
      ),
    );
  }

  Widget dropdownWidget() {
    return Obx(() => Container(
          padding: const EdgeInsets.only(left: 10.0),
          // height: 40.0,
          decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: outlineColor))),
          child: Row(
            children: [
              Icon(
                Icons.keyboard_arrow_down,
                color: textColor,
                // size: 24.0,
              ),
              const SizedBox(
                height: 4.0,
              ),
              DropdownButton<String>(
                padding: EdgeInsets.zero,
                icon: const SizedBox(),
                underline: const SizedBox(),
                value: controller.month.value,
                items: controller.months
                    .map<DropdownMenuItem<String>>(
                        (String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                              ),
                            ))
                    .toList(),
                onChanged: (String? item) => controller.month(item!),
              ),
            ],
          ),
        ));
  }

  Widget infoBalance(
      {required String title,
      required String ammount,
      required Color color,
      required String icon}) {
    return Container(
      width: (Get.width / 2) - 32.0,
      height: 85.0,
      padding: const EdgeInsets.all(16.0),
      decoration: ShapeDecoration(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
          color: color),
      child: Row(
        // spacing: 10.0,
        children: [
          Container(
            // width: 48.0,
            // height: 48.0,
            margin: const EdgeInsets.only(right: 10.0),
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                color: textWhiteColor),
            child: SvgPicture.asset(
              icon,
              width: 24.0,
              colorFilter: ColorFilter.mode(color, BlendMode.color),
            ),
          ),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: textWhiteColor),
              ),
              const SizedBox(
                height: 4.0,
              ),
              FittedBox(
                child: Text(ammount,
                    style: TextStyle(
                        height: 1.4,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                        color: textWhiteColor)),
              )
            ]),
          )
        ],
      ),
    );
  }
}
