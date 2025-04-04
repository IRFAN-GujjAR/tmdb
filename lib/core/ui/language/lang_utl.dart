final class LangUtl {
  static String? formatLanguage(String? language) {
    if (language == null || language.isEmpty) {
      return null;
    }
    return language == 'en' ? 'Enligsh' : 'Other';
  }
}
