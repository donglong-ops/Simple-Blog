/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longdh.users;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;
import longdh.db.MyConnection;

/**
 *
 * @author Dong Long
 */
public class UsersDAO {

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
        UsersDTO dto = null;
        try {
            String sql = "SELECT U.Email, U.Fullname, R.Name as Role, S.Name as Status "
                    + "FROM Users U, Status S, Role R "
                    + "WHERE U.RoleId = R.Id and U.StatusId = S.Id and  U.Email = ? AND U.Password = ? and U.StatusId = '2' ";
            conn = MyConnection.getConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, email);
            preStm.setString(2, password);
            rs = preStm.executeQuery();
            if (rs.next()) {
                String Email = rs.getString("Email");
                String fullname = rs.getString("Fullname");
                String role = rs.getString("Role");
                String status = rs.getString("Status");
                dto = new UsersDTO(Email, fullname, role, status);
            }
        } finally {
            closeConnection();
        }
        return dto;
    }

    public void createAccount(UsersDTO dto) throws SQLException, NamingException {
        try {
            String sql = "INSERT INTO Users (Email, FullName, Password, RoleId, StatusId) "
                    + " VALUES (?, ?, ?, ?, ?)";
            conn = MyConnection.getConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, dto.getEmail());
            preStm.setString(2, dto.getFullname());
            preStm.setString(3, dto.getPassword());
            preStm.setInt(4, 2);
            preStm.setInt(5, 1);
            preStm.executeUpdate();
        } finally {
            closeConnection();
        }
    }

    public boolean updateUser(String email) throws SQLException, NamingException {
        boolean result = false;
        try {
            conn = MyConnection.getConnection();
            String sql = " UPDATE Users SET StatusId = ? WHERE Email = ? ";
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, 2);
            preStm.setString(2, email);
            result = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return result;
    }

    public boolean checkEmailUser(String email) throws SQLException, NamingException {
        boolean result = false;
        try {
            String sql = "select U.Email from Users U where U.Email = ? ";
            conn = MyConnection.getConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, email);
            rs = preStm.executeQuery();
            if (rs.next()) {
                result = true;
            }
        } finally {
            closeConnection();
        }
        return result;
    }
}
