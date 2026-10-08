import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MainPage());
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              key: Key('left'),
              child: WeaponPanel(title: 'Левое орудие'),
            ),
            Expanded(
              key: Key('right'),
              child: WeaponPanel(title: 'Правое орудие'),
            ),
          ],
        ),
      ),
    );
  }
}

class WeaponPanel extends StatefulWidget {
  const WeaponPanel({super.key, required this.title});

  final String title;

  @override
  State<WeaponPanel> createState() => _WeaponPanelState();
}

class _WeaponPanelState extends State<WeaponPanel> {
  final _controller = TextEditingController();

  double? _distance;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String text) {
    setState(() => _distance = double.tryParse(text));
  }

  @override
  Widget build(BuildContext context) {
    int? charges;
    double? elevation;

    if (_distance != null && _distance! > 0) {
      charges = (_distance! / 5).ceil();
      elevation = 12 / charges * _distance!;
    }

    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
            ],
            decoration: const InputDecoration(
              labelText: 'Расстояние',
              border: OutlineInputBorder(),
            ),
            onChanged: _onChanged,
          ),
          const SizedBox(height: 8),
          Text('Заряды: ${charges ?? '—'}'),
          const SizedBox(height: 8),
          Text('Возвышение: ${elevation?.toStringAsFixed(2) ?? '—'}'),
        ],
      ),
    );
  }
}
