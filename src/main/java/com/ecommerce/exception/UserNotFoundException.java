package com.ecommerce.exception;

/**
 * 用户不存在异常
 * 
 * @author ecommerce-system
 * @since 1.0.0
 */
public class UserNotFoundException extends BusinessException {
    
    public UserNotFoundException() {
        super("USER_NOT_FOUND", "用户不存在");
    }
    
    public UserNotFoundException(String message) {
        super("USER_NOT_FOUND", message);
    }
}