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
import javax.naming.NamingException;
import longdh.db.MyConnection;
import longdh.dtos.UsersDTO;

/**
 *
 * @author Cyrus
 */
public class UsersDAO implements ICRUDRepository<UsersDTO, String> {

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

    public UsersDTO checkLogin(String email, String password) throws Exception {
        String role = "failed";
        UsersDTO dto = null;
        try {
            String sql = "SELECT Role FROM tbl_Users WHERE Email = ? AND Password = ?";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, email);
                preStm.setString(2, password);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    role = rs.getString("Role");
                    dto = new UsersDTO(email, null, null, role, null);
                }
            }
        } finally {
            closeConnection();
        }
        return dto;
    }

    public String getName(String email, String password) throws Exception {
        String name = null;
        try {
            String sql = "SELECT Name FROM tbl_Users WHERE Email = ? AND Password = ?";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, email);
                preStm.setString(2, password);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    name = rs.getString("Name");
                }
            }

        } finally {
            closeConnection();
        }
        return name;
    }

    @Override
    public boolean insert(UsersDTO dto) throws SQLException, NamingException {
        boolean check = false;
        try {
            String sql = "INSERT INTO tbl_Users(Email, Name, Password, Role, Status) VALUES (?,?,?,?,?)";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, dto.getEmail());
                preStm.setString(2, dto.getName());
                preStm.setString(3, dto.getPassword());
                preStm.setString(4, dto.getRole());
                preStm.setString(5, dto.getStatus());
                check = preStm.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    @Override
    public boolean delete(UsersDTO k) throws SQLException, NamingException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean update(UsersDTO k, String v) throws SQLException, NamingException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public UsersDTO get(String v) throws SQLException, NamingException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
