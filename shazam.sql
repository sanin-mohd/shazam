--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0
-- Dumped by pg_dump version 14.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: auth_group; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO admin;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO admin;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO admin;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO admin;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO admin;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO admin;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: banners_banner; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.banners_banner (
    id integer NOT NULL,
    name character varying(250) NOT NULL,
    poster character varying(100) NOT NULL,
    status character varying(20) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    vendor_id integer NOT NULL,
    vehicle_id integer
);


ALTER TABLE public.banners_banner OWNER TO admin;

--
-- Name: banners_banner_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.banners_banner_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.banners_banner_id_seq OWNER TO admin;

--
-- Name: banners_banner_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.banners_banner_id_seq OWNED BY public.banners_banner.id;


--
-- Name: cart_cart; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.cart_cart (
    id integer NOT NULL,
    cart_id character varying(250) NOT NULL,
    date_added timestamp with time zone NOT NULL
);


ALTER TABLE public.cart_cart OWNER TO admin;

--
-- Name: cart_cart_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.cart_cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cart_cart_id_seq OWNER TO admin;

--
-- Name: cart_cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.cart_cart_id_seq OWNED BY public.cart_cart.id;


--
-- Name: cart_cartitem; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.cart_cartitem (
    id integer NOT NULL,
    quantity integer NOT NULL,
    is_active boolean NOT NULL,
    cart_id_id integer,
    variant_id integer NOT NULL,
    user_id integer
);


ALTER TABLE public.cart_cartitem OWNER TO admin;

--
-- Name: cart_cartitem_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.cart_cartitem_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cart_cartitem_id_seq OWNER TO admin;

--
-- Name: cart_cartitem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.cart_cartitem_id_seq OWNED BY public.cart_cartitem.id;


--
-- Name: category_category; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.category_category (
    id integer NOT NULL,
    category_name character varying(50) NOT NULL,
    slug character varying(100) NOT NULL,
    gif character varying(1000) NOT NULL
);


ALTER TABLE public.category_category OWNER TO admin;

--
-- Name: category_category_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.category_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_category_id_seq OWNER TO admin;

--
-- Name: category_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.category_category_id_seq OWNED BY public.category_category.id;


--
-- Name: coupons_coupon; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.coupons_coupon (
    id uuid NOT NULL,
    code character varying(10) NOT NULL,
    discount integer NOT NULL,
    is_active boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    CONSTRAINT coupons_coupon_discount_check CHECK ((discount >= 0))
);


ALTER TABLE public.coupons_coupon OWNER TO admin;

