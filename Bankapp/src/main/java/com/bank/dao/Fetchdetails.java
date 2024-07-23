package com.bank.dao;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bank.util.DatabaseUtil;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


@WebServlet("/FetchCustomerServlet")
public class Fetchdetails extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accNo = request.getParameter("acc-no");
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
        	con = DatabaseUtil.getConnection();


            String query = "SELECT * FROM cdetails WHERE acc_no = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, accNo);
            rs = ps.executeQuery();

            if (rs.next()) {
                request.setAttribute("user_name", rs.getString("user_name"));
                request.setAttribute("dob", rs.getDate("dob"));
                request.setAttribute("phone_no", rs.getString("phone_no"));
                request.setAttribute("email", rs.getString("email"));
                request.setAttribute("address", rs.getString("address"));
                request.setAttribute("initial_balance", rs.getBigDecimal("initial_balance"));
                request.setAttribute("IDproof", rs.getString("IDproof"));
                request.setAttribute("acc_type", rs.getString("acc_type"));
                request.setAttribute("acc_no", rs.getString("acc_no"));
                request.setAttribute("u_password", rs.getString("u_password"));

                request.getRequestDispatcher("editdetails.jsp").forward(request, response);
            } else {
                response.getWriter().println("No customer found with the provided account number.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

