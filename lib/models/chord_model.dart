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

  // 支持的分隔符列表
  static const List<String> separators = ['-', ' ', ',', '，', '、'];

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
    // 标准化输入字符串，将所有支持的分隔符替换为空格
    String normalizedProgression = progression;
    for (String separator in separators) {
      normalizedProgression = normalizedProgression.replaceAll(separator, ' ');
    }

    // 分割和弦并过滤空字符串
    List<String> chords = normalizedProgression
        .split(' ')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    // 转换和弦
    List<String> convertedChords =
        chords.map((chord) => convertChord(chord, fromKey, toKey)).toList();

    // 使用空格连接转换后的和弦
    return convertedChords.join(' ');
  }
}
