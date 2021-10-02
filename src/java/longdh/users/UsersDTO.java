/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longdh.users;

/**
 *
 * @author Dong Long
 */
public class UsersDTO {
    private String email;
    private String fullname;
    private String password;
    private String role;
    private String status;

    public UsersDTO() {
    }

    public UsersDTO(String email, String fullname) {
        this.email = email;
        this.fullname = fullname;
    }
    

    public UsersDTO(String fullname, String role, String status) {
        this.fullname = fullname;
        this.role = role;
        this.status = status;
    }
    
    
//    public UsersDTO(String email, String password, String fullname) {
//        this.email = email;
//        this.password = password;
//        this.fullname = fullname;        
//        this.role = "User";
//        this.status = "New";
//    }

    public UsersDTO(String email, String fullname, String role, String status) {
        this.email = email;
        this.fullname = fullname;
        this.role = role;
        this.status = status;
    }
    
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }


    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
}
