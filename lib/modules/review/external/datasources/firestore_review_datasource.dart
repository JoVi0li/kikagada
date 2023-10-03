import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kikagada/modules/review/domain/entities/review_entity.dart';
import 'package:kikagada/modules/review/external/extensions/review_entity_extension.dart';
import 'package:kikagada/modules/review/infra/datasources/review_datasource.dart';

class FirestoreReviewDatasource implements IReviewDatasource {
  FirestoreReviewDatasource({required FirebaseFirestore firestore})
      : _firestore = firestore;

  final FirebaseFirestore _firestore;

  @override
  Future<ReviewEntity> create(ReviewEntity review) async {
    return await _firestore
        .collection('reviews')
        .add(ReviewEntityExtension.toMap(review))
        .then((docRef) async => await docRef
            .get()
            .then((docSnap) => ReviewEntityExtension.fromMap(docSnap.data()!)));
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
