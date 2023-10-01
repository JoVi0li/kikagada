import 'package:flutter_test/flutter_test.dart';
import 'package:kikagada/modules/rank/domain/entities/relevance_vote_entity.dart';

void main() {
  group('relevance vote entity tests', () {
    test('should throw an assertion error when id property is empty', () {
      void createRelevanceEntity() {
        RelevanceVoteEntity(id: '', userId: '01', isRelevant: true);
      }

      expect(createRelevanceEntity, throwsAssertionError);
    });

    test('should throw an assertion error when userId property is empty', () {
      void createRelevanceEntity() {
        RelevanceVoteEntity(id: '01', userId: '', isRelevant: true);
      }

      expect(createRelevanceEntity, throwsAssertionError);
    });

    test('should create an instance of RelevanceVoteEntity', () {
      expect(
        RelevanceVoteEntity(id: '01', userId: '01', isRelevant: true),
        isA<RelevanceVoteEntity>(),
      );
    });
  });
}
