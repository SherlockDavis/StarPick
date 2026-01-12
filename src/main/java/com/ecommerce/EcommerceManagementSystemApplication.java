package com.ecommerce;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;

/**
 * 外卖/电商管理系统启动类
 * 
 * @author ecommerce-system
 * @since 1.0.0
 */
@SpringBootApplication
@EnableCaching
@MapperScan("com.ecommerce.dao")
public class EcommerceManagementSystemApplication {

    public static void main(String[] args) {
        SpringApplication.run(EcommerceManagementSystemApplication.class, args);
    }
}