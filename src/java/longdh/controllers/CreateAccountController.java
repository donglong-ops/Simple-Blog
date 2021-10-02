/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longdh.controllers;

import java.io.IOException;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import longdh.users.UsersDAO;
import longdh.users.UsersCreateError;
import longdh.users.UsersDTO;
import longdh.utils.SendEmail;

/**
 *
 * @author Dong Long
 */
@WebServlet(name = "CreateAccountController", urlPatterns = {"/CreateAccountController"})
public class CreateAccountController extends HttpServlet {

    private final String ERROR_PAGE = "createAccount.jsp";
    private final String SUCCESS_PAGE = "verify";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url;
        UsersDAO userDao = new UsersDAO();
        HttpSession session = request.getSession();
        UsersCreateError errors = new UsersCreateError();
        boolean fourdErr = false;
        String email = request.getParameter("txtEmail");
        String fullname = request.getParameter("txtFullname");
        String password = request.getParameter("txtPassword");
        String rePassword = request.getParameter("txtRepassword");
        try {
            if (email.trim().length() < 2 || email.trim().length() > 30) {
                fourdErr = true;
                errors.setEmailLengthError("Email required from 2 to 30 characters");
            }

            if (fullname.trim().length() < 2 || fullname.trim().length() > 50) {
                fourdErr = true;
                errors.setFullnameLengthError("Fullname required from 2 to 50 characters");
            }

            if (password.trim().length() < 2 || password.trim().length() > 10) {
                fourdErr = true;
                errors.setPasswordLengthError("Password from 2 to 10 characters");
            } else if (!password.trim().equals(rePassword.trim())) {
                fourdErr = true;
                errors.setConfirmNotMatched("Confirm must match with password");
            }

            if (fourdErr) {
                request.setAttribute("CREATEERROR", errors);
                url = ERROR_PAGE;
                request.getRequestDispatcher(url).forward(request, response);
            } else {
                int aNumber = (int) ((Math.random() * 900000) + 100000);
                String encryPassword = org.apache.commons.codec.digest.DigestUtils.sha256Hex(password);
                UsersDTO userDto = new UsersDTO();
                userDto.setEmail(email);
                userDto.setFullname(fullname);
                userDto.setPassword(encryPassword);
                boolean checkEmail = userDao.checkEmailUser(email);
                if (checkEmail) {
                    errors.setEmailExistedError(email + " is existed. Please, Use another mail!");
                    request.setAttribute("CREATEERROR", errors);
                    url = ERROR_PAGE;
                    request.getRequestDispatcher(url).forward(request, response);
                } else {
                    userDao.createAccount(userDto);
                    url = SUCCESS_PAGE;
                    session.setAttribute("REGISEMAIL", email);
                    session.setAttribute("RANDOMCODE", aNumber);
                    SendEmail se = new SendEmail(email, String.valueOf(aNumber));
                    se.sendMail();
                    response.sendRedirect(url);
                }
            }
        } catch (SQLException | NamingException ex) {
            log("Error CreateAccount SQL | Namming: " + ex.getMessage());
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
