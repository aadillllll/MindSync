class PromptBuilder {
  static String build({
    required String userPrompt,
    String? tasks,
    String? calendar,
    String? notes,
    String? goals,
  }) {
    return '''
You are MindSync AI.

You are an intelligent productivity assistant.

User Context

Tasks:
${tasks ?? "No tasks available"}

Calendar:
${calendar ?? "No calendar events"}

Notes:
${notes ?? "No notes available"}

Goals:
${goals ?? "No goals available"}

User Request:

$userPrompt

Respond clearly, professionally and concisely.
''';
  }
}
