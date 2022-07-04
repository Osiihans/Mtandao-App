
class NewsApiData {
	String? id;
	String? author;
	String? title;
	String? article;
	String? image;
	String? imagedesc;
	String? datepublished;

	NewsApiData({this.id,this.title,this.author,this.article,this.imagedesc,this.datepublished,this.image});

	NewsApiData.fromJson(Map<String,dynamic> parsedJson){
		id = parsedJson ["id"];
		author = parsedJson ["author"];
		title = parsedJson ["title"];
		article = parsedJson ["article"];
		image = parsedJson ["image"];
		imagedesc = parsedJson ["imagedesc"];
		datepublished = parsedJson ["datepublished"];

	}

}
