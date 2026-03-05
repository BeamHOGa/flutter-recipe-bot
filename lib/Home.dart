import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<_ChatMessage> _messages = [
    const _ChatMessage(
      text:
          'สวัสดีครับ 👩‍🍳 ผมคือผู้ช่วยสูตรอาหาร\nถามได้เลย เช่น “ขอสูตรผัดกะเพราไก่” หรือ “มีเมนูไข่ง่าย ๆ ไหม”',
      isUser: false,
    ),
  ];

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(_ChatMessage(text: text, isUser: true));
      _messages.add(_ChatMessage(text: _generateRecipeReply(text), isUser: false));
      _textController.clear();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _generateRecipeReply(String prompt) {
    final lower = prompt.toLowerCase();

    if (lower.contains('กะเพรา')) {
      return 'สูตรผัดกะเพราไก่ (1-2 ที่)\n\n'
          'วัตถุดิบ\n- อกไก่สับ 200 กรัม\n- กระเทียม 5 กลีบ + พริก 5 เม็ด\n- ใบกะเพรา 1 ถ้วย\n- น้ำปลา 1 ช้อนโต๊ะ\n- ซีอิ๊วดำ 1/2 ช้อนชา\n- น้ำตาล 1/2 ช้อนชา\n\n'
          'วิธีทำ\n1) โขลกกระเทียมพริกแล้วผัดกับน้ำมัน\n2) ใส่ไก่ ผัดจนสุก\n3) ปรุงรสด้วยน้ำปลา ซีอิ๊วดำ น้ำตาล\n4) ใส่ใบกะเพรา ปิดไฟทันที\n\n'
          'เสิร์ฟกับข้าวสวยและไข่ดาวจะอร่อยมากครับ 🍳';
    }

    if (lower.contains('ไข่')) {
      return 'เมนูไข่ง่าย ๆ: ไข่เจียวฟู\n\n'
          'วัตถุดิบ\n- ไข่ 2 ฟอง\n- น้ำปลา 1 ช้อนชา\n- น้ำมะนาว 2-3 หยด\n\n'
          'วิธีทำ\n1) ตีไข่ให้ขึ้นฟองเยอะ ๆ\n2) ใส่น้ำปลาและน้ำมะนาว\n3) ใช้น้ำมันร้อนจัด แล้วเทไข่ลงทอด\n4) กลับด้านสั้น ๆ แล้วตักขึ้น\n\n'
          'ทานกับซอสพริกหรือข้าวร้อน ๆ ได้เลยครับ 😋';
    }

    if (lower.contains('ต้มยำ')) {
      return 'สูตรต้มยำกุ้งน้ำใส\n\n'
          'วัตถุดิบ\n- กุ้งสด 200 กรัม\n- ข่า ตะไคร้ ใบมะกรูด\n- เห็ดฟาง 100 กรัม\n- น้ำปลา 2 ช้อนโต๊ะ\n- น้ำมะนาว 2 ช้อนโต๊ะ\n- พริกบุบตามชอบ\n\n'
          'วิธีทำ\n1) ต้มน้ำให้เดือด ใส่สมุนไพร\n2) ใส่เห็ดและกุ้ง\n3) ปรุงด้วยน้ำปลา\n4) ปิดไฟแล้วค่อยใส่น้ำมะนาว\n\n'
          'เคล็ดลับ: ใส่น้ำมะนาวหลังปิดไฟ กลิ่นจะหอมสดชื่นครับ';
    }

    if (lower.contains('เมนู') || lower.contains('แนะนำ')) {
      return 'ลองเลือกจากเมนูยอดนิยมนี้ได้เลยครับ\n'
          '- ผัดกะเพราไก่\n'
          '- ข้าวผัดกุ้ง\n'
          '- ต้มยำกุ้งน้ำใส\n'
          '- ไข่เจียวหมูสับ\n\n'
          'พิมพ์ชื่อเมนูที่อยากได้ แล้วผมจะส่งสูตรให้ทันที 👨‍🍳';
    }

    return 'ผมช่วยเรื่องสูตรอาหารได้ครับ 🍲\n'
        'ลองถามแบบนี้ได้:\n'
        '- ขอสูตรผัดกะเพราไก่\n'
        '- มีเมนูไข่ง่าย ๆ ไหม\n'
        '- ขอสูตรต้มยำกุ้ง\n\n'
        'ถ้ามีวัตถุดิบที่บ้านอยู่แล้ว บอกผมได้ เดี๋ยวช่วยคิดเมนูให้ครับ';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _MessageBubble(message: message);
              },
            ),
          ),
          SafeArea(
            top: false,
            minimum: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'พิมพ์คำถามเกี่ยวกับสูตรอาหาร...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;

  const _ChatMessage({required this.text, required this.isUser});
}

class _MessageBubble extends StatelessWidget {
  final _ChatMessage message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 320),
        decoration: BoxDecoration(
          color: message.isUser
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message.text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}