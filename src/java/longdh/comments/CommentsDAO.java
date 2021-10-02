/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longdh.comments;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;
import javax.naming.NamingException;
import longdh.db.MyConnection;
import longdh.users.UsersDTO;

/**
 *
 * @author Dong Long
 */
public class CommentsDAO {

    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;

    private void closeConnection() throws SQLException {
        if (rs != null) {
            rs.close();
        }
        if (preStm != null) {
            preStm.close();
        }
        if (conn != null) {
            conn.close();
        }
    }

    private String convertDateToString(Date txtDate) throws ParseException {
        return new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss z").format(txtDate);
    }

    public boolean createComment(CommentsDTO dto, String email) throws SQLException, NamingException {
        Timestamp now = new Timestamp(System.currentTimeMillis());
        boolean check = false;
        try {
            String sql = "INSERT INTO Comments( PostId, Content, Email, Date) VALUES (?, ?, ?, ?)";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, dto.getPostID());
                preStm.setString(2, dto.getContent());
                preStm.setString(3, email);
                preStm.setDate(4, new java.sql.Date(now.getTime()));
                check = preStm.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public List<CommentsDTO> getAllCommentsByPostID(int postID) throws SQLException, ParseException, NamingException {
        CommentsDTO dto;
        List<CommentsDTO> result = null;
        try {
            String sql = "SELECT c.CommentID, c.Content, c.Date, c.Email, u.Fullname as Author "
                    + "FROM Comments c , Users u "
                    + "WHERE c.Email = u.Email and PostID = ? ";
            conn = MyConnection.getConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, postID);
            rs = preStm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                int commentID = rs.getInt("CommentID");
                String content = rs.getString("Content");
                String email = rs.getString("Email");
                Date date = rs.getDate("Date");
                String author = rs.getString("Author");
                dto = new CommentsDTO(commentID, postID, new UsersDTO(email, author), content, date);
                result.add(dto);
            }

        } finally {
            closeConnection();
        }
        return result;
    }

}
