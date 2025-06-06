import 'package:flutter/material.dart';

class HistoryList extends StatelessWidget {
  final List history;
  const HistoryList({super.key, this.history = const []});

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return const Center(child: Text('No history yet.'));
    }
    return ListView.builder(
      itemCount: history.length,
      itemBuilder: (context, index) {
        final item = history[index];
        return ListTile(
          title: Text(item.expression),
          subtitle: Text('= ${item.result}'),
          trailing: Text(
            '${item.timestamp.hour.toString().padLeft(2, '0')}:${item.timestamp.minute.toString().padLeft(2, '0')}',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        );
      },
    );
  }
}
