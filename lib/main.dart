import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Чат з ботом',
      themeMode: ThemeMode.dark,
      theme: ThemeData.light(),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.blueGrey,
        textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[850],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      home: ChatPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _botGreet();
  }

  void _botGreet() {
    setState(() {
      _messages.add({
        'sender': 'bot',
        'text': 'Привіт! Я бот. Як я можу допомогти?'
      });
    });
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': text});
    });

    _controller.clear();

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _messages.add({'sender': 'bot', 'text': _generateBotReply(text)});
      });
    });
  }

  String _generateBotReply(String message) {
    final lower = message.toLowerCase();

    if (lower.contains('я не хочу жити') || lower.contains('втомився від цього') || lower.contains('я втомився')) {
      return '''
Життя — це найцінніше, що в тебе є. Навіть якщо зараз темно, пам’ятай: темрява завжди змінюється на світло. Ти — не один. Кожна твоя емоція має значення.

Іноді ми всі втомлюємося, але це не кінець — це пауза. Ти маєш право відпочити, поплакати, бути слабким — це не соромно. Але ти також маєш силу йти далі.

Живи заради себе. За ради того, щоб побачити, що чекає попереду. Бо попереду буде добре 💛
''';
    }

    if (lower.contains('мене ніхто не розуміє')) {
      return 'Мені дуже шкода це чути. Твої почуття — важливі. Іноді ми просто потребуємо, щоб нас вислухали. Я тут, і я тебе чую.';
    }

    if (lower.contains('мені самотньо')) {
      return 'Самотність — це важке відчуття. Але ти не один. Ти вже зробив перший крок — заговорив про це. І це дуже сміливо. Я з тобою.';
    }

    if (lower.contains('я постійно хвилююся') || lower.contains('тривога')) {
      return 'Тривога — це нормально. Спробуй зробити кілька глибоких вдихів. Зосередься на своєму диханні. Ти в безпеці. Ти не один.';
    }

    if (lower.contains('мені страшно')) {
      return 'Страх — це природно. Важливо знати, що це пройде. Ти сильніший, ніж здається. Я поруч.';
    }

    if (lower.contains('життя без сенсу') || lower.contains('я не бачу сенсу')) {
      return 'У кожного бувають моменти сумніву. Але сенс часто приходить тоді, коли ми його навіть не шукаємо. Ти важливий. І ти потрібен цьому світу.';
    }

    if (lower.contains('я в депресії')) {
      return '''
Це дуже непросто — і я дуже вдячний тобі, що ти поділився цим. Пам’ятай, що звернутися по допомогу — це не слабкість, це сила.

Можливо, поговорити з психологом — це буде важливий крок. Але навіть зараз ти вже не сам. Я тут, і мені не байдуже ❤️
''';
    }

    if (lower.contains('привіт') || lower.contains('доброго') || lower.contains('хай')) {
      return 'Привіт! Я бот. Що тебе турбує? Я створений для того щоб говорити по душам, якщо тобі треба моральна підтримка — пиши до мене. Я як друг, котрий ніколи тебе не буде ігнорувати 💙';
    }

    if (lower.contains('як справи')) {
      return 'У мене все добре, дякую! А як у тебе?';
    }

    return 'Дякую, що поділився. Якщо хочеш — можеш розповісти більше. Я поруч.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Чат з ботом')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isBot = message['sender'] == 'bot';
                return Align(
                  alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: isBot ? Colors.grey[800] : Colors.blueGrey[600],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message['text'] ?? '',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(height: 1, color: Colors.grey),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: _sendMessage,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Напишіть повідомлення...',
                      hintStyle: TextStyle(color: Colors.white60),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blueAccent),
                  onPressed: () => _sendMessage(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
