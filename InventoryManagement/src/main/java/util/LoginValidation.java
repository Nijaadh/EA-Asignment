package util;

public class LoginValidation {
	public boolean authenticateUser(String username, String password) {
        // Implement your authentication logic here.
        // For demonstration, we're using hardcoded credentials.
        
        if (username != null && username.equals("admin") && password != null && password.equals("admin")) {
            return true;
        } else {
            return false;
        }
    }
}
