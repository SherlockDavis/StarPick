package com.ecommerce.exception;

/**
 * 无效令牌异常
 * 
 * @author ecommerce-system
 * @since 1.0.0
 */
public class InvalidTokenException extends BusinessException {
    
    public InvalidTokenException() {
        super("INVALID_TOKEN", "令牌无效或已过期");
    }
    
    public InvalidTokenException(String message) {
        super("INVALID_TOKEN", message);
    }
}