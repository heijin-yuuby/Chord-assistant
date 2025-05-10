class ChordModel {
  static const List<String> majorScale = [
    'C',
    'C#',
    'D',
    'D#',
    'E',
    'F',
    'F#',
    'G',
    'G#',
    'A',
    'A#',
    'B',
  ];
  static const List<String> minorScale = [
    'C',
    'C#',
    'D',
    'D#',
    'E',
    'F',
    'F#',
    'G',
    'G#',
    'A',
    'A#',
    'B',
  ];

  static String convertChord(String chord, String fromKey, String toKey) {
    // 获取和弦的根音和类型（如 Cmaj7 中的 C 和 maj7）
    String rootNote = chord[0];
    String chordType = chord.length > 1 ? chord.substring(1) : '';

    // 获取源调性和目标调性的索引
    int fromIndex = majorScale.indexOf(fromKey);
    int toIndex = majorScale.indexOf(toKey);

    // 计算音程差
    int interval = (toIndex - fromIndex + 12) % 12;

    // 获取根音在音阶中的索引
    int rootIndex = majorScale.indexOf(rootNote);
    if (rootIndex == -1) return chord;

    // 计算新的根音
    int newRootIndex = (rootIndex + interval) % 12;
    String newRootNote = majorScale[newRootIndex];

    // 返回转换后的和弦
    return newRootNote + chordType;
  }

  static String convertProgression(
    String progression,
    String fromKey,
    String toKey,
  ) {
    List<String> chords = progression.split('-').map((e) => e.trim()).toList();
    List<String> convertedChords =
        chords.map((chord) => convertChord(chord, fromKey, toKey)).toList();
    return convertedChords.join(' - ');
  }
}
