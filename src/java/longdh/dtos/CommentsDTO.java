/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longdh.dtos;

/**
 *
 * @author Cyrus
 */
public class CommentsDTO {
    private int commentID;
    private int postID;
    private String email;
    private String content;
    private String date;
    private String status;

    public CommentsDTO() {
    }

    public CommentsDTO(int postID, String email, String content, String date, String status) {
        this.postID = postID;
        this.email = email;
        this.content = content;
        this.date = date;
        this.status = status;
    }

    
    public CommentsDTO(int commentID, int postID, String email, String content, String date, String status) {
        this.commentID = commentID;
        this.postID = postID;
        this.email = email;
        this.content = content;
        this.date = date;
        this.status = status;
    }

    public int getCommentID() {
        return commentID;
    }

    public void setCommentID(int commentID) {
        this.commentID = commentID;
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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
}
