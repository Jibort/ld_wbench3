// Model de dades per a la informació d'hora mundial.
// CreatedAt: 2025/03/15 ds.

class WorldTime {
  final String timezone;
  final String abbreviation;
  final String datetime;
  final int utcOffset;
  final bool isDST;
  final String displayName;

  WorldTime({
    required this.timezone,
    required this.abbreviation,
    required this.datetime,
    required this.utcOffset,
    required this.isDST,
    required this.displayName,
  });

  /// Crea una instància a partir de la resposta JSON de l'API
  factory WorldTime.fromJson(Map<String, dynamic> json, String timezone) {
    // Extraiem el nom per mostrar a partir de la zona horària
    String displayName = timezone.split('/').last.replaceAll('_', ' ');

    // Calculem l'offset UTC en hores a partir de la cadena
    final offsetStr = json['utc_offset'] as String;
    final isNegative = offsetStr.startsWith('-');
    final parts = offsetStr.substring(1).split(':');
    final hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);
    final totalMinutes = (hours * 60 + minutes) * (isNegative ? -1 : 1);

    return WorldTime(
      timezone: timezone,
      abbreviation: json['abbreviation'],
      datetime: json['datetime'],
      utcOffset: totalMinutes,
      isDST: json['dst'] ?? false,
      displayName: displayName,
    );
  }

  /// Obté un objecte DateTime a partir de la cadena ISO
  DateTime get dateTimeObject {
    return DateTime.parse(datetime);
  }

  /// Obté una representació formatada de l'hora
  String get formattedTime {
    final dt = dateTimeObject;
    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');
    final second = dt.second.toString().padLeft(2, '0');
    return '$hour:$minute:$second';
  }

  /// Obté una representació formatada de la data
  String get formattedDate {
    final dt = dateTimeObject;
    final day = dt.day.toString().padLeft(2, '0');
    final month = dt.month.toString().padLeft(2, '0');
    final year = dt.year;
    return '$day/$month/$year';
  }

  /// Obté una representació formatada de la informació de fus horari
  String get formattedOffset {
    final hours = utcOffset ~/ 60;
    final minutes = utcOffset.abs() % 60;
    final sign = utcOffset >= 0 ? '+' : '-';
    return 'UTC$sign${hours.abs()}:${minutes.toString().padLeft(2, '0')}';
  }

  @override
  String toString() {
    return '$displayName: $formattedTime ($formattedOffset)';
  }
}
