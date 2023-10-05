import 'dart:io';

import 'package:flutter/material.dart';

class SelectedFilesPreviewComponent extends StatelessWidget {
  const SelectedFilesPreviewComponent({super.key, required this.files});

  final List<File> files;

  @override
  Widget build(BuildContext context) {
    if (files.isEmpty) return Container();
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: files.length,
        itemBuilder: (ctx, index) {
          final filePath = files[index].path;
          final fileNameStartAter = filePath.lastIndexOf('/') + 1;
          final fileName = files[index].path.substring(
                fileNameStartAter,
                filePath.length - 1,
              );
          return ListTile(
            title: Text(
              fileName,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        },
      ),
    );
  }
}
