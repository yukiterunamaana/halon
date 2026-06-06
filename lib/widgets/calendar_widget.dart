import 'package:flutter/material.dart';

import '../models/calendar_config.dart';

class CalendarWidget extends StatefulWidget {
  final CalendarConfig config;
  const CalendarWidget({super.key, required this.config});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _currentMonth = DateTime.now();
  DateTime? _selectedDate;

  void _previousMonth() => setState(
    () => _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1),
  );
  void _nextMonth() => setState(
    () => _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1),
  );
  void _selectDate(DateTime date) => setState(() => _selectedDate = date);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Вычисляем размер ячейки: доступная ширина / 7 (минус отступы)
        final double cellSize =
            (constraints.maxWidth - 16) / 7; // отступы по бокам 8+8
        return Container(
          //padding: const EdgeInsets.all(2),
          child: Column(
            children: [
              //    _buildHeader(),
              const SizedBox(height: 16),
              //_buildWeekdaysHeader(cellSize),
              //const SizedBox(height: 4),
              Row(
                children: [
                  const SizedBox(width: 8),
                  Expanded(child: _buildDaysGrid(cellSize)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: _previousMonth,
          icon: const Icon(Icons.chevron_left),
        ),
        Text(
          '${_currentMonth.year} - ${_currentMonth.month}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        IconButton(
          onPressed: _nextMonth,
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }

  Widget _buildWeekdaysHeader(double cellSize) {
    final weekdays = widget.config.startMonday
        ? ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс']
        : ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'];
    return Row(
      children: weekdays
          .map(
            (day) => SizedBox(
              width: cellSize,
              child: Text(
                day,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: cellSize * 0.7,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildDaysGrid(double cellSize) {
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    int startOffset = widget.config.startMonday
        ? (firstDay.weekday - 1) % 7
        : firstDay.weekday % 7;
    final daysInMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month + 1,
      0,
    ).day;
    final today = DateTime.now();

    List<Widget> rows = [];
    List<Widget> currentRow = [];
    // Пустые ячейки до начала месяца
    for (int i = 0; i < startOffset; i++) {
      currentRow.add(SizedBox(width: cellSize, height: cellSize));
    }
    // Дни месяца
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(_currentMonth.year, _currentMonth.month, day);
      final weekday = date.weekday;
      Color dayColor = widget.config.weekdayColor;
      if (weekday == 6)
        dayColor = widget.config.saturdayColor;
      else if (weekday == 7)
        dayColor = widget.config.sundayColor;

      final isSelected = _selectedDate == date;
      final isToday =
          date.year == today.year &&
          date.month == today.month &&
          date.day == today.day;

      currentRow.add(
        GestureDetector(
          onTap: () => _selectDate(date),
          child: Container(
            width: cellSize,
            height: cellSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.blue.shade100
                  : (isToday ? Colors.blue.shade50 : null),
              shape: BoxShape.circle,
            ),
            child: Text(day.toString(), style: TextStyle(color: dayColor)),
          ),
        ),
      );
      if (currentRow.length == 7 || day == daysInMonth) {
        rows.add(Row(children: currentRow));
        currentRow = [];
      }
    }

    return Column(children: rows);
  }
}
