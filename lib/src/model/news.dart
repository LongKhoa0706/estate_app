class News {
  int id;
  String title;
  int categoryId;
  String shortContent;
  String content;
  String urlImg;
  String postDate;
  Null newsRelate;
  String titleWebsite;
  String description;
  String keyword;
  String sort;
  String postAuthor;
  String postSource;
  String postAuthorUpdate;
  String postAuthorDelete;
  String createdAt;
  String updatedAt;
  Null deletedAt;
  String categoryName;

  News(
      {this.id,
        this.title,
        this.categoryId,
        this.shortContent,
        this.content,
        this.urlImg,
        this.postDate,
        this.newsRelate,
        this.titleWebsite,
        this.description,
        this.keyword,
        this.sort,
        this.postAuthor,
        this.postSource,
        this.postAuthorUpdate,
        this.postAuthorDelete,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.categoryName});

  News.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    categoryId = json['category_id'];
    shortContent = json['short_content'];
    content = json['content'];
    urlImg = json['url_img'];
    postDate = json['post_date'];
    newsRelate = json['news_relate'];
    titleWebsite = json['title_website'];
    description = json['description'];
    keyword = json['keyword'];
    sort = json['sort'];
    postAuthor = json['post_author'];
    postSource = json['post_source'];
    postAuthorUpdate = json['post_author_update'];
    postAuthorDelete = json['post_author_delete'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['category_id'] = this.categoryId;
    data['short_content'] = this.shortContent;
    data['content'] = this.content;
    data['url_img'] = this.urlImg;
    data['post_date'] = this.postDate;
    data['news_relate'] = this.newsRelate;
    data['title_website'] = this.titleWebsite;
    data['description'] = this.description;
    data['keyword'] = this.keyword;
    data['sort'] = this.sort;
    data['post_author'] = this.postAuthor;
    data['post_source'] = this.postSource;
    data['post_author_update'] = this.postAuthorUpdate;
    data['post_author_delete'] = this.postAuthorDelete;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['category_name'] = this.categoryName;
    return data;
  }
}