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
import longdh.comments.CommentsDTO;
import longdh.users.UsersDTO;

/**
 *
 * @author Dong Long
 */
@WebServlet(name = "HomeController", urlPatterns = {"/HomeController"})
public class HomeController extends HttpServlet {

    private static final String ERROR_PAGE = "errorPage";
    private static final String SUCCESS_PAGE = "homePage";

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
        UsersDTO userDTO = (UsersDTO) session.getAttribute("USER");
        String email = null;
        if (userDTO != null) {
            email = userDTO.getEmail();
        }
        String pageNum = request.getParameter("pageNum");
        try {
            List<ArticlesDTO> list;
            List<ArticlesDTO> listAticle;
            List<CommentsDTO> listCommentOfUser;
            List<CommentsDTO> listCommentOfPeople;
            int numberArticle = dao.countTotalArticleWithStatus();
            int page = (int) (Math.ceil((double) numberArticle / 5));
            int pageIndex = 1;
            if (pageNum != null) {
                int num = Integer.parseInt(pageNum);
                if (num > 0 && num < page) {
                    pageIndex = num + 1;
                }
            }
            list = dao.getAllArticlesWithStatus(pageIndex, 5);
            listAticle = dao.getAllArticlesWithStatus(2, 9);
            listCommentOfUser = dao.getListCommentByEmail(email);
            listCommentOfPeople = dao.getListCommentRandom();
            if (list != null) {
                session.setAttribute("LIST", list);
                session.setAttribute("LISTARTICLE", listAticle);
                session.setAttribute("LISTCOMMENTRECENT", listCommentOfPeople);
                session.setAttribute("LISTCOMMENTBYMAIL", listCommentOfUser);
                url = SUCCESS_PAGE;
            }
        } catch (SQLException | NamingException | ParseException ex) {
            log("Error HomeController : " + ex.getMessage());
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
