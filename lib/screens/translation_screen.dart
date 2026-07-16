import 'package:flutter/material.dart';
import '../services/api_service.dart';

class TranslationScreen extends StatefulWidget {
  const TranslationScreen({super.key});

  @override
  State<TranslationScreen> createState() =>
      _TranslationScreenState();
}

class _TranslationScreenState
    extends State<TranslationScreen> {

  final TextEditingController controller =
      TextEditingController();

  String translatedText = "";

  String selectedLanguage = "hi";

  Future<void> translate() async {

    final result =
        await ApiService.translateText(
      controller.text,
      selectedLanguage,
    );

    setState(() {
      translatedText =
    result["translated_text"];
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
            const Text("AI Translation"),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller: controller,

              decoration:
                  const InputDecoration(
                hintText:
                    "Enter Message",
              ),
            ),

            const SizedBox(height: 20),

            DropdownButton<String>(
              value: selectedLanguage,

              items: const [

                DropdownMenuItem(
                  value: "hi",
                  child: Text("Hindi"),
                ),

                DropdownMenuItem(
                  value: "mr",
                  child: Text("Marathi"),
                ),

                DropdownMenuItem(
                  value: "en",
                  child: Text("English"),
                ),
              ],

              onChanged: (value) {

                setState(() {

                  selectedLanguage =
                      value!;

                });
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: translate,
              child:
                  const Text("Translate"),
            ),

            const SizedBox(height: 30),

            Text(
              translatedText,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}