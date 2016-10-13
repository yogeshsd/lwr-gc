package com.lwr.software.reporter.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lwr.software.reporter.DashboardConstants;
import com.lwr.software.reporter.admin.usermgmt.User;
import com.lwr.software.reporter.admin.usermgmt.UserManager;
import com.lwr.software.reporter.security.UserSecurityContext;

public class LoginServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String username = (String) req.getParameter(DashboardConstants.USERNAME);
		String password = (String) req.getParameter(DashboardConstants.PASSWORD);

		User user = UserManager.getUserManager().getUser(username);
		if(user == null){
			req.getSession().putValue("errmsg", "Invalid Username or Password. Try again!!");
			getServletContext().getRequestDispatcher("/login").forward(req, resp);
		}else if(!(password.equals(user.getPassword()))){
			req.getSession().putValue("errmsg", "Invalid Username or Password. Try again!!");
			getServletContext().getRequestDispatcher("/login").forward(req, resp);
		}else{
			UserSecurityContext context = new UserSecurityContext();
			context.setPassword(user.getPassword());
			context.setUserName(user.getUsername());
			context.setRole(user.getRole());
			context.setDisplayName(user.getDisplayName());
			req.getSession().setAttribute(DashboardConstants.SECURITY_CONTEXT,context);
			getServletContext().getRequestDispatcher("/home").forward(req, resp);
		}
	}
}
