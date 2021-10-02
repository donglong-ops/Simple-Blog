/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longdh.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import longdh.articles.ArticlesDAO;
import longdh.articles.ArticlesDTO;
import longdh.users.UsersDTO;

/**
 *
 * @author Dong Long
 */
@WebServlet(name = "ManageArticlesController", urlPatterns = {"/ManageArticlesController"})
public class ManageArticlesController extends HttpServlet {

    private static final String ERROR_PAGE = "try";
    private static final String SUCCESS_PAGE = "manageArticlePage.jsp";

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
        ArticlesDAO dao = new ArticlesDAO();
        String url = ERROR_PAGE;
        HttpSession session = request.getSession();
        UsersDTO user = (UsersDTO) session.getAttribute("USER");
        int pageSize = 5;
        try {
            if (user != null && user.getRole().equals("User")) {
                url = ERROR_PAGE;
                response.sendRedirect(url);
            } else {
                String pageNum = request.getParameter("pageNum");
                if (user != null) {
                    List<ArticlesDTO> list;
                    request.removeAttribute("MANAGELIST");
                    int numberArticle = dao.countTotalArticle();
                    int page = (int) (Math.ceil((double) numberArticle / pageSize));
                    request.setAttribute("PAGENUMBER", page);
                    int pageIndex = 1;
                    if (pageNum != null) {
                        pageIndex = Integer.parseInt(pageNum);
                    }
                    list = dao.getAllArticles(pageIndex, pageSize);
                    request.setAttribute("MANAGELIST", list);
                    url = SUCCESS_PAGE;
                }
                request.getRequestDispatcher(url).forward(request, response);
            }
        } catch (SQLException | NamingException | ParseException ex) {
            log("Error ManageArticlesController : " + ex.getMessage());
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
