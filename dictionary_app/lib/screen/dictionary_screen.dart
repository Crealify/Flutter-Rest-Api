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
            SizedBox(height: 15  ),
            if (isLoading)
              const LinearProgressIndicator()
            else if (myDictionaryModel != null)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      myDictionaryModel!.phonetics.isNotEmpty
                          ? myDictionaryModel!.phonetics[0].text ?? ""
                          : "",
                    ),
                    Divider(height: 4, thickness: 2),
                    const SizedBox(height: 2),
                    Expanded(
                      child: ListView.builder(
                        itemCount: myDictionaryModel!.meanings.length,
                        itemBuilder: (context, index) {
                          return showMeaning(
                            myDictionaryModel!.meanings[index],
                          );
                        },
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

  showMeaning(Meaning meaning) {
    String wordDefination = "";
    for (var element in meaning.definitions) {
      int index = meaning.definitions.indexOf(element);
      wordDefination += "\n${index + 1}.${element.definition}\n";
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              meaning.partOfSpeech,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Defination: ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black38,
              ),
            ),
            const SizedBox(height: 10),
            Text(wordDefination, style: TextStyle(fontSize: 16, height: 1)),
            wordRelation("Synonyms", meaning.synonyms),
            wordRelation("Antonyms", meaning.antonyms),
          ],
        ),
      ),
    );
  }

  wordRelation(String title, List<String>? setList) {
    if (setList?.isNotEmpty ?? false) {
      return Column(
        children: [
          Text(
            "$title: ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            setList!
                .toList()
                .toString()
                .replaceAll("{", "")
                .replaceAll("}", ""),
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
        ],
      );
    } else {
      return SizedBox();
    }
  }
}
