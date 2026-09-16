# Tienda de Electrónicos - DB MariaDB

Sistema de gestión de stock y ventas para tienda de electrónicos, desarrollado en MariaDB (GPL v2).

### Problema que resuelve
Evita vender productos sin stock y avisa automáticamente antes de quedarte sin inventario. Ideal para tiendas que manejan productos de alta rotación.

### Funcionalidades
- **Validación automática:** No permite registrar una venta si no hay stock suficiente.
- **Descuento automático:** Al vender, descuenta el stock sin intervención manual.
- **Alerta de stock mínimo:** Cuando un producto llega a 4 unidades o menos, genera un registro en `alertas_stock`.

### Estructura
- `productos` / `ventas` / `detalle_ventas` / `alertas_stock`
- 3 Triggers: `trg_validar_stock`, `trg_descontar_stock`, `trg_alerta_stock_minimo`

### Cómo probarlo
```bash
mysql -u root -p < tienda_electronicos_triggers.sql
