/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import utils.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.UserDTO;

/**
 *
 * @author HuuThanh
 */
public class UserDAO extends DBContext {

    private static final String LOGIN = "SELECT * FROM Users WHERE (username=? OR email = ?) AND password=? and status=1";

    //private static final String GET_DATA = "SELECT * FROM Users WHERE status = 1 Order by roleid asc";
    private static final String GET_DATA = "SELECT * FROM Users ORDER BY status DESC, roleid ASC";
    
    private static final String GET_USER_BY_NAME = "SELECT * FROM Users WHERE username = ? AND status = 1";

    private static final String GET_USER_BY_EMAIL = "SELECT * FROM Users WHERE email = ? AND status = 1";

    private static final String GET_TOTAL_USERS = "SELECT COUNT(*) AS Total FROM Users WHERE status = 1 AND roleid=2";

    private static final String UPDATE_USER = "UPDATE Users SET firstName = ?, lastName = ?, email = ?, address = ?, phone = ?, avatar = ?, roleid = ? WHERE username = ?";

    private static final String UPDATE_PASSWORD_FOR_USER = "UPDATE Users SET password = ? WHERE username = ?";

    private static final String CHECK_USERNAME_DUPLICATE = "SELECT * FROM Users WHERE userName = ? or email = ? and [status] = 1";

    private static final String DELETE_USER = "UPDATE Users SET status = 0 WHERE id = ?";
    
     private static final String SEARCH_USERS = "SELECT * FROM Users WHERE (firstName LIKE ? OR lastName LIKE ? OR email LIKE ? OR phone LIKE ? OR username LIKE ? OR CONCAT(firstName, ' ', lastName) LIKE ?) ORDER BY status DESC, roleid ASC";
    private static final String REGISTER_USER = "INSERT INTO [dbo].[Users]\n"
            + "           ([firstname]\n"
            + "           ,[lastname]\n"
            + "           ,[email]\n"
            + "           ,[avatar]\n"
            + "           ,[username]\n"
            + "           ,[password]\n"
            + "           ,[address]\n"
            + "           ,[phone]\n"
            + "           ,[roleid]\n"
            + "           ,[status])\n"
            + "     VALUES\n"
            + "           (?,?,?,?,?,?,?,?,?,?)";

    public List<UserDTO> getData() throws SQLException {
        List<UserDTO> users = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_DATA);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String firstName = rs.getString("firstName");
                    String lastName = rs.getString("lastName");
                    String email = rs.getString("email");
                    String avatar = rs.getString("avatar");
                    String userName = rs.getString("userName");
                    String password = rs.getString("password");
                    String address = rs.getString("address");
                    String phone = rs.getString("phone");
                    int roleId = rs.getInt("roleId");
                    boolean status = rs.getBoolean("status");
                    users.add(new UserDTO(id, firstName, lastName, email, avatar, userName, password, address, phone, roleId, status));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return users;
    }

    public UserDTO checkLogin(String userName, String password) throws SQLException {
        UserDTO user = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(LOGIN);
                ptm.setString(1, userName);
                ptm.setString(2, userName);
                ptm.setString(3, password);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    int id = rs.getInt("id");
                    String firstname = rs.getString("firstname");
                    String lastname = rs.getString("lastname");
                    String email = rs.getString("email");                    
                    String userNamee = rs.getString("userName");
                    String avatar = rs.getString("avatar");
                    String address = rs.getString("address");
                    String phone = rs.getString("phone");
                    int roleid = rs.getInt("roleID");
                    boolean roleID = rs.getBoolean("roleID");
                    user = new UserDTO(id, firstname, lastname, email, avatar, userNamee, password, address, phone, roleid, roleID);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return user;
    }

    public int getTotalUsers() throws SQLException {
        int result = 0;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_TOTAL_USERS);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    result = rs.getInt("Total");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return result;
    }

