import 'package:flutter/material.dart';
import 'package:repository/repository/fact_repository.dart';
import 'package:repository/view_model/fact_view_model.dart';

class FactScreen extends StatefulWidget {
  const FactScreen({super.key});

  @override
  State<FactScreen> createState() => _FactScreenState();
}

class _FactScreenState extends State<FactScreen> {
  final factViewModel = FactViewModel();
  final factRepository = FactRepository();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadFacts();
  }

  @override
  void dispose() {
    super.dispose();
    factViewModel.facts.clear();
  }

  void loadFacts() async {
    setState(() => isLoading = true);

    await Future.delayed(Duration(milliseconds: 300));
    await factViewModel.getFacts();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Facts"),
        actions: [
          IconButton(
            onPressed: () async {
              isLoading = true;
              setState(() {});
              await factViewModel.getFresh();
              isLoading = false;
              setState(() {});
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                itemBuilder: (context, index) {
                  final fact = factViewModel.facts[index];
                  return ListTile(title: Text("${index + 1}. ${fact.dates}"));
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: factViewModel.facts.length,
              ),
    );
  }
}
