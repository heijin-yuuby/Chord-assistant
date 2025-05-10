import 'package:flutter/material.dart';
import '../models/chord_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _progressionController = TextEditingController();
  String _fromKey = 'C';
  String _toKey = 'C';
  String _convertedProgression = '';
  final bool _isMajor = true;

  final List<String> _keys = ChordModel.majorScale;

  void _convertProgression() {
    if (_progressionController.text.isEmpty) return;

    setState(() {
      _convertedProgression = ChordModel.convertProgression(
        _progressionController.text,
        _fromKey,
        _toKey,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('和弦转换助手'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _progressionController,
              decoration: const InputDecoration(
                labelText: '输入和弦进行',
                hintText: '例如: C - F - G - Am',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _fromKey,
                    decoration: const InputDecoration(
                      labelText: '原调',
                      border: OutlineInputBorder(),
                    ),
                    items: _keys.map((String key) {
                      return DropdownMenuItem<String>(
                        value: key,
                        child: Text(key),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _fromKey = newValue;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _toKey,
                    decoration: const InputDecoration(
                      labelText: '目标调',
                      border: OutlineInputBorder(),
                    ),
                    items: _keys.map((String key) {
                      return DropdownMenuItem<String>(
                        value: key,
                        child: Text(key),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _toKey = newValue;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convertProgression,
              child: const Text('转换'),
            ),
            const SizedBox(height: 24),
            if (_convertedProgression.isNotEmpty) ...[
              const Text(
                '转换结果:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _convertedProgression,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _progressionController.dispose();
    super.dispose();
  }
}
