/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longdh.dtos;

import java.io.Serializable;

/**
 *
 * @author Cyrus
 */
public class ArticlesDTO implements Serializable{
    private int postID;
    private String title;
    private String description;
    private String image;
    private String date;
    private String email;
    private String status;
    private int countComment;
    private int like;
    private int dislike;
  

    public ArticlesDTO() {
    }


    
    public ArticlesDTO(String title, String description, String image, String date, String email, String status) {
        this.title = title;
        this.description = description;
        this.image = image;
        this.date = date;
        this.email = email;
        this.status = status;
    }

    public ArticlesDTO(int postID, String title, String description, String image, String date, String email, String status) {
        this.postID = postID;
        this.title = title;
        this.description = description;
        this.image = image;
        this.date = date;
        this.email = email;
        this.status = status;
    }
    
    public ArticlesDTO(int postID, String title, String description, String image, String date, String email, String status, int countComment) {
        this.postID = postID;
        this.title = title;
        this.description = description;
        this.image = image;
        this.date = date;
        this.email = email;
        this.status = status;
        this.countComment = countComment;

    }

    public int getLike() {
        return like;
    }

    public void setLike(int like) {
        this.like = like;
    }

    public int getDislike() {
        return dislike;
    }

    public void setDislike(int dislike) {
        this.dislike = dislike;
    }

    
    public int getCountComment() {
        return countComment;
    }

    public void setCountComment(int countComment) {
        this.countComment = countComment;
    }




    

    public int getPostID() {
        return postID;
    }

    public void setPostID(int postID) {
        this.postID = postID;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    } 
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }



    
}
