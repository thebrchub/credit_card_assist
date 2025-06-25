import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/expense_model.dart';
import '../widgets/expense_tile.dart';

class ExpenseTrackerScreen extends StatefulWidget {
  const ExpenseTrackerScreen({super.key});

  @override
  State<ExpenseTrackerScreen> createState() => _ExpenseTrackerScreenState();
}

class _ExpenseTrackerScreenState extends State<ExpenseTrackerScreen> {
  final List<Expense> expenses = [
    Expense(title: 'Domino’s Pizza', amount: 249.00, category: 'Food', date: DateTime.now()),
    Expense(title: 'Raincoat', amount: 1340.00, category: 'Shopping', date: DateTime.now()),
    Expense(title: 'Amazon', amount: 200.00, category: 'Shopping', date: DateTime.now()),
    Expense(title: 'Train Ticket', amount: 390.00, category: 'Travel', date: DateTime.now()),
    Expense(title: 'Electricity', amount: 300.00, category: 'Bills', date: DateTime.now()),
  ];

  String selectedFilter = 'Day';
  bool isPieChart = true;
  DateTimeRange? selectedRange;
  double monthlyBudget = 20000;

  List<Expense> get filteredExpenses {
    if (selectedRange == null) return expenses;
    return expenses.where((e) =>
      e.date.isAfter(selectedRange!.start.subtract(const Duration(days: 1))) &&
      e.date.isBefore(selectedRange!.end.add(const Duration(days: 1)))
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final double monthSpent = filteredExpenses
        .where((e) => e.date.month == DateTime.now().month)
        .fold(0, (sum, e) => sum + e.amount);
    final double remaining = monthlyBudget - monthSpent;

    final Map<String, double> categoryTotals = {};
    for (var e in filteredExpenses) {
      categoryTotals[e.category] = (categoryTotals[e.category] ?? 0) + e.amount;
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0E0F1B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E0F1B),
        elevation: 0,
        centerTitle: true,
        title: Text('Expense Tracker', style: GoogleFonts.inter(color: Colors.white, fontSize: 20)),
        actions: [
          IconButton(
            icon: const Icon(Icons.date_range, color: Colors.white),
            onPressed: () async {
              DateTimeRange? picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2023),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (picked != null) setState(() => selectedRange = picked);
            },
          ),
          IconButton(
            icon: Icon(isPieChart ? Icons.bar_chart : Icons.pie_chart, color: Colors.white),
            onPressed: () => setState(() => isPieChart = !isPieChart),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6D6DFF),
        onPressed: () {},
        child: const Icon(Icons.add, size: 32),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      _analysisCard('This Month', monthSpent),
                      _analysisCard('Remaining\nBudget', remaining),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Chart Section
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: isPieChart
                        ? _buildPieChart(categoryTotals, monthSpent)
                        : _buildBarChart(categoryTotals),
                  ),
                  const SizedBox(height: 16),

                  // Category Labels with soft glow
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: categoryTotals.entries.map((entry) {
                      final color = _getCategoryColor(entry.key);
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: color.withOpacity(0.5),
                              blurRadius: 18,
                              spreadRadius: 0,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(radius: 5, backgroundColor: color),
                            const SizedBox(width: 6),
                            Text(entry.key, style: GoogleFonts.inter(color: Colors.white)),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),

                  // Filter Tabs with glow
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: ['Day', 'Week', 'Month'].map((label) {
                      final isSelected = selectedFilter == label;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => selectedFilter = label),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              gradient: isSelected
                                  ? const LinearGradient(
                                      colors: [Color(0xFF251E6D), Color(0xFF0E0E1D)],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )
                                  : null,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white24),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: Colors.deepPurpleAccent.withOpacity(0.4),
                                        blurRadius: 18,
                                        spreadRadius: 0,
                                      )
                                    ]
                                  : [],
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              label,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Expense List
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ExpenseTile(expense: filteredExpenses[index]),
              childCount: filteredExpenses.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart(Map<String, double> categoryTotals, double total) {
    return AspectRatio(
      key: const ValueKey("pie"),
      aspectRatio: 1.4,
      child: PieChart(
        PieChartData(
          sectionsSpace: 2,
          centerSpaceRadius: 50,
          sections: categoryTotals.entries.map((entry) {
            final percent = (entry.value / total) * 100;
            final color = _getCategoryColor(entry.key);
            return PieChartSectionData(
              color: color.withOpacity(0.85),
              value: entry.value,
              radius: 44,
              title: '${percent.toStringAsFixed(1)}%',
              titleStyle: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: color.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              titlePositionPercentageOffset: 0.6,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildBarChart(Map<String, double> categoryTotals) {
    return AspectRatio(
      key: const ValueKey("bar"),
      aspectRatio: 1.4,
      child: BarChart(
        BarChartData(
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: categoryTotals.entries.map((entry) {
            final color = _getCategoryColor(entry.key);
            return BarChartGroupData(
              x: categoryTotals.keys.toList().indexOf(entry.key),
              barRods: [
                BarChartRodData(
                  toY: entry.value,
                  color: color,
                  width: 18,
                  borderRadius: BorderRadius.circular(6),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _analysisCard(String title, double value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF181826),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.08),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(title, style: GoogleFonts.inter(color: Colors.white70, fontSize: 12), textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text('₹${value.toStringAsFixed(0)}', style: GoogleFonts.inter(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Food':
        return const Color(0xFF5A5FFF);
      case 'Shopping':
        return const Color(0xFF8A55E2);
      case 'Travel':
        return const Color(0xFF00B4D8);
      case 'Bills':
        return const Color(0xFF48E49B);
      default:
        return const Color(0xFF6C757D);
    }
  }
}
