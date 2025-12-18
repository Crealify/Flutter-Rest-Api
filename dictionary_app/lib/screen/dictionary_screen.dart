import 'package:dictionary_app/model/dictionary_model.dart';
import 'package:dictionary_app/services/services.dart';
import 'package:flutter/material.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  DictionaryModel? myDictionaryModel;
  bool isLoading = false;
  String noDataFound = "Now You Can Search";
  searchContain(String word) async {
    setState(() {
      isLoading = true;
    });
    try {
      myDictionaryModel = await APIservices.fetchData(word);
      setState(() {});
    } catch (e) {
      myDictionaryModel = null;
      noDataFound = "Meaning can't be found";
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Dictionary",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            //for searching the word
            SearchBar(
              hintText: "Search the word here",
              onSubmitted: (value) {
                searchContain(value);
              },
            ),
            SizedBox(height: 10),
            if (isLoading)
              const LinearProgressIndicator()
            else if (myDictionaryModel != null)
              Expanded(
                child: Column(
                  children: [
                    Text(
                      myDictionaryModel!.word,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      myDictionaryModel!.phonetics.isEmpty
                          ? myDictionaryModel!.phonetics[0].text ?? ""
                          : "",
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: ListView.builder(
                        itemCount: myDictionaryModel!.meanings.length,
                        itemBuilder: (context, index) {},
                      ),
                    ),
                  ],
                ),
              )
            else
              Center(child: Text(noDataFound, style: TextStyle(fontSize: 22))),
          ],
        ),
      ),
    );
  }
  
}
