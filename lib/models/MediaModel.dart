class MediaModel {
    String? altText;
    int? author;
    Caption? caption;
    String? commentStatus;
    String? date;
    String? dateGmt;
    Description? description;
    Guid? guid;
    int? id;
    String? link;
    Links? links;
    MediaDetails? mediaDetails;
    String? mediaType;
    String? mimeType;
    String? modified;
    String? modifiedGmt;
    String? pingStatus;
    String? slug;
    String? sourceUrl;
    String? status;
    String? template;
    Title? title;
    String? type;

    MediaModel({this.altText, this.author, this.caption, this.commentStatus, this.date, this.dateGmt, this.description, this.guid, this.id, this.link, this.links, this.mediaDetails, this.mediaType, this.mimeType, this.modified, this.modifiedGmt, this.pingStatus, this.slug, this.sourceUrl, this.status, this.template, this.title, this.type});

    factory MediaModel.fromJson(Map<String, dynamic> json) {
        return MediaModel(
            altText: json['alt_text'], 
            author: json['author'], 
            caption: json['caption'] != null ? Caption.fromJson(json['caption']) : null, 
            commentStatus: json['comment_status'], 
            date: json['date'], 
            dateGmt: json['date_gmt'], 
            description: json['description'] != null ? Description.fromJson(json['description']) : null, 
            guid: json['guid'] != null ? Guid.fromJson(json['guid']) : null, 
            id: json['id'], 
            link: json['link'], 
            links: json['links'] != null ? Links.fromJson(json['links']) : null, 
            mediaDetails: json['media_details'] != null ? MediaDetails.fromJson(json['media_details']) : null, 
            mediaType: json['media_type'], 
            mimeType: json['mime_type'], 
            modified: json['modified'], 
            modifiedGmt: json['modified_gmt'], 
            pingStatus: json['ping_status'], 
            slug: json['slug'], 
            sourceUrl: json['source_url'], 
            status: json['status'], 
            template: json['template'], 
            title: json['title'] != null ? Title.fromJson(json['title']) : null, 
            type: json['type'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['alt_text'] = this.altText;
        data['author'] = this.author;
        data['comment_status'] = this.commentStatus;
        data['date'] = this.date;
        data['date_gmt'] = this.dateGmt;
        data['id'] = this.id;
        data['link'] = this.link;
        data['media_type'] = this.mediaType;
        data['mime_type'] = this.mimeType;
        data['modified'] = this.modified;
        data['modified_gmt'] = this.modifiedGmt;
        data['ping_status'] = this.pingStatus;
        data['slug'] = this.slug;
        data['source_url'] = this.sourceUrl;
        data['status'] = this.status;
        data['template'] = this.template;
        data['type'] = this.type;
        if (this.caption != null) {
            data['caption'] = this.caption!.toJson();
        }
        if (this.description != null) {
            data['description'] = this.description!.toJson();
        }
        if (this.guid != null) {
            data['guid'] = this.guid!.toJson();
        }
        if (this.links != null) {
            data['links'] = this.links!.toJson();
        }
        if (this.mediaDetails != null) {
            data['media_details'] = this.mediaDetails!.toJson();
        }
        if (this.title != null) {
            data['title'] = this.title!.toJson();
        }
        return data;
    }
}

class Guid {
    String? rendered;

    Guid({this.rendered});

    factory Guid.fromJson(Map<String, dynamic> json) {
        return Guid(
            rendered: json['rendered'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['rendered'] = this.rendered;
        return data;
    }
}

class MediaDetails {
    String? file;
    int? height;
    ImageMeta? imageMeta;
    Sizes? sizes;
    int? width;

    MediaDetails({this.file, this.height, this.imageMeta, this.sizes, this.width});

    factory MediaDetails.fromJson(Map<String, dynamic> json) {
        return MediaDetails(
            file: json['`file`'],
            height: json['height'], 
            imageMeta: json['image_meta'] != null ? ImageMeta.fromJson(json['image_meta']) : null, 
            sizes: json['sizes'] != null ? Sizes.fromJson(json['sizes']) : null, 
            width: json['width'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['`file`'] = this.file;
        data['height'] = this.height;
        data['width'] = this.width;
        if (this.imageMeta != null) {
            data['image_meta'] = this.imageMeta!.toJson();
        }
        if (this.sizes != null) {
            data['sizes'] = this.sizes!.toJson();
        }
        return data;
    }
}

class ImageMeta {
    String? aperture;
    String? camera;
    String? caption;
    String? copyright;
    String? createdTimestamp;
    String? credit;
    String? focalLength;
    String? iso;
    String? orientation;
    String? shutterSpeed;
    String? title;

    ImageMeta({this.aperture, this.camera, this.caption, this.copyright, this.createdTimestamp, this.credit, this.focalLength, this.iso, this.orientation, this.shutterSpeed, this.title});

    factory ImageMeta.fromJson(Map<String, dynamic> json) {
        return ImageMeta(
            aperture: json['aperture'], 
            camera: json['camera'], 
            caption: json['caption'], 
            copyright: json['copyright'], 
            createdTimestamp: json['created_timestamp'], 
            credit: json['credit'], 
            focalLength: json['focal_length'], 
            iso: json['iso'], 
            orientation: json['orientation'], 
            shutterSpeed: json['shutter_speed'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['aperture'] = this.aperture;
        data['camera'] = this.camera;
        data['caption'] = this.caption;
        data['copyright'] = this.copyright;
        data['created_timestamp'] = this.createdTimestamp;
        data['credit'] = this.credit;
        data['focal_length'] = this.focalLength;
        data['iso'] = this.iso;
        data['orientation'] = this.orientation;
        data['shutter_speed'] = this.shutterSpeed;
        data['title'] = this.title;
        return data;
    }
}

class Sizes {
    Full? full;
    WoocommerceGalleryThumbnail? woocommerceGalleryThumbnail;
    WoocommerceSingle? woocommerceSingle;
    WoocommerceThumbnail? woocommerceThumbnail;

    Sizes({this.full, this.woocommerceGalleryThumbnail, this.woocommerceSingle, this.woocommerceThumbnail});

    factory Sizes.fromJson(Map<String, dynamic> json) {
        return Sizes(
            full: json['full'] != null ? Full.fromJson(json['full']) : null, 
            woocommerceGalleryThumbnail: json['woocommerce_gallery_thumbnail'] != null ? WoocommerceGalleryThumbnail.fromJson(json['woocommerce_gallery_thumbnail']) : null, 
            woocommerceSingle: json['woocommerce_single'] != null ? WoocommerceSingle.fromJson(json['woocommerce_single']) : null, 
            woocommerceThumbnail: json['woocommerce_thumbnail'] != null ? WoocommerceThumbnail.fromJson(json['woocommerce_thumbnail']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.full != null) {
            data['full'] = this.full!.toJson();
        }
        if (this.woocommerceGalleryThumbnail != null) {
            data['woocommerce_gallery_thumbnail'] = this.woocommerceGalleryThumbnail!.toJson();
        }
        if (this.woocommerceSingle != null) {
            data['woocommerce_single'] = this.woocommerceSingle!.toJson();
        }
        if (this.woocommerceThumbnail != null) {
            data['woocommerce_thumbnail'] = this.woocommerceThumbnail!.toJson();
        }
        return data;
    }
}

class Full {
    String? file;
    int? height;
    String? mimeType;
    String? sourceUrl;
    int? width;

    Full({this.file, this.height, this.mimeType, this.sourceUrl, this.width});

    factory Full.fromJson(Map<String, dynamic> json) {
        return Full(
            file: json['`file`'],
            height: json['height'], 
            mimeType: json['mime_type'], 
            sourceUrl: json['source_url'], 
            width: json['width'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['`file`'] = this.file;
        data['height'] = this.height;
        data['mime_type'] = this.mimeType;
        data['source_url'] = this.sourceUrl;
        data['width'] = this.width;
        return data;
    }
}

class WoocommerceGalleryThumbnail {
    String? file;
    int? height;
    String? mimeType;
    String? sourceUrl;
    int? width;

    WoocommerceGalleryThumbnail({this.file, this.height, this.mimeType, this.sourceUrl, this.width});

    factory WoocommerceGalleryThumbnail.fromJson(Map<String, dynamic> json) {
        return WoocommerceGalleryThumbnail(
            file: json['`file`'],
            height: json['height'], 
            mimeType: json['mime_type'], 
            sourceUrl: json['source_url'], 
            width: json['width'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['`file`'] = this.file;
        data['height'] = this.height;
        data['mime_type'] = this.mimeType;
        data['source_url'] = this.sourceUrl;
        data['width'] = this.width;
        return data;
    }
}

class WoocommerceSingle {
    String? file;
    int? height;
    String? mimeType;
    String? sourceUrl;
    int? width;

    WoocommerceSingle({this.file, this.height, this.mimeType, this.sourceUrl, this.width});

    factory WoocommerceSingle.fromJson(Map<String, dynamic> json) {
        return WoocommerceSingle(
            file: json['`file`'],
            height: json['height'], 
            mimeType: json['mime_type'], 
            sourceUrl: json['source_url'], 
            width: json['width'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['`file`'] = this.file;
        data['height'] = this.height;
        data['mime_type'] = this.mimeType;
        data['source_url'] = this.sourceUrl;
        data['width'] = this.width;
        return data;
    }
}

class WoocommerceThumbnail {
    String? file;
    int? height;
    String? mimeType;
    String? sourceUrl;
    bool? unCropped;
    int? width;

    WoocommerceThumbnail({this.file, this.height, this.mimeType, this.sourceUrl, this.unCropped, this.width});

    factory WoocommerceThumbnail.fromJson(Map<String, dynamic> json) {
        return WoocommerceThumbnail(
            file: json['`file`'],
            height: json['height'], 
            mimeType: json['mime_type'], 
            sourceUrl: json['source_url'], 
            unCropped: json['uncropped'], 
            width: json['width'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['`file`'] = this.file;
        data['height'] = this.height;
        data['mime_type'] = this.mimeType;
        data['source_url'] = this.sourceUrl;
        data['uncropped'] = this.unCropped;
        data['width'] = this.width;
        return data;
    }
}

class Caption {
    String? rendered;

    Caption({this.rendered});

    factory Caption.fromJson(Map<String, dynamic> json) {
        return Caption(
            rendered: json['rendered'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['rendered'] = this.rendered;
        return data;
    }
}

class Links {
    List<About>? about;
    List<Author>? author;
    List<Collection>? collection;
    List<Reply>? replies;
    List<Self>? self;

    Links({this.about, this.author, this.collection, this.replies, this.self});

    factory Links.fromJson(Map<String, dynamic> json) {
        return Links(
            about: json['about'] != null ? (json['about'] as List).map((i) => About.fromJson(i)).toList() : null, 
            author: json['author'] != null ? (json['author'] as List).map((i) => Author.fromJson(i)).toList() : null, 
            collection: json['collection'] != null ? (json['collection'] as List).map((i) => Collection.fromJson(i)).toList() : null, 
            replies: json['replies'] != null ? (json['replies'] as List).map((i) => Reply.fromJson(i)).toList() : null, 
            self: json['self'] != null ? (json['self'] as List).map((i) => Self.fromJson(i)).toList() : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.about != null) {
            data['about'] = this.about!.map((v) => v.toJson()).toList();
        }
        if (this.author != null) {
            data['author'] = this.author!.map((v) => v.toJson()).toList();
        }
        if (this.collection != null) {
            data['collection'] = this.collection!.map((v) => v.toJson()).toList();
        }
        if (this.replies != null) {
            data['replies'] = this.replies!.map((v) => v.toJson()).toList();
        }
        if (this.self != null) {
            data['self'] = this.self!.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Collection {
    String? href;

    Collection({this.href});

    factory Collection.fromJson(Map<String, dynamic> json) {
        return Collection(
            href: json['href'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['href'] = this.href;
        return data;
    }
}

class About {
    String? href;

    About({this.href});

    factory About.fromJson(Map<String, dynamic> json) {
        return About(
            href: json['href'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['href'] = this.href;
        return data;
    }
}

class Author {
    bool? embeddable;
    String? href;

    Author({this.embeddable, this.href});

    factory Author.fromJson(Map<String, dynamic> json) {
        return Author(
            embeddable: json['embeddable'], 
            href: json['href'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['embeddable'] = this.embeddable;
        data['href'] = this.href;
        return data;
    }
}

class Self {
    String? href;

    Self({this.href});

    factory Self.fromJson(Map<String, dynamic> json) {
        return Self(
            href: json['href'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['href'] = this.href;
        return data;
    }
}

class Reply {
    bool? embeddable;
    String? href;

    Reply({this.embeddable, this.href});

    factory Reply.fromJson(Map<String, dynamic> json) {
        return Reply(
            embeddable: json['embeddable'], 
            href: json['href'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['embeddable'] = this.embeddable;
        data['href'] = this.href;
        return data;
    }
}

class Description {
    String? rendered;

    Description({this.rendered});

    factory Description.fromJson(Map<String, dynamic> json) {
        return Description(
            rendered: json['rendered'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['rendered'] = this.rendered;
        return data;
    }
}

class Title {
    String? rendered;

    Title({this.rendered});

    factory Title.fromJson(Map<String, dynamic> json) {
        return Title(
            rendered: json['rendered'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['rendered'] = this.rendered;
        return data;
    }
}