--
-- Name: coupons_redeemedcoupon; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.coupons_redeemedcoupon (
    id integer NOT NULL,
    coupon_id uuid NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.coupons_redeemedcoupon OWNER TO admin;

--
-- Name: coupons_redeemedcoupon_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.coupons_redeemedcoupon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.coupons_redeemedcoupon_id_seq OWNER TO admin;

--
-- Name: coupons_redeemedcoupon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.coupons_redeemedcoupon_id_seq OWNED BY public.coupons_redeemedcoupon.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO admin;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO admin;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO admin;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO admin;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO admin;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO admin;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO admin;

--
-- Name: offers_vehicleoffer; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.offers_vehicleoffer (
    id uuid NOT NULL,
    discount integer NOT NULL,
    is_active boolean NOT NULL,
    vehicle_id integer NOT NULL,
    vendor_id integer,
    CONSTRAINT offers_vehicleoffer_discount_cc727563_check CHECK ((discount >= 0))
);


ALTER TABLE public.offers_vehicleoffer OWNER TO admin;

--
-- Name: orders_order; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.orders_order (
    id integer NOT NULL,
    full_name character varying(50) NOT NULL,
    address_line_1 character varying(50) NOT NULL,
    country character varying(50) NOT NULL,
    city character varying(50) NOT NULL,
    zip_code bigint NOT NULL,
    mobile bigint NOT NULL,
    landmark character varying(50) NOT NULL,
    address_line_2 character varying(50) NOT NULL,
    order_number character varying(20) NOT NULL,
    order_total double precision NOT NULL,
    tax double precision NOT NULL,
    status character varying(100) NOT NULL,
    ip character varying(20) NOT NULL,
    is_ordered boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    payment_id integer,
    user_id integer,
    state character varying(50),
    payment_option character varying(10),
    pending_amount bigint NOT NULL,
    discount_price double precision NOT NULL
);


ALTER TABLE public.orders_order OWNER TO admin;

--
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_order_id_seq OWNER TO admin;

--
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders_order.id;


--
-- Name: orders_ordervehicle; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.orders_ordervehicle (
    id integer NOT NULL,
    ordered boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    order_id integer NOT NULL,
    payment_id integer,
    user_id integer NOT NULL,
    variant_id integer NOT NULL,
    vehicle_id integer NOT NULL,
    price double precision NOT NULL,
    quantity integer NOT NULL,
    paid double precision NOT NULL,
    vendor_id integer NOT NULL,
    status character varying(100) NOT NULL
);


ALTER TABLE public.orders_ordervehicle OWNER TO admin;

--
-- Name: orders_ordervehicle_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.orders_ordervehicle_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_ordervehicle_id_seq OWNER TO admin;

--
-- Name: orders_ordervehicle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.orders_ordervehicle_id_seq OWNED BY public.orders_ordervehicle.id;


--
-- Name: orders_payments; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.orders_payments (
    id integer NOT NULL,
    payment_id character varying(100) NOT NULL,
    payment_method character varying(100) NOT NULL,
    amount_paid character varying(100) NOT NULL,
    status character varying(100) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.orders_payments OWNER TO admin;

--
-- Name: orders_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.orders_payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_payments_id_seq OWNER TO admin;

--
-- Name: orders_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.orders_payments_id_seq OWNED BY public.orders_payments.id;


--
-- Name: showroom_reviewrating; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.showroom_reviewrating (
    id integer NOT NULL,
    subject character varying(200) NOT NULL,
    review text NOT NULL,
    rating double precision NOT NULL,
    ip character varying(20) NOT NULL,
    status boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    user_id integer NOT NULL,
    vehicle_id integer NOT NULL
);


ALTER TABLE public.showroom_reviewrating OWNER TO admin;

--
-- Name: showroom_reviewrating_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.showroom_reviewrating_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.showroom_reviewrating_id_seq OWNER TO admin;

--
-- Name: showroom_reviewrating_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.showroom_reviewrating_id_seq OWNED BY public.showroom_reviewrating.id;


--
-- Name: showroom_variant; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.showroom_variant (
    id integer NOT NULL,
    color character varying(18) NOT NULL,
    color_name character varying(100) NOT NULL,
    slug character varying(200) NOT NULL,
    image1 character varying(100) NOT NULL,
    image2 character varying(100) NOT NULL,
    image3 character varying(100) NOT NULL,
    price integer NOT NULL,
    remaining integer NOT NULL,
    vehicle_id_id integer NOT NULL,
    is_available boolean NOT NULL
);


ALTER TABLE public.showroom_variant OWNER TO admin;

--
-- Name: showroom_variant_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.showroom_variant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.showroom_variant_id_seq OWNER TO admin;

--
-- Name: showroom_variant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.showroom_variant_id_seq OWNED BY public.showroom_variant.id;


--
-- Name: showroom_vehicle; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.showroom_vehicle (
    id integer NOT NULL,
    vehicle_name character varying(200) NOT NULL,
    slug character varying(200) NOT NULL,
    range integer NOT NULL,
    top_speed integer NOT NULL,
    created_date timestamp with time zone NOT NULL,
    modified_date timestamp with time zone NOT NULL,
    category_id integer NOT NULL,
    gif character varying(200) NOT NULL,
    no_of_seats integer NOT NULL,
    vendor_id_id integer NOT NULL,
    is_available boolean NOT NULL
);


ALTER TABLE public.showroom_vehicle OWNER TO admin;

--
-- Name: showroom_vehicle_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.showroom_vehicle_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.showroom_vehicle_id_seq OWNER TO admin;

--
-- Name: showroom_vehicle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.showroom_vehicle_id_seq OWNED BY public.showroom_vehicle.id;


--
-- Name: superadmin_bookingprice; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.superadmin_bookingprice (
    id integer NOT NULL,
    booking_price integer NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.superadmin_bookingprice OWNER TO admin;

--
-- Name: superadmin_bookingprice_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.superadmin_bookingprice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.superadmin_bookingprice_id_seq OWNER TO admin;

--
-- Name: superadmin_bookingprice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.superadmin_bookingprice_id_seq OWNED BY public.superadmin_bookingprice.id;


--
-- Name: user_account; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_account (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    mobile character varying(10),
    gender character varying(10),
    dp character varying(100) NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    last_login timestamp with time zone NOT NULL,
    is_admin boolean NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    is_verified boolean NOT NULL,
    is_superadmin boolean NOT NULL,
    otp_verified boolean NOT NULL
);


ALTER TABLE public.user_account OWNER TO admin;

--
-- Name: user_account_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.user_account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_account_id_seq OWNER TO admin;

--
-- Name: user_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.user_account_id_seq OWNED BY public.user_account.id;


--
-- Name: user_address; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_address (
    id uuid NOT NULL,
    full_name character varying(100) NOT NULL,
    address_line_1 character varying(100) NOT NULL,
    address_line_2 character varying(100) NOT NULL,
    city character varying(100) NOT NULL,
    zip_code bigint NOT NULL,
    state character varying(50),
    country character varying(50) NOT NULL,
    mobile bigint NOT NULL,
    landmark character varying(50) NOT NULL,
    "default" boolean NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.user_address OWNER TO admin;

--
-- Name: vendor_vendor; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.vendor_vendor (
    id integer NOT NULL,
    vendor_name character varying(50) NOT NULL,
    "GST_number" character varying(8) NOT NULL,
    email character varying(100) NOT NULL,
    mobile character varying(10) NOT NULL,
    logo character varying(100) NOT NULL,
    password character varying(20) NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    last_login timestamp with time zone NOT NULL,
    is_admin boolean NOT NULL,
    is_staff boolean NOT NULL,
    is_verified boolean NOT NULL,
    is_active boolean NOT NULL,
    is_superadmin boolean NOT NULL,
    is_mobile_verified boolean NOT NULL
);


ALTER TABLE public.vendor_vendor OWNER TO admin;

--
-- Name: vendor_vendor_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.vendor_vendor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vendor_vendor_id_seq OWNER TO admin;

--
-- Name: vendor_vendor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.vendor_vendor_id_seq OWNED BY public.vendor_vendor.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: banners_banner id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.banners_banner ALTER COLUMN id SET DEFAULT nextval('public.banners_banner_id_seq'::regclass);


--
-- Name: cart_cart id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.cart_cart ALTER COLUMN id SET DEFAULT nextval('public.cart_cart_id_seq'::regclass);


--
-- Name: cart_cartitem id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.cart_cartitem ALTER COLUMN id SET DEFAULT nextval('public.cart_cartitem_id_seq'::regclass);


--
-- Name: category_category id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.category_category ALTER COLUMN id SET DEFAULT nextval('public.category_category_id_seq'::regclass);


--
-- Name: coupons_redeemedcoupon id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.coupons_redeemedcoupon ALTER COLUMN id SET DEFAULT nextval('public.coupons_redeemedcoupon_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: orders_order id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.orders_order ALTER COLUMN id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- Name: orders_ordervehicle id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.orders_ordervehicle ALTER COLUMN id SET DEFAULT nextval('public.orders_ordervehicle_id_seq'::regclass);


--
-- Name: orders_payments id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.orders_payments ALTER COLUMN id SET DEFAULT nextval('public.orders_payments_id_seq'::regclass);


--
-- Name: showroom_reviewrating id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.showroom_reviewrating ALTER COLUMN id SET DEFAULT nextval('public.showroom_reviewrating_id_seq'::regclass);


--
-- Name: showroom_variant id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.showroom_variant ALTER COLUMN id SET DEFAULT nextval('public.showroom_variant_id_seq'::regclass);


--
-- Name: showroom_vehicle id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.showroom_vehicle ALTER COLUMN id SET DEFAULT nextval('public.showroom_vehicle_id_seq'::regclass);


--
-- Name: superadmin_bookingprice id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.superadmin_bookingprice ALTER COLUMN id SET DEFAULT nextval('public.superadmin_bookingprice_id_seq'::regclass);


--
-- Name: user_account id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_account ALTER COLUMN id SET DEFAULT nextval('public.user_account_id_seq'::regclass);


--
-- Name: vendor_vendor id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.vendor_vendor ALTER COLUMN id SET DEFAULT nextval('public.vendor_vendor_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add account	6	add_account
22	Can change account	6	change_account
23	Can delete account	6	delete_account
24	Can view account	6	view_account
25	Can add Category	7	add_category
26	Can change Category	7	change_category
27	Can delete Category	7	delete_category
28	Can view Category	7	view_category
29	Can add vendor	8	add_vendor
30	Can change vendor	8	change_vendor
31	Can delete vendor	8	delete_vendor
32	Can view vendor	8	view_vendor
33	Can add vehicle	9	add_vehicle
34	Can change vehicle	9	change_vehicle
35	Can delete vehicle	9	delete_vehicle
36	Can view vehicle	9	view_vehicle
37	Can add variant	10	add_variant
38	Can change variant	10	change_variant
39	Can delete variant	10	delete_variant
40	Can view variant	10	view_variant
41	Can add cart	11	add_cart
42	Can change cart	11	change_cart
43	Can delete cart	11	delete_cart
44	Can view cart	11	view_cart
45	Can add cart item	12	add_cartitem
46	Can change cart item	12	change_cartitem
47	Can delete cart item	12	delete_cartitem
48	Can view cart item	12	view_cartitem
49	Can add order	13	add_order
50	Can change order	13	change_order
51	Can delete order	13	delete_order
52	Can view order	13	view_order
53	Can add payments	14	add_payments
54	Can change payments	14	change_payments
55	Can delete payments	14	delete_payments
56	Can view payments	14	view_payments
57	Can add order vehicle	15	add_ordervehicle
58	Can change order vehicle	15	change_ordervehicle
59	Can delete order vehicle	15	delete_ordervehicle
60	Can view order vehicle	15	view_ordervehicle
61	Can add banner	16	add_banner
62	Can change banner	16	change_banner
63	Can delete banner	16	delete_banner
64	Can view banner	16	view_banner
65	Can add vehicle offer	17	add_vehicleoffer
66	Can change vehicle offer	17	change_vehicleoffer
67	Can delete vehicle offer	17	delete_vehicleoffer
68	Can view vehicle offer	17	view_vehicleoffer
69	Can add review rating	18	add_reviewrating
70	Can change review rating	18	change_reviewrating
71	Can delete review rating	18	delete_reviewrating
72	Can view review rating	18	view_reviewrating
73	Can add Address	19	add_address
74	Can change Address	19	change_address
75	Can delete Address	19	delete_address
76	Can view Address	19	view_address
77	Can add coupon	20	add_coupon
78	Can change coupon	20	change_coupon
79	Can delete coupon	20	delete_coupon
80	Can view coupon	20	view_coupon
81	Can add redeemed coupon	21	add_redeemedcoupon
82	Can change redeemed coupon	21	change_redeemedcoupon
83	Can delete redeemed coupon	21	delete_redeemedcoupon
84	Can view redeemed coupon	21	view_redeemedcoupon
85	Can add booking price	22	add_bookingprice
86	Can change booking price	22	change_bookingprice
87	Can delete booking price	22	delete_bookingprice
88	Can view booking price	22	view_bookingprice
\.


--
-- Data for Name: banners_banner; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.banners_banner (id, name, poster, status, created_at, vendor_id, vehicle_id) FROM stdin;
16	ford	photos/banners/kisspng-ford-motor-company-logo-ford-aerospace-aeronutroni-aerospace-engi_TmJV7qt.png	Active	2021-12-10 14:21:48.171+00	3	11
18	Mustag offer	photos/banners/Capturesa_M8rvSBK.PNG	Active	2021-12-10 14:26:03.517+00	3	4
\.


--
-- Data for Name: cart_cart; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.cart_cart (id, cart_id, date_added) FROM stdin;
92	a9vp8ws5d5lswccm1c0r9w5l8m7v8ma7	2021-12-03 07:36:39.894+00
93	ocrhnca2h3vuch9ugsxy4kwfz0k1tsay	2021-12-03 09:20:53.323+00
94	9heo55atzkcyrqgt1f32art0wpyujl2z	2021-12-10 08:16:18.338+00
\.


--
-- Data for Name: cart_cartitem; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.cart_cartitem (id, quantity, is_active, cart_id_id, variant_id, user_id) FROM stdin;
\.


--
-- Data for Name: category_category; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.category_category (id, category_name, slug, gif) FROM stdin;
1	Coupe	coupe	https://c.tenor.com/O3-NZGdihtAAAAAd/jaguar-cars-jaguar-ftype.gif
2	Sport	sport	https://i.pinimg.com/originals/dd/82/da/dd82da996075fc8bba22a26b0b176974.gif
3	SUV	suv	https://c.tenor.com/dodPeBaeR2AAAAAd/volvo-luxury.gif
11	Muscle car	muscle-car	https://c.tenor.com/zKUOp5y0ZX4AAAAC/srt-dodge.gif
12	Scooter	scooter	https://imgk.timesnownews.com/story/ola_elec_front_hq.jpg?tr=w-400,h-300,fo-auto
\.


--
-- Data for Name: coupons_coupon; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.coupons_coupon (id, code, discount, is_active, created_at) FROM stdin;
6928c038-d365-4497-9d26-e9991bb97594	HAPPY02	2	t	2021-12-04 06:47:32.348+00
fed9704e-e8c1-424f-8f5f-250d04c18a18	NEWYEAR03	3	t	2021-12-03 03:17:26.519+00
\.


--
-- Data for Name: coupons_redeemedcoupon; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.coupons_redeemedcoupon (id, coupon_id, user_id) FROM stdin;
14	fed9704e-e8c1-424f-8f5f-250d04c18a18	11
15	6928c038-d365-4497-9d26-e9991bb97594	11
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2021-11-15 16:37:15.075+00	1	Coupe	1	[{"added": {}}]	7	1
2	2021-11-15 16:41:41.244+00	2	Sport	1	[{"added": {}}]	7	1
3	2021-11-15 17:06:54.632+00	3	SUV	1	[{"added": {}}]	7	1
4	2021-11-16 09:13:19.227+00	4	RFRE	3		7	1
5	2021-11-16 09:57:40.262+00	5	Sedan	3		7	1
6	2021-11-16 10:52:06.627+00	1	OLA	2	[{"changed": {"fields": ["Password", "Is verified"]}}]	8	1
7	2021-11-16 12:59:26.682+00	3	eqwde@gmail.com	1	[{"added": {}}]	6	1
8	2021-11-16 14:59:15.25+00	1	MG Hector	1	[{"added": {}}]	9	1
9	2021-11-16 15:00:04.394+00	1	#57F9FF	1	[{"added": {}}]	10	1
10	2021-11-16 15:02:53.877+00	2	#FF0000	1	[{"added": {}}]	10	1
11	2021-11-16 15:20:25.846+00	2	R!5	1	[{"added": {}}]	9	1
12	2021-11-16 16:51:27.133+00	4	sanin@gmail.com	3		6	1
13	2021-11-16 17:11:20.953+00	1	OLA	2	[]	8	1
14	2021-11-16 17:25:01.865+00	2	R!5	3		9	1
15	2021-11-16 17:25:01.868+00	1	MG Hector	3		9	1
16	2021-11-17 12:57:37.598+00	3	#00FFD2	1	[{"added": {}}]	10	1
17	2021-11-17 15:01:11.497+00	8	Scooter	1	[{"added": {}}]	7	1
18	2021-11-17 16:41:32.903+00	4	#FF0000	1	[{"added": {}}]	10	1
19	2021-11-18 11:10:51.481+00	7	#1ff0ff	3		10	1
20	2021-11-18 11:10:57.85+00	3	#00ffd2	3		10	1
21	2021-11-18 12:23:18.177+00	5	#021112	3		10	1
22	2021-11-18 14:04:27.357+00	3	S1 Pro	3		9	1
23	2021-11-18 14:12:59.696+00	2	Mustag	3		9	1
24	2021-11-18 14:20:46.185+00	1	S1 Pro	1	[{"added": {}}]	9	1
25	2021-11-18 14:23:17.551+00	1	OLA	2	[{"changed": {"fields": ["Mobile"]}}]	8	1
26	2021-11-18 14:25:23.079+00	2	Tata Motors	2	[{"changed": {"fields": ["Password", "Is verified"]}}]	8	1
27	2021-11-19 02:49:06.046+00	2	Tata Motors	2	[{"changed": {"fields": ["Mobile"]}}]	8	1
28	2021-11-19 02:51:42.04+00	3	Ford Motors	2	[{"changed": {"fields": ["Is verified"]}}]	8	1
29	2021-11-20 15:26:50.094+00	12	#000000	2	[{"changed": {"fields": ["Color name", "Slug", "Price"]}}]	10	1
30	2021-11-20 15:27:07.107+00	11	#FF0000	2	[{"changed": {"fields": ["Color", "Color name", "Slug"]}}]	10	1
31	2021-11-21 05:24:04.298+00	3	Ford Motors	2	[{"changed": {"fields": ["Mobile"]}}]	8	1
32	2021-11-21 05:48:21.439+00	8	Scooter	3		7	1
33	2021-11-21 05:49:06.007+00	9	Mini	2	[{"changed": {"fields": ["Category name"]}}]	7	1
34	2021-11-22 09:29:30.959+00	6	sanin.fun@gmail.com	2	[{"changed": {"fields": ["Email"]}}]	6	1
35	2021-11-23 05:45:36.367+00	28	1	2	[{"changed": {"fields": ["Cart id"]}}]	11	1
36	2021-11-23 05:49:49.709+00	28	Cart object (28)	3		11	1
37	2021-11-23 05:50:22.565+00	31	CartItem object (31)	3		12	1
38	2021-11-23 05:50:22.58+00	30	CartItem object (30)	3		12	1
39	2021-11-23 05:50:22.583+00	29	CartItem object (29)	3		12	1
40	2021-11-23 05:50:22.587+00	27	CartItem object (27)	3		12	1
41	2021-11-23 05:50:22.59+00	26	CartItem object (26)	3		12	1
42	2021-11-23 05:50:22.595+00	25	CartItem object (25)	3		12	1
43	2021-11-23 05:50:22.598+00	24	CartItem object (24)	3		12	1
44	2021-11-23 05:50:22.602+00	23	CartItem object (23)	3		12	1
45	2021-11-23 05:50:22.607+00	22	CartItem object (22)	3		12	1
46	2021-11-23 05:50:22.612+00	21	CartItem object (21)	3		12	1
47	2021-11-23 05:50:22.619+00	20	CartItem object (20)	3		12	1
48	2021-11-23 05:50:22.625+00	19	CartItem object (19)	3		12	1
49	2021-11-23 05:50:22.63+00	18	CartItem object (18)	3		12	1
50	2021-11-23 05:50:22.637+00	17	CartItem object (17)	3		12	1
51	2021-11-23 05:50:22.644+00	16	CartItem object (16)	3		12	1
52	2021-11-23 05:50:22.649+00	15	CartItem object (15)	3		12	1
53	2021-11-23 05:50:22.655+00	14	CartItem object (14)	3		12	1
54	2021-11-23 05:50:22.661+00	12	CartItem object (12)	3		12	1
55	2021-11-23 05:50:22.667+00	9	CartItem object (9)	3		12	1
56	2021-11-23 05:50:22.673+00	6	CartItem object (6)	3		12	1
57	2021-11-23 05:50:22.679+00	3	CartItem object (3)	3		12	1
58	2021-11-23 05:50:22.685+00	2	CartItem object (2)	3		12	1
59	2021-11-23 05:50:22.69+00	1	CartItem object (1)	3		12	1
60	2021-11-23 05:50:29.543+00	27	Cart object (27)	3		11	1
61	2021-11-23 05:50:29.559+00	26	Cart object (26)	3		11	1
62	2021-11-23 05:50:29.562+00	25	Cart object (25)	3		11	1
63	2021-11-23 05:50:29.566+00	24	Cart object (24)	3		11	1
64	2021-11-23 05:50:29.57+00	23	Cart object (23)	3		11	1
65	2021-11-23 05:50:29.574+00	22	Cart object (22)	3		11	1
66	2021-11-23 05:50:29.578+00	21	Cart object (21)	3		11	1
67	2021-11-23 05:50:29.582+00	20	Cart object (20)	3		11	1
68	2021-11-23 05:50:29.586+00	19	Cart object (19)	3		11	1
69	2021-11-23 05:50:29.591+00	18	Cart object (18)	3		11	1
70	2021-11-23 05:50:29.597+00	17	Cart object (17)	3		11	1
71	2021-11-23 05:50:29.603+00	16	Cart object (16)	3		11	1
72	2021-11-23 05:50:29.61+00	15	Cart object (15)	3		11	1
73	2021-11-23 05:50:29.617+00	14	Cart object (14)	3		11	1
74	2021-11-23 05:50:29.623+00	13	Cart object (13)	3		11	1
75	2021-11-23 05:50:29.629+00	12	Cart object (12)	3		11	1
76	2021-11-23 05:50:29.635+00	11	Cart object (11)	3		11	1
77	2021-11-23 05:50:29.641+00	10	Cart object (10)	3		11	1
78	2021-11-23 05:50:29.647+00	9	Cart object (9)	3		11	1
79	2021-11-23 05:50:29.652+00	8	Cart object (8)	3		11	1
80	2021-11-23 05:50:29.659+00	7	Cart object (7)	3		11	1
81	2021-11-23 05:50:29.664+00	6	Cart object (6)	3		11	1
82	2021-11-23 05:50:29.67+00	5	Cart object (5)	3		11	1
83	2021-11-23 05:50:29.675+00	4	Cart object (4)	3		11	1
84	2021-11-23 05:50:29.681+00	3	Cart object (3)	3		11	1
85	2021-11-23 05:50:29.685+00	2	Cart object (2)	3		11	1
86	2021-11-23 05:50:29.689+00	1	Cart object (1)	3		11	1
87	2021-11-23 05:58:44.92+00	34	CartItem object (34)	3		12	1
88	2021-11-23 05:58:44.935+00	33	CartItem object (33)	3		12	1
89	2021-11-23 05:58:55.712+00	30	Cart object (30)	3		11	1
90	2021-11-23 05:58:55.726+00	29	Cart object (29)	3		11	1
91	2021-11-23 07:03:36.561+00	38	Cart object (38)	3		11	1
92	2021-11-23 07:03:36.579+00	37	Cart object (37)	3		11	1
93	2021-11-23 07:03:36.589+00	36	Cart object (36)	3		11	1
94	2021-11-23 07:03:36.602+00	35	Cart object (35)	3		11	1
95	2021-11-23 07:03:36.618+00	34	Cart object (34)	3		11	1
96	2021-11-23 07:03:36.633+00	33	Cart object (33)	3		11	1
97	2021-11-23 07:03:36.653+00	32	Cart object (32)	3		11	1
98	2021-11-23 07:03:36.668+00	31	Cart object (31)	3		11	1
99	2021-11-23 10:38:08.768+00	43	Cart object (43)	3		11	1
100	2021-11-23 10:38:08.774+00	42	Cart object (42)	3		11	1
101	2021-11-23 10:38:08.783+00	41	Cart object (41)	3		11	1
102	2021-11-23 10:38:08.793+00	40	Cart object (40)	3		11	1
103	2021-11-23 10:38:08.805+00	39	Cart object (39)	3		11	1
104	2021-11-23 10:49:33.617+00	51	Cart object (51)	3		11	1
105	2021-11-23 10:49:33.636+00	50	Cart object (50)	3		11	1
106	2021-11-23 10:49:33.644+00	49	Cart object (49)	3		11	1
107	2021-11-23 10:49:33.654+00	48	Cart object (48)	3		11	1
108	2021-11-23 10:49:33.661+00	47	Cart object (47)	3		11	1
109	2021-11-23 10:49:33.669+00	46	Cart object (46)	3		11	1
110	2021-11-23 10:49:33.676+00	45	Cart object (45)	3		11	1
111	2021-11-23 10:49:33.684+00	44	Cart object (44)	3		11	1
112	2021-11-23 10:53:53.385+00	55	Cart object (55)	3		11	1
113	2021-11-23 10:53:53.4+00	54	Cart object (54)	3		11	1
114	2021-11-23 10:53:53.408+00	53	Cart object (53)	3		11	1
115	2021-11-23 10:53:53.417+00	52	Cart object (52)	3		11	1
116	2021-11-23 11:16:07.376+00	59	Cart object (59)	3		11	1
117	2021-11-23 11:16:07.389+00	58	Cart object (58)	3		11	1
118	2021-11-23 11:16:07.394+00	57	Cart object (57)	3		11	1
119	2021-11-23 11:16:07.397+00	56	Cart object (56)	3		11	1
120	2021-11-23 11:16:56.255+00	68	CartItem object (68)	3		12	1
121	2021-11-23 11:16:56.268+00	58	CartItem object (58)	3		12	1
122	2021-11-23 13:08:23.369+00	74	Cart object (74)	3		11	1
123	2021-11-23 13:08:23.384+00	73	Cart object (73)	3		11	1
124	2021-11-23 13:08:23.388+00	72	Cart object (72)	3		11	1
125	2021-11-23 13:08:23.391+00	71	Cart object (71)	3		11	1
126	2021-11-23 13:08:23.394+00	70	Cart object (70)	3		11	1
127	2021-11-23 13:08:23.396+00	69	Cart object (69)	3		11	1
128	2021-11-23 13:08:23.399+00	68	Cart object (68)	3		11	1
129	2021-11-23 13:08:23.403+00	67	Cart object (67)	3		11	1
130	2021-11-23 13:08:23.406+00	66	Cart object (66)	3		11	1
131	2021-11-23 13:08:23.408+00	65	Cart object (65)	3		11	1
132	2021-11-23 13:08:23.411+00	64	Cart object (64)	3		11	1
133	2021-11-23 13:08:23.414+00	63	Cart object (63)	3		11	1
134	2021-11-23 13:08:23.416+00	62	Cart object (62)	3		11	1
135	2021-11-23 13:08:23.419+00	61	Cart object (61)	3		11	1
136	2021-11-23 13:08:23.421+00	60	Cart object (60)	3		11	1
137	2021-11-23 13:08:30.806+00	69	CartItem object (69)	3		12	1
138	2021-11-23 14:28:04.059+00	83	Cart object (83)	3		11	1
139	2021-11-23 14:28:04.073+00	82	Cart object (82)	3		11	1
140	2021-11-23 14:28:04.083+00	81	Cart object (81)	3		11	1
141	2021-11-23 14:28:04.096+00	80	Cart object (80)	3		11	1
142	2021-11-23 14:28:04.116+00	79	Cart object (79)	3		11	1
143	2021-11-23 14:28:04.136+00	78	Cart object (78)	3		11	1
144	2021-11-23 14:28:04.161+00	77	Cart object (77)	3		11	1
145	2021-11-23 14:28:04.167+00	76	Cart object (76)	3		11	1
146	2021-11-23 14:28:04.174+00	75	Cart object (75)	3		11	1
147	2021-11-24 08:51:29.954+00	7	sanin	3		13	1
148	2021-11-24 08:51:29.96+00	6	sanin	3		13	1
149	2021-11-24 08:51:29.965+00	5	sanin	3		13	1
150	2021-11-24 08:51:29.971+00	4	sanin	3		13	1
151	2021-11-24 08:51:29.976+00	3	sanin	3		13	1
152	2021-11-24 08:51:29.979+00	2	sanin	3		13	1
153	2021-11-24 08:51:29.982+00	1	sanin	3		13	1
154	2021-11-25 03:31:33.928+00	81	sanin	3		13	1
155	2021-11-25 03:31:33.931+00	80	sanin	3		13	1
156	2021-11-25 03:31:33.934+00	79	sanin	3		13	1
157	2021-11-25 03:31:33.938+00	78	sanin	3		13	1
158	2021-11-25 03:31:33.941+00	77	sanin	3		13	1
159	2021-11-25 03:31:33.945+00	76	sanin	3		13	1
160	2021-11-25 03:31:33.947+00	75	sanin	3		13	1
161	2021-11-25 03:31:33.951+00	74	sanin	3		13	1
162	2021-11-25 03:31:33.956+00	73	sanin	3		13	1
163	2021-11-25 03:31:33.959+00	72	sanin	3		13	1
164	2021-11-25 03:31:33.962+00	71	sanin	3		13	1
165	2021-11-25 03:31:33.965+00	70	sanin	3		13	1
166	2021-11-25 03:31:33.968+00	69	sanin	3		13	1
167	2021-11-25 03:31:33.971+00	68	sanin	3		13	1
168	2021-11-25 03:31:33.974+00	67	sanin	3		13	1
169	2021-11-25 03:31:33.977+00	66	sanin	3		13	1
170	2021-11-25 03:31:33.98+00	65	sanin	3		13	1
171	2021-11-25 03:31:33.982+00	64	sanin	3		13	1
172	2021-11-25 03:31:33.984+00	63	sanin	3		13	1
173	2021-11-25 03:31:33.987+00	62	sanin	3		13	1
174	2021-11-25 03:31:33.989+00	61	sanin	3		13	1
175	2021-11-25 03:31:33.992+00	60	sanin	3		13	1
176	2021-11-25 03:31:33.994+00	59	sanin	3		13	1
177	2021-11-25 03:31:33.996+00	58	sanin	3		13	1
178	2021-11-25 03:31:33.998+00	57	sanin	3		13	1
179	2021-11-25 03:31:34+00	56	sanin	3		13	1
180	2021-11-25 03:31:34.004+00	55	sanin	3		13	1
181	2021-11-25 03:31:34.007+00	54	sanin	3		13	1
182	2021-11-25 03:31:34.009+00	53	sanin	3		13	1
183	2021-11-25 03:31:34.011+00	52	sanin	3		13	1
184	2021-11-25 03:31:34.014+00	51	sanin	3		13	1
185	2021-11-25 03:31:34.016+00	50	sanin	3		13	1
186	2021-11-25 03:31:34.018+00	49	sanin	3		13	1
187	2021-11-25 03:31:34.021+00	48	sanin	3		13	1
188	2021-11-25 03:31:34.024+00	47	sanin	3		13	1
189	2021-11-25 03:31:34.026+00	46	sanin	3		13	1
190	2021-11-25 03:31:34.028+00	45	sanin	3		13	1
191	2021-11-25 03:31:34.03+00	44	sanin	3		13	1
192	2021-11-25 03:31:34.033+00	43	sanin	3		13	1
193	2021-11-25 03:31:34.035+00	42	sanin	3		13	1
194	2021-11-25 03:31:34.038+00	41	sanin	3		13	1
195	2021-11-25 03:31:34.04+00	40	sanin	3		13	1
196	2021-11-25 03:31:34.043+00	39	sanin	3		13	1
197	2021-11-25 03:31:34.045+00	38	sanin	3		13	1
198	2021-11-25 03:31:34.047+00	37	sanin	3		13	1
199	2021-11-25 03:31:34.049+00	36	sanin	3		13	1
200	2021-11-25 03:31:34.051+00	35	sanin	3		13	1
201	2021-11-25 03:31:34.054+00	34	sanin	3		13	1
202	2021-11-25 03:31:34.057+00	33	sanin	3		13	1
203	2021-11-25 03:31:34.059+00	32	sanin	3		13	1
204	2021-11-25 03:31:34.061+00	31	sanin	3		13	1
205	2021-11-25 03:31:34.064+00	30	sanin	3		13	1
206	2021-11-25 03:31:34.067+00	29	sanin	3		13	1
207	2021-11-25 03:31:34.069+00	28	sanin	3		13	1
208	2021-11-25 03:31:34.073+00	27	sanin	3		13	1
209	2021-11-25 03:31:34.075+00	26	sanin	3		13	1
210	2021-11-25 03:31:34.078+00	25	sanin	3		13	1
211	2021-11-25 03:31:34.081+00	24	sanin	3		13	1
212	2021-11-25 03:31:34.083+00	23	sanin	3		13	1
213	2021-11-25 03:31:34.087+00	22	sanin	3		13	1
214	2021-11-25 03:31:34.09+00	21	sanin	3		13	1
215	2021-11-25 03:31:34.093+00	20	sanin	3		13	1
216	2021-11-25 03:31:34.095+00	19	sanin	3		13	1
217	2021-11-25 03:31:34.098+00	18	sanin	3		13	1
218	2021-11-25 03:31:34.1+00	17	sanin	3		13	1
219	2021-11-25 03:31:34.104+00	16	sanin	3		13	1
220	2021-11-25 03:31:34.107+00	15	sanin	3		13	1
221	2021-11-25 03:31:34.111+00	14	sanin	3		13	1
222	2021-11-25 03:31:34.115+00	13	sanin	3		13	1
223	2021-11-25 03:31:34.117+00	12	sanin	3		13	1
224	2021-11-25 03:31:34.12+00	11	sanin	3		13	1
225	2021-11-25 03:31:34.123+00	10	sanin	3		13	1
226	2021-11-25 03:31:34.125+00	9	sanin	3		13	1
227	2021-11-25 03:31:34.128+00	8	sanin	3		13	1
228	2021-11-25 15:52:41.72+00	13	saninwww	3		13	1
229	2021-11-25 15:52:41.724+00	12	saninsass	3		13	1
230	2021-11-25 15:52:41.726+00	11	saninsass	3		13	1
231	2021-11-25 15:52:41.728+00	10	asif	3		13	1
232	2021-11-25 15:52:41.73+00	9	sanin	3		13	1
233	2021-11-25 15:52:41.731+00	8	sanin	3		13	1
234	2021-11-25 15:52:41.733+00	7	sanin	3		13	1
235	2021-11-25 15:52:41.734+00	6	sanin	3		13	1
236	2021-11-25 15:52:41.736+00	5	favas	3		13	1
237	2021-11-25 15:52:41.738+00	4	favas	3		13	1
238	2021-11-25 15:52:41.742+00	3	favas	3		13	1
239	2021-11-25 15:52:41.744+00	2	sanin	3		13	1
240	2021-11-25 15:52:41.746+00	1	sanin	3		13	1
241	2021-11-25 15:53:00.769+00	26	sanin	3		13	1
242	2021-11-25 15:53:00.773+00	25	sanin	3		13	1
243	2021-11-25 15:53:00.775+00	24	sanin	3		13	1
244	2021-11-25 15:53:00.777+00	23	sanin	3		13	1
245	2021-11-25 15:53:00.778+00	22	sanin	3		13	1
246	2021-11-25 15:53:00.78+00	21	sanin	3		13	1
247	2021-11-25 15:53:00.782+00	20	sanin	3		13	1
248	2021-11-25 15:53:00.784+00	19	sanin	3		13	1
249	2021-11-25 15:53:00.786+00	18	faiz	3		13	1
250	2021-11-25 15:53:00.788+00	17	saninsa	3		13	1
251	2021-11-25 15:53:00.793+00	16	saninsdaa	3		13	1
252	2021-11-25 15:53:00.795+00	15	saninrwerwer	3		13	1
253	2021-11-25 15:53:00.796+00	14	faiz	3		13	1
254	2021-11-26 09:02:37.724+00	25	OrderVehicle object (25)	3		15	1
255	2021-11-26 09:02:37.729+00	24	OrderVehicle object (24)	3		15	1
256	2021-11-26 09:02:37.731+00	23	OrderVehicle object (23)	3		15	1
257	2021-11-26 09:02:37.733+00	22	OrderVehicle object (22)	3		15	1
258	2021-11-26 09:02:37.734+00	21	OrderVehicle object (21)	3		15	1
259	2021-11-26 09:02:37.736+00	20	OrderVehicle object (20)	3		15	1
260	2021-11-26 09:02:37.738+00	19	OrderVehicle object (19)	3		15	1
261	2021-11-26 09:02:52.007+00	33	saninsa	3		13	1
262	2021-11-26 09:02:52.009+00	32	sanin	3		13	1
263	2021-11-26 09:02:52.011+00	31	saninsa	3		13	1
264	2021-11-26 09:02:52.013+00	30	faiz	3		13	1
265	2021-11-26 09:02:52.016+00	29	sanin	3		13	1
266	2021-11-26 09:02:52.018+00	28	sanin	3		13	1
267	2021-11-26 09:02:52.019+00	27	sanin	3		13	1
268	2021-11-26 09:02:57.719+00	22	93223069SR079020D	3		14	1
269	2021-11-26 09:02:57.721+00	21	963497632M4883239	3		14	1
270	2021-11-26 09:02:57.723+00	20	90W79433A6047651L	3		14	1
271	2021-11-26 09:02:57.726+00	19	8YB12098UD329221X	3		14	1
272	2021-11-26 09:02:57.728+00	18	7K343693M0261491G	3		14	1
273	2021-11-26 09:02:57.73+00	17	9RU01321P91125358	3		14	1
274	2021-11-26 09:02:57.731+00	16	92S9001124273270D	3		14	1
275	2021-11-26 09:02:57.733+00	15	86F547157P114735X	3		14	1
276	2021-11-26 09:02:57.735+00	14	70A860034W964011W	3		14	1
277	2021-11-26 09:02:57.737+00	13	5YD49485E78624515	3		14	1
278	2021-11-26 09:02:57.738+00	12	1A755551CC7474800	3		14	1
279	2021-11-26 09:02:57.74+00	11	7BS59794TC381951N	3		14	1
280	2021-11-26 09:02:57.744+00	10	9EG55852NG6928020	3		14	1
281	2021-11-26 09:02:57.747+00	9	60267042D66147250	3		14	1
282	2021-11-26 09:02:57.748+00	8	84792792TJ7025245	3		14	1
283	2021-11-26 09:02:57.75+00	7	0PC50385H6692273X	3		14	1
284	2021-11-26 09:02:57.752+00	6	69W57356JX042891J	3		14	1
285	2021-11-26 09:02:57.754+00	5	7FF84213DW3814529	3		14	1
286	2021-11-26 09:02:57.755+00	4	8LB09727E0183900J	3		14	1
287	2021-11-26 09:02:57.757+00	3	5L351251GF743660R	3		14	1
288	2021-11-26 09:02:57.76+00	2	4FF356955F035600K	3		14	1
289	2021-11-26 09:02:57.762+00	1	52J77334HF342372J	3		14	1
290	2021-11-26 09:40:26.987+00	37	saninsdaa	3		13	1
291	2021-11-26 09:40:26.993+00	36	sanin	3		13	1
292	2021-11-26 09:40:26.999+00	35	sanin	3		13	1
293	2021-11-26 09:40:27.004+00	34	saninsa	3		13	1
294	2021-11-26 09:40:33.498+00	26	49409467C48445625	3		14	1
295	2021-11-26 09:40:33.504+00	25	54B51579D36213321	3		14	1
296	2021-11-26 09:40:33.509+00	24	58H154709E008680Y	3		14	1
297	2021-11-26 09:40:33.514+00	23	5UB03036KK067944B	3		14	1
298	2021-11-26 09:45:37.517+00	38	saninsa	3		13	1
299	2021-11-26 09:45:42.613+00	27	05G07821XY0233734	3		14	1
300	2021-11-26 11:04:05.637+00	1	sanin	3		13	1
301	2021-11-27 05:04:08.152+00	5	sanin	3		13	1
302	2021-11-27 05:04:08.156+00	4	saninsa	3		13	1
303	2021-11-27 05:04:08.164+00	3	faiz	3		13	1
304	2021-11-27 05:04:08.174+00	2	sanin	3		13	1
305	2021-11-27 16:38:38.812+00	6	sanin.fun@gmail.com	2	[{"changed": {"fields": ["Last name"]}}]	6	1
306	2021-11-27 17:14:16.869+00	6	sanin.fun@gmail.com	2	[{"changed": {"fields": ["Mobile"]}}]	6	1
307	2021-11-28 08:04:53.37+00	1	Banner object (1)	2	[]	16	1
308	2021-11-28 08:20:31.95+00	2	Banner object (2)	3		16	1
309	2021-11-28 08:20:43.626+00	3	Banner object (3)	3		16	1
310	2021-11-28 08:26:19.315+00	5	Banner object (5)	3		16	1
311	2021-11-28 08:26:19.328+00	4	Banner object (4)	3		16	1
312	2021-11-28 08:26:43.545+00	6	Banner object (6)	3		16	1
313	2021-11-28 08:31:46.688+00	7	Banner object (7)	3		16	1
314	2021-11-28 09:11:06.482+00	8	Banner object (8)	3		16	1
315	2021-11-28 09:57:32.3+00	12	faiz	3		13	1
316	2021-11-28 09:57:32.313+00	11	saninsdaa	3		13	1
317	2021-11-28 09:57:32.316+00	10	saninsa	3		13	1
318	2021-11-28 09:57:32.319+00	9	saninsdaa	3		13	1
319	2021-11-28 09:57:32.321+00	8	sanin	3		13	1
320	2021-11-28 09:57:32.324+00	7	sanin	3		13	1
321	2021-11-28 09:57:32.328+00	6	faiz	3		13	1
322	2021-11-29 06:50:23.989+00	8c99193d-096c-4786-8bb1-8aba51515b7f	15	1	[{"added": {}}]	17	1
323	2021-11-29 15:50:07.263+00	1	s	2	[]	18	1
324	2021-11-29 16:00:43.019+00	2	wq	1	[{"added": {}}]	18	1
325	2021-11-29 16:03:00.987+00	1	s	2	[]	18	1
326	2021-11-29 16:03:06.099+00	2	wq	2	[{"changed": {"fields": ["Ip"]}}]	18	1
327	2021-11-29 16:03:28.041+00	2	wq	2	[{"changed": {"fields": ["User"]}}]	18	1
328	2021-11-29 16:16:42.97+00	2	Best Driving	2	[{"changed": {"fields": ["Subject", "Review"]}}]	18	1
329	2021-11-29 16:17:20.529+00	1	Worth of money	2	[{"changed": {"fields": ["Subject", "Review"]}}]	18	1
330	2021-11-30 03:56:10.902+00	91	Cart object (91)	3		11	1
331	2021-11-30 03:56:10.909+00	90	Cart object (90)	3		11	1
332	2021-11-30 03:56:10.912+00	89	Cart object (89)	3		11	1
333	2021-11-30 03:56:10.915+00	88	Cart object (88)	3		11	1
334	2021-11-30 03:56:10.918+00	87	Cart object (87)	3		11	1
335	2021-11-30 03:56:10.921+00	86	Cart object (86)	3		11	1
336	2021-11-30 03:56:10.924+00	85	Cart object (85)	3		11	1
337	2021-11-30 03:56:10.926+00	84	Cart object (84)	3		11	1
338	2021-11-30 03:56:19.856+00	154	CartItem object (154)	3		12	1
339	2021-11-30 03:56:19.872+00	153	CartItem object (153)	3		12	1
340	2021-11-30 03:56:19.875+00	152	CartItem object (152)	3		12	1
341	2021-11-30 04:27:09.145+00	9	chris@gmail.com	3		6	1
342	2021-11-30 05:21:13.729+00	6	sanin.fun@gmail.com	2	[{"changed": {"fields": ["Mobile"]}}]	6	1
343	2021-11-30 08:56:32.265+00	f4ab512a-8d81-461e-a02a-b55147e76def	Address object (f4ab512a-8d81-461e-a02a-b55147e76def)	1	[{"added": {}}]	19	1
344	2021-11-30 08:57:01.04+00	c9185b99-a558-4498-a8ff-c15f49721a5b	Address object (c9185b99-a558-4498-a8ff-c15f49721a5b)	1	[{"added": {}}]	19	1
345	2021-11-30 09:02:04.243+00	f4ab512a-8d81-461e-a02a-b55147e76def	Address object (f4ab512a-8d81-461e-a02a-b55147e76def)	2	[{"changed": {"fields": ["Address line 1"]}}]	19	1
346	2021-11-30 11:09:34.53+00	a2f6f42a-91a3-4d4d-ab69-f229afbf36b3	Address object (a2f6f42a-91a3-4d4d-ab69-f229afbf36b3)	3		19	1
347	2021-11-30 11:09:34.534+00	76cafa1a-3d86-4f8f-8b40-a008af59e416	Address object (76cafa1a-3d86-4f8f-8b40-a008af59e416)	3		19	1
348	2021-11-30 11:18:12.598+00	6484c85e-a8b3-4b40-9ec1-d9e454fa91b0	Address object (6484c85e-a8b3-4b40-9ec1-d9e454fa91b0)	1	[{"added": {}}]	19	1
349	2021-11-30 11:18:32.988+00	1959a89f-c353-4c11-9bc8-7e1dd760a55d	Address object (1959a89f-c353-4c11-9bc8-7e1dd760a55d)	1	[{"added": {}}]	19	1
350	2021-11-30 11:19:01.198+00	b459419c-691f-458d-a757-bb25d5bf4472	Address object (b459419c-691f-458d-a757-bb25d5bf4472)	1	[{"added": {}}]	19	1
351	2021-12-01 03:58:40.009+00	1	BookingPrice object (1)	1	[{"added": {}}]	22	1
352	2021-12-01 04:01:08.982+00	2	BookingPrice object (2)	1	[{"added": {}}]	22	1
353	2021-12-01 04:01:14.617+00	3	BookingPrice object (3)	1	[{"added": {}}]	22	1
354	2021-12-01 04:01:20.447+00	4	BookingPrice object (4)	1	[{"added": {}}]	22	1
355	2021-12-01 04:01:28.448+00	5	BookingPrice object (5)	1	[{"added": {}}]	22	1
356	2021-12-01 04:05:19.874+00	56e521dd-681a-4ea1-b66e-8dbbbef7ca65	12	2	[{"changed": {"fields": ["Is active"]}}]	17	1
357	2021-12-01 04:05:33.637+00	56e521dd-681a-4ea1-b66e-8dbbbef7ca65	12	2	[{"changed": {"fields": ["Is active"]}}]	17	1
358	2021-12-01 05:06:54.292+00	5	BookingPrice object (5)	2	[{"changed": {"fields": ["Booking price"]}}]	22	1
359	2021-12-01 05:06:58.542+00	1	BookingPrice object (1)	2	[]	22	1
360	2021-12-01 05:07:04.546+00	4	BookingPrice object (4)	2	[{"changed": {"fields": ["Booking price"]}}]	22	1
361	2021-12-01 05:07:11.283+00	2	BookingPrice object (2)	2	[{"changed": {"fields": ["Booking price"]}}]	22	1
362	2021-12-01 05:07:21.309+00	3	BookingPrice object (3)	2	[{"changed": {"fields": ["Booking price"]}}]	22	1
363	2021-12-02 11:55:52.646+00	5	tvs	2	[{"changed": {"fields": ["Is verified", "Is mobile verified"]}}]	8	1
364	2021-12-02 13:44:10.307+00	13	ds@gmaik.com	2	[{"changed": {"fields": ["Is verified", "Otp verified"]}}]	6	1
365	2021-12-03 05:27:13.616+00	1	RedeemedCoupon object (1)	3		21	1
366	2021-12-03 05:36:05.116+00	2	RedeemedCoupon object (2)	3		21	1
367	2021-12-03 14:01:01.898+00	fed9704e-e8c1-424f-8f5f-250d04c18a18	Coupon object (fed9704e-e8c1-424f-8f5f-250d04c18a18)	2	[{"changed": {"fields": ["Is active"]}}]	20	1
368	2021-12-04 06:04:31.582+00	3	RedeemedCoupon object (3)	3		21	1
369	2021-12-04 06:11:27.685+00	4	RedeemedCoupon object (4)	3		21	1
370	2021-12-04 06:22:51.129+00	5	RedeemedCoupon object (5)	3		21	1
371	2021-12-04 06:38:24.839+00	6	RedeemedCoupon object (6)	3		21	1
372	2021-12-04 07:08:39.609+00	7	RedeemedCoupon object (7)	3		21	1
373	2021-12-05 04:06:56.144+00	10	RedeemedCoupon object (10)	3		21	1
374	2021-12-05 04:06:56.152+00	9	RedeemedCoupon object (9)	3		21	1
375	2021-12-05 04:06:56.155+00	8	RedeemedCoupon object (8)	3		21	1
376	2021-12-05 04:28:59.671+00	12	RedeemedCoupon object (12)	3		21	1
377	2021-12-05 04:28:59.674+00	11	RedeemedCoupon object (11)	3		21	1
378	2021-12-06 09:13:54.953+00	13	RedeemedCoupon object (13)	3		21	1
379	2021-12-07 16:47:07.119+00	2	Raptor	3		9	1
380	2021-12-07 16:52:53.127+00	8	Raptorr	3		9	1
381	2021-12-07 16:53:01.919+00	10	tva	3		9	1
382	2021-12-08 23:54:20.075+00	4	Loved it	1	[{"added": {}}]	18	1
383	2021-12-08 23:56:45.769+00	5	Thanks to OLA	1	[{"added": {}}]	18	1
384	2021-12-08 23:58:08.679+00	6	Powerful and gorgeous	1	[{"added": {}}]	18	1
385	2021-12-08 23:59:54.007+00	7	Best OFF road vehicle i bought	1	[{"added": {}}]	18	1
386	2021-12-09 00:01:41.13+00	8	Best sport car i driven	1	[{"added": {}}]	18	1
387	2021-12-09 00:02:23.989+00	9	Best GT	1	[{"added": {}}]	18	1
388	2021-12-09 00:03:42.769+00	10	Best Muscle car	1	[{"added": {}}]	18	1
389	2021-12-10 14:11:31.534+00	33	Variant object (33)	3		10	1
390	2021-12-11 06:03:23.101+00	fb16a474-cecf-46a0-8611-8c6450d098d0	Address object (fb16a474-cecf-46a0-8611-8c6450d098d0)	3		19	1
391	2021-12-11 06:03:23.116+00	f51b6eb6-7a4c-43f9-a71c-395694ad3a18	Address object (f51b6eb6-7a4c-43f9-a71c-395694ad3a18)	3		19	1
392	2021-12-11 06:03:23.116+00	d6d1d146-c05f-46d1-a7a3-089023daa427	Address object (d6d1d146-c05f-46d1-a7a3-089023daa427)	3		19	1
393	2021-12-11 06:03:23.132+00	b10d38ef-7d22-4b94-9e8e-fa3603314b89	Address object (b10d38ef-7d22-4b94-9e8e-fa3603314b89)	3		19	1
394	2021-12-11 06:03:23.132+00	9854806c-c136-4f6c-887d-3a6a927f4435	Address object (9854806c-c136-4f6c-887d-3a6a927f4435)	3		19	1
395	2021-12-11 06:03:23.132+00	547b6779-3f1f-49f2-9111-348634de80ea	Address object (547b6779-3f1f-49f2-9111-348634de80ea)	3		19	1
396	2021-12-11 06:03:23.132+00	4603a911-87ee-4cc8-88fb-cb266b26b452	Address object (4603a911-87ee-4cc8-88fb-cb266b26b452)	3		19	1
397	2021-12-11 06:03:23.147+00	10729772-743b-45bf-b4d3-41fd1ca4dbcc	Address object (10729772-743b-45bf-b4d3-41fd1ca4dbcc)	3		19	1
398	2021-12-11 06:21:51.024+00	264	faiz	3		13	1
399	2021-12-11 06:21:51.024+00	263	faiz	3		13	1
400	2021-12-11 06:21:51.04+00	262	faiz	3		13	1
401	2021-12-11 06:21:51.04+00	261	faiz	3		13	1
402	2021-12-11 06:21:51.04+00	260	faiz	3		13	1
403	2021-12-11 06:21:51.055+00	259	faiz	3		13	1
404	2021-12-11 06:21:51.055+00	258	faiz	3		13	1
405	2021-12-11 06:21:51.055+00	257	faiz	3		13	1
406	2021-12-11 06:21:51.055+00	256	faiz	3		13	1
407	2021-12-11 06:21:51.055+00	255	faiz	3		13	1
408	2021-12-11 06:21:51.055+00	254	faiz	3		13	1
409	2021-12-11 06:21:51.071+00	253	faiz	3		13	1
410	2021-12-11 06:21:51.071+00	252	faiz	3		13	1
411	2021-12-11 06:21:51.071+00	251	faiz	3		13	1
412	2021-12-11 06:21:51.071+00	250	faiz	3		13	1
413	2021-12-11 06:21:51.071+00	249	faiz	3		13	1
414	2021-12-11 06:21:51.071+00	248	faiz	3		13	1
415	2021-12-11 06:21:51.071+00	247	faiz	3		13	1
416	2021-12-11 06:21:51.071+00	246	faiz	3		13	1
417	2021-12-11 06:21:51.086+00	245	faiz	3		13	1
418	2021-12-11 06:22:03.311+00	244	faiz	3		13	1
419	2021-12-11 06:22:03.327+00	243	faiz	3		13	1
420	2021-12-11 06:22:03.327+00	242	faiz	3		13	1
421	2021-12-11 06:22:03.343+00	241	faiz	3		13	1
422	2021-12-11 06:22:03.343+00	240	faiz	3		13	1
423	2021-12-11 06:22:03.343+00	239	faiz	3		13	1
424	2021-12-11 06:22:03.358+00	238	faiz	3		13	1
425	2021-12-11 06:22:03.365+00	237	faiz	3		13	1
426	2021-12-11 06:22:03.365+00	236	faiz	3		13	1
427	2021-12-11 06:22:03.365+00	235	faiz	3		13	1
428	2021-12-11 06:22:03.38+00	234	faiz	3		13	1
429	2021-12-11 06:22:03.38+00	233	faiz	3		13	1
430	2021-12-11 06:22:03.38+00	232	faiz	3		13	1
431	2021-12-11 06:22:03.396+00	231	faiz	3		13	1
432	2021-12-11 06:22:03.396+00	230	faiz	3		13	1
433	2021-12-11 06:22:03.396+00	229	faiz	3		13	1
434	2021-12-11 06:22:03.412+00	228	faiz	3		13	1
435	2021-12-11 06:22:03.412+00	227	faiz	3		13	1
436	2021-12-11 06:22:03.412+00	226	faiz	3		13	1
437	2021-12-11 06:22:03.427+00	225	faiz	3		13	1
438	2021-12-11 06:22:17.024+00	24	ameeraaa	3		13	1
439	2021-12-11 06:22:17.024+00	23	ameeraaa	3		13	1
440	2021-12-11 06:22:17.024+00	22	ameer	3		13	1
441	2021-12-11 06:22:17.039+00	21	ameer	3		13	1
442	2021-12-11 06:22:17.039+00	20	faiz	3		13	1
443	2021-12-11 06:22:17.039+00	19	saninsdaa	3		13	1
444	2021-12-11 06:22:17.039+00	18	saninsa	3		13	1
445	2021-12-11 06:22:17.039+00	17	saninsa	3		13	1
446	2021-12-11 06:22:17.039+00	16	faiz	3		13	1
447	2021-12-11 06:22:17.039+00	15	sanin	3		13	1
448	2021-12-11 06:22:17.039+00	14	saninsa	3		13	1
449	2021-12-11 06:22:17.055+00	13	saninsdaa	3		13	1
450	2021-12-11 06:22:50.921+00	224	faiz	3		13	1
451	2021-12-11 06:22:50.936+00	223	faiz	3		13	1
452	2021-12-11 06:22:50.936+00	222	faiz	3		13	1
453	2021-12-11 06:22:50.936+00	221	faiz	3		13	1
454	2021-12-11 06:22:50.936+00	220	faiz	3		13	1
455	2021-12-11 06:22:50.936+00	219	faiz	3		13	1
456	2021-12-11 06:22:50.952+00	218	faiz	3		13	1
457	2021-12-11 06:22:50.952+00	217	faiz	3		13	1
458	2021-12-11 06:22:50.952+00	216	faiz	3		13	1
459	2021-12-11 06:22:50.952+00	215	ameer	3		13	1
460	2021-12-11 06:22:50.952+00	214	ameer	3		13	1
461	2021-12-11 06:22:50.952+00	213	ameer	3		13	1
462	2021-12-11 06:22:50.952+00	212	ameer	3		13	1
463	2021-12-11 06:22:50.968+00	211	ameer	3		13	1
464	2021-12-11 06:22:50.968+00	210	ameer	3		13	1
465	2021-12-11 06:22:50.968+00	209	ameer	3		13	1
466	2021-12-11 06:22:50.968+00	208	ameer	3		13	1
467	2021-12-11 06:22:50.968+00	207	ameer	3		13	1
468	2021-12-11 06:22:50.968+00	206	ameer	3		13	1
469	2021-12-11 06:22:50.968+00	205	ameer	3		13	1
470	2021-12-11 06:22:56.335+00	204	ameer	3		13	1
471	2021-12-11 06:22:56.335+00	203	ameer	3		13	1
472	2021-12-11 06:22:56.335+00	202	ameer	3		13	1
473	2021-12-11 06:22:56.335+00	201	ameer	3		13	1
474	2021-12-11 06:22:56.335+00	200	ameer	3		13	1
475	2021-12-11 06:22:56.335+00	199	ameer	3		13	1
476	2021-12-11 06:22:56.35+00	198	ameer	3		13	1
477	2021-12-11 06:22:56.35+00	197	ameer	3		13	1
478	2021-12-11 06:22:56.35+00	196	ameer	3		13	1
479	2021-12-11 06:22:56.35+00	195	ameer	3		13	1
480	2021-12-11 06:22:56.35+00	194	ameer	3		13	1
481	2021-12-11 06:22:56.35+00	193	ameer	3		13	1
482	2021-12-11 06:22:56.35+00	192	ameer	3		13	1
483	2021-12-11 06:22:56.366+00	191	ameer	3		13	1
484	2021-12-11 06:22:56.366+00	190	ameer	3		13	1
485	2021-12-11 06:22:56.366+00	189	ameer	3		13	1
486	2021-12-11 06:22:56.366+00	188	ameer	3		13	1
487	2021-12-11 06:22:56.366+00	187	ameer	3		13	1
488	2021-12-11 06:22:56.366+00	186	ameer	3		13	1
489	2021-12-11 06:22:56.366+00	185	ameer	3		13	1
490	2021-12-11 06:23:08.295+00	184	ameer	3		13	1
491	2021-12-11 06:23:08.31+00	183	ameer	3		13	1
492	2021-12-11 06:23:08.31+00	182	ameer	3		13	1
493	2021-12-11 06:23:08.31+00	181	ameer	3		13	1
494	2021-12-11 06:23:08.31+00	180	ameer	3		13	1
495	2021-12-11 06:23:08.31+00	179	ameer	3		13	1
496	2021-12-11 06:23:08.31+00	178	ameer	3		13	1
497	2021-12-11 06:23:08.31+00	177	ameer	3		13	1
498	2021-12-11 06:23:08.326+00	176	ameer	3		13	1
499	2021-12-11 06:23:08.326+00	175	ameer	3		13	1
500	2021-12-11 06:23:08.326+00	174	ameer	3		13	1
501	2021-12-11 06:23:08.326+00	173	ameer	3		13	1
502	2021-12-11 06:23:08.326+00	172	ameer	3		13	1
503	2021-12-11 06:23:08.326+00	171	ameer	3		13	1
504	2021-12-11 06:23:08.326+00	170	ameer	3		13	1
505	2021-12-11 06:23:08.342+00	169	ameer	3		13	1
506	2021-12-11 06:23:08.342+00	168	ameer	3		13	1
507	2021-12-11 06:23:08.342+00	167	ameer	3		13	1
508	2021-12-11 06:23:08.342+00	166	ameer	3		13	1
509	2021-12-11 06:23:08.342+00	165	ameer	3		13	1
510	2021-12-11 06:23:13.291+00	164	ameer	3		13	1
511	2021-12-11 06:23:13.307+00	163	ameer	3		13	1
512	2021-12-11 06:23:13.307+00	162	saninsdaa	3		13	1
513	2021-12-11 06:23:13.307+00	161	saninsdaa	3		13	1
514	2021-12-11 06:23:13.307+00	160	saninsdaa	3		13	1
515	2021-12-11 06:23:13.307+00	159	saninsdaa	3		13	1
516	2021-12-11 06:23:13.307+00	158	saninsdaa	3		13	1
517	2021-12-11 06:23:13.307+00	157	saninsdaa	3		13	1
518	2021-12-11 06:23:13.323+00	156	saninsdaa	3		13	1
519	2021-12-11 06:23:13.323+00	155	saninsdaa	3		13	1
520	2021-12-11 06:23:13.323+00	154	saninsdaa	3		13	1
521	2021-12-11 06:23:13.323+00	153	saninsdaa	3		13	1
522	2021-12-11 06:23:13.323+00	152	saninsdaa	3		13	1
523	2021-12-11 06:23:13.323+00	151	saninsdaa	3		13	1
524	2021-12-11 06:23:13.323+00	150	saninsdaa	3		13	1
525	2021-12-11 06:23:13.338+00	149	saninsdaa	3		13	1
526	2021-12-11 06:23:13.338+00	148	saninsdaa	3		13	1
527	2021-12-11 06:23:13.338+00	147	saninsdaa	3		13	1
528	2021-12-11 06:23:13.338+00	146	saninsdaa	3		13	1
529	2021-12-11 06:23:13.338+00	145	saninsdaa	3		13	1
530	2021-12-11 06:23:18.889+00	144	saninsdaa	3		13	1
531	2021-12-11 06:23:18.889+00	143	saninsdaa	3		13	1
532	2021-12-11 06:23:18.905+00	142	saninsdaa	3		13	1
533	2021-12-11 06:23:18.905+00	141	saninsdaa	3		13	1
534	2021-12-11 06:23:18.905+00	140	saninsdaa	3		13	1
535	2021-12-11 06:23:18.905+00	139	saninsdaa	3		13	1
536	2021-12-11 06:23:18.905+00	138	saninsdaa	3		13	1
537	2021-12-11 06:23:18.905+00	137	saninsdaa	3		13	1
538	2021-12-11 06:23:18.905+00	136	saninsdaa	3		13	1
539	2021-12-11 06:23:18.92+00	135	saninsdaa	3		13	1
540	2021-12-11 06:23:18.92+00	134	saninsdaa	3		13	1
541	2021-12-11 06:23:18.92+00	133	saninsdaa	3		13	1
542	2021-12-11 06:23:18.92+00	132	saninsdaa	3		13	1
543	2021-12-11 06:23:18.92+00	131	saninsdaa	3		13	1
544	2021-12-11 06:23:18.92+00	130	saninsdaa	3		13	1
545	2021-12-11 06:23:18.936+00	129	saninsdaa	3		13	1
546	2021-12-11 06:23:18.936+00	128	saninsdaa	3		13	1
547	2021-12-11 06:23:18.936+00	127	saninsdaa	3		13	1
548	2021-12-11 06:23:18.936+00	126	saninsdaa	3		13	1
549	2021-12-11 06:23:18.936+00	125	saninsdaa	3		13	1
550	2021-12-11 06:23:24.501+00	124	saninsdaa	3		13	1
551	2021-12-11 06:23:24.516+00	123	saninsdaa	3		13	1
552	2021-12-11 06:23:24.516+00	122	saninsdaa	3		13	1
553	2021-12-11 06:23:24.532+00	121	saninsdaa	3		13	1
554	2021-12-11 06:23:24.532+00	120	saninsdaa	3		13	1
555	2021-12-11 06:23:24.532+00	119	saninsdaa	3		13	1
556	2021-12-11 06:23:24.532+00	118	saninsdaa	3		13	1
557	2021-12-11 06:23:24.532+00	117	saninsdaa	3		13	1
558	2021-12-11 06:23:24.532+00	116	saninsdaa	3		13	1
559	2021-12-11 06:23:24.547+00	115	saninsdaa	3		13	1
560	2021-12-11 06:23:24.549+00	114	saninsdaa	3		13	1
561	2021-12-11 06:23:24.551+00	113	saninsdaa	3		13	1
562	2021-12-11 06:23:24.553+00	112	saninsdaa	3		13	1
563	2021-12-11 06:23:24.553+00	111	saninsdaa	3		13	1
564	2021-12-11 06:23:24.553+00	110	saninsdaa	3		13	1
565	2021-12-11 06:23:24.553+00	109	saninsdaa	3		13	1
566	2021-12-11 06:23:24.553+00	108	saninsdaa	3		13	1
567	2021-12-11 06:23:24.553+00	107	saninsdaa	3		13	1
568	2021-12-11 06:23:24.553+00	106	saninsdaa	3		13	1
569	2021-12-11 06:23:24.553+00	105	saninsdaa	3		13	1
570	2021-12-11 06:23:29.242+00	104	saninsdaa	3		13	1
571	2021-12-11 06:23:29.257+00	103	saninsdaa	3		13	1
572	2021-12-11 06:23:29.257+00	102	saninsdaa	3		13	1
573	2021-12-11 06:23:29.257+00	101	saninsdaa	3		13	1
574	2021-12-11 06:23:29.257+00	100	saninsdaa	3		13	1
575	2021-12-11 06:23:29.257+00	99	saninsdaa	3		13	1
576	2021-12-11 06:23:29.257+00	98	saninsdaa	3		13	1
577	2021-12-11 06:23:29.273+00	97	saninsdaa	3		13	1
578	2021-12-11 06:23:29.273+00	96	saninsdaa	3		13	1
579	2021-12-11 06:23:29.273+00	95	saninsdaa	3		13	1
580	2021-12-11 06:23:29.273+00	94	saninsdaa	3		13	1
581	2021-12-11 06:23:29.273+00	93	saninsdaa	3		13	1
582	2021-12-11 06:23:29.273+00	92	saninsdaa	3		13	1
583	2021-12-11 06:23:29.273+00	91	saninsdaa	3		13	1
584	2021-12-11 06:23:29.289+00	90	saninsdaa	3		13	1
585	2021-12-11 06:23:29.289+00	89	saninsdaa	3		13	1
586	2021-12-11 06:23:29.289+00	88	saninsdaa	3		13	1
587	2021-12-11 06:23:29.295+00	87	saninsdaa	3		13	1
588	2021-12-11 06:23:29.295+00	86	saninsdaa	3		13	1
589	2021-12-11 06:23:29.295+00	85	saninsdaa	3		13	1
590	2021-12-11 06:23:34.436+00	84	saninsdaa	3		13	1
591	2021-12-11 06:23:34.436+00	83	saninsdaa	3		13	1
592	2021-12-11 06:23:34.451+00	82	saninsdaa	3		13	1
593	2021-12-11 06:23:34.451+00	81	saninsdaa	3		13	1
594	2021-12-11 06:23:34.451+00	80	saninsdaa	3		13	1
595	2021-12-11 06:23:34.451+00	79	saninsdaa	3		13	1
596	2021-12-11 06:23:34.451+00	78	saninsdaa	3		13	1
597	2021-12-11 06:23:34.451+00	77	saninsdaa	3		13	1
598	2021-12-11 06:23:34.467+00	76	saninsdaa	3		13	1
599	2021-12-11 06:23:34.467+00	75	saninsdaa	3		13	1
600	2021-12-11 06:23:34.467+00	74	saninsdaa	3		13	1
601	2021-12-11 06:23:34.467+00	73	saninsdaa	3		13	1
602	2021-12-11 06:23:34.467+00	72	saninsdaa	3		13	1
603	2021-12-11 06:23:34.467+00	71	saninsdaa	3		13	1
604	2021-12-11 06:23:34.482+00	70	saninsdaa	3		13	1
605	2021-12-11 06:23:34.482+00	69	saninsdaa	3		13	1
606	2021-12-11 06:23:34.482+00	68	saninsdaa	3		13	1
607	2021-12-11 06:23:34.482+00	67	saninsdaa	3		13	1
608	2021-12-11 06:23:34.482+00	66	saninsdaa	3		13	1
609	2021-12-11 06:23:34.482+00	65	saninsdaa	3		13	1
610	2021-12-11 06:23:39.833+00	64	ameer	3		13	1
611	2021-12-11 06:23:39.833+00	63	ameer	3		13	1
612	2021-12-11 06:23:39.845+00	62	ameer	3		13	1
613	2021-12-11 06:23:39.845+00	61	ameer	3		13	1
614	2021-12-11 06:23:39.845+00	60	ameer	3		13	1
615	2021-12-11 06:23:39.845+00	59	ameer	3		13	1
616	2021-12-11 06:23:39.845+00	58	ameer	3		13	1
617	2021-12-11 06:23:39.845+00	57	ameer	3		13	1
618	2021-12-11 06:23:39.845+00	56	ameer	3		13	1
619	2021-12-11 06:23:39.861+00	55	ameer	3		13	1
620	2021-12-11 06:23:39.861+00	54	ameer	3		13	1
621	2021-12-11 06:23:39.861+00	53	ameer	3		13	1
622	2021-12-11 06:23:39.861+00	52	saninsdaa	3		13	1
623	2021-12-11 06:23:39.861+00	51	saninsdaa	3		13	1
624	2021-12-11 06:23:39.861+00	50	saninsdaa	3		13	1
625	2021-12-11 06:23:39.861+00	49	saninsdaa	3		13	1
626	2021-12-11 06:23:39.876+00	48	saninsdaa	3		13	1
627	2021-12-11 06:23:39.876+00	47	saninsdaa	3		13	1
628	2021-12-11 06:23:39.876+00	46	saninsdaa	3		13	1
629	2021-12-11 06:23:39.876+00	45	saninsdaa	3		13	1
630	2021-12-11 06:23:44.752+00	44	saninsdaa	3		13	1
631	2021-12-11 06:23:44.767+00	43	saninsdaa	3		13	1
632	2021-12-11 06:23:44.767+00	42	saninsdaa	3		13	1
633	2021-12-11 06:23:44.767+00	41	saninsdaa	3		13	1
634	2021-12-11 06:23:44.767+00	40	saninsdaa	3		13	1
635	2021-12-11 06:23:44.767+00	39	saninsdaa	3		13	1
636	2021-12-11 06:23:44.783+00	38	saninsdaa	3		13	1
637	2021-12-11 06:23:44.783+00	37	saninsdaa	3		13	1
638	2021-12-11 06:23:44.783+00	36	saninsdaa	3		13	1
639	2021-12-11 06:23:44.783+00	35	saninsdaa	3		13	1
640	2021-12-11 06:23:44.783+00	34	saninsdaa	3		13	1
641	2021-12-11 06:23:44.783+00	33	saninsdaa	3		13	1
642	2021-12-11 06:23:44.798+00	32	saninsdaa	3		13	1
643	2021-12-11 06:23:44.798+00	31	saninsdaa	3		13	1
644	2021-12-11 06:23:44.798+00	30	faiz	3		13	1
645	2021-12-11 06:23:44.798+00	29	faiz	3		13	1
646	2021-12-11 06:23:44.798+00	28	faiz	3		13	1
647	2021-12-11 06:23:44.798+00	27	faiz	3		13	1
648	2021-12-11 06:23:44.798+00	26	ameer	3		13	1
649	2021-12-11 06:23:44.798+00	25	ameer	3		13	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	user	account
7	category	category
8	vendor	vendor
9	showroom	vehicle
10	showroom	variant
11	cart	cart
12	cart	cartitem
13	orders	order
14	orders	payments
15	orders	ordervehicle
16	banners	banner
17	offers	vehicleoffer
18	showroom	reviewrating
19	user	address
20	coupons	coupon
21	coupons	redeemedcoupon
22	superadmin	bookingprice
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	user	0001_initial	2021-12-11 04:53:54.012275+00
2	contenttypes	0001_initial	2021-12-11 04:53:54.043033+00
3	admin	0001_initial	2021-12-11 04:53:54.057621+00
4	admin	0002_logentry_remove_auto_add	2021-12-11 04:53:54.077423+00
5	admin	0003_logentry_add_action_flag_choices	2021-12-11 04:53:54.086646+00
6	contenttypes	0002_remove_content_type_name	2021-12-11 04:53:54.118623+00
7	auth	0001_initial	2021-12-11 04:53:54.157533+00
8	auth	0002_alter_permission_name_max_length	2021-12-11 04:53:54.184669+00
9	auth	0003_alter_user_email_max_length	2021-12-11 04:53:54.192665+00
10	auth	0004_alter_user_username_opts	2021-12-11 04:53:54.200679+00
11	auth	0005_alter_user_last_login_null	2021-12-11 04:53:54.208651+00
12	auth	0006_require_contenttypes_0002	2021-12-11 04:53:54.208651+00
13	auth	0007_alter_validators_add_error_messages	2021-12-11 04:53:54.216646+00
14	auth	0008_alter_user_username_max_length	2021-12-11 04:53:54.232542+00
15	auth	0009_alter_user_last_name_max_length	2021-12-11 04:53:54.237612+00
16	auth	0010_alter_group_name_max_length	2021-12-11 04:53:54.257257+00
17	auth	0011_update_proxy_permissions	2021-12-11 04:53:54.267481+00
18	auth	0012_alter_user_first_name_max_length	2021-12-11 04:53:54.275478+00
19	vendor	0001_initial	2021-12-11 04:53:54.296763+00
20	vendor	0002_vendor_is_mobile_verified	2021-12-11 04:53:54.312718+00
21	category	0001_initial	2021-12-11 04:53:54.336786+00
22	category	0002_auto_20211115_1950	2021-12-11 04:53:54.344792+00
23	category	0003_auto_20211115_2158	2021-12-11 04:53:54.357437+00
24	showroom	0001_initial	2021-12-11 04:53:54.39667+00
25	showroom	0002_vehicle_gif	2021-12-11 04:53:54.432718+00
26	showroom	0003_remove_vehicle_gif	2021-12-11 04:53:54.437248+00
27	showroom	0004_vehicle_gif	2021-12-11 04:53:54.447534+00
28	showroom	0005_vehicle_no_of_seats	2021-12-11 04:53:54.456661+00
29	showroom	0006_vehicle_vendor_id	2021-12-11 04:53:54.472662+00
30	showroom	0007_auto_20211119_1144	2021-12-11 04:53:54.488625+00
31	showroom	0008_variant_is_available	2021-12-11 04:53:54.506674+00
32	vendor	0003_auto_20211119_1144	2021-12-11 04:53:54.514667+00
33	banners	0001_initial	2021-12-11 04:53:54.527535+00
34	banners	0002_banner_vehicle	2021-12-11 04:53:54.557398+00
35	cart	0001_initial	2021-12-11 04:53:54.587526+00
36	cart	0002_auto_20211120_1833	2021-12-11 04:53:54.667218+00
37	cart	0003_auto_20211123_1044	2021-12-11 04:53:54.697581+00
38	coupons	0001_initial	2021-12-11 04:53:54.727401+00
39	coupons	0002_coupon_category	2021-12-11 04:53:54.764697+00
40	coupons	0003_remove_coupon_category	2021-12-11 04:53:54.794638+00
41	offers	0001_initial	2021-12-11 04:53:54.827552+00
42	offers	0002_auto_20211129_1214	2021-12-11 04:53:54.87464+00
43	offers	0003_auto_20211129_1350	2021-12-11 04:53:54.882665+00
44	orders	0001_initial	2021-12-11 04:53:54.997664+00
45	orders	0002_auto_20211124_1010	2021-12-11 04:53:55.027929+00
46	orders	0003_auto_20211124_1052	2021-12-11 04:53:55.114772+00
47	orders	0004_order_payment_option	2021-12-11 04:53:55.127844+00
48	orders	0005_auto_20211125_0902	2021-12-11 04:53:55.157608+00
49	orders	0006_auto_20211125_1038	2021-12-11 04:53:55.202707+00
50	orders	0007_ordervehicle_paid	2021-12-11 04:53:55.227548+00
51	orders	0008_auto_20211126_1531	2021-12-11 04:53:55.27277+00
52	orders	0009_ordervehicle_status	2021-12-11 04:53:55.288759+00
53	orders	0010_order_discount_price	2021-12-11 04:53:55.307567+00
54	sessions	0001_initial	2021-12-11 04:53:55.317795+00
55	showroom	0009_reviewrating	2021-12-11 04:53:55.367752+00
56	superadmin	0001_initial	2021-12-11 04:53:55.412703+00
57	user	0002_auto_20211113_0835	2021-12-11 04:53:55.43271+00
58	user	0003_account_otp_verified	2021-12-11 04:53:55.447573+00
59	user	0004_address	2021-12-11 04:53:55.488646+00
60	user	0005_auto_20211211_1117	2021-12-11 05:49:13.091796+00
61	orders	0002_auto_20211212_0157	2021-12-11 20:27:36.582499+00
62	user	0002_auto_20211212_0157	2021-12-11 20:27:36.643562+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
3osmdcr4mhpotbg9ok1a8clb7rppo9i0	e30:1morRz:OILiwWjGy61Pza7ZKUQV4Qm2qOWk0fPHZas15--V27Q	2021-12-05 18:20:27.51+00
4fxrehr4557ctadza3tlteebq1afu6h6	.eJxVjDsOwyAQBe9CHSHWGHikTJ8zWLBLYudjJH-qKHdPLLlx-2bmfdS75uFV1FnBGoIHIqmT6tK69N06l6kbZIPHLSd-lnED8kjjvWqu4zINWW-K3umsr1XK67K7h4M-zf2_Lt5TWwhBkEPj6MZshJ3PIUaQcSSemxy4tYadidZGCgYWEgUMQH1_wno8Tw:1mpPsL:9nxuHtgFe3LSIa1CwpiI2YmjRCq0W1ZNQ7ludLMnAVU	2021-12-07 07:05:57.807+00
542o4e9w4kjt7x19rptfwttkridwu72i	.eJxdzzFuwzAMBdC7aC4EixQlOmP2nsGgbLp24liBLXcJcvcqQDq0K9__H-DD3HKaFzUnw9g4DsxtNB-mk6NM3bHr1s1DxX-3JP1V1xcMF1m_su3zWrY52VfEvnW3n3nQ5fzO_hmYZJ9qm3wvAdUhxWYkLwkct31Aan2I6hghBgeAoUVKg1YbRTyR9w1GcqmOllxk6Tb91vWobwAAxwhsm_Br9y2PczEnchBcjNYT8vMHsgFMbg:1mvgv3:mjsrpH9A5b0yw_ZTD68mjFbmKAu6dlLz546d1Z9bv8U	2021-12-24 14:30:41.722+00
862x1tpvin3rfl39zj3834ndg8fmr0ks	.eJxVjbkKwzAQRP9FdRC6j5Tp_Q1ipV1HThwLfFQh_x4b3BimmveY-bJPy8NI7M6i1TF4ZbRkN5ZgW2vaFprTgDuU4lpmKG-aDoIvmJ6Nlzat85D5ofCTLrxrSOPjdC8DFZZ6nAqbvRMFgrYQyCIGrzWg9VI4q3rlo5E5ZEIVEVWIe3oUgNIZ9OTY7w_sJz0x:1mrupz:5_C63t5tC7DMhS_bowjnz8GTpirfjgAfD6rzh_DBnjQ	2021-12-14 04:33:51.387+00
89h0mm45ofyaatxev53s4dq11hmvt05q	.eJxVj80OwiAQhN-FsyH8lAIevfsMZOnSFlvBUJqYGN9daryY7GXmm8xmXuSefVwDOROrpDVadJKTE3Gw19ntWyguYoOc_ZsehiWkg-AN0pTpkFMt0dMjQn90o9eMYb38sn8FM2zz8ZQpr3s2gJEKTFCIRksJqDRnvRKj0Lbj3viAwiIKY9uNyAB536EOfSv1OS8xTe5R4tB2sBOpucLqKjybok1PBRK6r_t13h8kC041:1mruoK:sHNs6IWn73cQ4g9CNUzMwry8mJU5ySDJ-hbtfsK7gpA	2021-12-14 04:32:08.168+00
8gtko5vogcxzzgj71vyflhbfvsgpktbc	e30:1morS7:RSY2kwuzbu8qxcAiRk_f3CP522lkVAs6RoLaQeMK_ek	2021-12-05 18:20:35.122+00
9sldej0h0ob3rs6sle3f0hiek78e4c67	.eJxVjMsOwiAQAP-FsyEs5bF49O43kAVWqRqalPZk_HdD0oNeZybzFpH2rca98xrnIs4CxOmXJcpPbkOUB7X7IvPStnVOciTysF1el8Kvy9H-DSr1OrYTQk5cGLyfwBrvjNLoHCWlEJMDg0GzvRkIAUsC9JCzJtDstVXeis8XsD82VA:1mrBu2:-nmJWlYadO58lr7KIDcivuGav75hziR3bxwnm8J2jKM	2021-12-12 04:35:02.684+00
acx0rpovvwv05xoup177bl91iq5yebmv	.eJxVjDsOwyAQBe9CHSHWGHikTJ8zWLBLYudjJH-qKHdPLLlx-2bmfdS75uFV1FnBGoIHIqmT6tK69N06l6kbZIPHLSd-lnED8kjjvWqu4zINWW-K3umsr1XK67K7h4M-zf2_Lt5TWwhBkEPj6MZshJ3PIUaQcSSemxy4tYadidZGCgYWEgUMQH1_wno8Tw:1mp7Hf:ZY4axf1XDTcXiRrhlEaPFqMM0Nv2fWPkbbFAd41LPQM	2021-12-06 11:14:51.586+00
aonzyu17g0nvq1bqe34re7hvqivm7uyf	.eJxVjTsOgzAQRO_iOrJYG7N2yvScAe2uTSAhWOJTRbl7jERDMc28-XzVJ_M4JXVXwdng0dQW1E11tG9Dt69p6cZYYHP1mOSd5gPEF83PrCXP2zKyPiL6pKtuc0zT48xeBgZah9KG2kVBRo_BQnmvqGdkFokuFIGxwVZivMVeGvQ9CEEAZxyBAd_U6vcHzng8mA:1mp3o8:NlMWANcsF0OA_wR6U3O82GgqqxXPASYNpsZt3G1_erM	2021-12-06 07:32:08.533+00
brx4ac10buzk599kn4ngpqzfzgu0hsvl	.eJxVjTsOgzAQRO_iOrJYG7N2yvScAe2uTSAhWOJTRbl7jERDMc28-XzVJ_M4JXVXwdng0dQW1E11tG9Dt69p6cZYYHP1mOSd5gPEF83PrCXP2zKyPiL6pKtuc0zT48xeBgZah9KG2kVBRo_BQnmvqGdkFokuFIGxwVZivMVeGvQ9CEEAZxyBAd_U6vcHzng8mA:1mp2ou:GO_CzfB-vJjtQzYme1VIR9N6uZnWbclmgfNXdTKVE-E	2021-12-06 06:28:52.806+00
cgrfw3qd67wks3da56g2umo3rojx17mg	.eJxVjDsOwjAQBe_iGlmx1-sPJX3OEK3tDQmEWMqnQtwdR0oB7Zt58xYd7dvQ7Ssv3ZjFVThx-d0ipSfPB8gPmu9FpjJvyxjlociTrrItmafb6f4FBlqH-kaTyAIrQNf0aChq5UOygMFYx8qDdlZpDTYAxsyV9UQG0ZgGHKpYo68Sx4lry0OjvPU-KPH5Ap7LO9c:1mnu09:_QRLuiQrY4yLwDvhZXN1gI-OJ1HakVDdpsN9nE27EdQ	2021-12-03 02:51:45.049+00
cpxkoxcgv79hwyi9li3t1cisl66vgrkj	e30:1moyqf:h9ylLSIO7vR_qRPNUBjP1lK1pIFcZGDVKzuhb6qRrQ8	2021-12-06 02:14:25.512+00
d1aeeemc0tg3se9etqipj01pc9lg7eoz	e30:1mpBWt:dqbCCAONs-tnHooSUxVmiafg2OeMbsanVwRlkGjNHPw	2021-12-06 15:46:51.277+00
gipw8cdega1h5eba4p4ylc0rba0c17ob	.eJxVjTsOgzAQRO_iOrJYG7N2yvScAe2uTSAhWOJTRbl7jERDMc28-XzVJ_M4JXVXwdng0dQW1E11tG9Dt69p6cZYYHP1mOSd5gPEF83PrCXP2zKyPiL6pKtuc0zT48xeBgZah9KG2kVBRo_BQnmvqGdkFokuFIGxwVZivMVeGvQ9CEEAZxyBAd_U6vcHzng8mA:1mp5as:i5dZAwAVQYqTu1faplOFXQC8he9gv3JuvUeJU90lLbQ	2021-12-06 09:26:34.594+00
hsvgiwl0i82qgt1p4tqdn83agnpgtwfs	.eJxVjDkOgzAURO_iOrK88bFTpucMyH8hkBAssVRR7h6QaKhGmvdmvupTcBhF3VX0xkaIMVl1U23e1r7dFpnbgXforh1mest0AH7l6Vk0lWmdB9SHok-66KawjI_TvRz0een3tXcBXIh7dEk6yRWhD2xrYBZIRL62VSALAYJBEfYZU2cNOyYWA6h-f9KrPdM:1mnaQR:y0JEBF54o3SqrhJaYge506SJfR03oxhR1DPhOs0rKEY	2021-12-02 05:57:35.13+00
lf68sqb3npzqoh14x2wolxcz17g3t3mm	.eJxlUMluwyAQ_RfONmIxMPjYe78Bsdo0LkQ2lipV_feSKK0adU6jt83yid6ry1tEMwJOqJAAmqIBGXu21ZxH3E0OnaT8GXTWX2K5MeHNlqViX0vbs8M3CX6wB36tIW4vD-1TwGqPtbs5V5E4rRhXLIL0Vmo_KSrABwVWOqeT5kGToFUiQigrmQSaSBQ2JOZTD3W1XnJZzHXPvt9BlZIDarXZzTT7gWYADORP0QEtuy3B3DXdAJRiwQbk63mtxYR89K40NPN_2M8Q8svcv5Ni349McYzg6TixKY2QRBqZIIFMnoKlgL6-AVKxcas:1mt35V:bYBJXQ4btmfdqbmkjqhywczfDh9N4sYxrpn9XS-itHk	2021-12-17 07:34:33.432+00
lzau2cvws4p8h6pl6uaye717hpwfz1kx	.eJxVj0uOwyAQRO_C2kIQA-72MvucATU_m4kDkU2kkUa5e8gom2zfqyqp_titurxFNjMYhQQDgJINzNKjrfZxxN3m0KX5Zo78NZa3CD9Ulsp9LW3Pjr8j_GMPfqkhbudP9mtgpWPtbemVnozHpNGkCQSeVBgTYFRKhGS8CDQJQDyBAjNKFTSSRHCeTNI-qD7qar3mstj7nn2_gYgDa7XRZhv9slkhRz2wZacS7D9nsxQKOn2-AEiST5Q:1mretq:8rTE8bcG_vbqiB8_VGYQVvRjlNiE3hq9_oMW8-XGnTY	2021-12-13 11:32:46.705+00
p578yxtlloi9fa1bo4l5xbjnsl9dzqmg	e30:1morS8:kHR6Hr4WuPdCNcBQ_WsTvm2RCIeILbXWdv1AHHgEN_8	2021-12-05 18:20:36.584+00
py2t3mmlpp75yvhz0qih5h40k8s0esea	e30:1moPzE:k5GDFzuiCcBrLnpA2DfFIc5uHuSjaBFOzhvcAe2ELdg	2021-12-04 13:00:56.325+00
q8eexg0hszwczez5mkztkk46gqfij8cm	e30:1mokaO:E6zCHMapCv0PpLsz2B6OG1_DQ5drnWtFXFbVitF7M28	2021-12-05 11:00:40.292+00
r1w0yeff2bwr3xxym2dynya4589emjho	.eJxVjTkOgzAURO_iGll876ZMnzNY3wtLQmwJTBXl7jESDcU082b5kmnDHF0tFVcycBCKGtmRT_HLmshArOTWaCY4kI44POrsjj1tbokNqrvnMbxTPkF8YZ4KDSXXbfH0jNCL7vRZYlofV_Y2MOM-tzYIGYP22mjLob33OHrtfQhR2iZg3PI-MMP1GJQ2IwQEC5JJBAZGCfL7Ayk_Qzo:1mpPL7:W4r61BrYRnXb2t7XrjeoMGe6yeWctMBwgjOeng__dtM	2021-12-07 06:31:37.324+00
ucklv7thqomd4vicakgha3yyno2npgk7	e30:1morSH:_JzpvPH9XYi-jFwic26o3uU2MDBzbajgDO1gnS5dnMk	2021-12-05 18:20:45.527+00
udsw66gal9tde17v74ays0wluoc8x7w0	e30:1mp3JR:k1w8icy3jBonK5i5uID7R0x3w7CY8qQ1wRhHew-VXoE	2021-12-06 07:00:25.777+00
uzq0i5qfdrdo930cpmxhb8kiarw3q7q8	.eJxVjsEOgjAQRP-lZ9PQbelSj979BrLbrYIiTSicjP8uTbhwm8x7mcxXfTKPU1JXFVobOgRnjbqonrZ16LeSln6UCs8dU3ynuQJ50fzMOuZ5XUbWVdEHLfqeJU23wz0NDFSGOgsP2yC13lsxloQ9oOv2LALBBrSmhSYigEtEuB9Mgmxiw86Tk8jq9we3Qzzi:1mrugg:jsctXcSUdUKzn7Msu7pAz_kpDFodg48RynJ6r0bRAcI	2021-12-14 04:24:14.334+00
vyxup35xx2ahg5f8dosgzlshs9kimlz0	e30:1mp3EJ:bu-wMRXmdZzcwA5YoCEYErd6Jqx89fE48xmHlVU-3sw	2021-12-06 06:55:07.296+00
xo21ynf88fost1gipwmwi9z3ovyk3d2k	.eJxVjMsKgzAURP8lawnemJgbl933G0Iet2q1CfjopvTfq2ihnc3AzOG8mHXr0tl1psn2kTUMWPG7eRcGSvsR7y61mYeclqn3fEf4-c78miONl5P9E3Ru7nZthRA8RQKtK1BS17IUWNfOlyWir0GiEaRuEozB6AE1hCAcCNJClVptUhcffdpURxdsyYsb7URPSiuxRkijjOZSmCP4JXzOQ5_amTWA6v0B0YVMQQ:1muYZk:q926ocB5--hetZHvu4RqiCUezsRo5nVJAiaxqqtO2kk	2021-12-21 11:24:00.103+00
y5ebq1pedo48amvhqc3ek47kaj10fvle	e30:1morS7:RSY2kwuzbu8qxcAiRk_f3CP522lkVAs6RoLaQeMK_ek	2021-12-05 18:20:35.806+00
ya2mh631zifruv7pqxztvj1j5qywhkhe	e30:1morS9:y3UgqLuuv25S6UGNP03qbnIG-LmOsF5IVFmZoRFAn3w	2021-12-05 18:20:37.445+00
yrta62lm1595tsva82njgmgxjrzp0ald	e30:1morSG:PG8uanoB-OBrpkCTOJANiX-JgXl0ILTf4KMEDfhWjR8	2021-12-05 18:20:44.147+00
zteh87fkcr4orindaiaht1fsulz17u6j	e30:1morSK:7rUFx2zlthScujuCJOSmebVqJwqIa1h75qD4TJh7vXU	2021-12-05 18:20:48.409+00
7rc4kwrrokityr05cgnjtni1wiuh07h8	.eJxdT01PhTAQ_C89E9LSBdp3NJrIwURjjMdm-wGUx2tJAc2L8b9bzLto9rI7M7sz-0UuUfvZkRMRnDLRCCEZKYjCfRvVvrqkvM0k-wdqNGcXDsZOGIZYmhi25HV5SMobu5ZP0br57qb9c2DEdczbEmwLraC86rGmsjUgNYB2ta7BQW-kQayh7XvRGBQgHDauQck1hbYx_Eil96sK8VN9YPIYtt-8nBbExH2JQVm_5i7jS_Im_5mZIWGwSsd49mFQW9xwVm-v9-RUUVEyVpCYrEtdBkhFK8aqXNlowevF3QyOQXXvnZ8o2Mfnlwc-ke8fc4drJg:1mw93A:EOOCOaRptU3AovuTMsktFg1-RksYriZeLWOUVEmh0DU	2021-12-25 20:32:56.296613+00
\.


--
-- Data for Name: offers_vehicleoffer; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.offers_vehicleoffer (id, discount, is_active, vehicle_id, vendor_id) FROM stdin;
4831ed2c-b163-4ac0-ac30-732997884786	0	f	15	3
4ba04767-0131-4e00-9b55-7ef684e85ae3	0	f	13	1
56e521dd-681a-4ea1-b66e-8dbbbef7ca65	12	t	3	3
6c0959e7-6572-466c-8a8b-577ee0d57000	0	f	17	3
7819be0f-b876-4f36-a630-5b68174eeaf8	0	f	11	3
8551f1b2-f0ab-4b2f-bba8-11d1b5857b93	0	f	16	3
bcedad18-b9e5-43cd-8141-ed6d60a8aa63	11	t	4	3
bd2d5c22-bee4-4b18-af36-611c527c47d6	0	f	14	3
c4d3ffc8-d388-4c54-9484-df3624da5554	0	f	12	1
\.


--
-- Data for Name: orders_order; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.orders_order (id, full_name, address_line_1, country, city, zip_code, mobile, landmark, address_line_2, order_number, order_total, tax, status, ip, is_ordered, created_at, updated_at, payment_id, user_id, state, payment_option, pending_amount, discount_price) FROM stdin;
1	ameer	kaizen	India	calicut	673641	8301868891		kuttichira	202112121	14999	749.95	New	127.0.0.1	t	2021-12-11 20:32:38.53946+00	2021-12-11 20:32:55.867464+00	138	11	kerala	Razorpay	8900000	0
\.


--
-- Data for Name: orders_ordervehicle; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.orders_ordervehicle (id, ordered, created_at, updated_at, order_id, payment_id, user_id, variant_id, vehicle_id, price, quantity, paid, vendor_id, status) FROM stdin;
1	t	2021-12-11 20:32:55.894207+00	2021-12-11 20:32:55.894207+00	1	138	11	30	15	8900000	1	15748.95	3	Offline verification Pending
\.


--
-- Data for Name: orders_payments; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.orders_payments (id, payment_id, payment_method, amount_paid, status, created_at, user_id) FROM stdin;
28	03S376276K799830G	Paypal	999.0	COMPLETED	2021-11-26 10:04:45.349+00	6
29	8G2042194E793021C	Paypal	999.0	COMPLETED	2021-11-27 02:32:16.958+00	6
30	62D908025R799890R	Paypal	1998.0	COMPLETED	2021-11-27 04:20:24.96+00	6
31	2US61571YJ583701F	Paypal	2997.0	COMPLETED	2021-11-27 04:30:04.074+00	6
32	25V501607C920852G	Paypal	1998.0	COMPLETED	2021-11-27 05:05:12.795+00	6
33	3EB58851M4105511T	Paypal	1998.0	COMPLETED	2021-11-27 05:19:45.449+00	6
34	67V16546BD9125907	Paypal	999.0	COMPLETED	2021-11-27 14:11:39.9+00	6
35	81M57263SM4575201	Paypal	999.0	COMPLETED	2021-11-27 15:51:06.04+00	6
36	06R90750SB643651B	Paypal	999.0	COMPLETED	2021-11-27 15:56:44.644+00	6
37	7CX908577N144963M	Paypal	999.0	COMPLETED	2021-11-28 05:08:39.285+00	6
38	85T07204P6557845L	Paypal	999.0	COMPLETED	2021-11-28 05:13:20.311+00	6
39	9WY00792HT617343X	Paypal	999.0	COMPLETED	2021-11-28 10:03:54.106+00	6
40	1764456481457131K	Paypal	999.0	COMPLETED	2021-11-28 11:33:11.691+00	6
41	7PT501579E119391V	Paypal	1998.0	COMPLETED	2021-11-29 10:40:36.998+00	6
42	3BG73685E1356621P	Paypal	999.0	COMPLETED	2021-11-29 10:51:41.599+00	6
43	6PD5601530583874U	Paypal	999.0	COMPLETED	2021-11-29 11:34:18.046+00	6
44	5M0304656H100300N	Paypal	999.0	COMPLETED	2021-11-30 04:17:50.868+00	6
45	8G8191605M5599826	Paypal	4995.0	COMPLETED	2021-11-30 05:15:52.657+00	6
46	52E60085088226440	Paypal	999.0	COMPLETED	2021-11-30 14:49:54.083+00	6
47	96J88737W46669027	Paypal	1999.0	COMPLETED	2021-12-01 04:58:30.808+00	11
48	484655817K2864040	Paypal	1999.0	COMPLETED	2021-12-01 05:00:44.46+00	11
49	11T23371NW713194P	Paypal	1999.0	COMPLETED	2021-12-01 05:02:18.335+00	11
50	58L94627V66873412	Paypal	999.0	COMPLETED	2021-12-01 05:06:35.982+00	11
51	5D758774NS499104B	Paypal	1999.0	COMPLETED	2021-12-01 05:10:15.443+00	11
52	26K94493BG654512C	Paypal	4886.0	COMPLETED	2021-12-01 05:11:44.021+00	11
53	1P957552BT541212W	Paypal	1999.0	COMPLETED	2021-12-01 06:50:57.904+00	11
54	6U2749240L436803E	Paypal	888.0	COMPLETED	2021-12-01 06:52:14.055+00	11
55	4Y281133KW778405X	Paypal	789.0	COMPLETED	2021-12-01 12:01:02.344+00	11
56	5AD40225CN2428007	Paypal	555.0	COMPLETED	2021-12-01 13:18:06.197+00	11
57	9FK999516H9726605	Paypal	789.0	COMPLETED	2021-12-02 02:36:18.464+00	11
58	6RH93338J7666900N	Paypal	888.0	COMPLETED	2021-12-02 10:24:28.157+00	11
59	2CC83714NX6474006	Paypal	1999.0	COMPLETED	2021-12-02 10:49:40.583+00	11
60	71327301XY471431F	Paypal	1999.0	COMPLETED	2021-12-02 10:50:52.917+00	11
61	9JF535806R099284K	Paypal	1999.0	COMPLETED	2021-12-02 11:12:16.825+00	11
62	3K464850NG0548849	Paypal	1999.0	COMPLETED	2021-12-02 11:15:02.308+00	11
63	9KS82081WV1908545	Paypal	888.0	COMPLETED	2021-12-02 12:01:56.082+00	11
64	3M165460D7475334C	Paypal	888.0	COMPLETED	2021-12-02 12:04:10.447+00	11
65	18958727DY000000G	Paypal	888.0	COMPLETED	2021-12-02 12:53:31.774+00	11
66	9343168958039781X	Paypal	888.0	COMPLETED	2021-12-03 12:26:45.282+00	11
67	87M574315R966271D	Paypal	888.0	COMPLETED	2021-12-03 12:51:18.204+00	11
68	31G84592BF007415D	Paypal	861.36	COMPLETED	2021-12-03 12:55:37.378+00	11
69	9Y057495MX5093225	Paypal	1776.0	COMPLETED	2021-12-03 13:39:17.84+00	11
70	4J403131205999842	Paypal	861.36	COMPLETED	2021-12-03 14:14:06.062+00	11
71	31M37281S5750231B	Paypal	861.36	COMPLETED	2021-12-04 02:27:27.82+00	11
72	pay_ITHeTfDZkt2v7N	razorpay	1722.72	True	2021-12-04 05:33:10.907+00	11
73	pay_ITI0ngEcfbSSVA	razorpay	888.0	True	2021-12-04 05:54:17.979+00	11
74	pay_ITIGyBnwcPC5fa	razorpay	861.36	True	2021-12-04 06:09:38.904+00	11
75	pay_ITIJK1DooCDdu5	razorpay	861.36	True	2021-12-04 06:11:49.946+00	11
76	pay_ITIOskFRMKljtF	razorpay	888.0	True	2021-12-04 06:17:06.04+00	11
77	pay_ITIRlJ34n7EnL4	razorpay	888.0	True	2021-12-04 06:19:49.011+00	11
78	pay_ITIVYlKLiZx0Pu	razorpay	861.36	True	2021-12-04 06:23:25.92+00	11
79	pay_ITItrZ3oLTpMM7	razorpay	1939.03	True	2021-12-04 06:46:25.801+00	11
80	14A742489B136181D	Paypal	870.24	COMPLETED	2021-12-04 06:48:06.27+00	11
81	2ED53667N97042418	Paypal	870.24	COMPLETED	2021-12-04 06:59:30.013+00	11
82	75288094AM351504E	Paypal	870.24	COMPLETED	2021-12-04 07:00:44.886+00	11
83	81S92322LW360000F	Paypal	1939.03	COMPLETED	2021-12-04 07:09:11.685+00	11
84	pay_ITJJA0rAcynWGS	razorpay	870.24	True	2021-12-04 07:10:22.505+00	11
85	pay_ITeHfyhV58UHw5	razorpay	555.0	True	2021-12-05 03:41:32.143+00	11
86	7EB88302LW0937904	Paypal	1939.03	COMPLETED	2021-12-05 04:07:29.286+00	11
87	71S92710T81519902	Paypal	1959.02	COMPLETED	2021-12-05 04:10:42.897+00	11
88	pay_ITfJBeCAjkRT7N	razorpay	1939.03	True	2021-12-05 04:41:40.351+00	11
89	7RX25125M2103880R	Paypal	1776.0	COMPLETED	2021-12-06 05:59:33.191+00	11
90	0XX6939120315011R	Paypal	1999.0	COMPLETED	2021-12-06 06:07:11.404+00	11
91	8RA04563NN730864D	Paypal	888.0	COMPLETED	2021-12-06 06:09:36.368+00	11
92	9LA5021716550483D	Paypal	888.0	COMPLETED	2021-12-06 06:13:13.979+00	11
93	4SN13621K3875721G	Paypal	888.0	COMPLETED	2021-12-06 06:29:43.978+00	11
94	8LT0106990839825W	Paypal	1999.0	COMPLETED	2021-12-06 08:53:59.857+00	11
95	8YT48619U07844100	Paypal	1999.0	COMPLETED	2021-12-06 09:12:25.459+00	11
96	46K27548RL258171T	Paypal	888.0	COMPLETED	2021-12-06 09:13:05.068+00	11
97	73825909AX293742A	Paypal	1939.03	COMPLETED	2021-12-06 09:15:41.558+00	11
98	26V553241C9035223	Paypal	888.0	COMPLETED	2021-12-06 10:02:37.586+00	11
99	0PH30264NJ046774G	Paypal	5997.0	COMPLETED	2021-12-06 10:35:59.152+00	11
100	75M116739F666361R	Paypal	888.0	COMPLETED	2021-12-06 14:03:43.082+00	11
101	78B3121992109691K	Paypal	888.0	COMPLETED	2021-12-06 14:33:16.433+00	11
102	2HX403750C961160X	Paypal	888.0	COMPLETED	2021-12-06 14:35:30.902+00	11
103	71A08398BT7043041	Paypal	1999.0	COMPLETED	2021-12-07 06:45:54.433+00	11
104	38B77711FJ841753A	Paypal	1999.0	COMPLETED	2021-12-07 06:47:34.291+00	11
105	pay_IUXmU5aIhui00X	razorpay	5997.0	True	2021-12-07 09:58:53.349+00	11
106	2T049127KL337342F	Paypal	499.0	COMPLETED	2021-12-07 16:30:03.984+00	11
107	15U93662CJ493402V	Paypal	499.0	COMPLETED	2021-12-07 16:31:58.045+00	11
108	pay_IUsTE2Wmzct2Ti	razorpay	789.0	True	2021-12-08 06:13:13.077+00	11
109	pay_IUt6fiPE5aQglS	razorpay	1111.0	True	2021-12-08 06:50:35.477+00	11
110	pay_IUuTCBs0nSZwOv	razorpay	489.02	True	2021-12-08 08:10:34.109+00	11
111	pay_IV2xXTBl69oDR1	razorpay	14999.0	True	2021-12-08 16:28:50.476+00	11
112	pay_IVKKLcTwB7OuBT	razorpay	14997.0	True	2021-12-09 09:29:52.687+00	11
113	pay_IVhe30bE6eoeGq	razorpay	9999.0	True	2021-12-10 08:16:47.959+00	11
114	pay_IVhjcUFnW8iSKj	razorpay	4999.0	True	2021-12-10 08:22:04.401+00	11
115	pay_IVi4wFM9unsWDE	razorpay	9999.0	True	2021-12-10 08:42:16.794+00	11
116	pay_IViIhnkObQKl6D	razorpay	14999.0	True	2021-12-10 08:55:17.096+00	11
117	pay_IViJnTZqeEdkIC	razorpay	4999.0	True	2021-12-10 08:56:20.334+00	11
118	pay_IViKVugi5z5CkC	razorpay	4999.0	True	2021-12-10 08:57:00.06+00	11
119	pay_IViL2KsWE3xQ5s	razorpay	9999.0	True	2021-12-10 08:57:29.932+00	11
120	pay_IViMYXmAfrNMGC	razorpay	9999.0	True	2021-12-10 08:58:56.113+00	11
121	pay_IViOvACtaQposF	razorpay	14999.0	True	2021-12-10 09:01:10.447+00	11
122	pay_IVkTyJWE8VKbpG	razorpay	4999.0	True	2021-12-10 11:03:22.782+00	11
123	2R5477983M374705H	Paypal	4999.0	COMPLETED	2021-12-10 11:08:55.729+00	11
124	pay_IVkjwZp5LKPeKs	razorpay	4999.0	COMPLETED	2021-12-10 11:18:29.408+00	11
125	pay_IVkrdpntX3GXVx	razorpay	4999.0	COMPLETED	2021-12-10 11:25:46.401+00	11
126	pay_IVkvcw6wgfdw38	razorpay	4999.0	COMPLETED	2021-12-10 11:29:32.39+00	11
127	pay_IVl60khPNjqxfi	razorpay	4999.0	COMPLETED	2021-12-10 11:39:22.808+00	11
128	pay_IVlCTcoNRKTJ9Z	razorpay	4999.0	COMPLETED	2021-12-10 11:45:29.915+00	11
129	74S48956FS657112H	Paypal	4999.0	COMPLETED	2021-12-10 11:47:22.914+00	11
130	3AY66856F1197862U	Paypal	4999.0	COMPLETED	2021-12-10 11:48:04.843+00	11
131	9US84548BR2402403	Paypal	4999.0	COMPLETED	2021-12-10 11:48:32.301+00	11
132	pay_IVlYyZ1TtCHwyz	razorpay	4999.0	COMPLETED	2021-12-10 12:06:50.065+00	11
133	pay_IVmGo0QmAJz4hy	razorpay	4999.0	COMPLETED	2021-12-10 12:48:17.437+00	11
134	pay_IVo8HU7zCB6hL6	razorpay	4999.0	COMPLETED	2021-12-10 14:37:35.73+00	11
135	pay_IVoE4uE4qPFgYA	razorpay	4999.0	COMPLETED	2021-12-10 14:43:04.235+00	11
136	pay_IVoHt0ds1gNym9	razorpay	14999.0	COMPLETED	2021-12-10 14:46:40.691+00	11
137	pay_IVoMeDiLEvB7oq	razorpay	14999.0	COMPLETED	2021-12-10 14:51:10.836+00	11
138	pay_IWIij04dHPQE3j	razorpay	14999.0	COMPLETED	2021-12-11 20:32:55.863703+00	11
\.


--
-- Data for Name: showroom_reviewrating; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.showroom_reviewrating (id, subject, review, rating, ip, status, created_at, updated_at, user_id, vehicle_id) FROM stdin;
1	good	super	3	127.0.0.1	t	2021-11-29 15:43:32.12+00	2021-11-30 04:45:22.605+00	6	3
2	Best Driving	i love this vehicle	4	127.0.0.1	t	2021-11-29 16:00:43.006+00	2021-11-29 16:16:42.958+00	1	3
3	Awesome	Worth of money	5	127.0.0.1	t	2021-12-08 06:33:34.628+00	2021-12-08 06:33:34.628+00	11	12
4	Loved it	Better than i expected	4.5		t	2021-12-08 23:54:20.067+00	2021-12-08 23:54:20.067+00	6	17
5	Thanks to OLA	My first EV\r\nWorth of money	3.5		t	2021-12-08 23:56:45.76+00	2021-12-08 23:56:45.76+00	6	13
6	Powerful and gorgeous	loved riding a tiger	4.5		t	2021-12-08 23:58:08.676+00	2021-12-08 23:58:08.676+00	6	16
7	Best OFF road vehicle i bought	Excellent performance	5		t	2021-12-08 23:59:53.999+00	2021-12-08 23:59:53.999+00	6	14
8	Best sport car i driven	Awesome performance	4		t	2021-12-09 00:01:41.13+00	2021-12-09 00:01:41.13+00	6	4
9	Best GT	loved to ride	4		t	2021-12-09 00:02:23.98+00	2021-12-09 00:02:23.98+00	6	11
10	Best Muscle car	awesome feeling	5		t	2021-12-09 00:03:42.769+00	2021-12-09 00:03:42.769+00	6	15
\.


--
-- Data for Name: showroom_variant; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.showroom_variant (id, color, color_name, slug, image1, image2, image3, price, remaining, vehicle_id_id, is_available) FROM stdin;
10	#c9c9c9			photos/vehicles/2021_ford_bronco_base_004.jpg	photos/vehicles/2021_broncosport_1sted_cactus.webp	photos/vehicles/2021_ford_bronco_outer-banks_003.jpg	11300000	35	3	t
11	#ff0000	w	w	photos/vehicles/RedBroncoTop.png	photos/vehicles/ford-bronco-india.jpg	photos/vehicles/33c4150f4e3960aa363566bbcd209a2b.png	12344333	0	3	t
12	#000000	q	q	photos/vehicles/170488983-3594158584024098-4131151689824896766-n-1618413905.jpg	photos/vehicles/Maxlider-Motors-Ford-Bronco-6x6-02-1024x1024.jpeg	photos/vehicles/Maxlider-Motors-Ford-Bronco-6x6-03-1024x1024.jpeg	14533231	215	3	t
17	#ffffff			photos/vehicles/cc_2021foc050116_01_640_yz_KjCnSDA.jpg	photos/vehicles/cc_2017foc050002_02_640_yz_s669USb.jpg	photos/vehicles/h2mlora_1420636_1.jpg	9999999	23	4	t
24	#000000			photos/vehicles/61005-6-_decal-sample_20190908_8-scaled_Yiq4C1Z.jpg	photos/vehicles/vxllora_1420634_mjlvvpy.jpg	photos/vehicles/2021_10_10377_88653_000.jpg	9200000	198	4	t
25	#ffec1a			photos/vehicles/72944e-scaled-removebg-preview.png	photos/vehicles/ford-gt-2017-triple-yellowblack-stripes-autoart-118-72944-removebg-preview.png	photos/vehicles/s-l640-removebg-preview.png	23000000	300	11	t
26	#f2f2f2			photos/vehicles/Capturegd-removebg-preview.png	photos/vehicles/hfg-removebg-preview.png	photos/vehicles/Capture_io-removebg-preview.png	99999	2000	12	t
27	#f0ff1f			photos/vehicles/dada-removebg-preview.png	photos/vehicles/dsa-removebg-preview.png	photos/vehicles/Capturesadas-removebg-preview.png	119999	1999	12	t
28	#ff3d3d			photos/vehicles/hsh-removebg-preview.png	photos/vehicles/jgfh-removebg-preview.png	photos/vehicles/oluk-removebg-preview.png	129999	1998	13	t
29	#fb8313			photos/vehicles/Ford-Ranger-Raptor-Custom_1812-removebg-preview.png	photos/vehicles/Ford-Ranger-Raptor-Custom_1816-removebg-preview.png	photos/vehicles/Ford-Ranger-Raptor-Custom_1815-600x400-1-removebg-preview.png	6700000	49	14	t
31	#949494			photos/vehicles/gsdfsf-removebg-preview.png	photos/vehicles/gregefaf-removebg-preview.png	photos/vehicles/gsdfga-removebg-preview.png	6700000	50	16	t
32	#b9cd1d			photos/vehicles/hrthaerg-removebg-preview.png	photos/vehicles/hrgrefgea-removebg-preview.png	photos/vehicles/hergaer-removebg-preview.png	61999999	49	17	t
30	#ff3838			photos/vehicles/2021-Dodge-Challenger-SRT-Super-Stock-front-removebg-preview.png	photos/vehicles/2020-Dodge-Challenger-SRT-Super-Stock-30-removebg-preview.png	photos/vehicles/dg020-138cl9lvv3sbdupb13acjkprtsvullq-1597415175-removebg-preview.png	8900000	45	15	t
\.


--
-- Data for Name: showroom_vehicle; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.showroom_vehicle (id, vehicle_name, slug, range, top_speed, created_date, modified_date, category_id, gif, no_of_seats, vendor_id_id, is_available) FROM stdin;
3	Bronco	bronco	345	234	2021-11-19 02:56:13.883+00	2021-11-19 02:56:13.883+00	3	https://c.tenor.com/Y8An9OjsIaUAAAAd/ford-bronco-bronco.gif	4	3	t
4	Mustang	mustang	344	245	2021-11-19 05:32:28.779+00	2021-11-19 05:32:28.779+00	2	https://i.pinimg.com/originals/23/5a/d4/235ad4421d02f1ea266c011f7f7df111.gif	2	3	t
11	FORD GT	ford-gt	234	304	2021-12-07 16:00:27.203+00	2021-12-07 16:00:27.203+00	2	https://thumbs.gfycat.com/PeskyViciousAmethystsunbird-max-1mb.gif	2	3	t
12	Ola S1	ola-s1	154	90	2021-12-07 16:19:51.965+00	2021-12-07 16:19:51.965+00	12	https://imgk.timesnownews.com/story/ola_elec_front_hq.jpg?tr=w-400,h-300,fo-auto	2	1	t
13	Ola S1 Pro	ola-s1-pro	180	110	2021-12-07 16:27:08.251+00	2021-12-07 16:27:08.251+00	12	https://imgk.timesnownews.com/story/ola_elec_front_hq.jpg?tr=w-400,h-300,fo-auto	2	1	t
14	Raptor	raptor	45	134	2021-12-07 16:47:58.574+00	2021-12-07 16:47:58.574+00	3	https://c.tenor.com/IaqDijNPdeIAAAAC/ford-f150-ford.gif	4	3	t
15	Dodge challenger	dodge-challenger	300	234	2021-12-07 16:58:45.298+00	2021-12-07 16:58:45.298+00	11	https://c.tenor.com/zKUOp5y0ZX4AAAAC/srt-dodge.gif	2	3	t
16	Boss 426	boss-426	300	189	2021-12-07 17:08:46.642+00	2021-12-07 17:08:46.642+00	11	https://64.media.tumblr.com/e85bea782c8029946dc4168b9e076e88/tumblr_p1xis9Qa911wtcg89o1_500.gifv	2	3	t
17	Lamborgini	lamborgini	400	345	2021-12-07 17:22:23.299+00	2021-12-07 17:22:23.299+00	1	https://i.gifer.com/7zBw.gif	2	3	t
\.


--
-- Data for Name: superadmin_bookingprice; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.superadmin_bookingprice (id, booking_price, category_id) FROM stdin;
1	4999	3
2	9999	1
3	9999	2
6	14999	11
7	4999	12
\.


--
-- Data for Name: user_account; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_account (id, password, first_name, last_name, email, mobile, gender, dp, date_joined, last_login, is_admin, is_staff, is_active, is_verified, is_superadmin, otp_verified) FROM stdin;
1	pbkdf2_sha256$216000$1yCkBXsKvEYH$V27SsYb7UPwdj4nLHWHS54ZlGuPbCOsKaAEHlnQeXtk=	admin	admin	admin@gmail.com	8324293382	Male		2021-11-15 16:36:04.522+00	2021-11-30 03:55:29.289+00	t	t	t	f	t	f
2	pbkdf2_sha256$216000$gRCl9aTx16cf$DNCKQ2Lms3iww95x5cBxVgLjWy3G3ob3p7wvdpnNc5Q=			ola@gmail.com	\N	\N		2021-11-16 10:51:17.796+00	2021-12-07 16:11:37.89+00	f	t	t	f	f	f
3	21	fs	fsa	eqwde@gmail.com	312	Male	photos/users_dp/pngegg_8.png	2021-11-16 12:59:26.679+00	2021-11-16 12:59:26.679+00	f	f	t	f	f	f
5	pbkdf2_sha256$216000$WCUT6Oi2ALTa$Lzw2+DU4lvKc5mJYorYtTy7VviL39Dt/WTbGPMOH5YY=			tata@gmail.com	\N	\N		2021-11-18 14:23:26.846+00	2021-11-18 14:24:03.507+00	f	t	t	f	f	f
6	pbkdf2_sha256$216000$V40ayFfdbG9D$qKUhGFAFtrl4XGoc0Dgwm7mDlz1JROMNMLL+PFU8C4A=	ameer	kk	sanin.fun@gmail.com	8301868845	Male		2021-11-18 16:23:52.339+00	2021-11-30 06:05:49.673+00	f	f	t	t	f	f
7	pbkdf2_sha256$216000$wsBAiJ3Ha0vg$QvAuVKuRMBG+8FqQ/FblN8HtB1c5qWJs3bdZlPB8pbE=			ford@gmail.com	\N	\N		2021-11-19 02:50:48.692+00	2021-12-07 16:37:18.473+00	f	t	t	f	f	f
8	pbkdf2_sha256$216000$j6dUFmIBUOlo$lqn8YzR05Y2GFO8tMk/ogyPlQ/P5XlHme8j87lcpaF8=			mini@gmail.com	\N	\N		2021-11-21 05:42:24.01+00	2021-11-23 07:05:57.77+00	f	t	t	f	f	f
10	pbkdf2_sha256$216000$kUyQLcknvy0X$4zXUCbEIkH5zqc8Bh5eU99hQh6g0jNOFOH420vfxHs0=	monoos	moloos	monoos@gmail.com	9539872431	Male		2021-11-30 04:27:25.297+00	2021-11-30 04:33:51.381+00	f	f	t	t	f	f
12	pbkdf2_sha256$216000$TgS9pul2j246$x2iWg7EYeDSbuAMOFz2HEnzWUlF6kunlJ4Fg2qZgUh8=			tvs@gmail.com	\N	\N		2021-12-02 11:51:39.116+00	2021-12-02 11:51:39.242+00	f	t	t	f	f	f
13	pbkdf2_sha256$216000$1pcRcw5m3hzJ$28mvnYSAcWQ9CKPAXApG7nNbW8GmApO6AendtgvkPUI=	da	da	ds@gmaik.com	8301568891	Male		2021-12-02 13:43:26.09+00	2021-12-02 13:44:22.933+00	f	f	t	t	f	t
14	pbkdf2_sha256$216000$9Ojuv3VG7fVx$w0LbEwXARmeWa3mMotF5WYaI9B3kOg8rnlSzXjGaRGU=	ramees	ew	neww@gmail.com	9495836716	Male		2021-12-11 08:50:18.399697+00	2021-12-11 08:50:18.399697+00	f	f	t	f	f	f
11	pbkdf2_sha256$216000$CpYGmpMVebWn$8+RVmbAe0F+/U3rkOYP4eEc30SdjzBtsaq5BSJZwnRk=	saninDAS	w	new@gmail.com	8301868891	Male		2021-11-30 05:21:17.237+00	2021-12-11 20:31:43.626584+00	f	f	t	t	f	f
\.


--
-- Data for Name: user_address; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_address (id, full_name, address_line_1, address_line_2, city, zip_code, state, country, mobile, landmark, "default", user_id) FROM stdin;
\.


--
-- Data for Name: vendor_vendor; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.vendor_vendor (id, vendor_name, "GST_number", email, mobile, logo, password, date_joined, last_login, is_admin, is_staff, is_verified, is_active, is_superadmin, is_mobile_verified) FROM stdin;
1	OLA	12231233	ola@gmail.com	8301868892	photos/vendors_logo/pngegg_8.png	1	2021-11-16 10:51:17.58+00	2021-11-16 10:51:17.58+00	f	t	t	t	f	t
2	Tata Motors	53455345	tata@gmail.com	8301868893	photos/vendors_logo/22588379-tata.530x298_qIflU4P.jpg	1234	2021-11-18 14:23:26.646+00	2021-11-18 14:23:26.646+00	f	t	t	t	f	t
3	Ford Motors	32231321	ford@gmail.com	8301868897	photos/vendors_logo/download.png	1234	2021-11-19 02:50:48.5+00	2021-11-19 02:50:48.5+00	f	t	t	t	f	t
4	MINI	34234432	mini@gmail.com	8301868891	photos/vendors_logo/mini_logo.jfif	1234	2021-11-21 05:42:23.786+00	2021-11-21 05:42:23.786+00	f	t	t	t	f	t
5	tvs	42344234	tvs@gmail.com	8301860891	photos/vendors_logo/ikyrkr.jfif	1234	2021-12-02 11:51:38.899+00	2021-12-02 11:51:38.899+00	f	t	t	t	f	t
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 88, true);


--
-- Name: banners_banner_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.banners_banner_id_seq', 18, true);


--
-- Name: cart_cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.cart_cart_id_seq', 94, true);


--
-- Name: cart_cartitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.cart_cartitem_id_seq', 1, false);


--
-- Name: category_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.category_category_id_seq', 12, true);


--
-- Name: coupons_redeemedcoupon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.coupons_redeemedcoupon_id_seq', 15, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 649, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 22, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 62, true);


--
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 1, true);


--
-- Name: orders_ordervehicle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.orders_ordervehicle_id_seq', 1, true);


--
-- Name: orders_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.orders_payments_id_seq', 138, true);


--
-- Name: showroom_reviewrating_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.showroom_reviewrating_id_seq', 10, true);


--
-- Name: showroom_variant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.showroom_variant_id_seq', 32, true);


--
-- Name: showroom_vehicle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.showroom_vehicle_id_seq', 17, true);


--
-- Name: superadmin_bookingprice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.superadmin_bookingprice_id_seq', 7, true);


--
-- Name: user_account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.user_account_id_seq', 14, true);


--
-- Name: vendor_vendor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.vendor_vendor_id_seq', 5, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: banners_banner banners_banner_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.banners_banner
    ADD CONSTRAINT banners_banner_pkey PRIMARY KEY (id);


--
-- Name: cart_cart cart_cart_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.cart_cart
    ADD CONSTRAINT cart_cart_pkey PRIMARY KEY (id);


--
-- Name: cart_cartitem cart_cartitem_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.cart_cartitem
    ADD CONSTRAINT cart_cartitem_pkey PRIMARY KEY (id);


--
-- Name: category_category category_category_name_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.category_category
    ADD CONSTRAINT category_category_name_key UNIQUE (category_name);


--
-- Name: category_category category_category_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.category_category
    ADD CONSTRAINT category_category_pkey PRIMARY KEY (id);


--
-- Name: category_category category_category_slug_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.category_category
    ADD CONSTRAINT category_category_slug_key UNIQUE (slug);


--
-- Name: coupons_coupon coupons_coupon_code_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.coupons_coupon
    ADD CONSTRAINT coupons_coupon_code_key UNIQUE (code);


--
-- Name: coupons_coupon coupons_coupon_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.coupons_coupon
    ADD CONSTRAINT coupons_coupon_pkey PRIMARY KEY (id);


--
-- Name: coupons_redeemedcoupon coupons_redeemedcoupon_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.coupons_redeemedcoupon
    ADD CONSTRAINT coupons_redeemedcoupon_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: offers_vehicleoffer offers_vehicleoffer_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.offers_vehicleoffer
    ADD CONSTRAINT offers_vehicleoffer_pkey PRIMARY KEY (id);


--
-- Name: offers_vehicleoffer offers_vehicleoffer_vehicle_id_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.offers_vehicleoffer
    ADD CONSTRAINT offers_vehicleoffer_vehicle_id_key UNIQUE (vehicle_id);


--
-- Name: orders_order orders_order_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.orders_order
    ADD CONSTRAINT orders_order_pkey PRIMARY KEY (id);


--
-- Name: orders_ordervehicle orders_ordervehicle_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.orders_ordervehicle
    ADD CONSTRAINT orders_ordervehicle_pkey PRIMARY KEY (id);


--
-- Name: orders_payments orders_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.orders_payments
    ADD CONSTRAINT orders_payments_pkey PRIMARY KEY (id);


--
-- Name: showroom_reviewrating showroom_reviewrating_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.showroom_reviewrating
    ADD CONSTRAINT showroom_reviewrating_pkey PRIMARY KEY (id);


--
-- Name: showroom_variant showroom_variant_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.showroom_variant
    ADD CONSTRAINT showroom_variant_pkey PRIMARY KEY (id);


--
-- Name: showroom_vehicle showroom_vehicle_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.showroom_vehicle
    ADD CONSTRAINT showroom_vehicle_pkey PRIMARY KEY (id);


--
-- Name: showroom_vehicle showroom_vehicle_slug_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.showroom_vehicle
    ADD CONSTRAINT showroom_vehicle_slug_key UNIQUE (slug);


--
-- Name: showroom_vehicle showroom_vehicle_vehicle_name_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.showroom_vehicle
    ADD CONSTRAINT showroom_vehicle_vehicle_name_key UNIQUE (vehicle_name);


--
-- Name: superadmin_bookingprice superadmin_bookingprice_category_id_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.superadmin_bookingprice
    ADD CONSTRAINT superadmin_bookingprice_category_id_key UNIQUE (category_id);


--
-- Name: superadmin_bookingprice superadmin_bookingprice_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.superadmin_bookingprice
    ADD CONSTRAINT superadmin_bookingprice_pkey PRIMARY KEY (id);


--
-- Name: user_account user_account_email_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_account
    ADD CONSTRAINT user_account_email_key UNIQUE (email);


--
-- Name: user_account user_account_mobile_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_account
    ADD CONSTRAINT user_account_mobile_key UNIQUE (mobile);


--
-- Name: user_account user_account_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_account
    ADD CONSTRAINT user_account_pkey PRIMARY KEY (id);


--
-- Name: user_address user_address_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_address
    ADD CONSTRAINT user_address_pkey PRIMARY KEY (id);


--
-- Name: vendor_vendor vendor_vendor_GST_number_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.vendor_vendor
    ADD CONSTRAINT "vendor_vendor_GST_number_key" UNIQUE ("GST_number");


--
-- Name: vendor_vendor vendor_vendor_email_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.vendor_vendor
    ADD CONSTRAINT vendor_vendor_email_key UNIQUE (email);


--
-- Name: vendor_vendor vendor_vendor_mobile_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.vendor_vendor
    ADD CONSTRAINT vendor_vendor_mobile_key UNIQUE (mobile);


--
-- Name: vendor_vendor vendor_vendor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.vendor_vendor
    ADD CONSTRAINT vendor_vendor_pkey PRIMARY KEY (id);


--
-- Name: vendor_vendor vendor_vendor_vendor_name_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.vendor_vendor
    ADD CONSTRAINT vendor_vendor_vendor_name_key UNIQUE (vendor_name);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: banners_banner_vehicle_id_4db9dbea; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX banners_banner_vehicle_id_4db9dbea ON public.banners_banner USING btree (vehicle_id);


--
-- Name: banners_banner_vendor_id_93cb2d74; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX banners_banner_vendor_id_93cb2d74 ON public.banners_banner USING btree (vendor_id);


--
-- Name: cart_cartitem_cart_id_370ad265; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX cart_cartitem_cart_id_370ad265 ON public.cart_cartitem USING btree (cart_id_id);


--
-- Name: cart_cartitem_user_id_292943b8; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX cart_cartitem_user_id_292943b8 ON public.cart_cartitem USING btree (user_id);


--
-- Name: cart_cartitem_variant_id_69f5d8c8; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX cart_cartitem_variant_id_69f5d8c8 ON public.cart_cartitem USING btree (variant_id);


--
-- Name: category_category_name_e3e43e48_like; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX category_category_name_e3e43e48_like ON public.category_category USING btree (category_name varchar_pattern_ops);


--
-- Name: category_category_slug_4f83d5f6_like; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX category_category_slug_4f83d5f6_like ON public.category_category USING btree (slug varchar_pattern_ops);


--
-- Name: coupons_coupon_code_40174643_like; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX coupons_coupon_code_40174643_like ON public.coupons_coupon USING btree (code varchar_pattern_ops);


--
-- Name: coupons_redeemedcoupon_coupon_id_088d1423; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX coupons_redeemedcoupon_coupon_id_088d1423 ON public.coupons_redeemedcoupon USING btree (coupon_id);


--
-- Name: coupons_redeemedcoupon_user_id_bd6af326; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX coupons_redeemedcoupon_user_id_bd6af326 ON public.coupons_redeemedcoupon USING btree (user_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: offers_vehicleoffer_vendor_id_cb1fbe3e; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX offers_vehicleoffer_vendor_id_cb1fbe3e ON public.offers_vehicleoffer USING btree (vendor_id);


--
-- Name: orders_order_payment_id_46928ccc; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX orders_order_payment_id_46928ccc ON public.orders_order USING btree (payment_id);


--
-- Name: orders_order_user_id_e9b59eb1; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX orders_order_user_id_e9b59eb1 ON public.orders_order USING btree (user_id);


--
-- Name: orders_ordervehicle_order_id_a803afe7; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX orders_ordervehicle_order_id_a803afe7 ON public.orders_ordervehicle USING btree (order_id);


--
-- Name: orders_ordervehicle_payment_id_4df2948a; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX orders_ordervehicle_payment_id_4df2948a ON public.orders_ordervehicle USING btree (payment_id);


--
-- Name: orders_ordervehicle_user_id_6f57636c; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX orders_ordervehicle_user_id_6f57636c ON public.orders_ordervehicle USING btree (user_id);


--
-- Name: orders_ordervehicle_variant_id_3d11b621; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX orders_ordervehicle_variant_id_3d11b621 ON public.orders_ordervehicle USING btree (variant_id);


--
-- Name: orders_ordervehicle_vehicle_id_5980119c; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX orders_ordervehicle_vehicle_id_5980119c ON public.orders_ordervehicle USING btree (vehicle_id);


--
-- Name: orders_ordervehicle_vendor_id_4737a809; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX orders_ordervehicle_vendor_id_4737a809 ON public.orders_ordervehicle USING btree (vendor_id);


--
-- Name: orders_payments_user_id_b0352926; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX orders_payments_user_id_b0352926 ON public.orders_payments USING btree (user_id);


--
-- Name: showroom_reviewrating_user_id_09794d0d; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX showroom_reviewrating_user_id_09794d0d ON public.showroom_reviewrating USING btree (user_id);


--
-- Name: showroom_reviewrating_vehicle_id_78523c7c; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX showroom_reviewrating_vehicle_id_78523c7c ON public.showroom_reviewrating USING btree (vehicle_id);


--
-- Name: showroom_variant_slug_db1609ad; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX showroom_variant_slug_db1609ad ON public.showroom_variant USING btree (slug);


--
-- Name: showroom_variant_slug_db1609ad_like; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX showroom_variant_slug_db1609ad_like ON public.showroom_variant USING btree (slug varchar_pattern_ops);


--
-- Name: showroom_variant_vehicle_id_id_9c667699; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX showroom_variant_vehicle_id_id_9c667699 ON public.showroom_variant USING btree (vehicle_id_id);


--
-- Name: showroom_vehicle_category_id_ccb65806; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX showroom_vehicle_category_id_ccb65806 ON public.showroom_vehicle USING btree (category_id);


--
-- Name: showroom_vehicle_slug_03f6cfe5_like; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX showroom_vehicle_slug_03f6cfe5_like ON public.showroom_vehicle USING btree (slug varchar_pattern_ops);


--
-- Name: showroom_vehicle_vehicle_name_ac879e25_like; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX showroom_vehicle_vehicle_name_ac879e25_like ON public.showroom_vehicle USING btree (vehicle_name varchar_pattern_ops);


--
-- Name: showroom_vehicle_vendor_id_id_2ee79119; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX showroom_vehicle_vendor_id_id_2ee79119 ON public.showroom_vehicle USING btree (vendor_id_id);


--
-- Name: user_account_email_d74bf2f6_like; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX user_account_email_d74bf2f6_like ON public.user_account USING btree (email varchar_pattern_ops);


--
-- Name: user_account_mobile_e9c10212_like; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX user_account_mobile_e9c10212_like ON public.user_account USING btree (mobile varchar_pattern_ops);


--
-- Name: user_address_user_id_64deb2c7; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX user_address_user_id_64deb2c7 ON public.user_address USING btree (user_id);


--
-- Name: vendor_vendor_GST_number_a84bbe0a_like; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX "vendor_vendor_GST_number_a84bbe0a_like" ON public.vendor_vendor USING btree ("GST_number" varchar_pattern_ops);


--
-- Name: vendor_vendor_email_3a95f7e4_like; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX vendor_vendor_email_3a95f7e4_like ON public.vendor_vendor USING btree (email varchar_pattern_ops);


--
-- Name: vendor_vendor_mobile_3c852241_like; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX vendor_vendor_mobile_3c852241_like ON public.vendor_vendor USING btree (mobile varchar_pattern_ops);


--
-- Name: vendor_vendor_vendor_name_83efab65_like; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX vendor_vendor_vendor_name_83efab65_like ON public.vendor_vendor USING btree (vendor_name varchar_pattern_ops);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: banners_banner banners_banner_vehicle_id_4db9dbea_fk_showroom_vehicle_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.banners_banner
    ADD CONSTRAINT banners_banner_vehicle_id_4db9dbea_fk_showroom_vehicle_id FOREIGN KEY (vehicle_id) REFERENCES public.showroom_vehicle(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: banners_banner banners_banner_vendor_id_93cb2d74_fk_vendor_vendor_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.banners_banner
    ADD CONSTRAINT banners_banner_vendor_id_93cb2d74_fk_vendor_vendor_id FOREIGN KEY (vendor_id) REFERENCES public.vendor_vendor(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cart_cartitem cart_cartitem_cart_id_id_615c8425_fk_cart_cart_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.cart_cartitem
    ADD CONSTRAINT cart_cartitem_cart_id_id_615c8425_fk_cart_cart_id FOREIGN KEY (cart_id_id) REFERENCES public.cart_cart(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cart_cartitem cart_cartitem_user_id_292943b8_fk_user_account_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.cart_cartitem
    ADD CONSTRAINT cart_cartitem_user_id_292943b8_fk_user_account_id FOREIGN KEY (user_id) REFERENCES public.user_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cart_cartitem cart_cartitem_variant_id_69f5d8c8_fk_showroom_variant_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.cart_cartitem
    ADD CONSTRAINT cart_cartitem_variant_id_69f5d8c8_fk_showroom_variant_id FOREIGN KEY (variant_id) REFERENCES public.showroom_variant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: coupons_redeemedcoupon coupons_redeemedcoupon_coupon_id_088d1423_fk_coupons_coupon_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.coupons_redeemedcoupon
    ADD CONSTRAINT coupons_redeemedcoupon_coupon_id_088d1423_fk_coupons_coupon_id FOREIGN KEY (coupon_id) REFERENCES public.coupons_coupon(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: coupons_redeemedcoupon coupons_redeemedcoupon_user_id_bd6af326_fk_user_account_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.coupons_redeemedcoupon
    ADD CONSTRAINT coupons_redeemedcoupon_user_id_bd6af326_fk_user_account_id FOREIGN KEY (user_id) REFERENCES public.user_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_user_account_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_user_account_id FOREIGN KEY (user_id) REFERENCES public.user_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offers_vehicleoffer offers_vehicleoffer_vehicle_id_469df19a_fk_showroom_vehicle_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.offers_vehicleoffer
    ADD CONSTRAINT offers_vehicleoffer_vehicle_id_469df19a_fk_showroom_vehicle_id FOREIGN KEY (vehicle_id) REFERENCES public.showroom_vehicle(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offers_vehicleoffer offers_vehicleoffer_vendor_id_cb1fbe3e_fk_vendor_vendor_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.offers_vehicleoffer
    ADD CONSTRAINT offers_vehicleoffer_vendor_id_cb1fbe3e_fk_vendor_vendor_id FOREIGN KEY (vendor_id) REFERENCES public.vendor_vendor(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_order orders_order_payment_id_46928ccc_fk_orders_payments_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.orders_order
    ADD CONSTRAINT orders_order_payment_id_46928ccc_fk_orders_payments_id FOREIGN KEY (payment_id) REFERENCES public.orders_payments(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_order orders_order_user_id_e9b59eb1_fk_user_account_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.orders_order
    ADD CONSTRAINT orders_order_user_id_e9b59eb1_fk_user_account_id FOREIGN KEY (user_id) REFERENCES public.user_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_ordervehicle orders_ordervehicle_order_id_a803afe7_fk_orders_order_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.orders_ordervehicle
    ADD CONSTRAINT orders_ordervehicle_order_id_a803afe7_fk_orders_order_id FOREIGN KEY (order_id) REFERENCES public.orders_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_ordervehicle orders_ordervehicle_payment_id_4df2948a_fk_orders_payments_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.orders_ordervehicle
    ADD CONSTRAINT orders_ordervehicle_payment_id_4df2948a_fk_orders_payments_id FOREIGN KEY (payment_id) REFERENCES public.orders_payments(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_ordervehicle orders_ordervehicle_user_id_6f57636c_fk_user_account_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.orders_ordervehicle
    ADD CONSTRAINT orders_ordervehicle_user_id_6f57636c_fk_user_account_id FOREIGN KEY (user_id) REFERENCES public.user_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_ordervehicle orders_ordervehicle_variant_id_3d11b621_fk_showroom_variant_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.orders_ordervehicle
    ADD CONSTRAINT orders_ordervehicle_variant_id_3d11b621_fk_showroom_variant_id FOREIGN KEY (variant_id) REFERENCES public.showroom_variant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_ordervehicle orders_ordervehicle_vehicle_id_5980119c_fk_showroom_vehicle_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.orders_ordervehicle
    ADD CONSTRAINT orders_ordervehicle_vehicle_id_5980119c_fk_showroom_vehicle_id FOREIGN KEY (vehicle_id) REFERENCES public.showroom_vehicle(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_ordervehicle orders_ordervehicle_vendor_id_4737a809_fk_vendor_vendor_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.orders_ordervehicle
    ADD CONSTRAINT orders_ordervehicle_vendor_id_4737a809_fk_vendor_vendor_id FOREIGN KEY (vendor_id) REFERENCES public.vendor_vendor(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_payments orders_payments_user_id_b0352926_fk_user_account_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.orders_payments
    ADD CONSTRAINT orders_payments_user_id_b0352926_fk_user_account_id FOREIGN KEY (user_id) REFERENCES public.user_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: showroom_reviewrating showroom_reviewratin_vehicle_id_78523c7c_fk_showroom_; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.showroom_reviewrating
    ADD CONSTRAINT showroom_reviewratin_vehicle_id_78523c7c_fk_showroom_ FOREIGN KEY (vehicle_id) REFERENCES public.showroom_vehicle(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: showroom_reviewrating showroom_reviewrating_user_id_09794d0d_fk_user_account_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.showroom_reviewrating
    ADD CONSTRAINT showroom_reviewrating_user_id_09794d0d_fk_user_account_id FOREIGN KEY (user_id) REFERENCES public.user_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: showroom_variant showroom_variant_vehicle_id_id_9c667699_fk_showroom_vehicle_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.showroom_variant
    ADD CONSTRAINT showroom_variant_vehicle_id_id_9c667699_fk_showroom_vehicle_id FOREIGN KEY (vehicle_id_id) REFERENCES public.showroom_vehicle(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: showroom_vehicle showroom_vehicle_category_id_ccb65806_fk_category_category_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.showroom_vehicle
    ADD CONSTRAINT showroom_vehicle_category_id_ccb65806_fk_category_category_id FOREIGN KEY (category_id) REFERENCES public.category_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: showroom_vehicle showroom_vehicle_vendor_id_id_2ee79119_fk_vendor_vendor_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.showroom_vehicle
    ADD CONSTRAINT showroom_vehicle_vendor_id_id_2ee79119_fk_vendor_vendor_id FOREIGN KEY (vendor_id_id) REFERENCES public.vendor_vendor(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: superadmin_bookingprice superadmin_bookingpr_category_id_e12408ff_fk_category_; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.superadmin_bookingprice
    ADD CONSTRAINT superadmin_bookingpr_category_id_e12408ff_fk_category_ FOREIGN KEY (category_id) REFERENCES public.category_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_address user_address_user_id_64deb2c7_fk_user_account_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_address
    ADD CONSTRAINT user_address_user_id_64deb2c7_fk_user_account_id FOREIGN KEY (user_id) REFERENCES public.user_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

