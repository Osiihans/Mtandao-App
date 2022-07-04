class SingleStory{

  String? id;
  String? author;
  String? title;
  String? article;
  String? image;
  String? imagedesc;
  String? datepublished;


  SingleStory({this.id,this.author,this.title,this.article,this.image,this.datepublished,this.imagedesc});


  SingleStory.fromJson(Map<String,dynamic> parsedJson){
    id = parsedJson ["id"];
    author = parsedJson ["author"];
    title = parsedJson ["title"];
    article = parsedJson ["article"];
    image = parsedJson ["image"];
    imagedesc = parsedJson ["imagedesc"];
    datepublished = parsedJson ["datepublished"];

  }


}