package com.lwr.software.reporter.admin.usermgmt;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.type.CollectionType;
import org.codehaus.jackson.map.type.TypeFactory;

import com.lwr.software.reporter.DashboardConstants;
import com.lwr.software.reporter.DashboardConstants.Role;

public class UserManager {

	private static volatile UserManager manager;
	
	private Set<User> users = new HashSet<User>();
	
	private static Logger logger = LogManager.getLogger(UserManager.class);
	
	static{
		File configDir = new File(DashboardConstants.CONFIG_PATH);
		configDir.mkdirs();
	}
	
	private String fileName = DashboardConstants.CONFIG_PATH+"users.json";
	
	public static UserManager getUserManager(){
		if(manager == null){
			synchronized (UserManager.class) {
				if(manager == null){
					manager = new UserManager();
				}
			}
		}
		return manager;
	}
	
	private UserManager(){
		init();
	}
	
	private void init(){
	    try {
	    	ObjectMapper objectMapper = new ObjectMapper();
	        TypeFactory typeFactory = objectMapper.getTypeFactory();
	        CollectionType collectionType = typeFactory.constructCollectionType(Set.class, User.class);
	        users =  objectMapper.readValue(new File(fileName), collectionType);
	        System.out.println(objectMapper.writerWithDefaultPrettyPrinter().writeValueAsString(users));
	    } catch (IOException e) {
	    	logger.error("Unable to initialize user manager",e);
	    }
		if(users == null || users.isEmpty()){
			User adminUser = new User("Administrator","admin","admin",Role.ADMIN);
			users.add(adminUser);
		}
	}
	
	public boolean saveUser(User user){
		logger.info("Saving user "+user.getUsername());
		boolean isSaved = false;
		try{
			if(user.getUsername().equals(DashboardConstants.ADMIN_USER) && user.getRole().equals(Role.VIEW))
				user.setRole(Role.ADMIN);
			if(users.contains(user)){
				users.remove(user);
				users.add(user);
				isSaved=true;
			}else{
				users.add(user);
				isSaved=true;
			}
			seralize();
		}catch(Exception e){
			logger.error("Unable to save user "+user.getUsername(),e);
			isSaved=false;
		}
		return isSaved;
	}
	
	public Set<User> getUsers(){
		return this.users;
	}
	
	public User getUser(String username){
		for (User user : users) {
			if(user.getUsername().equalsIgnoreCase(username))
				return user;
		}
		return null;
	}
	
	private void seralize(){
		try{
	    	ObjectMapper objectMapper = new ObjectMapper();
	        String dataToRight = objectMapper.writerWithDefaultPrettyPrinter().writeValueAsString(users);
	        FileWriter writer = new FileWriter(fileName);
	        writer.write(dataToRight);
	        writer.flush();
	        writer.close();
		}catch(Exception e){
			logger.error("Unable to serialize user manager",e);
		}
	}

	public boolean removeUser(String userName) {
		logger.info("Deleting user "+userName);
		if(userName.equals(DashboardConstants.ADMIN_USER))
			return false;
		User userToDelete = null;
		for (User user : users) {
			if(user.getUsername().equalsIgnoreCase(userName)){
				userToDelete = user;
				break;
			}
		}
		if(userToDelete == null)
			return false;
		users.remove(userToDelete);
		seralize();
		return true;
	}
}
