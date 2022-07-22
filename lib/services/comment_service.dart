import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:travel_hour/models/comment.dart';
import 'package:travel_hour/models/questItem.dart';
import 'package:http/http.dart' as http;

import '../api/api.dart';
import '../api/api_end_points.dart';

class CommentService {
  static Future<List<Comment>?> fetchCommentsData(int lastVisible,String jwtToken,String idCustomer,int idQuest) async {
     print('fetchCommentsData: '+jwtToken);
   print('fetchCommentsData: ID CUSTOMER-'+idCustomer+"abxc"+idQuest.toString());
    var response = await http.get(
        Uri.parse('https://citytourist.azurewebsites.net/api/v1/customer-quests/show-comments/${idQuest}'),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
           'Authorization': 'Bearer ' + jwtToken
        });
         print("fetchCommentsData Status_code: " '${response.statusCode}');
         Map data = jsonDecode(response.body);
    // Iterable list = dbc;
    Iterable list = data['data'];
    // Iterable list = [
    //   {
    //     "id": 1,
    //     "name": "Van A",
    //     "imageUrl":
    //         "https://scontent.fsgn2-1.fna.fbcdn.net/v/t39.30808-6/283735605_707169810554306_2779114478194105871_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=mLxxvx8AHDwAX-L8N2D&_nc_ht=scontent.fsgn2-1.fna&oh=00_AT8ThXf9xKndR0LnY1V8U3T1r6uwtXJdcqCpHKv4TFcfKA&oe=62B1919F",
    //     "comment": "Verry Good",
    //     "rating": 4,
    //     "date": "2022-05-04T03:39:46.355"
    //   },
    //   {
    //     "id": 2,
    //     "name": "Tri Cuong",
    //     "imageUrl":
    //         "Ahttps://scontent.fsgn2-4.fna.fbcdn.net/v/t39.30808-6/270034934_616136156324339_1182072068441026613_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=174925&_nc_ohc=YMPc_eRXSLkAX_73KTd&_nc_ht=scontent.fsgn2-4.fna&oh=00_AT_wsdSa9F0SRKV3qNCspZclMglMYZN8olO49oC8scEYsQ&oe=62B26E1B",
    //     "comment": "Verry Good",
    //     "rating": 4,
    //     "date": "2022-05-04T03:39:46.355"
    //   },
    //   {
    //     "id": 3,
    //     "name": "Quan",
    //     "imageUrl":
    //         "https://scontent.fsgn2-6.fna.fbcdn.net/v/t39.30808-6/270181530_616134316324523_7961667178114579715_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=174925&_nc_ohc=LlE9KvD2_q0AX97xV0g&tn=tvssDTI9fKzyrhZQ&_nc_ht=scontent.fsgn2-6.fna&oh=00_AT9zxs3Su2kozLCsic_fZY5DGq5aQEl4XpO4LLZVMfJsRQ&oe=62B1FA06",
    //     "comment": "Verry Good",
    //     "rating": 4,
    //     "date": "2022-05-04T03:39:46.355"
    //   },      {
    //     "id": 3,
    //     "name": "Quan",
    //     "imageUrl":
    //         "https://scontent.fsgn2-6.fna.fbcdn.net/v/t39.30808-6/270181530_616134316324523_7961667178114579715_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=174925&_nc_ohc=LlE9KvD2_q0AX97xV0g&tn=tvssDTI9fKzyrhZQ&_nc_ht=scontent.fsgn2-6.fna&oh=00_AT9zxs3Su2kozLCsic_fZY5DGq5aQEl4XpO4LLZVMfJsRQ&oe=62B1FA06",
    //     "comment": "Verry Good",
    //     "rating": 4,
    //     "date": "2022-05-04T03:39:46.355"
    //   },      {
    //     "id": 3,
    //     "name": "Quan",
    //     "imageUrl":
    //         "https://scontent.fsgn2-6.fna.fbcdn.net/v/t39.30808-6/270181530_616134316324523_7961667178114579715_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=174925&_nc_ohc=LlE9KvD2_q0AX97xV0g&tn=tvssDTI9fKzyrhZQ&_nc_ht=scontent.fsgn2-6.fna&oh=00_AT9zxs3Su2kozLCsic_fZY5DGq5aQEl4XpO4LLZVMfJsRQ&oe=62B1FA06",
    //     "comment": "Verry Good",
    //     "rating": 4,
    //     "date": "2022-05-04T03:39:46.355"
    //   },      {
    //     "id": 3,
    //     "name": "Quan",
    //     "imageUrl":
    //         "https://scontent.fsgn2-6.fna.fbcdn.net/v/t39.30808-6/270181530_616134316324523_7961667178114579715_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=174925&_nc_ohc=LlE9KvD2_q0AX97xV0g&tn=tvssDTI9fKzyrhZQ&_nc_ht=scontent.fsgn2-6.fna&oh=00_AT9zxs3Su2kozLCsic_fZY5DGq5aQEl4XpO4LLZVMfJsRQ&oe=62B1FA06",
    //     "comment": "Verry Good",
    //     "rating": 4,
    //     "date": "2022-05-04T03:39:46.355"
    //   },      {
    //     "id": 3,
    //     "name": "Quan",
    //     "imageUrl":
    //         "https://scontent.fsgn2-6.fna.fbcdn.net/v/t39.30808-6/270181530_616134316324523_7961667178114579715_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=174925&_nc_ohc=LlE9KvD2_q0AX97xV0g&tn=tvssDTI9fKzyrhZQ&_nc_ht=scontent.fsgn2-6.fna&oh=00_AT9zxs3Su2kozLCsic_fZY5DGq5aQEl4XpO4LLZVMfJsRQ&oe=62B1FA06",
    //     "comment": "Verry Good",
    //     "rating": 4,
    //     "date": "2022-05-04T03:39:46.355"
    //   },      {
    //     "id": 3,
    //     "name": "Quan",
    //     "imageUrl":
    //         "https://scontent.fsgn2-6.fna.fbcdn.net/v/t39.30808-6/270181530_616134316324523_7961667178114579715_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=174925&_nc_ohc=LlE9KvD2_q0AX97xV0g&tn=tvssDTI9fKzyrhZQ&_nc_ht=scontent.fsgn2-6.fna&oh=00_AT9zxs3Su2kozLCsic_fZY5DGq5aQEl4XpO4LLZVMfJsRQ&oe=62B1FA06",
    //     "comment": "Verry Good",
    //     "rating": 4,
    //     "date": "2022-05-04T03:39:46.355"
    //   },      {
    //     "id": 3,
    //     "name": "Quan",
    //     "imageUrl":
    //         "https://scontent.fsgn2-6.fna.fbcdn.net/v/t39.30808-6/270181530_616134316324523_7961667178114579715_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=174925&_nc_ohc=LlE9KvD2_q0AX97xV0g&tn=tvssDTI9fKzyrhZQ&_nc_ht=scontent.fsgn2-6.fna&oh=00_AT9zxs3Su2kozLCsic_fZY5DGq5aQEl4XpO4LLZVMfJsRQ&oe=62B1FA06",
    //     "comment": "Verry Good",
    //     "rating": 4,
    //     "date": "2022-05-04T03:39:46.355"
    //   },      {
    //     "id": 3,
    //     "name": "Quan",
    //     "imageUrl":
    //         "https://scontent.fsgn2-6.fna.fbcdn.net/v/t39.30808-6/270181530_616134316324523_7961667178114579715_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=174925&_nc_ohc=LlE9KvD2_q0AX97xV0g&tn=tvssDTI9fKzyrhZQ&_nc_ht=scontent.fsgn2-6.fna&oh=00_AT9zxs3Su2kozLCsic_fZY5DGq5aQEl4XpO4LLZVMfJsRQ&oe=62B1FA06",
    //     "comment": "Verry Good",
    //     "rating": 4,
    //     "date": "2022-05-04T03:39:46.355"
    //   },      {
    //     "id": 3,
    //     "name": "Quan",
    //     "imageUrl":
    //         "https://scontent.fsgn2-6.fna.fbcdn.net/v/t39.30808-6/270181530_616134316324523_7961667178114579715_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=174925&_nc_ohc=LlE9KvD2_q0AX97xV0g&tn=tvssDTI9fKzyrhZQ&_nc_ht=scontent.fsgn2-6.fna&oh=00_AT9zxs3Su2kozLCsic_fZY5DGq5aQEl4XpO4LLZVMfJsRQ&oe=62B1FA06",
    //     "comment": "Verry Good",
    //     "rating": 4,
    //     "date": "2022-05-04T03:39:46.355"
    //   },      {
    //     "id": 3,
    //     "name": "Quan",
    //     "imageUrl":
    //         "https://scontent.fsgn2-6.fna.fbcdn.net/v/t39.30808-6/270181530_616134316324523_7961667178114579715_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=174925&_nc_ohc=LlE9KvD2_q0AX97xV0g&tn=tvssDTI9fKzyrhZQ&_nc_ht=scontent.fsgn2-6.fna&oh=00_AT9zxs3Su2kozLCsic_fZY5DGq5aQEl4XpO4LLZVMfJsRQ&oe=62B1FA06",
    //     "comment": "Verry Good",
    //     "rating": 4,
    //     "date": "2022-05-04T03:39:46.355"
    //   },      {
    //     "id": 3,
    //     "name": "Quan",
    //     "imageUrl":
    //         "https://scontent.fsgn2-6.fna.fbcdn.net/v/t39.30808-6/270181530_616134316324523_7961667178114579715_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=174925&_nc_ohc=LlE9KvD2_q0AX97xV0g&tn=tvssDTI9fKzyrhZQ&_nc_ht=scontent.fsgn2-6.fna&oh=00_AT9zxs3Su2kozLCsic_fZY5DGq5aQEl4XpO4LLZVMfJsRQ&oe=62B1FA06",
    //     "comment": "Verry Good",
    //     "rating": 4,
    //     "date": "2022-05-04T03:39:46.355"
    //   },      {
    //     "id": 3,
    //     "name": "Quan",
    //     "imageUrl":
    //         "https://scontent.fsgn2-6.fna.fbcdn.net/v/t39.30808-6/270181530_616134316324523_7961667178114579715_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=174925&_nc_ohc=LlE9KvD2_q0AX97xV0g&tn=tvssDTI9fKzyrhZQ&_nc_ht=scontent.fsgn2-6.fna&oh=00_AT9zxs3Su2kozLCsic_fZY5DGq5aQEl4XpO4LLZVMfJsRQ&oe=62B1FA06",
    //     "comment": "Verry Good",
    //     "rating": 4,
    //     "date": "2022-05-04T03:39:46.355"
    //   },      {
    //     "id": 3,
    //     "name": "Quan",
    //     "imageUrl":
    //         "https://scontent.fsgn2-6.fna.fbcdn.net/v/t39.30808-6/270181530_616134316324523_7961667178114579715_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=174925&_nc_ohc=LlE9KvD2_q0AX97xV0g&tn=tvssDTI9fKzyrhZQ&_nc_ht=scontent.fsgn2-6.fna&oh=00_AT9zxs3Su2kozLCsic_fZY5DGq5aQEl4XpO4LLZVMfJsRQ&oe=62B1FA06",
    //     "comment": "Verry Good",
    //     "rating": 4,
    //     "date": "2022-05-04T03:39:46.355"
    //   },
    // ];
    final commentMap = list.cast<Map<String, dynamic>>();
    final dataComment = await commentMap.map<Comment>((json) {
      return Comment.fromJson(json);
    }).toList();
    return dataComment;
  }
  static void pushComment(String comment){
    
  }
}
