/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longdh.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.naming.NamingException;
import longdh.db.MyConnection;
import longdh.dtos.CommentsDTO;

/**
 *
 * @author Cyrus
 */
public class CommentsDAO implements ICRUDRepository<CommentsDTO, String> {

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

    @Override
    public boolean insert(CommentsDTO dto) throws SQLException, NamingException {
        boolean check = false;
        try {
            String sql = "INSERT INTO tbl_Comments(PostID, Email, Content, Date, Status) VALUES (?,?,?,?,?)";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, dto.getPostID());
                preStm.setString(2, dto.getEmail());
                preStm.setString(3, dto.getContent());
                preStm.setLong(4, System.currentTimeMillis());
                preStm.setString(5, "Active");
                check = preStm.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    @Override
    public boolean delete(CommentsDTO dto) throws SQLException, NamingException {
        boolean check = false;
        try {
            String sql = "DELETE FROM tbl_Articles WHERE CommentID = ?";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, dto.getCommentID());
                check = preStm.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public List<CommentsDTO> getAllCommentsByPostID(int postID) throws SQLException, ParseException, NamingException {
        String email, content, date, status;
        int commentID;
        CommentsDTO dto;
        List<CommentsDTO> result = null;
        try {
            String sql = "SELECT CommentID, Email, Content, Date, Status FROM tbl_Comments WHERE PostID = ?";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, postID);
                rs = preStm.executeQuery();
                result = new ArrayList<>();
                while (rs.next()) {
                    commentID = rs.getInt("CommentID");
                    email = rs.getString("Email");
                    content = rs.getString("Content");
                    date = convertDateToString(new Date(Long.parseLong(rs.getString("Date"))));
                    status = rs.getString("Status");
                    dto = new CommentsDTO(commentID, postID, email, content, date, status);
                    result.add(dto);
                }
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public CommentsDTO get(int postID) throws SQLException, NamingException, ParseException {
        String email, content, date, status;
        CommentsDTO dto = null;
        try {
            String sql = "SELECT CommentID, PostID, Email, Content, Date, Status FROM tbl_Comments WHERE PostID = ?";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, postID);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    email = rs.getString("Email");
                    content = rs.getString("Content");
                    date = convertDateToString(new Date(Long.parseLong(rs.getString("Date"))));
                    status = rs.getString("Status");
                    dto = new CommentsDTO(postID, email, content, date, status);
                }
            }
        } finally {
            closeConnection();
        }
        return dto;

    }

    @Override
    public boolean update(CommentsDTO k, String v) throws SQLException, NamingException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public CommentsDTO get(String v) throws SQLException, NamingException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
