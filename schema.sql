--
-- PostgreSQL database dump
--

\restrict 0u3NHS45oNQIMOfHYF5eUsu3BUPoo8W6aqYaR1nV5YL9Gv7rqCmefx5E7rEaK87

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: albumes; Type: TABLE; Schema: public; Owner: soporte
--

CREATE TABLE public.albumes (
    album_id integer NOT NULL,
    titulo character varying(50),
    "a¤o_lanzamiento" date,
    genero_musical character varying(50),
    artista_id integer
);


ALTER TABLE public.albumes OWNER TO soporte;

--
-- Name: albumes_album_id_seq; Type: SEQUENCE; Schema: public; Owner: soporte
--

CREATE SEQUENCE public.albumes_album_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.albumes_album_id_seq OWNER TO soporte;

--
-- Name: albumes_album_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: soporte
--

ALTER SEQUENCE public.albumes_album_id_seq OWNED BY public.albumes.album_id;


--
-- Name: artistas; Type: TABLE; Schema: public; Owner: soporte
--

CREATE TABLE public.artistas (
    artista_id integer NOT NULL,
    nombre_banda character varying(100)
);


ALTER TABLE public.artistas OWNER TO soporte;

--
-- Name: artistas_artista_id_seq; Type: SEQUENCE; Schema: public; Owner: soporte
--

CREATE SEQUENCE public.artistas_artista_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.artistas_artista_id_seq OWNER TO soporte;

--
-- Name: artistas_artista_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: soporte
--

ALTER SEQUENCE public.artistas_artista_id_seq OWNED BY public.artistas.artista_id;


--
-- Name: cliente; Type: TABLE; Schema: public; Owner: soporte
--

CREATE TABLE public.cliente (
    cliente_id integer NOT NULL,
    nombre character varying(20) NOT NULL,
    apellido character varying(20) NOT NULL,
    email character varying(100),
    telefono integer,
    direccion character varying(100)
);


ALTER TABLE public.cliente OWNER TO soporte;

--
-- Name: cliente_cliente_id_seq; Type: SEQUENCE; Schema: public; Owner: soporte
--

CREATE SEQUENCE public.cliente_cliente_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cliente_cliente_id_seq OWNER TO soporte;

--
-- Name: cliente_cliente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: soporte
--

ALTER SEQUENCE public.cliente_cliente_id_seq OWNED BY public.cliente.cliente_id;


--
-- Name: detallepedido; Type: TABLE; Schema: public; Owner: soporte
--

CREATE TABLE public.detallepedido (
    detalle_id integer NOT NULL,
    cantidad integer,
    precio_unitario numeric(10,2),
    subtotal numeric(10,2),
    pedido_id integer,
    producto_id integer
);


ALTER TABLE public.detallepedido OWNER TO soporte;

--
-- Name: detallepedido_detalle_id_seq; Type: SEQUENCE; Schema: public; Owner: soporte
--

CREATE SEQUENCE public.detallepedido_detalle_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.detallepedido_detalle_id_seq OWNER TO soporte;

--
-- Name: detallepedido_detalle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: soporte
--

ALTER SEQUENCE public.detallepedido_detalle_id_seq OWNED BY public.detallepedido.detalle_id;


--
-- Name: empleados; Type: TABLE; Schema: public; Owner: soporte
--

CREATE TABLE public.empleados (
    empleado_id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    puesto character varying(50) NOT NULL,
    contacto character varying(100),
    pedido_id integer
);


ALTER TABLE public.empleados OWNER TO soporte;

--
-- Name: empleados_empleado_id_seq; Type: SEQUENCE; Schema: public; Owner: soporte
--

CREATE SEQUENCE public.empleados_empleado_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.empleados_empleado_id_seq OWNER TO soporte;

--
-- Name: empleados_empleado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: soporte
--

ALTER SEQUENCE public.empleados_empleado_id_seq OWNED BY public.empleados.empleado_id;


--
-- Name: pedidos; Type: TABLE; Schema: public; Owner: soporte
--

CREATE TABLE public.pedidos (
    pedido_id integer NOT NULL,
    numero_pedido integer,
    fecha date,
    estado character varying(50),
    cliente_id integer
);


ALTER TABLE public.pedidos OWNER TO soporte;

--
-- Name: pedidos_pedido_id_seq; Type: SEQUENCE; Schema: public; Owner: soporte
--

CREATE SEQUENCE public.pedidos_pedido_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pedidos_pedido_id_seq OWNER TO soporte;

--
-- Name: pedidos_pedido_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: soporte
--

ALTER SEQUENCE public.pedidos_pedido_id_seq OWNED BY public.pedidos.pedido_id;


--
-- Name: productos; Type: TABLE; Schema: public; Owner: soporte
--

CREATE TABLE public.productos (
    titulo character varying(100),
    tipo character varying(100),
    precio numeric(10,2),
    stock integer,
    producto_id integer NOT NULL
);


ALTER TABLE public.productos OWNER TO soporte;

