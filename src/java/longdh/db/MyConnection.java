/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longdh.db;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author Cyrus
 */
public class MyConnection implements Serializable {
    public static Connection getConnection() throws NamingException,SQLException{
        Context tomcatContext =(Context) new InitialContext().lookup("java:comp/env");
        DataSource ds = (DataSource) tomcatContext.lookup("SE1502");
        Connection con = ds.getConnection();      
        return con;
    }
}
