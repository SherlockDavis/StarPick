package com.ecommerce.exception;

/**
 * 商品库存不足异常
 * 
 * @author ecommerce-system
 * @since 1.0.0
 */
public class ProductOutOfStockException extends BusinessException {
    
    public ProductOutOfStockException() {
        super("PRODUCT_OUT_OF_STOCK", "商品库存不足");
    }
    
    public ProductOutOfStockException(String message) {
        super("PRODUCT_OUT_OF_STOCK", message);
    }
}