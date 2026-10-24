import 'package:flutter/material.dart';

void main() {
  runApp(const AccountingGameApp());
}

class AccountingGameApp extends StatelessWidget {
  const AccountingGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'لعبة ألغاز المحاسبة - باكالوريا',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int currentLevel = 0;
  int score = 0;
  String feedback = "";

  // قائمة بألغاز المحاسبة المستوحاة من تمارين البكالوريا
  final List<Map<String, dynamic>> levels = [
    {
      "title": "المرحلة 1: القيود البسيطة (شراء بضاعة)",
      "question": "تم شراء بضاعة بمبلغ 50,000 دج على الحساب (على المدى القصير). ما هو الحساب الذي يكون في الطرف **المدين**؟",
      "options": [
        "حساب 401 الموردون",
        "حساب 380 بضائع مخزنة",
        "حساب 512 البنك"
      ],
      "correctIndex": 1, // الحساب 380 أو حساب المخزونات/المشتريات حسب الخطة المحاسبية
      "explanation": "عند الشراء، حساب المشتريات/المخزونات يسجل في المدين، والموردون في الدائن."
    },
    {
      "title": "المرحلة 2: التسوية وإهتلاك التثبيتات",
      "question": "تم حيازة معدات وادوات بمبلغ 120,000 دج مدة الاهتلاك 5 سنوات (خطوط متناقصة/متناظرة). ما هي قسط الاهتلاك السنوي؟",
      "options": [
        "24,000 دج",
        "20,000 دج",
        "30,000 دج"
      ],
      "correctIndex": 0,
      "explanation": "الاهتلاك السنوي = التكلفة / المدة = 120000 / 5 = 24000 دج."
    }
  ];

  void checkAnswer(int selectedIndex) {
    setState(() {
      if (selectedIndex == levels[currentLevel]["correctIndex"]) {
        score += 10;
        feedback = "إجابة صحيحة! أحسنت 👏";
        
        // الانتقال للمرحلة التالية بعد تأخير بسيط أو الضغط
        if (currentLevel < levels.length - 1) {
          currentLevel++;
        } else {
          feedback = "لقد أكزلت جميع مراحل اللعبة بنجاح! مبروك البكالوريا 🎉";
        }
      } else {
        feedback = "إجابة خاطئة، حاول مرة أخرى ❌";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final level = levels[currentLevel];

    return Scaffold(
      appBar: AppBar(
        title: Text('لعبة تحدي المحاسبة - مرحلة ${currentLevel + 1}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('المخزون/النقاط: $score', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('المستوى: ${currentLevel + 1}/${levels.length}', style: const TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(level["title"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
                    const SizedBox(height: 10),
                    Text(level["question"], style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ...List.generate(
              (level["options"] as List).length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ElevatedButton(
                  onPressed: () => checkAnswer(index),
                  child: Text(level["options"][index], style: const TextStyle(fontSize: 16)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              feedback,
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold, 
                color: feedback.contains("صحيحة") ? Colors.green : Colors.red
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
