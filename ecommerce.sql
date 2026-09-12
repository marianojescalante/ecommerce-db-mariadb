-- Proyecto E-commerce Completo - MariaDB
-- Autor: marianojescalante
-- Descripcion: Sistema de gestion con productos, clientes, pedidos, pagos, NC y RC

CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- 1. Productos
CREATE TABLE productos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DECIMAL(10,2) NOT NULL,
  stock INT DEFAULT 0,
  fecha_alta DATE DEFAULT (CURDATE())
);

-- 2. Clientes
CREATE TABLE clientes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE,
  saldo DECIMAL(10,2) DEFAULT 0
);

-- 3. Pedidos / Facturas
CREATE TABLE pedidos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT NOT NULL,
  fecha DATE DEFAULT (CURDATE()),
  total DECIMAL(10,2) NOT NULL,
  estado VARCHAR(20) DEFAULT 'PENDIENTE',
  FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- 4. Detalle del pedido
CREATE TABLE detalle_pedidos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  pedido_id INT NOT NULL,
  producto_id INT NOT NULL,
  cantidad INT NOT NULL,
  precio_unitario DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
  FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- 5. Pagos / Recibos (RC)
CREATE TABLE pagos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT NOT NULL,
  pedido_id INT,
  monto DECIMAL(10,2) NOT NULL,
  tipo VARCHAR(20) DEFAULT 'RC',
  fecha DATE DEFAULT (CURDATE()),
  FOREIGN KEY (cliente_id) REFERENCES clientes(id),
  FOREIGN KEY (pedido_id) REFERENCES pedidos(id)
);

-- 6. Notas de Credito (NC)
CREATE TABLE notas_credito (
  id INT AUTO_INCREMENT PRIMARY KEY,
  pedido_id INT NOT NULL,
  motivo VARCHAR(255),
  monto DECIMAL(10,2) NOT NULL,
  fecha DATE DEFAULT (CURDATE()),
  FOREIGN KEY (pedido_id) REFERENCES pedidos(id)
);

-- DATOS DE PRUEBA
INSERT INTO productos (nombre, precio, stock) VALUES 
('Notebook Gamer', 1500.00, 5), 
('Mouse Logitech', 30.00, 50), 
('Teclado Mecanico', 80.00, 20);

INSERT INTO clientes (nombre, email) VALUES 
('Mariano Escalante', 'mariano@test.com');
