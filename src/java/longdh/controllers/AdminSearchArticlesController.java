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
@WebServlet(name = "AdminSearchArticlesController", urlPatterns = {"/AdminSearchArticlesController"})
public class AdminSearchArticlesController extends HttpServlet {

    private final String SUCCESS_PAGE = "manageArticlePage.jsp";
    private final String LOST_LOGIN_PAGE = "try";

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
        String search = request.getParameter("txtSearchName");
        String status = request.getParameter("txtStatus");
        String pageNum = request.getParameter("pageNum");
        String url;
        ArticlesDAO dao = new ArticlesDAO();
        HttpSession session = request.getSession();
        UsersDTO user = ((UsersDTO) session.getAttribute("USER"));
        try {
            if (user == null) {
                url = LOST_LOGIN_PAGE;
                response.sendRedirect(url);
            } else if (user.getRole().equals("Admin")) {
                int numberArticle = dao.coutTotalArticlesSearch(search, Integer.parseInt(status));
                int page = (int) (Math.ceil((double) numberArticle / 5));
                request.setAttribute("PAGENUMBER", page);
                int pageIndex = 1;
                if (pageNum != null) {
                    pageIndex = Integer.parseInt(pageNum);
                }
                List<ArticlesDTO> listSearch = dao.searchAllArticlesByContent(search, Integer.parseInt(status), pageIndex);
                request.setAttribute("MANAGELIST", listSearch);
                url = SUCCESS_PAGE;
                request.getRequestDispatcher(url).forward(request, response);
            }
        } catch (SQLException | NamingException e) {
            log("Error SearchArticlesController at: " + e.getMessage());
        } catch (ParseException ex) {
            log("Error SearchArticlesController Parse: " + ex.getMessage());
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
