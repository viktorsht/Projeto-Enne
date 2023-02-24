import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TimeSlot {
  final int id;
  final DateTime startTime;
  final DateTime endTime;

  TimeSlot({required this.id, required this.startTime, required this.endTime});
}

class TimeSlotsPage extends StatefulWidget {
  @override
  _TimeSlotsPageState createState() => _TimeSlotsPageState();
}

class _TimeSlotsPageState extends State<TimeSlotsPage> {
  List<TimeSlot> _timeSlots = [];
  int? _selectedTimeSlotId;

  @override
  void initState() {
    super.initState();
    _loadTimeSlots();
  }

  Future<void> _loadTimeSlots() async {
    final timeSlots = await Api.getTimeSlots();
    setState(() {
      _timeSlots = timeSlots;
    });
  }

  void _onTimeSlotSelected(int timeSlotId) {
    setState(() {
      _selectedTimeSlotId = timeSlotId;
    });
  }

  Future<void> _reserveTimeSlot() async {
    if (_selectedTimeSlotId == null) {
      return;
    }
    await Api.reserveTimeSlot(_selectedTimeSlotId!);
    _loadTimeSlots();
    setState(() {
      _selectedTimeSlotId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Slots'),
      ),
      body: ListView.builder(
        itemCount: _timeSlots.length,
        itemBuilder: (context, index) {
          final timeSlot = _timeSlots[index];
          final isSelected = timeSlot.id == _selectedTimeSlotId;
          return ListTile(
            title: Text('${timeSlot.startTime} - ${timeSlot.endTime}'),
            trailing: isSelected ? Icon(Icons.check) : null,
            onTap: () => _onTimeSlotSelected(timeSlot.id),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _reserveTimeSlot,
        child: Icon(Icons.check),
      ),
    );
  }
}

class Api {
  static const baseUrl = 'http://localhost/phpApi/public_html/api';

  static Future<List<TimeSlot>> getTimeSlots() async {
    final response = await http.get(Uri.parse('$baseUrl/time'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => TimeSlot(
        id: json['id'],
        startTime: DateTime.parse(json['start_time']),
        endTime: DateTime.parse(json['end_time']),
      )).toList();
    } else {
      throw Exception('Failed to load time slots');
    }
  }

  static Future<void> reserveTimeSlot(int timeSlotId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reserve_time_slot'),
      body: {
        'time_slot_id': timeSlotId.toString(),
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to reserve time slot');
    }
  }
}
