package com.profile;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    
    private ProfileDAO profileDAO;
    
    @Override
    public void init() {
        profileDAO = new ProfileDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "viewAll":
            case "list":
                listProfiles(request, response);
                break;
            case "search":
                searchProfiles(request, response);
                break;
            case "filter":
                filterByProgramme(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteProfile(request, response);
                break;
            default:
                listProfiles(request, response);
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("insert".equals(action)) {
            insertProfile(request, response);
        } else if ("update".equals(action)) {
            updateProfile(request, response);
        } else {
            listProfiles(request, response);
        }
    }
    
    
    private void listProfiles(HttpServletRequest request,
                              HttpServletResponse response)
            throws ServletException, IOException {
        
        List<ProfileBean> profiles = profileDAO.getAllProfiles();
        request.setAttribute("profiles", profiles);
        request.setAttribute("totalProfiles", profiles.size());
        request.getRequestDispatcher("viewProfiles.jsp").forward(request, response);
    }
    
    
    private void insertProfile(HttpServletRequest request,
                               HttpServletResponse response)
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String studentId = request.getParameter("studentId");
        String programme = request.getParameter("programme");
        String email = request.getParameter("email");
        String hobbies = request.getParameter("hobbies");
        String intro = request.getParameter("intro");
        
        
        if (name == null || name.trim().isEmpty() ||
            studentId == null || studentId.trim().isEmpty() ||
            programme == null || programme.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            
            request.setAttribute("error", "All required fields must be filled!");
            request.getRequestDispatcher("index.html").forward(request, response);
            return;
        }
        
        ProfileBean profile = new ProfileBean(name, studentId, programme, email, hobbies, intro);
        
        if (profileDAO.insertProfile(profile)) {
            request.setAttribute("profile", profile);
            request.setAttribute("message", "Profile saved successfully!");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Failed to save profile!");
            response.sendRedirect("index.html");
        }
    }
    
    
    private void searchProfiles(HttpServletRequest request,
                                HttpServletResponse response)
            throws ServletException, IOException {
        
        String keyword = request.getParameter("keyword");
        
        if (keyword == null || keyword.trim().isEmpty()) {
            listProfiles(request, response);
            return;
        }
        
        List<ProfileBean> profiles = profileDAO.searchProfiles(keyword);
        request.setAttribute("profiles", profiles);
        request.setAttribute("searchKeyword", keyword);
        request.setAttribute("totalProfiles", profiles.size());
        request.getRequestDispatcher("viewProfiles.jsp").forward(request, response);
    }
    
    
    private void filterByProgramme(HttpServletRequest request,
                                   HttpServletResponse response)
            throws ServletException, IOException {
        
        String programme = request.getParameter("programme");
        
        if (programme == null || programme.trim().isEmpty()) {
            listProfiles(request, response);
            return;
        }
        
        List<ProfileBean> profiles = profileDAO.filterByProgramme(programme);
        request.setAttribute("profiles", profiles);
        request.setAttribute("filterProgramme", programme);
        request.setAttribute("totalProfiles", profiles.size());
        request.getRequestDispatcher("viewProfiles.jsp").forward(request, response);
    }
    
    
    private void showEditForm(HttpServletRequest request,
                              HttpServletResponse response)
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        ProfileBean profile = profileDAO.getProfileById(id);
        
        if (profile != null) {
            request.setAttribute("profile", profile);
            request.getRequestDispatcher("editProfile.jsp").forward(request, response);
        } else {
            response.sendRedirect("ProfileServlet?action=list");
        }
    }
    
    
    private void updateProfile(HttpServletRequest request,
                               HttpServletResponse response)
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String studentId = request.getParameter("studentId");
        String programme = request.getParameter("programme");
        String email = request.getParameter("email");
        String hobbies = request.getParameter("hobbies");
        String intro = request.getParameter("intro");
        
        ProfileBean profile = new ProfileBean(name, studentId, programme, email, hobbies, intro);
        profile.setId(id);
        
        if (profileDAO.updateProfile(profile)) {
            request.setAttribute("message", "Profile updated successfully!");
            listProfiles(request, response);
        } else {
            request.setAttribute("error", "Failed to update profile!");
            showEditForm(request, response);
        }
    }
    
    
    private void deleteProfile(HttpServletRequest request,
                               HttpServletResponse response)
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        
        if (profileDAO.deleteProfile(id)) {
            request.setAttribute("message", "Profile deleted successfully!");
        } else {
            request.setAttribute("error", "Failed to delete profile!");
        }
        
        listProfiles(request, response);
    }
}