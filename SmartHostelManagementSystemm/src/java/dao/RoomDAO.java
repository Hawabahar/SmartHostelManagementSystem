/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Room;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {

    public boolean addRoom(Room room){

        boolean success = false;

        try{

            Connection conn = DBConnection.getConnection();

            String sql = "INSERT INTO rooms(room_number, capacity, status) VALUES (?, ?, ?)";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, room.getRoomNumber());
            ps.setInt(2, room.getCapacity());
            ps.setString(3, room.getStatus());

            int rows = ps.executeUpdate();

            if(rows > 0){
                success = true;
            }

        } catch(Exception e){
            e.printStackTrace();
        }

        return success;
    }
    
    public List<Room> getAllRooms(){

    List<Room> roomList = new ArrayList<>();

    try{

        Connection conn = DBConnection.getConnection();

        String sql = "SELECT * FROM rooms";

        PreparedStatement ps = conn.prepareStatement(sql);

        ResultSet rs = ps.executeQuery();

        while(rs.next()){

            Room room = new Room();

            room.setRoomId(rs.getInt("room_id"));
            room.setRoomNumber(rs.getString("room_number"));
            room.setCapacity(rs.getInt("capacity"));
            room.setStatus(rs.getString("status"));

            roomList.add(room);
        }

    } catch(Exception e){
        e.printStackTrace();
    }

    return roomList;
}
    
    public boolean updateRoom(Room room){

    boolean success = false;

    try{

        Connection conn = DBConnection.getConnection();

        String sql = "UPDATE rooms SET room_number=?, capacity=?, status=? WHERE room_id=?";

        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setString(1, room.getRoomNumber());
        ps.setInt(2, room.getCapacity());
        ps.setString(3, room.getStatus());
        ps.setInt(4, room.getRoomId());

        int rows = ps.executeUpdate();

        if(rows > 0){
            success = true;
        }

    } catch(Exception e){
        e.printStackTrace();
    }

    return success;
}
    
    public Room getRoomById(int roomId){

    Room room = null;

    try{

        Connection conn = DBConnection.getConnection();

        String sql = "SELECT * FROM rooms WHERE room_id=?";

        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setInt(1, roomId);

        ResultSet rs = ps.executeQuery();

        if(rs.next()){

            room = new Room();

            room.setRoomId(rs.getInt("room_id"));
            room.setRoomNumber(rs.getString("room_number"));
            room.setCapacity(rs.getInt("capacity"));
            room.setStatus(rs.getString("status"));
        }

    } catch(Exception e){
        e.printStackTrace();
    }

    return room;
}
    
    public boolean deleteRoom(int roomId){

    boolean success = false;

    try{

        Connection conn = DBConnection.getConnection();

        String sql = "DELETE FROM rooms WHERE room_id=?";

        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setInt(1, roomId);

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