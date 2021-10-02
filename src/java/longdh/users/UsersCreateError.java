/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longdh.users;

import java.io.Serializable;

/**
 *
 * @author Dong Long
 */
public class UsersCreateError implements Serializable {

    private String emailLengthError;
    private String passwordLengthError;
    private String confirmNotMatched;
    private String fullnameLengthError;
    private String emailExistedError;

    public UsersCreateError() {

    }

    public UsersCreateError(String emailLengthError, String passwordLengthError, String confirmNotMatched, String fullnameLengthError, String emailExistedError) {
        this.emailLengthError = emailLengthError;
        this.passwordLengthError = passwordLengthError;
        this.confirmNotMatched = confirmNotMatched;
        this.fullnameLengthError = fullnameLengthError;
        this.emailExistedError = emailExistedError;
    }

    public String getEmailLengthError() {
        return emailLengthError;
    }

    public void setEmailLengthError(String emailLengthError) {
        this.emailLengthError = emailLengthError;
    }

    public String getPasswordLengthError() {
        return passwordLengthError;
    }

    public void setPasswordLengthError(String passwordLengthError) {
        this.passwordLengthError = passwordLengthError;
    }

    public String getConfirmNotMatched() {
        return confirmNotMatched;
    }

    public void setConfirmNotMatched(String confirmNotMatched) {
        this.confirmNotMatched = confirmNotMatched;
    }

    public String getFullnameLengthError() {
        return fullnameLengthError;
    }

    public void setFullnameLengthError(String fullnameLengthError) {
        this.fullnameLengthError = fullnameLengthError;
    }

    public String getEmailExistedError() {
        return emailExistedError;
    }

    public void setEmailExistedError(String emailExistedError) {
        this.emailExistedError = emailExistedError;
    }

    

}
