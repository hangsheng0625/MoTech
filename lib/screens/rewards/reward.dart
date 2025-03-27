import 'package:flutter/material.dart';
import 'package:myapp/components/navbar.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({Key? key}) : super(key: key);

  @override
  _RewardScreenState createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Task> _tasks = [];
  int _points = 500;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initializeTasks();
  }

  void _initializeTasks() {
    _tasks = [
      Task(description: 'Complete daily check-in', points: 50, completed: false),
      Task(description: 'Add crop measurement', points: 100, completed: true),
      Task(description: 'Analyze crop health', points: 150, completed: false),
      Task(description: 'Record fertilizer usage', points: 75, completed: false),
      Task(description: 'Submit weekly report', points: 200, completed: false),
    ];
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index].completed = !_tasks[index].completed;
      if (_tasks[index].completed) {
        _points += _tasks[index].points;
      } else {
        _points -= _tasks[index].points;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: const Navbar(index: 1),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFFFCD8), Color(0xFFCBEFD1)],
              stops: [0.196, 0.451],
            ),
          ),
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 24, left: 24, right: 24),
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        'My Rewards',
                        style: TextStyle(
                          color: const Color(0xFF010102),
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          height: 1.125,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 20),
                            const SizedBox(width: 4),
                            Text(
                              '$_points',
                              style: const TextStyle(
                                color: Color(0xFF010102),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Tab Bar with Line Indicator
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: const Color(0xFF4B9B28),
                  indicatorWeight: 3,
                  labelColor: const Color(0xFF4B9B28),
                  unselectedLabelColor: const Color(0xFF010102),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  tabs: const [
                    Tab(text: 'Vouchers'),
                    Tab(text: 'Points'),
                  ],
                ),
              ),

              // Tab Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Vouchers Tab
                    ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      itemCount: vouchers.length,
                      itemBuilder: (context, index) => _buildVoucherCard(vouchers[index]),
                    ),

                    // Points Tab
                    ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) => _buildTaskItem(_tasks[index], index),
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

  Widget _buildTaskItem(Task task, int index) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: Checkbox(
          value: task.completed,
          onChanged: (value) => _toggleTask(index),
          activeColor: const Color(0xFF4B9B28),
        ),
        title: Text(
          task.description,
          style: TextStyle(
            fontSize: 16,
            color: task.completed ? Colors.grey : const Color(0xFF010102),
            decoration: task.completed ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF4B9B28).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '+${task.points}',
            style: const TextStyle(
              color: Color(0xFF1A612D),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVoucherCard(Voucher voucher) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF4B9B28).withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${voucher.discount}%',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A612D),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    voucher.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Valid until ${voucher.expiryDate}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            // Points Required Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF4B9B28).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.star, 
                    color: Color(0xFF4B9B28), 
                    size: 16
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${voucher.pointsRequired}',
                    style: const TextStyle(
                      color: Color(0xFF1A612D),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Task {
  String description;
  int points;
  bool completed;

  Task({
    required this.description,
    required this.points,
    required this.completed,
  });
}

class Voucher {
  final String name;
  final int discount;
  final String expiryDate;
  final int pointsRequired;

  Voucher({
    required this.name,
    required this.discount,
    required this.expiryDate,
    required this.pointsRequired,
  });
}

final List<Voucher> vouchers = [
  Voucher(
    name: 'Seed Purchase Discount',
    discount: 20,
    expiryDate: '2025-12-31',
    pointsRequired: 250,
  ),
  Voucher(
    name: 'Fertilizer Special Offer',
    discount: 15,
    expiryDate: '2025-11-30',
    pointsRequired: 200,
  ),
  Voucher(
    name: 'Equipment Special Offer',
    discount: 25,
    expiryDate: '2025-01-15',
    pointsRequired: 350,
  ),
  Voucher(
    name: 'Organic Pesticide Coupon',
    discount: 10,
    expiryDate: '2025-12-15',
    pointsRequired: 150,
  ),
];