//    public void updateUser(String firstName, String lastName, String email, String address, String phone, String userName, String avatar, int roleId) throws SQLException {
//        UserDTO user = null;
//        Connection conn = null;
//        PreparedStatement ptm = null;
//        ResultSet rs = null;
//        try {
//            conn = getConnection();
//            if (conn != null) {
//                ptm = conn.prepareStatement(UPDATE_USER);
//                ptm.setString(1, firstName);
//                ptm.setString(2, lastName);
//                ptm.setString(3, email);
//                ptm.setString(4, address);
//                ptm.setString(5, phone);
//                ptm.setString(6, avatar);
//                ptm.setInt(7, roleId);
//                ptm.setString(8, userName);
//                ptm.executeUpdate();
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        } finally {
//            if (rs != null) {
//                rs.close();
//            }
//            if (ptm != null) {
//                ptm.close();
//            }
//            if (conn != null) {
//                conn.close();
//            }
//        }
//    }

    public boolean updatePasswordUser(UserDTO user, String pass) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE_PASSWORD_FOR_USER);
                ptm.setString(1, pass);
                ptm.setString(2, user.getUserName());
                ptm.executeUpdate();
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return false;
    }
    
    
         public List<String> getAdminEmails() {
            List<String> adminEmails = new ArrayList<>();
            Connection conn = null;
            PreparedStatement ptm = null;
            ResultSet rs = null;

            try {
                conn = getConnection();
                String sql = "SELECT email FROM Users WHERE roleid = 1 AND status = 1";
                ptm = conn.prepareStatement(sql);
                rs = ptm.executeQuery();

                while (rs.next()) {
                    String email = rs.getString("email");
                    adminEmails.add(email);
                    System.out.println("Found admin email: " + email);
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (Exception e) { }
                if (ptm != null) try { ptm.close(); } catch (Exception e) { }
                if (conn != null) try { conn.close(); } catch (Exception e) { }
            }

            return adminEmails;
        }

    public UserDTO getUserByName(String userName) throws SQLException {
        UserDTO user = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_USER_BY_NAME);
                ptm.setString(1, userName);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String firstname = rs.getString("firstname");
                    String lastname = rs.getString("lastname");
                    String email = rs.getString("email");
                    String avatar = rs.getString("avatar");
                    String address = rs.getString("address");
                    String password = rs.getString("password");
                    String phone = rs.getString("phone");
                    int roleid = rs.getInt("roleID");
                    boolean roleID = rs.getBoolean("roleID");
                    user = new UserDTO(id, firstname, lastname, email, avatar, userName, password, address, phone, roleid, roleID);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return user;
    }
    
    public List<UserDTO> searchUsers(String searchQuery) throws SQLException, Exception {
        List<UserDTO> users = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        
        
        try {
            conn = this.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement("SELECT * FROM Users WHERE (firstName LIKE ? OR lastName LIKE ? OR email LIKE ? OR phone LIKE ? OR username LIKE ? OR CONCAT(firstName, ' ', lastName) LIKE ?) ORDER BY status DESC, roleid ASC");
                String searchPattern = "%" + searchQuery + "%";
                ptm.setString(1, searchPattern);
                ptm.setString(2, searchPattern);
                ptm.setString(3, searchPattern);
                ptm.setString(4, searchPattern);
                ptm.setString(5, searchPattern);
                ptm.setString(6, searchPattern);
                rs = ptm.executeQuery();

                while(rs.next()) {
                    int id = rs.getInt("id");
                    String firstName = rs.getString("firstName");
                    String lastName = rs.getString("lastName");
                    String email = rs.getString("email");
                    String avatar = rs.getString("avatar");
                    String userName = rs.getString("userName");
                    String password = rs.getString("password");
                    String address = rs.getString("address");
                    String phone = rs.getString("phone");
                    int roleId = rs.getInt("roleId");
                    boolean status = rs.getBoolean("status");
                    users.add(new UserDTO(id, firstName, lastName, email, avatar, userName, password, address, phone, roleId, status));
                }
            }
           
        } finally {
            if (rs != null) rs.close();
            if (ptm != null) ptm.close();
            if (conn != null) conn.close();
        }
        return users;
    }
    

    public UserDTO getUserByEmail(String email) throws SQLException {
        UserDTO user = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_USER_BY_EMAIL);
                ptm.setString(1, email);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String firstname = rs.getString("firstname");
                    String userName = rs.getString("userName");
                    String lastname = rs.getString("lastname");
                    String avatar = rs.getString("avatar");
                    String address = rs.getString("address");
                    String password = rs.getString("password");
                    String phone = rs.getString("phone");
                    int roleid = rs.getInt("roleID");
                    boolean status = rs.getBoolean("status");
                    user = new UserDTO(id, firstname, lastname, email, avatar, userName, password, address, phone, roleid, status);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return user;
    }

    public boolean checkUserNameDuplicate(String username) throws SQLException {
        boolean ok = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CHECK_USERNAME_DUPLICATE);
                ptm.setString(1, username);
                ptm.setString(2, username);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    ok = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return ok;
    }

    public void registerUser(UserDTO user) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(REGISTER_USER);
                ptm.setString(1, user.getFirstName());
                ptm.setString(2, user.getLastName());
                ptm.setString(3, user.getEmail());
                ptm.setString(4, user.getAvatar());
                ptm.setString(5, user.getUserName());
                ptm.setString(6, user.getPassword());
                ptm.setString(7, user.getAddress());
                ptm.setString(8, user.getPhone());
                ptm.setInt(9, user.getRoleID());
                ptm.setBoolean(10, user.isStatus());
                ptm.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }
    
    public void deleteUser(String uid) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(DELETE_USER);
                ptm.setString(1, uid);
                ptm.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }
    public UserDTO getUserById(int userId) throws SQLException {
    UserDTO user = null;
    Connection conn = null;
    PreparedStatement ptm = null;
    ResultSet rs = null;
    try {
        conn = getConnection();
        if (conn != null) {
            // Câu lệnh SQL để lấy thông tin người dùng theo ID
            String query = "SELECT * FROM Users WHERE id = ? AND status = 1";
            ptm = conn.prepareStatement(query);
            ptm.setInt(1, userId);  // Gán ID người dùng vào câu lệnh truy vấn
            rs = ptm.executeQuery();
            
            if (rs.next()) {
                // Lấy thông tin người dùng từ kết quả truy vấn
                int id = rs.getInt("id");
                String firstName = rs.getString("firstName");
                String lastName = rs.getString("lastName");
                String email = rs.getString("email");
                String avatar = rs.getString("avatar");
                String userName = rs.getString("userName");
                String password = rs.getString("password");
                String address = rs.getString("address");
                String phone = rs.getString("phone");
                int roleId = rs.getInt("roleID");
                boolean status = rs.getBoolean("status");
                
                // Tạo đối tượng UserDTO từ dữ liệu truy vấn
                user = new UserDTO(id, firstName, lastName, email, avatar, userName, password, address, phone, roleId, status);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Đóng kết nối và các đối tượng sau khi sử dụng
        if (rs != null) {
            rs.close();
        }
        if (ptm != null) {
            ptm.close();
        }
        if (conn != null) {
            conn.close();
        }
    }
    return user;
}

        public void restoreUser(String uid) throws SQLException {// thêm 2 cái này 
    Connection conn = null;
    PreparedStatement ptm = null;
    try {
        conn = getConnection();
        if (conn != null) {
            String query = "UPDATE Users SET status = 1 WHERE id = ?";
            ptm = conn.prepareStatement(query);
            ptm.setString(1, uid);
            ptm.executeUpdate();
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (ptm != null) {
            ptm.close();
        }
        if (conn != null) {
            conn.close();
        }
    }
}
    public void permanentlyDeleteUser(String uid) throws SQLException { 
    Connection conn = null;
    PreparedStatement ptm = null;
    try {
        conn = getConnection();
        if (conn != null) {
            String query = "DELETE FROM Users WHERE id = ?";
            ptm = conn.prepareStatement(query);
            ptm.setString(1, uid);
            ptm.executeUpdate();
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (ptm != null) {
            ptm.close();
        }
        if (conn != null) {
            conn.close();
        }
    }
}
    
    
    
    public List<Object[]> getTopUsersByTotalSpent(int limit) throws SQLException {
        List<Object[]> topUsers = new ArrayList();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = this.getConnection();
            if (conn != null) {
                String query = "SELECT u.firstname + ' ' + u.lastname AS fullName, SUM(o.totalprice) AS totalSpent FROM Orders o JOIN Users u ON o.username = u.username WHERE o.status = 1 AND u.roleid = 2 AND u.status = 1GROUP BY u.username, u.firstname, u.lastname HAVING SUM(o.totalprice) > 0 ORDER BY totalSpent DESC";
                ptm = conn.prepareStatement(query);
                rs = ptm.executeQuery();

                while(rs.next()) {
                    Object[] userData = new Object[2];
                    userData[0] = rs.getString("fullName");
                    userData[1] = rs.getDouble("totalSpent");
                    topUsers.add(userData);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }

            if (ptm != null) {
                ptm.close();
            }

            if (conn != null) {
                conn.close();
            }

        }

        return topUsers;
    }
//    public static void main(String[] args) throws SQLException {
//        UserDAO dao = new UserDAO();
//        UserDTO user = dao.checkLogin("phuuthanh2003", "1231231231");
////        List<UserDTO> list = dao.getData();
////        for (int i = 0; i < list.size(); i++) {
////            System.out.println(list.get(i).getAvatar());
////        }
//        System.out.println(user.getFirstName());
//    }
}
