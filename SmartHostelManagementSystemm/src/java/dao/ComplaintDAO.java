/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Complaint;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ComplaintDAO {

    public boolean addComplaint(Complaint complaint){

        boolean success = false;

        try{

            Connection conn = DBConnection.getConnection();

            String sql = "INSERT INTO complaints(user_id, description, status) VALUES (?, ?, ?)";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, complaint.getUserId());
            ps.setString(2, complaint.getDescription());
            ps.setString(3, complaint.getStatus());

            int rows = ps.executeUpdate();

            if(rows > 0){
                success = true;
            }

        } catch(Exception e){
            e.printStackTrace();
        }

        return success;
    }
    
    public List<Complaint> getAllComplaints(){

    List<Complaint> complaintList = new ArrayList<>();

    try{

        Connection conn = DBConnection.getConnection();

        String sql = "SELECT complaints.*, users.name " +
             "FROM complaints " +
             "JOIN users ON complaints.user_id = users.user_id";

        PreparedStatement ps = conn.prepareStatement(sql);

        ResultSet rs = ps.executeQuery();

        while(rs.next()){

            Complaint complaint = new Complaint();

            complaint.setComplaintId(
                    rs.getInt("complaint_id"));

            complaint.setUserId(
                    rs.getInt("user_id"));

            complaint.setDescription(
                    rs.getString("description"));

            complaint.setStatus(
                    rs.getString("status"));
            
            complaint.setStudentName(rs.getString("name"));

            complaintList.add(complaint);
        }

    } catch(Exception e){
        e.printStackTrace();
    }

    return complaintList;
}
    
    public boolean updateComplaintStatus(int complaintId,
                                     String status){

    boolean success = false;

    try{

        Connection conn = DBConnection.getConnection();

        String sql =
            "UPDATE complaints SET status=? WHERE complaint_id=?";

        PreparedStatement ps =
                conn.prepareStatement(sql);

        ps.setString(1, status);
        ps.setInt(2, complaintId);

        int rows = ps.executeUpdate();

        if(rows > 0){
            success = true;
        }

    } catch(Exception e){
        e.printStackTrace();
    }

    return success;
}
}