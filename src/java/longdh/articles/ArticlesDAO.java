/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longdh.articles;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.naming.NamingException;
import longdh.comments.CommentsDTO;
import longdh.db.MyConnection;

/**
 *
 * @author Dong Long
 */
public class ArticlesDAO {

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

    public int countTotalArticle() throws SQLException, NamingException {
        int countPage = 0;
        try {
            String sql = "SELECT COUNT(A.PostID) as totalRows FROM Articles A ";
            conn = MyConnection.getConnection();
            preStm = conn.prepareStatement(sql);
            rs = preStm.executeQuery();
            if (rs.next()) {
                countPage = rs.getInt("totalRows");
            }
        } finally {
            closeConnection();
        }
        return countPage;
    }

    public int countTotalArticleWithStatus() throws SQLException, NamingException {
        int countPage = 0;
        try {
            String sql = "SELECT COUNT(A.PostID) as totalRows FROM Articles A where A.StatusId = '2' ";
            conn = MyConnection.getConnection();
            preStm = conn.prepareStatement(sql);
            rs = preStm.executeQuery();
            if (rs.next()) {
                countPage = rs.getInt("totalRows");
            }
        } finally {
            closeConnection();
        }
        return countPage;
    }

    private String convertDateToString(Date txtDate) throws ParseException {
        return new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss z").format(txtDate);
    }

