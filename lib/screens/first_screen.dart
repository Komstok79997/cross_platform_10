import 'package:flutter/material.dart';
import 'preview_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  static const String _robotIconUrl =
      'https://emojiisland.com/cdn/shop/products/Robot_Emoji_Icon_abe1111a-1293-4668-bdf9-9ceb05cff58e_large.png?v=1571606090';

  final TextEditingController _textController = TextEditingController();
  double _fontSize = 16;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _openPreview() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewScreen(
          text: _textController.text,
          fontSize: _fontSize,
        ),
      ),
    );

    if (!mounted) return;

    final String message = switch (result) {
      'ok' => 'Cool!',
      'cancel' => "Let's try something else.",
      _ => "Don't know what to say.",
    };

    _showResultDialog(message);
  }

  void _showResultDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
          child: Image.network(
            _robotIconUrl,
            width: 56,
            height: 56,
            errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.smart_toy, size: 56),
          ),
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text previewer'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: 'Text',
                  helperText: 'Enter some text',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Font size: ${_fontSize.toInt()}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Expanded(
                    child: Slider(
                      value: _fontSize,
                      min: 10,
                      max: 100,
                      divisions: 90,
                      label: _fontSize.toInt().toString(),
                      onChanged: (value) {
                        setState(() {
                          _fontSize = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: _openPreview,
                child: const Text('Preview'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}