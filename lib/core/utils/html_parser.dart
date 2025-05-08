import 'package:html/parser.dart' as html_parser;

String htmlDescriptionToSingleLine(String? encodedHtml) {
  if (encodedHtml == null) return "لا يوجد وصف";

  final decodedHtml = encodedHtml
      .replaceAll(r'\u003C', '<')
      .replaceAll(r'\u003E', '>')
      .replaceAll(r'\n', '');

  final document = html_parser.parse(decodedHtml);
  final text = document.body?.text ?? '';
  return text.replaceAll('\n', ' ').replaceAll(RegExp(r'\s+'), ' ').trim();
}