    public List<ArticlesDTO> getAllArticlesWithStatus(int pageNumber, int pageSize) throws NamingException, SQLException, ParseException {
        List<ArticlesDTO> result = new ArrayList<>();
        ArticlesDTO dto;
        try {
            String sql = "select A.PostID, A.Title, A.Description, A.Image, A.Date, U.Fullname as Author, COUNT(C.PostID) As CommentCount "
                    + "from Users U, Articles A "
                    + "FULL OUTER JOIN Comments C ON A.PostID = C.PostID "
                    + "where A.Email = U.Email AND  A.StatusId = '2' "
                    + "GROUP BY A.PostID, A.Title, A.Description, A.Image, A.Date, U.Fullname "
                    + "ORDER BY A.Date ASC "
                    + "OFFSET ? ROWS "
                    + "FETCH NEXT ? ROWS ONLY";
            conn = MyConnection.getConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, pageSize * (pageNumber - 1));
            preStm.setInt(2, pageSize);
            rs = preStm.executeQuery();
            while (rs.next()) {
                int postID = rs.getInt("PostID");
                String title = rs.getString("Title");
                String description = rs.getString("Description");
                String image = rs.getString("Image");
                String txtDate = rs.getString("Date");
                String author = rs.getString("Author");
                int countComment = rs.getInt("CommentCount");

                dto = new ArticlesDTO(postID, title, description, image, txtDate, author, countComment);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;

    }

    public List<ArticlesDTO> getSearchArticlesContent(String arTitle, int pageNumber, int pageSize) throws NamingException, SQLException, ParseException {
        List<ArticlesDTO> result = null;
        ArticlesDTO dto;
        try {
            String sql = "select A.PostID, A.Title, A.Description, A.Image, A.Date,U.Fullname as Author, COUNT(C.PostID) As CommentCount  "
                    + "from Users U, Articles A "
                    + "FULL OUTER JOIN Comments C ON A.PostID = C.PostID "
                    + "where A.Email = U.Email and A.Title like ? AND  A.StatusId = '2' "
                    + "GROUP BY A.PostID, A.Title, A.Description, A.Image, A.Date, U.Fullname "
                    + "ORDER BY A.Date ASC "
                    + "OFFSET ? ROWS "
                    + "FETCH NEXT ? ROWS ONLY";
            conn = MyConnection.getConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, "%" + arTitle + "%");
            preStm.setInt(2, pageSize * (pageNumber - 1));
            preStm.setInt(3, pageSize);
            rs = preStm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                int postID = rs.getInt("PostID");
                String title = rs.getString("Title");
                String description = rs.getString("Description");
                String image = rs.getString("Image");
                String txtDate = convertDateToString(rs.getDate("Date"));
                String author = rs.getString("Author");
                int countComment = rs.getInt("CommentCount");

                dto = new ArticlesDTO(postID, title, description, image, txtDate, author, countComment);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public List<CommentsDTO> getListCommentByEmail(String email) throws NamingException, SQLException, ParseException {
        List<CommentsDTO> result = new ArrayList<>();
        CommentsDTO dto;
        try {
            String sql = "SELECT Top 5 A.Title, C.Content, U.FullName as Author "
                    + "FROM Articles A , Comments C,Users U "
                    + "where  A.PostID = C.PostID AND C.Email = U.Email and C.Email = ? "
                    + "ORDER BY  DATEDIFF(day, GETDATE(), C.Date ) DESC ";
            conn = MyConnection.getConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, email);
            rs = preStm.executeQuery();
            while (rs.next()) {
                String title = rs.getString("Title");
                String content = rs.getString("Content");
                String author = rs.getString("Author");
                dto = new CommentsDTO(title, content, author);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public List<CommentsDTO> getListCommentRandom() throws NamingException, SQLException, ParseException {
        List<CommentsDTO> result = new ArrayList<>();
        CommentsDTO dto;
        try {
            String sql = "SELECT TOP 8 A.Title, C.Content, U.FullName as Author "
                    + "FROM Articles A , Comments C,Users U "
                    + "where  A.PostID = C.PostID AND C.Email = U.Email "
                    + "ORDER BY NEWID()";
            conn = MyConnection.getConnection();
            preStm = conn.prepareStatement(sql);
            rs = preStm.executeQuery();
            while (rs.next()) {
                String title = rs.getString("Title");
                String content = rs.getString("Content");
                String author = rs.getString("Author");
                dto = new CommentsDTO(title, content, author);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public List<ArticlesDTO> searchAllArticlesByContent(String arTitle, int statusId, int pageNumber) throws NamingException, SQLException, ParseException {
        List<ArticlesDTO> result = null;
        int pageSize = 5;
        int count = 2;
        ArticlesDTO dto;
        try {
            String sql = "select A.PostID, A.Title, A.Description, A.Image, A.Date, U.Fullname as Author, COUNT(C.PostID) As CommentCount "
                    + "from Users U, Articles A "
                    + "FULL OUTER JOIN Comments C ON A.PostID = C.PostID  "
                    + "where A.Email = U.Email and A.StatusId = ?";
            if (arTitle != null) {
                sql += " and A.Title like ? ";
            }
            sql += " GROUP BY A.PostID, A.Title, A.Description, A.Image, A.Date, U.Fullname "
                    + "ORDER BY A.Date ASC "
                    + "OFFSET ? ROWS "
                    + "FETCH NEXT ? ROWS ONLY";
            conn = MyConnection.getConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, statusId);
            if (arTitle != null) {
                preStm.setString(count, "%" + arTitle + "%");
                count++;
            }
            preStm.setInt(count, pageSize * (pageNumber - 1));
            preStm.setInt(count + 1, pageSize);
            rs = preStm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                int postID = rs.getInt("PostID");
                String title = rs.getString("Title");
                String description = rs.getString("Description");
                String image = rs.getString("Image");
                String txtDate = convertDateToString(rs.getDate("Date"));
                String author = rs.getString("Author");
                int countComment = rs.getInt("CommentCount");

                dto = new ArticlesDTO(postID, title, description, image, txtDate, author, countComment);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public int coutTotalArticlesSearch(String arTitle, int statusId) throws NamingException, SQLException, ParseException {
        int countPage = 0;
        int count = 2;
        try {
            String sql = "SELECT COUNT(A.PostID) as totalRows FROM Articles A "
                    + " WHERE A.StatusId = ? ";
            if (arTitle != null) {
                sql += " and A.Title like ? ";
            }
            conn = MyConnection.getConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, statusId);
            if (arTitle != null) {
                preStm.setString(count, "%" + arTitle + "%");
            }
            rs = preStm.executeQuery();
            if (rs.next()) {
                countPage = rs.getInt("totalRows");
            }
        } finally {
            closeConnection();
        }
        return countPage;
    }

    public List<ArticlesDTO> getAllArticles(int pageNumber, int pageSize) throws NamingException, SQLException, ParseException {
        List<ArticlesDTO> result = null;
        ArticlesDTO dto;
        try {
            String sql = "select A.PostID, A.Title, A.Description, A.Image, A.Date, U.Fullname as Author, COUNT(C.PostID) As CommentCount  "
                    + "from Users U, Articles A FULL OUTER JOIN Comments C ON A.PostID = C.PostID  AND  A.StatusId = '2' "
                    + "where A.Email = U.Email "
                    + "GROUP BY A.PostID, A.Title, A.Description, A.Image, A.Date, U.Fullname "
                    + "ORDER BY A.Date ASC "
                    + "OFFSET ? ROWS "
                    + "FETCH NEXT ? ROWS ONLY ";
            conn = MyConnection.getConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, pageSize * (pageNumber - 1));
            preStm.setInt(2, pageSize);
            rs = preStm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                int postID = rs.getInt("PostID");
                String title = rs.getString("Title");
                String description = rs.getString("Description");
                String image = rs.getString("Image");
                String txtDate = convertDateToString(rs.getDate("Date"));
                String author = rs.getString("Author");
                int countComment = rs.getInt("CommentCount");
                dto = new ArticlesDTO(postID, title, description, image, txtDate, author, countComment);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;

    }

    public boolean insertArticle(ArticlesDTO dto) throws SQLException, NamingException {
        boolean check = false;
        Timestamp currentDate = new Timestamp(System.currentTimeMillis());
        try {
            String sql = "INSERT INTO Articles (Title, Description, Image, Date, Email, StatusId) VALUES (?,?,?,?,?,?)";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, dto.getTitle());
                preStm.setString(2, dto.getDescription());
                preStm.setString(3, dto.getImage());
                preStm.setTimestamp(4, currentDate);
                preStm.setString(5, dto.getEmail());
                preStm.setInt(6, 1);
                check = preStm.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public void updateArticle(int postID, int status) throws SQLException, NamingException {
        try {
            String sql = "UPDATE Articles SET StatusId = ? WHERE PostID = ? ";
            conn = MyConnection.getConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, status);
            preStm.setInt(2, postID);
            preStm.executeUpdate();
        } finally {
            closeConnection();
        }
    }

    public ArticlesDTO getBlogByID(int id) throws SQLException, NamingException, ParseException {
        ArticlesDTO dto = null;
        try {
            String sql = "SELECT a.PostID, a.Title, a.Description, a.Image, a.Date, s.Name as Status, u.Fullname as Author "
                    + "FROM Articles a , Status s, Users u "
                    + "where a.Email = u.Email and u.StatusId = s.Id and a.StatusId= '2' and a.PostID = ? ";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, id);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    String title = rs.getString("Title");
                    String description = rs.getString("Description");
                    String image = rs.getString("Image");
                    String date = convertDateToString(rs.getDate("Date"));
                    String author = rs.getString("Author");
                    String status = rs.getString("Status");
                    dto = new ArticlesDTO(id, title, description, image, date, author, status);
                }
            }
        } finally {
            closeConnection();
        }
        return dto;

    }
}
