import 'package:flutter/material.dart';
import 'package:iouring_flutter_task/features/watchlist/presentation/views/watchlist_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    Center(child: WatchlistScreen()),
    Center(child: Text('Order Screen')),
    Center(child: Text('Portfolio Screen')),
    Center(child: Text('Movers Screen')),
    Center(child: Text('IOU007 Screen')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 204, 227, 177),
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book_rounded),
            label: 'Watchlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_travel_sharp),
            label: 'Portfolio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart_outlined_sharp),
            label: 'Movers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz_sharp),
            label: 'IOU007',
          ),
        ],
      ),
    );
  }
}
