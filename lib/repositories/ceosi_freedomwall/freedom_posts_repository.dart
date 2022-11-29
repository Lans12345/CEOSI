import 'package:ceosi_app/repositories/ceosi_freedomwall/freedom_posts_repository_interface.dart';

class FreedomPostsRepository extends FreedomPostsRepositoryInterface {
  @override
  Future<Map<String, dynamic>?> getFreedomPostsList() async {
    final freedompostsdata = await Future.value({
      //user_id = unique id
      //fp_id = freedom posts unique id
      //user_fp_id =  freedom posts unique id for each  individual user
      //post_content  = the freedom posts content (saloobin)
      //date = date of the post created or modified.
      'freedom_posts_list': [
        {
          'fp_id': '0',
          'user_id': '1',
          'user_fp_id': '1',
          'post_content':
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore',
          'date': '12-21-22',
        },
        {
          'fp_id': '1',
          'user_id': '2',
          'user_fp_id': '1',
          'post_content': 'Lorem ipsum dolor sit amet, consectetur ad',
          'date': '12-21-22',
        },
        {
          'fp_id': '2',
          'user_id': '3',
          'user_fp_id': '1',
          'post_content': 'Lorem ipsum dol',
          'date': '12-21-22',
        },
        {
          'fp_id': '3',
          'user_id': '4',
          'user_fp_id': '1',
          'post_content':
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et',
          'date': '12-21-22',
        },
        {
          'fp_id': '4',
          'user_id': '1',
          'user_fp_id': '2',
          'post_content':
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmodt ',
          'date': '12-21-22',
        },
        {
          'fp_id': '5',
          'user_id': '5',
          'user_fp_id': '1',
          'post_content': 'Lorem ipsum dolor sit amet, consectetur ',
          'date': '12-21-22',
        },
        {
          'fp_id': '6',
          'user_id': '3',
          'user_fp_id': '2',
          'post_content': 'Lorem ipsum dolor sit amet',
          'date': '12-21-22',
        },
        {
          'fp_id': '7',
          'user_id': '2',
          'user_fp_id': '2',
          'post_content': 'Lorem ipsum dolor sit',
          'date': '12-21-22',
        },
        {
          'fp_id': '8',
          'user_id': '4',
          'user_fp_id': '2',
          'post_content':
              'Lorem ipsum dol Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et',
          'date': '12-21-22',
        },
        {
          'fp_id': '9',
          'user_id': '3',
          'user_fp_id': '3',
          'post_content': 'Lorem ipsum dolor sit Lorem',
          'date': '12-21-22',
        },
      ],
    });
    return Future.delayed(const Duration(seconds: 5), () => freedompostsdata);
  }
}
