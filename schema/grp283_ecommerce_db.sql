-- CREATE DATABASE grp283_ecommerce_db
DROP DATABASE IF EXISTS grp283_ecommerce_db;
CREATE DATABASE grp283_ecommerce_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE grp283_ecommerce_db;








-- ************************************************************************
-- Done by: Roy Kimathi (mwika.roy@gmail.com)
-- 25th April 2025
-- *************************************************************************
-- Create the DB Tables as below:
    -- product_variation
    -- size_category
    -- size_option

-- Table product_variation ---> Linking the products to the variations
-- Constraint: A foreign key constraint to product_id in product table and
--  a unique constraint between variation name and product
CREATE TABLE IF NOT EXISTS product_variation (
    variation_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    variation_name VARCHAR(50) NOT NULL,
    variation_description VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT  fk_variation_product FOREIGN KEY (product_id)
        REFERENCES product(product_id) ON DELETE CASCADE,
    CONSTRAINT uc_variation_name_product UNIQUE (product_id, variation_name)
) ENGINE=InnoDB COMMENT='The table defines the different types of variations for the products e.g size, color, package etc';

-- To enhance normalization, i further broke down the product variation to improve integrity and
-- minimize both redundancy and dependency.

-- Table product_item_variation ---> Linking product items to their specific variation values

CREATE TABLE IF NOT EXISTS product_item_variations (
    item_id INT NOT NULL,
    variation_id INT NOT NULL,
    variation_value VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_product_item_variation_item FOREIGN KEY (item_id)
        REFERENCES product_item(item_id) ON DELETE CASCADE,
    CONSTRAINT fk_product_item_variation_variation FOREIGN KEY (variation_id)
        REFERENCES product_variation(variation_id) ON DELETE CASCADE
    ) ENGINE=InnoDB COMMENT='Links product items to their specific variation values';

-- Table size_category
-- this table groups sizes in categories e.g Clothing, shoes etc
-- The table has a Unique constraint to avoid duplication of category name

CREATE TABLE IF NOT EXISTS size_category (
    size_category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL,
    category_description VARCHAR(200) NOT NULL,
    CONSTRAINT uc_size_category_name UNIQUE (category_name)
) ENGINE=InnoDB COMMENT='Group size options into categories';

-- Table size_options
-- The table lists specific sizes and options

CREATE TABLE IF NOT EXISTS size_options (
    size_id INT AUTO_INCREMENT PRIMARY KEY ,
    size_category_id INT NOT NULL,
    size_value VARCHAR(30) NOT NULL,
    size_description VARCHAR(200),
    CONSTRAINT fk_size_category_size_options FOREIGN KEY (size_category_id)
            REFERENCES size_category(size_category_id) ON DELETE CASCADE,
    CONSTRAINT uc_size_value_category UNIQUE (size_category_id, size_value)
) ENGINE = InnoDB COMMENT = 'Specific size options within categories';

