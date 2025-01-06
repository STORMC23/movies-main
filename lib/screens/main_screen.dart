import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/bottom_navigator_controller.dart';

class Main extends StatelessWidget {
  Main({super.key});
  final BottomNavigatorController controller =
      Get.put(BottomNavigatorController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.index.value,
              children: Get.find<BottomNavigatorController>().screens,
            ),
          ),
          bottomNavigationBar: Container(
            height: 78,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0xFF0296E5),
                  width: 1,
                ),
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: controller.index.value,
              onTap: (index) => controller.setIndex(index),
              backgroundColor: const Color(0xFF242A32),
              selectedItemColor: const Color(0xFF0296E5),
              unselectedItemColor: const Color(0xFF67686D),
              selectedFontSize: 12,
              unselectedFontSize: 12,
              items: [
                BottomNavigationBarItem(
                  //icon: SvgPicture.asset('assets/Actor.svg', height: 21),
                  icon: Icon(Icons.person,color: Colors.white),
                  label: 'Actors',
                ),
                BottomNavigationBarItem(
                  //icon: SvgPicture.asset('assets/Search.svg', height: 21),
                  icon: Icon(Icons.search,color: Colors.white),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  //icon: SvgPicture.asset('assets/Favorites.svg', height: 21),
                  icon: Icon(Icons.favorite,color: Colors.white),
                  label: 'Favorites',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
