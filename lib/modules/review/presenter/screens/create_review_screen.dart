import 'package:flutter/material.dart';
import 'package:kikagada/shared/components/app_bar_component.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key});

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.sizeOf(context).width, 60),
        child: const AppBarComponent(
          title: 'Criar review',
          hasBackButton: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              TextFormField(),
            ],
          ),
        ),
      ),
    );
  }
}
