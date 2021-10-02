/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longdh.comments;

import longdh.users.UsersDTO;
import java.io.Serializable;
import java.sql.Date;

/**
 *
 * @author Dong Long
 */
public class CommentsDTO implements Serializable {

    private int commentID;
    private int postID;
    private UsersDTO userDto;
    private String content;
    private String aticleTitle;
    private String author;
    private Date date;

    public CommentsDTO() {
    }

    public CommentsDTO(String aticleTitle, String content, String author) {
        this.aticleTitle = aticleTitle;
        this.content = content;
        this.author = author;
    }

    public CommentsDTO(int postID, UsersDTO userDto, String content, Date date) {
        this.postID = postID;
        this.userDto = userDto;
        this.content = content;
        this.date = date;
    }

    public CommentsDTO(int postID, String content, Date date) {
        this.postID = postID;
        this.content = content;
        this.date = date;
    }

    public CommentsDTO(int commentID, int postID, UsersDTO userDto, String content, Date date) {
        this.commentID = commentID;
        this.postID = postID;
        this.userDto = userDto;
        this.content = content;
        this.date = date;
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

    public UsersDTO getUserDto() {
        return userDto;
    }

    public void setUserDto(UsersDTO userDto) {
        this.userDto = userDto;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getAticleTitle() {
        return aticleTitle;
    }

    public void setAticleTitle(String aticleTitle) {
        this.aticleTitle = aticleTitle;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

}
