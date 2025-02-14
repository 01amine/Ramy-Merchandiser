import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../domain/entities/card.dart';
import '../../domain/entities/stat.dart';
import '../bloc/progress_bloc.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProgressBloc()..add(LoadProgress()),
      child: Scaffold(
        body: BlocBuilder<ProgressBloc, ProgressState>(
          builder: (context, state) {
            if (state is ProgressLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProgressLoaded) {
              return _buildContent(context, state.cards, state.stats);
            } else {
              return const Center(child: Text("Something went wrong!"));
            }
          },
        ),
      ),
    );
  }

  Widget _buildContent(
      BuildContext context, List<ProgressCard> cards, ProductivityStats stats) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: _buildStackedCards(cards),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildProductivityCharts(stats),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildStackedCards(List<ProgressCard> cards) {
    return SizedBox(
      height: 220,
      child: PageView.builder(
        itemCount: cards.length,
        controller: PageController(viewportFraction: 0.8),
        padEnds: false,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: PageController(),
            builder: (context, child) {
              double value = 1.0;
              if (index == 0) value = 1.0;
              return Transform.scale(
                scale: value,
                child: child,
              );
            },
            child: _buildCard(cards[index], index == 0),
          );
        },
      ),
    );
  }

  Widget _buildCard(ProgressCard card, bool isTop) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isTop
              ? [Colors.blueAccent, Colors.purpleAccent]
              : [Colors.grey[300]!, Colors.grey[400]!],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              card.title.toUpperCase(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 15),
            if (isTop)
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: card.progress,
                  strokeWidth: 8,
                  backgroundColor: Colors.white30,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            const SizedBox(height: 15),
            Text(
              card.date,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.9),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductivityCharts(ProductivityStats stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "Productivity Overview",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        _buildBarChart(stats),
        const SizedBox(height: 40),
        _buildPieChart(stats),
      ],
    );
  }

  Widget _buildBarChart(ProductivityStats stats) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value == 0 ? 'Completed' : 'Total',
                    style: const TextStyle(fontSize: 12),
                  );
                },
              ),
            ),
          ),
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(
                  toY: stats.completedTasks.toDouble(),
                  gradient: _barsGradient,
                  width: 20,
                  borderRadius: BorderRadius.circular(8),
                )
              ],
            ),
            BarChartGroupData(
              x: 1,
              barRods: [
                BarChartRodData(
                  toY: stats.totalTasks.toDouble(),
                  gradient: _barsGradient,
                  width: 20,
                  borderRadius: BorderRadius.circular(8),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart(ProductivityStats stats) {
    return SizedBox(
      height: 200,
      child: Row(
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 40,
                startDegreeOffset: -90,
                sections: [
                  PieChartSectionData(
                    value: stats.focusTime,
                    title:
                        '${(stats.focusTime / (stats.focusTime + stats.distractions) * 100).toStringAsFixed(1)}%',
                    color: Colors.blueAccent,
                    radius: 30,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    value: stats.distractions,
                    title:
                        '${(stats.distractions / (stats.focusTime + stats.distractions) * 100).toStringAsFixed(1)}%',
                    color: Colors.redAccent,
                    radius: 25,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _LegendItem(color: Colors.blueAccent, text: 'Focus Time'),
              SizedBox(height: 8),
              _LegendItem(color: Colors.redAccent, text: 'Distractions'),
            ],
          )
        ],
      ),
    );
  }

  final _barsGradient = const LinearGradient(
    colors: [
      Colors.lightBlueAccent,
      Colors.blueAccent,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const _LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 8),
        Text(text, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
