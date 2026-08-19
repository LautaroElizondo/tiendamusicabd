--
-- Esquema mejorado (basado en el dump original)
-- Cambios principales: encoding corregido, NOT NULL, CHECK, UNIQUE,
-- índices en FKs, subtotal calculado, timestamps de auditoría.
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET row_security = off;
SET default_tablespace = '';
SET default_table_access_method = heap;

-- =========================================================
-- ARTISTAS
-- =========================================================
CREATE TABLE public.artistas (
    artista_id      integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_banda    character varying(100) NOT NULL,
    created_at      timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.artistas OWNER TO soporte;

-- =========================================================
-- ALBUMES
-- =========================================================
CREATE TABLE public.albumes (
    album_id            integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    titulo              character varying(50) NOT NULL,
    anio_lanzamiento    date,                       -- nombre corregido (encoding)
    genero_musical      character varying(50),
    artista_id          integer NOT NULL
        REFERENCES public.artistas(artista_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    created_at          timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX idx_albumes_artista_id ON public.albumes(artista_id);

ALTER TABLE public.albumes OWNER TO soporte;

-- =========================================================
-- CLIENTE
-- =========================================================
CREATE TABLE public.cliente (
    cliente_id      integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre          character varying(50) NOT NULL,   -- 20 quedaba corto para nombres largos
    apellido        character varying(50) NOT NULL,
    email           character varying(100) NOT NULL UNIQUE,
    telefono        character varying(20),            -- varchar, no integer (pierde +54, 0, guiones)
    direccion       character varying(150),
    created_at      timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.cliente OWNER TO soporte;

-- =========================================================
-- PRODUCTOS
-- =========================================================
CREATE TABLE public.productos (
    producto_id     integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    titulo          character varying(100) NOT NULL,
    tipo            character varying(100),
    precio          numeric(10,2) NOT NULL CHECK (precio >= 0),
    stock           integer NOT NULL DEFAULT 0 CHECK (stock >= 0),
    created_at      timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.productos OWNER TO soporte;

-- =========================================================
-- PEDIDOS
-- =========================================================
CREATE TABLE public.pedidos (
    pedido_id       integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    numero_pedido   integer NOT NULL UNIQUE,
    fecha           date NOT NULL DEFAULT CURRENT_DATE,
    estado          character varying(50) NOT NULL DEFAULT 'pendiente'
        CHECK (estado IN ('pendiente','procesando','enviado','entregado','cancelado')),
    cliente_id      integer NOT NULL
        REFERENCES public.cliente(cliente_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    created_at      timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX idx_pedidos_cliente_id ON public.pedidos(cliente_id);

ALTER TABLE public.pedidos OWNER TO soporte;

-- =========================================================
-- DETALLE PEDIDO
-- =========================================================
CREATE TABLE public.detallepedido (
    detalle_id          integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    cantidad            integer NOT NULL CHECK (cantidad > 0),
    precio_unitario     numeric(10,2) NOT NULL CHECK (precio_unitario >= 0),
    -- subtotal calculado: nunca queda desincronizado con cantidad/precio
    subtotal            numeric(12,2) GENERATED ALWAYS AS (cantidad * precio_unitario) STORED,
    pedido_id           integer NOT NULL
        REFERENCES public.pedidos(pedido_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    producto_id         integer NOT NULL
        REFERENCES public.productos(producto_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE INDEX idx_detallepedido_pedido_id ON public.detallepedido(pedido_id);
CREATE INDEX idx_detallepedido_producto_id ON public.detallepedido(producto_id);

ALTER TABLE public.detallepedido OWNER TO soporte;

-- =========================================================
-- EMPLEADOS
-- =========================================================
-- Nota de diseño: en el original, empleados.pedido_id ataba
-- a UN empleado a UN SOLO pedido para siempre, lo cual no
-- tiene sentido de negocio (un empleado atiende muchos pedidos
-- a lo largo del tiempo). La FK correcta va del lado de "quién
-- atendió qué pedido", así que la muevo a una tabla puente.

CREATE TABLE public.empleados (
    empleado_id     integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre          character varying(100) NOT NULL,
    puesto          character varying(50) NOT NULL,
    contacto        character varying(100),
    created_at      timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.empleados OWNER TO soporte;

CREATE TABLE public.pedido_empleado (
    pedido_id       integer NOT NULL
        REFERENCES public.pedidos(pedido_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    empleado_id     integer NOT NULL
        REFERENCES public.empleados(empleado_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    PRIMARY KEY (pedido_id, empleado_id)
);

ALTER TABLE public.pedido_empleado OWNER TO soporte;
