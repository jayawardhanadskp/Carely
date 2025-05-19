import 'package:carely/features/service_seeker/widgets/booking_card_widget_ss.dart';
import 'package:flutter/material.dart';

class BookingsScreenSs extends StatefulWidget {
  @override
  _BookingsScreenSsState createState() => _BookingsScreenSsState();
}

class _BookingsScreenSsState extends State<BookingsScreenSs> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> tabs = ['Upcoming', 'Past'];
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'My Bookings',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF2563EB),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey[600],
                
                tabs: tabs.map((String name) => Tab(text: name)).toList(),
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildUpcomingBookings(),
          _buildPastBookings(),
        ],
      ),
    );
  }

  Widget _buildUpcomingBookings() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        BookingCardSs(
          caregiverName: 'Emma Johnson',
          caregiverRating: 4.8,
          date: 'Today',
          time: '2:00 PM - 5:00 PM',
          location: 'Home',
          status: BookingStatus.confirmed,
        ),
        const SizedBox(height: 16),
        BookingCardSs(
          caregiverName: 'Robert Miller',
          caregiverRating: 4.9,
          date: 'Tomorrow',
          time: '10:00 AM - 1:00 PM',
          location: 'Home',
          status: BookingStatus.pending,
        ),
      ],
    );
  }

  Widget _buildPastBookings() {
    return Center(
      child: Text('No past bookings'),
    );
  }
}