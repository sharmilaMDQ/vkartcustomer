import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkartcustomer/Components/AppTheme.dart';
import 'package:vkartcustomer/Controller/ProductHomeScreenController.dart';
import 'package:vkartcustomer/UI/HomeScreen/ProductHomeScreen.dart';
import '../Helper/Helper.dart';
import '../UI/MyOrderScreens/OrderListPage.dart';
import '../UI/OfferDetailScreens/OfferScreen.dart';
import '../UI/SettingsScreen/SettingScreen.dart';

/*class navigateBar extends StatefulWidget {
  navigateBar({Key? key}) : super(key: key);

  @override
  State<navigateBar> createState() => _navigateBarState();
}

class _navigateBarState extends State<navigateBar> {
  int _currentpage = 0;
  late List<Widget> page = [
    OfferScreen(),
    OrderListScreen(),
    ProductHomeScreen(),
    CartScreen(),
    SettingScreen(),
  ];
  int _lastTapTime = 0;
  int _lastTapIndex = 0;

  void onTap(int index) {
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    if (_lastTapIndex == index && currentTime - _lastTapTime < 500) {
      if (index == 0) {
        print('double tap');
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => navigateBar()),
        // );
      }
    } else {
      setState(() {
        _currentpage = index;
      });
    }
    _lastTapIndex = index;
    _lastTapTime = currentTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[_currentpage],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 10,
        selectedItemColor: AppTheme.Buttoncolor,
        unselectedItemColor: Colors.black87,
        unselectedFontSize: 10,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        currentIndex: _currentpage,
        onTap: onTap,
        selectedIconTheme: const IconThemeData(color: AppTheme.Buttoncolor),
        selectedLabelStyle: const TextStyle(
          color: AppTheme.Buttoncolor,
          fontWeight: FontWeight.w400,
          fontSize: 10,
        ),
        //
        unselectedIconTheme: const IconThemeData(
          color: Colors.black26,
        ),
        unselectedLabelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_sharp,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              label: 'My order',
              icon: Icon(
                Icons.shopping_bag_outlined,
                size: 32,
              )),
          BottomNavigationBarItem(
              label: 'Products',
              icon: Icon(
                Icons.card_giftcard_sharp,
                size: 32,
              )),
          BottomNavigationBarItem(
              label: 'Your cart',
              icon: Icon(
                Icons.shopping_cart_outlined,
                size: 32,
              )),
          BottomNavigationBarItem(
              label: 'Setting',
              icon: Icon(
                Icons.settings,
                size: 32,
              )),
        ],
      ),
    );
  }
}*/

class navigateBar extends StatefulWidget {
  final int initialIndex;

  const navigateBar({super.key, required this.initialIndex});

  @override
  State<navigateBar> createState() => _navigateBarState();
}

class _navigateBarState extends State<navigateBar> {
  late PageController _pageController;
  late int _currentIndex;

  final ProductHomeScreenController productController = Get.put(ProductHomeScreenController());

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; // Set initial index
    _pageController = PageController(initialPage: _currentIndex);

    WidgetsBinding.instance.addPostFrameCallback((callback) {
      productController.HomeScreenApi();
      productController.update();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const BouncingScrollPhysics(),
          onPageChanged: (int index) {
            setState(() {
              _currentIndex = index;
              if (_currentIndex == 1) {
                Helper.offerState = false;
                productController.HomeScreenApi();
              }
            });
          },
          children:  <Widget>[
            KeepAlivePage(child: OfferScreen()),
            KeepAlivePage(child: ProductHomeScreen()),
            KeepAlivePage(child: OrderListScreen()),
            KeepAlivePage(child: SettingScreen()),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          index: _currentIndex,
          animationCurve: Curves.easeInOut,
          color: AppTheme.Buttoncolor,
          backgroundColor: Colors.transparent,
          height: 65,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
            _pageController.jumpToPage(index);
          },
          items: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Image.asset(
                    "assets/icons/home.png",
                    color: Colors.white,
                    height: 25,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                if (_currentIndex != 0) // Show text only if not selected
                  const SizedBox(height: 5),
                if (_currentIndex != 0) // Show text only if not selected
                   Text(
                    "Home",
                    style: TextStyle(color: Colors.white, fontSize: 12,
                    fontWeight: FontWeight.bold),
                  ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Image.asset(
                    "assets/icons/set.png",
                    color: Colors.white,
                    height: 25,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                if (_currentIndex != 1) // Show text only if not selected
                  const SizedBox(height: 5),
                if (_currentIndex != 1) // Show text only if not selected
                   Text(
                    "Categories",
                    style: TextStyle(color: Colors.white, fontSize: 12,
                    fontWeight: FontWeight.bold),
                  ),
              ],
            ),
            Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Image.asset(
                    "assets/icons/order.png",
                    color: Colors.white,
                    height: 25,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                if (_currentIndex != 2) // Show text only if not selected
                  const SizedBox(height: 5),
                if (_currentIndex != 2) // Show text only if not selected
                   Text(
                    "My Orders",
                    style: TextStyle(color: Colors.white, fontSize: 12,
                    fontWeight: FontWeight.bold),
                  ),
              ],
            ),
             Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Image.asset(
                    "assets/icons/settings.png",
                    color: Colors.white,
                    height: 25,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                if (_currentIndex != 3) // Show text only if not selected
                  const SizedBox(height: 5),
                if (_currentIndex != 3) // Show text only if not selected
                   Text(
                    "Settings",
                    style: TextStyle(color: Colors.white, fontSize: 12,
                    fontWeight: FontWeight.bold),
                  ),
              ],
            ),
            // Icon(Icons.settings, color: Colors.white, size: 30),
           
          ],
        ),
      ),
    );
  }
}

class KeepAlivePage extends StatefulWidget {
  final Widget child;

  const KeepAlivePage({Key? key, required this.child}) : super(key: key);

  @override
  _KeepAlivePageState createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
