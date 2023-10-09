import 'dart:developer';

import 'package:get/get.dart';
import 'package:rtd_project/backend/model/wall/votes_model.dart';
import 'package:rtd_project/util/toast.dart';

import '../backend/model/wall/feed_data_model.dart';
import '../backend/parser/wall_screen_parser.dart';

class WallScreenController extends GetxController {
  final WallScreenParser parser;
  WallScreenController({required this.parser});
  @override
  void onInit() {
    getVotesData();
    getFeedData();
    super.onInit();
  }

  FeedData? data;
  int? optionId;
  List<VotesData> votesData = <VotesData>[];
  Votes? votes;
  bool loading = true;
  bool error = false;
  List<String> selectedOption = [];
  Future<void> getFeedData() async {
    Response response = await parser.getFeedData();
    log('feed status code ${response.statusCode}');
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> jsonData =
            Map<String, dynamic>.from(response.body);
        log('feed responce*******${response.body}');
        data = FeedData.fromJson(jsonData);

        if (data!.data.isEmpty) {
          error = true;
        }
        log('data$data');
      } catch (e, stackTrace) {
        log('wall catch $e', error: e, stackTrace: stackTrace);
      }
      log('responce${response.body}');
    }
    loading = false;
    update();
  }

  void selectOption(String option, int index) {
    selectedOption[index] = option;
    update();
  }

  Future<void> getVotesData() async {
    Response response = await parser.getVotesData();
    if (response.statusCode == 200) {
      selectedOption.clear();
      votesData.clear();
      try {
        Map<String, dynamic> jsonData =
            Map<String, dynamic>.from(response.body);

        votes = Votes.fromJson(jsonData);
        log('votess************${votes?.data.length}');
        if (votes?.data != null) {
          for (VotesData data in votes!.data) {
            votesData.add(data);
            selectedOption.add('');
          }
        }
        log('vote submit responce${response.body}');
      } catch (e) {
        log('votes catch $e');
      }

      update();
    }
  }

  Future<void> submitVote(int questionId, int optionId) async {
    final body = {
      "question_id": questionId,
      "option_id": optionId,
    };
    Response response = await parser.submitVote(body);
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> jsonData =
            Map<String, dynamic>.from(response.body);
        if (jsonData['status'] == true) {
          successToast(jsonData['message']);
          getVotesData();
        } else {
          showToast(jsonData['message']);
        }
        log(response.body.toString());
      } catch (e) {
        log('votes submit $e');
      }

      update();
    }
  }
}