--
-- Name: productos_producto_id_seq; Type: SEQUENCE; Schema: public; Owner: soporte
--

CREATE SEQUENCE public.productos_producto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.productos_producto_id_seq OWNER TO soporte;

--
-- Name: productos_producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: soporte
--

ALTER SEQUENCE public.productos_producto_id_seq OWNED BY public.productos.producto_id;


--
-- Name: albumes album_id; Type: DEFAULT; Schema: public; Owner: soporte
--

ALTER TABLE ONLY public.albumes ALTER COLUMN album_id SET DEFAULT nextval('public.albumes_album_id_seq'::regclass);


--
-- Name: artistas artista_id; Type: DEFAULT; Schema: public; Owner: soporte
--

ALTER TABLE ONLY public.artistas ALTER COLUMN artista_id SET DEFAULT nextval('public.artistas_artista_id_seq'::regclass);


--
-- Name: cliente cliente_id; Type: DEFAULT; Schema: public; Owner: soporte
--

ALTER TABLE ONLY public.cliente ALTER COLUMN cliente_id SET DEFAULT nextval('public.cliente_cliente_id_seq'::regclass);


--
-- Name: detallepedido detalle_id; Type: DEFAULT; Schema: public; Owner: soporte
--

ALTER TABLE ONLY public.detallepedido ALTER COLUMN detalle_id SET DEFAULT nextval('public.detallepedido_detalle_id_seq'::regclass);


--
-- Name: empleados empleado_id; Type: DEFAULT; Schema: public; Owner: soporte
--

ALTER TABLE ONLY public.empleados ALTER COLUMN empleado_id SET DEFAULT nextval('public.empleados_empleado_id_seq'::regclass);


--
-- Name: pedidos pedido_id; Type: DEFAULT; Schema: public; Owner: soporte
--

ALTER TABLE ONLY public.pedidos ALTER COLUMN pedido_id SET DEFAULT nextval('public.pedidos_pedido_id_seq'::regclass);


--
-- Name: productos producto_id; Type: DEFAULT; Schema: public; Owner: soporte
--

ALTER TABLE ONLY public.productos ALTER COLUMN producto_id SET DEFAULT nextval('public.productos_producto_id_seq'::regclass);


--
-- Name: albumes albumes_pkey; Type: CONSTRAINT; Schema: public; Owner: soporte
--

ALTER TABLE ONLY public.albumes
    ADD CONSTRAINT albumes_pkey PRIMARY KEY (album_id);


--
-- Name: artistas artistas_pkey; Type: CONSTRAINT; Schema: public; Owner: soporte
--

ALTER TABLE ONLY public.artistas
    ADD CONSTRAINT artistas_pkey PRIMARY KEY (artista_id);


--
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: soporte
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (cliente_id);


--
-- Name: detallepedido detallepedido_pkey; Type: CONSTRAINT; Schema: public; Owner: soporte
--

ALTER TABLE ONLY public.detallepedido
    ADD CONSTRAINT detallepedido_pkey PRIMARY KEY (detalle_id);


--
-- Name: empleados empleados_pkey; Type: CONSTRAINT; Schema: public; Owner: soporte
--

ALTER TABLE ONLY public.empleados
    ADD CONSTRAINT empleados_pkey PRIMARY KEY (empleado_id);


--
-- Name: pedidos pedidos_pkey; Type: CONSTRAINT; Schema: public; Owner: soporte
--

ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_pkey PRIMARY KEY (pedido_id);


--
-- Name: productos productos_pkey; Type: CONSTRAINT; Schema: public; Owner: soporte
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (producto_id);


--
-- Name: albumes albumes_artista_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: soporte
--

ALTER TABLE ONLY public.albumes
    ADD CONSTRAINT albumes_artista_id_fkey FOREIGN KEY (artista_id) REFERENCES public.artistas(artista_id);


--
-- Name: detallepedido detallepedido_pedido_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: soporte
--

ALTER TABLE ONLY public.detallepedido
    ADD CONSTRAINT detallepedido_pedido_id_fkey FOREIGN KEY (pedido_id) REFERENCES public.pedidos(pedido_id);


--
-- Name: detallepedido detallepedido_producto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: soporte
--

ALTER TABLE ONLY public.detallepedido
    ADD CONSTRAINT detallepedido_producto_id_fkey FOREIGN KEY (producto_id) REFERENCES public.productos(producto_id);


--
-- Name: empleados empleados_pedido_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: soporte
--

ALTER TABLE ONLY public.empleados
    ADD CONSTRAINT empleados_pedido_id_fkey FOREIGN KEY (pedido_id) REFERENCES public.pedidos(pedido_id);


--
-- Name: pedidos pedidos_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: soporte
--

ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.cliente(cliente_id);


--
-- PostgreSQL database dump complete
--

\unrestrict 0u3NHS45oNQIMOfHYF5eUsu3BUPoo8W6aqYaR1nV5YL9Gv7rqCmefx5E7rEaK87

