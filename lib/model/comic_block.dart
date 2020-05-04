class ComicBlock{
   String cover;
   String title;
   String description;

   ComicBlock.fromJson(Map data) {
     cover = data['cover'];
     title = data['title'];
     description = data['description'];
   }
}
