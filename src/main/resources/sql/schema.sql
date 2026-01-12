-- 外卖/电商管理系统数据库初始化脚本

-- 创建数据库
CREATE DATABASE IF NOT EXISTS ecommerce_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE ecommerce_db;

-- 用户表
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '用户ID',
    username VARCHAR(50) UNIQUE NOT NULL COMMENT '用户名',
    password VARCHAR(100) NOT NULL COMMENT '密码',
    email VARCHAR(100) COMMENT '邮箱',
    phone VARCHAR(20) COMMENT '手机号',
    role TINYINT DEFAULT 0 COMMENT '角色：0-普通用户, 1-管理员',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_username (username),
    INDEX idx_email (email),
    INDEX idx_phone (phone)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 商品分类表
CREATE TABLE IF NOT EXISTS categories (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '分类ID',
    name VARCHAR(50) NOT NULL COMMENT '分类名称',
    description TEXT COMMENT '分类描述',
    sort_order INT DEFAULT 0 COMMENT '排序顺序',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    INDEX idx_name (name),
    INDEX idx_sort_order (sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品分类表';

-- 商品表
CREATE TABLE IF NOT EXISTS products (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '商品ID',
    name VARCHAR(100) NOT NULL COMMENT '商品名称',
    description TEXT COMMENT '商品描述',
    price DECIMAL(10,2) NOT NULL COMMENT '商品价格',
    stock INT DEFAULT 0 COMMENT '库存数量',
    category_id BIGINT COMMENT '分类ID',
    image_url VARCHAR(255) COMMENT '商品图片URL',
    status TINYINT DEFAULT 1 COMMENT '状态：0-下架, 1-上架',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL,
    INDEX idx_name (name),
    INDEX idx_category_id (category_id),
    INDEX idx_status (status),
    INDEX idx_price (price),
    INDEX idx_create_time (create_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品表';

-- 购物车表
CREATE TABLE IF NOT EXISTS cart_items (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '购物车项ID',
    user_id BIGINT NOT NULL COMMENT '用户ID',
    product_id BIGINT NOT NULL COMMENT '商品ID',
    quantity INT NOT NULL COMMENT '商品数量',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    UNIQUE KEY uk_user_product (user_id, product_id),
    INDEX idx_user_id (user_id),
    INDEX idx_product_id (product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='购物车表';

-- 订单表
CREATE TABLE IF NOT EXISTS orders (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '订单ID',
    order_no VARCHAR(32) UNIQUE NOT NULL COMMENT '订单号',
    user_id BIGINT NOT NULL COMMENT '用户ID',
    total_amount DECIMAL(10,2) NOT NULL COMMENT '订单总金额',
    status TINYINT DEFAULT 0 COMMENT '订单状态：0-待支付, 1-已支付, 2-已发货, 3-已完成, 4-已取消',
    address TEXT COMMENT '收货地址',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT,
    INDEX idx_order_no (order_no),
    INDEX idx_user_id (user_id),
    INDEX idx_status (status),
    INDEX idx_create_time (create_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单表';

-- 订单详情表
CREATE TABLE IF NOT EXISTS order_items (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '订单项ID',
    order_id BIGINT NOT NULL COMMENT '订单ID',
    product_id BIGINT NOT NULL COMMENT '商品ID',
    product_name VARCHAR(100) NOT NULL COMMENT '商品名称',
    product_price DECIMAL(10,2) NOT NULL COMMENT '商品价格',
    quantity INT NOT NULL COMMENT '购买数量',
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE RESTRICT,
    INDEX idx_order_id (order_id),
    INDEX idx_product_id (product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单详情表';

-- 插入初始数据

-- 插入商品分类
INSERT INTO categories (name, description, sort_order) VALUES
('电子产品', '手机、电脑、数码产品等', 1),
('服装鞋帽', '男装、女装、鞋子、配饰等', 2),
('食品饮料', '零食、饮料、生鲜食品等', 3),
('家居用品', '家具、装饰、日用品等', 4),
('图书文具', '图书、文具、办公用品等', 5);

-- 插入示例商品
INSERT INTO products (name, description, price, stock, category_id, image_url, status) VALUES
('iPhone 15 Pro', '苹果最新款智能手机，配备A17 Pro芯片', 7999.00, 50, 1, '/images/iphone15pro.jpg', 1),
('MacBook Air M2', '轻薄便携的笔记本电脑，适合办公和学习', 8999.00, 30, 1, '/images/macbook-air-m2.jpg', 1),
('Nike Air Max', '经典运动鞋，舒适透气', 899.00, 100, 2, '/images/nike-air-max.jpg', 1),
('Adidas T恤', '纯棉材质，多色可选', 199.00, 200, 2, '/images/adidas-tshirt.jpg', 1),
('可口可乐 330ml', '经典碳酸饮料', 3.50, 1000, 3, '/images/coca-cola.jpg', 1),
('三只松鼠坚果礼盒', '精选坚果组合装', 89.00, 150, 3, '/images/nuts-gift-box.jpg', 1),
('宜家书桌', '简约现代风格办公桌', 599.00, 25, 4, '/images/ikea-desk.jpg', 1),
('小米台灯', 'LED护眼台灯，可调节亮度', 199.00, 80, 4, '/images/xiaomi-lamp.jpg', 1),
('《Java编程思想》', '经典Java学习书籍', 89.00, 60, 5, '/images/thinking-in-java.jpg', 1),
('晨光文具套装', '学生办公文具组合', 29.90, 300, 5, '/images/chenguang-stationery.jpg', 1);

-- 插入管理员用户（密码需要在应用中加密）
INSERT INTO users (username, password, email, phone, role) VALUES
('admin', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8ioctKk7Z4oc6YS8.Oa2Oy.Oy.Oy.O', 'admin@ecommerce.com', '13800138000', 1);

-- 插入测试用户
INSERT INTO users (username, password, email, phone, role) VALUES
('testuser', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8ioctKk7Z4oc6YS8.Oa2Oy.Oy.Oy.O', 'test@ecommerce.com', '13800138001', 0);