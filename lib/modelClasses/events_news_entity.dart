class EventsNewsData{
	String? id;
	String? author;
	String? title;
	String? article;
	String? image;
	String? imagedesc;
	String? datepublished;

	EventsNewsData({this.id,this.author,this.article,this.image,this.datepublished,this.imagedesc,this.title});

	EventsNewsData.fromJson(Map<String,dynamic> parsedJson){
		id = parsedJson ["id"];
		author = parsedJson ["author"];
		title = parsedJson ["title"];
		article = parsedJson ["article"];
		image = parsedJson ["image"];
		imagedesc = parsedJson ["imagedesc"];
		datepublished = parsedJson ["datepublished"];

	}

}
