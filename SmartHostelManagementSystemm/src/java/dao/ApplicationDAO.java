package dao;

import model.Application;
import util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ApplicationDAO {

    public boolean applyRoom(Application application) {
        boolean success = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO applications(user_id, room_id, status) VALUES (?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, application.getUserId());
            ps.setInt(2, application.getRoomId());
            ps.setString(3, application.getStatus());
            int rows = ps.executeUpdate();
            if (rows > 0) {
                success = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    public List<Application> getAllApplications() {
        List<Application> applicationList = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            
            // THE FIX: Added 'ORDER BY applications.application_id ASC' to force chronological sorting
            String sql = "SELECT applications.*, users.name, rooms.room_number "
                    + "FROM applications "
                    + "JOIN users ON applications.user_id = users.user_id "
                    + "JOIN rooms ON applications.room_id = rooms.room_id "
                    + "ORDER BY applications.application_id ASC";
                    
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Application application = new Application();
                application.setApplicationId(rs.getInt("application_id"));
                application.setUserId(rs.getInt("user_id"));
                application.setRoomId(rs.getInt("room_id"));
                application.setStatus(rs.getString("status"));
                application.setStudentName(rs.getString("name"));
                application.setRoomNumber(rs.getString("room_number"));
                applicationList.add(application);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return applicationList;
    }
    
    public List<Application> getFilteredApplications(String filterStatus) {
        List<Application> applicationList = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            
            String sql = "SELECT applications.*, users.name, rooms.room_number "
                    + "FROM applications "
                    + "JOIN users ON applications.user_id = users.user_id "
                    + "JOIN rooms ON applications.room_id = rooms.room_id "
                    + "WHERE applications.status = ? "
                    + "ORDER BY applications.application_id ASC";
                    
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, filterStatus);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Application application = new Application();
                application.setApplicationId(rs.getInt("application_id"));
                application.setUserId(rs.getInt("user_id"));
                application.setRoomId(rs.getInt("room_id"));
                application.setStatus(rs.getString("status"));
                application.setStudentName(rs.getString("name"));
                application.setRoomNumber(rs.getString("room_number"));
                applicationList.add(application);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return applicationList;
    }

    public Application getApplicationById(int applicationId) {
        Application app = null;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM applications WHERE application_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, applicationId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                app = new Application();
                app.setApplicationId(rs.getInt("application_id"));
                app.setUserId(rs.getInt("user_id"));
                app.setRoomId(rs.getInt("room_id"));
                app.setStatus(rs.getString("status"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return app;
    }

    public List<Application> getApplicationsByUserId(int userId) {
        List<Application> list = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            // Also explicitly sorting this list chronologically for the student
            String sql = "SELECT a.*, r.room_number FROM applications a "
                       + "JOIN rooms r ON a.room_id = r.room_id WHERE a.user_id=? "
                       + "ORDER BY a.application_id ASC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Application app = new Application();
                app.setApplicationId(rs.getInt("application_id"));
                app.setUserId(rs.getInt("user_id"));
                app.setRoomId(rs.getInt("room_id"));
                app.setStatus(rs.getString("status"));
                app.setRoomNumber(rs.getString("room_number"));
                list.add(app);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateApplicationStatus(int applicationId, String status) {
        boolean success = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE applications SET status=? WHERE application_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, applicationId);
            int rows = ps.executeUpdate();
            if (rows > 0) {
                success = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }
}