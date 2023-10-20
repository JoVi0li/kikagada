import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/external/extensions/review_entity_extension.dart';
import 'package:kikagada/modules/review/infra/datasources/review_datasource.dart';
import 'package:uuid/uuid.dart';

class FirebaseReviewDatasource implements IReviewDatasource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final FirebaseAuth _auth;

  FirebaseReviewDatasource({
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
    required FirebaseAuth auth,
  })  : _firestore = firestore,
        _storage = storage,
        _auth = auth;

  @override
  Future<ReviewEntity> create(ReviewEntity review) async {
    final reviewId = const Uuid().v4();
    return await _firestore
        .collection('reviews')
        .doc(reviewId)
        .set(ReviewEntityExtension.toMap(
          review.copyWith(
            id: reviewId,
            authorId: _auth.currentUser!.uid,
          ),
        ))
        .then((_) => review);
  }

  @override
  Future<ReviewEntity> delete(String id) async {
    final docSnap = await _firestore.collection('reviews').doc(id).get();
    final review = ReviewEntityExtension.fromMap(docSnap.data()!);
    await _firestore.collection('reviews').doc(id).delete();
    return review;
  }

  @override
  Future<ReviewEntity> getById(String id) async {
    final docSnap = await _firestore.collection('reviews').doc(id).get();
    return ReviewEntityExtension.fromMap(docSnap.data()!);
  }

  @override
  Future<ReviewEntity> update(ReviewEntity review) async {
    await _firestore
        .collection('reviews')
        .doc(review.id)
        .set(ReviewEntityExtension.toMap(review));
    final docSnap = await _firestore.collection('reviews').doc(review.id).get();
    return ReviewEntityExtension.fromMap(docSnap.data()!);
  }

  @override
  Future<List<ReviewEntity>> getReviews(
    ReviewEntity? starterAfter,
    int? limit,
  ) async {
    if (starterAfter != null) {
      return _firestore
          .collection('reviews')
          .orderBy('updatedAt', descending: true)
          .startAfter([starterAfter])
          .limit(limit ?? 25)
          .get()
          .then((querySnap) => querySnap.docs
              .map(
                (queryDocSnap) => ReviewEntityExtension.fromMap(
                  queryDocSnap.data(),
                ),
              )
              .toList());
    }
    return _firestore
        .collection('reviews')
        .orderBy('updatedAt', descending: true)
        .limit(limit ?? 25)
        .get()
        .then((querySnap) => querySnap.docs
            .map(
              (queryDocSnap) => ReviewEntityExtension.fromMap(
                queryDocSnap.data(),
              ),
            )
            .toList());
  }

  @override
  Future<List<String>> uploadPhotos(List<String> photosPath) async {
    const uuid = Uuid();
    final List<String> refToUploadedPhotos = [];

    for (int index = 0; index < photosPath.length; index++) {
      final imageRef = _storage.ref().child('images/${uuid.v4()}');
      final taskSnap = await imageRef.putFile(File(photosPath[index]));
      refToUploadedPhotos.add(taskSnap.ref.fullPath);
    }

    return refToUploadedPhotos;
  }

  @override
  Future<List<String>> getPhotosDownloadURL(List<String> photosPath) async {
    final List<String> photosDownloadURL = [];

    for (int index = 0; index < photosPath.length; index++) {
      photosDownloadURL.add(
        await _storage.ref(photosPath[index]).getDownloadURL(),
      );
    }

    return photosDownloadURL;
  }

  @override
  Future<List<ReviewEntity>> getMyReviews(
      ReviewEntity? starterAfter, int? limit) {
    if (starterAfter != null) {
      return _firestore
          .collection('reviews')
          .orderBy('updatedAt', descending: true)
          .where('authorId', isEqualTo: _auth.currentUser!.uid)
          .startAfter([starterAfter])
          .limit(limit ?? 25)
          .get()
          .then((querySnap) => querySnap.docs
              .map(
                (queryDocSnap) => ReviewEntityExtension.fromMap(
                  queryDocSnap.data(),
                ),
              )
              .toList());
    }
    return _firestore
        .collection('reviews')
        .orderBy('updatedAt', descending: true)
        .where('authorId', isEqualTo: _auth.currentUser!.uid)
        .limit(limit ?? 25)
        .get()
        .then((querySnap) => querySnap.docs
            .map(
              (queryDocSnap) => ReviewEntityExtension.fromMap(
                queryDocSnap.data(),
              ),
            )
            .toList());
  }
}
