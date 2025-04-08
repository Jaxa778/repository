import 'package:flutter/material.dart';
import 'package:repository/view_model/fact_view_model.dart';

class FactScreen extends StatefulWidget {
  const FactScreen({super.key});

  @override
  State<FactScreen> createState() => _FactScreenState();
}

class _FactScreenState extends State<FactScreen> {
  final factViewModel = FactViewModel();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    isLoading = true;
    factViewModel.getFacts().then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Facts"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.refresh))],
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                itemBuilder: (context, index) {
                  final fact = factViewModel.facts[index];
                  return Text("${index + 1}.${fact.dates}");
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: factViewModel.facts.length,
              ),
    );
  }
}
