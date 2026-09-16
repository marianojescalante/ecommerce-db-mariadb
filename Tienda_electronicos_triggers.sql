-- Tienda de Electrónicos - MariaDB
DROP DATABASE IF EXISTS tienda_electronicos;
CREATE DATABASE tienda_electronicos;
USE tienda_electronicos;

CREATE TABLE productos (id INT AUTO_INCREMENT PRIMARY KEY, nombre VARCHAR(150) NOT NULL, stock INT NOT NULL, stock_minimo INT DEFAULT 4, precio DECIMAL(10,2) NOT NULL);
CREATE TABLE ventas (id INT AUTO_INCREMENT PRIMARY KEY, fecha DATETIME DEFAULT CURRENT_TIMESTAMP, total DECIMAL(10,2) DEFAULT 0);
CREATE TABLE detalle_ventas (id INT AUTO_INCREMENT PRIMARY KEY, id_venta INT NOT NULL, id_producto INT NOT NULL, cantidad INT NOT NULL, FOREIGN KEY (id_venta) REFERENCES ventas(id), FOREIGN KEY (id_producto) REFERENCES productos(id));
CREATE TABLE alertas_stock (id INT AUTO_INCREMENT PRIMARY KEY, id_producto INT, stock_actual INT, fecha DATETIME DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (id_producto) REFERENCES productos(id));

DELIMITER //
CREATE TRIGGER trg_validar_stock BEFORE INSERT ON detalle_ventas FOR EACH ROW
BEGIN DECLARE s INT; SELECT stock INTO s FROM productos WHERE id = NEW.id_producto; IF s < NEW.cantidad THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stock insuficiente'; END IF; END//
CREATE TRIGGER trg_descontar_stock AFTER INSERT ON detalle_ventas FOR EACH ROW
BEGIN UPDATE productos SET stock = stock - NEW.cantidad WHERE id = NEW.id_producto; END//
CREATE TRIGGER trg_alerta_stock_minimo AFTER UPDATE ON productos FOR EACH ROW
BEGIN IF NEW.stock <= NEW.stock_minimo AND OLD.stock > NEW.stock_minimo THEN INSERT INTO alertas_stock (id_producto, stock_actual) VALUES (NEW.id, NEW.stock); END IF; END//
DELIMITER ;

INSERT INTO productos (nombre, stock, precio) VALUES ('Auriculares Bluetooth', 15, 12000), ('Teclado Mecanico RGB', 8, 25000), ('Mouse Gamer', 3, 15000);
