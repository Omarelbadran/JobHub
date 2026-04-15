
import '../api/api_config.dart';
import '../api/api_services.dart';
import '../models/access_chat/access_chat_request.dart';
import '../models/access_chat/access_chat_response.dart';
import '../models/add_bookmark/add_book_mark_request.dart';
import '../models/add_bookmark/add_book_mark_response.dart';
import '../models/create_job/create_job_request.dart';
import '../models/create_job/create_job_response.dart';
import '../models/delete_boomark/delete_bookmark_request.dart';
import '../models/delete_boomark/delete_bookmark_response.dart';
import '../models/delete_job/delete_job_request.dart';
import '../models/delete_job/delete_job_response.dart';
import '../models/get_all_bookmarks/get_all_bookmarks_response.dart';
import '../models/get_all_chats/get_all_chats_response.dart';
import '../models/get_all_jobs/get_all_jobs_response.dart';
import '../models/get_all_messages/get_all_messages_response.dart';
import '../models/search_job/serach_job_response.dart';
import '../models/send _message/send_message_request.dart';
import '../models/send _message/send_message_response.dart';
import '../models/update_job/update_job_request.dart';
import '../models/update_job/update_job_response.dart';

class MainRepo {
  static Future<CreateJobResponse> createJob(CreateJobRequest request, String token) async {
    var response = await APIService.post(
      endpoint: APIConfig.createJob,
      body: request.toJson(),
      token: token,
    );
    return CreateJobResponse.fromJson(response);
  }

  static Future<DeleteJobResponse> deleteJob(
      String token, DeleteJobRequest request) async {
    var response = await APIService.delete(
      endpoint: APIConfig.deleteJob,
      token: token,
      body: request.toJson(),
    );

    return DeleteJobResponse.fromJson(response);
  }

  static Future<UpdateJobResponse> updateJob(
      String token, UpdateJobRequest request) async {
    var response = await APIService.put(
      endpoint: APIConfig.updateJob,
      token: token,
      body: request.toJson(),
    );

    return UpdateJobResponse.fromJson(response);
  }

  static Future<GetAllJobsResponse> getAllJobs(String token) async {
    var response = await APIService.get(
      endpoint: APIConfig.getAllJobs,
      token: token,
    );

    return GetAllJobsResponse.fromJson(response);
  }

  static Future<SearchJobsResponse> searchJobs(
      String token, String query) async {

    var response = await APIService.get(
      endpoint: APIConfig.searchJobs,
      token: token,
      params: {
        'q': query,
      },
    );

    return SearchJobsResponse.fromJson(response);
  }
  static Future<AddBookmarkResponse> addBookmark(
      String token,
      AddBookmarkRequest request,
      ) async {
    var response = await APIService.post(
      endpoint: APIConfig.addBookmark,
      token: token,
      body: request.toJson(),
    );

    return AddBookmarkResponse.fromJson(response);
  }
  static Future<DeleteBookmarkResponse> deleteBookmark(
      String token,
      DeleteBookmarkRequest request,
      ) async {
    var response = await APIService.delete(
      endpoint: APIConfig.deleteBookmark,
      token: token,
      body: request.toJson(),
    );

    return DeleteBookmarkResponse.fromJson(response);
  }
  static Future<GetAllBookmarksResponse> getAllBookmarks(String token) async {
    var response = await APIService.get(
      endpoint: APIConfig.getAllBookmarks,
      token: token,
    );

    return GetAllBookmarksResponse.fromJson(response);
  }
  static Future<AccessChatResponse> accessChat(
      String token, AccessChatRequest request) async {
    var response = await APIService.post(
      endpoint: APIConfig.accessChat,
      token: token,
      body: request.toJson(),
    );
    return AccessChatResponse.fromJson(response);
  }

// 2. Get All Chats (Inbox)
  static Future<GetAllChatsResponse> getAllChats(String token) async {
    var response = await APIService.get(
      endpoint: APIConfig.getAllChats,
      token: token,
    );
    return GetAllChatsResponse.fromJson(response);
  }

// 3. Get All Messages in a Chat
  static Future<GetAllMessagesResponse> getMessages(
      String token, String chatId) async {
    var response = await APIService.get(
      endpoint: APIConfig.getAllMessages,
      token: token,
      params: {
        'chatId': chatId,
      },
    );

    return GetAllMessagesResponse.fromJson(response);
  }

// 4. Send a New Message
  static Future<SendMessageResponse> sendMessage(
      String token, SendMessageRequest request) async {
    var response = await APIService.post(
      endpoint: APIConfig.sendMessage,
      token: token,
      body: request.toJson(),
    );
    return SendMessageResponse.fromJson(response);
  }
}