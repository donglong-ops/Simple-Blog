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
import longdh.dtos.ArticlesDTO;


/**
 *
 * @author Cyrus
 */
public class ArticlesDAO  {

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

    public List<ArticlesDTO> getAllArticles() throws NamingException, SQLException, ParseException {
        List<ArticlesDTO> result = null;
        int postID, countComment;
        String title, description, image, email, status, date;
        ArticlesDTO dto;
        try {
            String sql = "SELECT tbl_Articles.PostID, tbl_Articles.Title, tbl_Articles.Description, tbl_Articles.Image, "
                    + "tbl_Articles.Date, tbl_Articles.Email, tbl_Articles.Status, COUNT(tbl_Comments.PostID) As CommentCount "
                    + "FROM tbl_Articles "
                    + "FULL OUTER JOIN tbl_Comments "
                    + "ON tbl_Articles.PostID = tbl_Comments.PostID AND tbl_Articles.Status = 'Active' "
                    + "GROUP BY tbl_Articles.PostID, tbl_Articles.Title, tbl_Articles.Description, tbl_Articles.Image, "
                    + "tbl_Articles.Date, tbl_Articles.Email, tbl_Articles.Status";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                rs = preStm.executeQuery();
                result = new ArrayList<>();
                while (rs.next()) {
                    postID = rs.getInt("PostID");
                    title = rs.getString("Title");
                    description = rs.getString("Description");
                    image = rs.getString("Image");
                    String txtDate = rs.getString("Date");
//                    long dateTime = Long.parseLong(txtDate);
//                    date = convertDateToString(new Date(dateTime));
                    email = rs.getString("Email");
                    status = rs.getString("Status");
                    countComment = rs.getInt("CommentCount");
                    dto = new ArticlesDTO(postID, title, description, image, txtDate, email, status, countComment);
                    result.add(dto);
                }
            }
        } finally {
            closeConnection();
        }
        return result;

    }

    public boolean insertEmotion(int postID, String email) throws SQLException, NamingException {
        boolean check = false;
        try {
            String sql = "INSERT INTO tbl_Emotion(PostID, Email, Date) VALUES (?,?,?)";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, postID);
                preStm.setString(2, email);
                preStm.setLong(3, System.currentTimeMillis());
                check = preStm.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean removeEmotion(int postID, String email) throws SQLException, NamingException {
        boolean check = false;
        try {
            String sql = "DELETE FROM tbl_Emotion WHERE PostID = ? AND Email = ?";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, postID);
                preStm.setString(2, email);
                check = preStm.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean checkBoxLikeAndDisLike(int postID, String email) throws SQLException, NamingException {
        boolean check = false;
        try {
            String sql = "SELECT EmotionID FROM tbl_Emotion WHERE PostID = ? AND Email = ?";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, postID);
                preStm.setString(2, email);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    check = true;
                }

            }
        } finally {
            closeConnection();
        }

        return check;
    }

    public List<ArticlesDTO> findByLikeName(String search) throws NamingException, SQLException, ParseException, NumberFormatException {
        List<ArticlesDTO> result = null;
        int postID;
        String title, description, image, date, email;
        ArticlesDTO dto;
        try {
            String sql = "SELECT PostID, Title, Description, Image, Date, Email, Status FROM tbl_Articles WHERE Description LIKE ? AND Status = 'Active'";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, "%" + search + "%");
                rs = preStm.executeQuery();
                result = new ArrayList<>();
                while (rs.next()) {
                    postID = rs.getInt("PostID");
                    title = rs.getString("Title");
                    description = rs.getString("Description");
                    image = rs.getString("Image");
                    date = convertDateToString(new Date(Long.parseLong(rs.getString("Date").trim())));
                    email = rs.getString("Email");
                    dto = new ArticlesDTO(postID, title, description, image, date, email, "Active");
                    result.add(dto);
                }
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public boolean insert(ArticlesDTO dto) throws SQLException, NamingException {
        boolean check = false;
        try {
            String sql = "INSERT INTO tbl_Articles(Title, Description, Image, Date, Email, Status) VALUES (?,?,?,?,?,?)";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, dto.getTitle());
                preStm.setString(2, dto.getDescription());
                preStm.setString(3, dto.getImage());
                preStm.setLong(4, System.currentTimeMillis());
                preStm.setString(5, dto.getEmail());
                preStm.setString(6, "Active");
                check = preStm.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public void delete(String postID) throws SQLException, NamingException {
        boolean check = false;
        try {
            String sql = "UPDATE tbl_Articles SET Status=? WHERE PostID=?";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, "Deleted");
                preStm.setString(2, postID);
                preStm.executeUpdate();
            }

        } finally {
            closeConnection();
        }
    }

    public ArticlesDTO getBlogByID(int id) throws SQLException, NamingException, ParseException {
        String title, description, image, date, email, status;
        ArticlesDTO dto = null;
        try {
            String sql = "SELECT PostID, Title, Description, Image, Date, Email, Status FROM tbl_Articles WHERE PostID = ?";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, id);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    title = rs.getString("Title");
                    description = rs.getString("Description");
                    image = rs.getString("Image");
                    date = convertDateToString(new Date(Long.parseLong(rs.getString("Date"))));
                    email = rs.getString("Email");
                    status = rs.getString("Status");
                    dto = new ArticlesDTO(id, title, description, image, date, email, status);
                }
            }
        } finally {
            closeConnection();
        }
        return dto;

    }

    public boolean updateLikeAndDislike(ArticlesDTO dto, int postID) throws SQLException, NamingException {
        boolean check = false;
        try {
            String sql = "UPDATE tbl_Emotion SET Like = ?, Dislike = ? WHERE PostID = ?";
            conn = MyConnection.getConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, dto.getLike());
            preStm.setInt(2, dto.getDislike());
            preStm.setInt(3, postID);
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
}

