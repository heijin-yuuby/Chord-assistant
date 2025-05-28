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
  final List<List<String>> _commonChordGroups = [
    ['C', 'Cmaj7', 'C7', 'Cm', 'Cm7', 'Cdim'],
    ['D', 'Dmaj7', 'D7', 'Dm', 'Dm7', 'Ddim'],
    ['E', 'Emaj7', 'E7', 'Em', 'Em7', 'Edim'],
    ['F', 'Fmaj7', 'F7', 'Fm', 'Fm7', 'Fdim'],
    ['G', 'Gmaj7', 'G7', 'Gm', 'Gm7', 'Gdim'],
    ['A', 'Amaj7', 'A7', 'Am', 'Am7', 'Adim'],
    ['B', 'Bmaj7', 'B7', 'Bm', 'Bm7', 'Bdim'],
  ];

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
        title: const Text('Chord Assistant'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _progressionController,
                decoration: const InputDecoration(
                  labelText: '输入或选择和弦进行',
                  hintText: '例如: C F G Am 或 C-F-G-Am 或 C,F,G,Am',
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
              const SizedBox(height: 24),
              const Text(
                '常用和弦',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Column(
                children: _commonChordGroups.map((chordGroup) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: chordGroup.map((chord) {
                        return ElevatedButton(
                          onPressed: () {
                            String current = _progressionController.text.trim();
                            String toAdd = current.isEmpty ? chord : ' $chord';
                            _progressionController.text = current + toAdd;
                            _progressionController.selection =
                                TextSelection.fromPosition(
                              TextPosition(
                                  offset: _progressionController.text.length),
                            );
                          },
                          child: Text(chord),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      child: Text('Hello'),
    );
  }

  @override
  void dispose() {
    _progressionController.dispose();
    super.dispose();
  }
}
