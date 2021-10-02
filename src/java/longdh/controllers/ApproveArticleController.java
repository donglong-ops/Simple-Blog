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
import longdh.articles.ArticlesDAO;
import longdh.users.UsersDTO;

/**
 *
 * @author Dong Long
 */
@WebServlet(name = "ApproveArticleController", urlPatterns = {"/ApproveArticleController"})
public class ApproveArticleController extends HttpServlet {

    private static final String SUCCESS = "manageArticleAction";
    private static final String ERROR = "errorPage";
    private static final String LOST_LOGIN_PAGE = "try";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = ERROR;
        response.setContentType("text/html;charset=UTF-8");
        String txtPostID = request.getParameter("txtPostID");
        HttpSession session = request.getSession();
        UsersDTO user = ((UsersDTO) session.getAttribute("USER"));
        ArticlesDAO artDao = new ArticlesDAO();

        try {
            if (user == null) {
                url = LOST_LOGIN_PAGE;
            } else {
                if (user.getRole().equals("Admin")) {
                    artDao.updateArticle(Integer.parseInt(txtPostID), 2);
                    url = SUCCESS;
                } else {
                    url = ERROR;
                }
            }
        } catch (NumberFormatException | SQLException | NamingException e) {
            log("Error ApproveArticleController at: " + e.getMessage());
        } finally {
            response.sendRedirect(url);
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
