DROP database IF EXISTS "a.safonenko";
CREATE database "a.safonenko";

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

CREATE TABLE public.delivery (
    id bigint NOT NULL,
    address_of_pick_up_point character varying(100) NOT NULL,
    first_name character varying(20) NOT NULL,
    last_name character varying(20) NOT NULL,
    delivery_man_licence character(16) NOT NULL
);


ALTER TABLE public.delivery OWNER TO postgres;


CREATE SEQUENCE public.delivery_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.delivery_id_seq OWNER TO postgres;


ALTER SEQUENCE public.delivery_id_seq OWNED BY public.delivery.id;


CREATE TABLE public.products (
    id bigint NOT NULL,
    seller_id bigint NOT NULL,
    product_name character varying(200) NOT NULL,
    description character varying(10000) NOT NULL,
    price numeric(12,2) NOT NULL,
    rating numeric(5,1) NOT NULL,
    CONSTRAINT products_price_check CHECK ((price > 0.0)),
    CONSTRAINT products_rating_check CHECK (((rating >= 0.0) AND (rating <= 5.0)))
);


ALTER TABLE public.products OWNER TO postgres;


CREATE VIEW public.orderbysellerid AS
 SELECT seller_id,
    count(product_name) AS count
   FROM public.products
  GROUP BY seller_id;


ALTER VIEW public.orderbysellerid OWNER TO postgres;


CREATE TABLE public.orders (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    product_id bigint NOT NULL,
    delivery_id bigint NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;


CREATE SEQUENCE public.orders_delivery_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_delivery_id_seq OWNER TO postgres;


ALTER SEQUENCE public.orders_delivery_id_seq OWNED BY public.orders.delivery_id;


CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO postgres;


ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


CREATE SEQUENCE public.orders_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_product_id_seq OWNER TO postgres;


ALTER SEQUENCE public.orders_product_id_seq OWNED BY public.orders.product_id;


CREATE SEQUENCE public.orders_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_user_id_seq OWNER TO postgres;


ALTER SEQUENCE public.orders_user_id_seq OWNED BY public.orders.user_id;


CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO postgres;


ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


CREATE SEQUENCE public.products_seller_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_seller_id_seq OWNER TO postgres;


ALTER SEQUENCE public.products_seller_id_seq OWNED BY public.products.seller_id;


CREATE TABLE public.sellers (
    id bigint NOT NULL,
    first_name character varying(20) NOT NULL,
    last_name character varying(20) NOT NULL,
    email character varying(100) NOT NULL,
    phone_number character varying(16) NOT NULL,
    fulfilment_center_address character varying(100) NOT NULL
);


ALTER TABLE public.sellers OWNER TO postgres;


CREATE SEQUENCE public.sellers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sellers_id_seq OWNER TO postgres;


ALTER SEQUENCE public.sellers_id_seq OWNED BY public.sellers.id;


CREATE TABLE public.users (
    id bigint NOT NULL,
    first_name character varying(20) NOT NULL,
    last_name character varying(20) NOT NULL,
    gender character(1) NOT NULL,
    date_of_birth date NOT NULL,
    email character varying(100) NOT NULL,
    phone_number character varying(16) NOT NULL,
    bank_card_number character(16) NOT NULL,
    CONSTRAINT users_gender_check CHECK (((gender = 'M'::bpchar) OR (gender = 'F'::bpchar)))
);


ALTER TABLE public.users OWNER TO postgres;


CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;


ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


ALTER TABLE ONLY public.delivery ALTER COLUMN id SET DEFAULT nextval('public.delivery_id_seq'::regclass);


ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


ALTER TABLE ONLY public.orders ALTER COLUMN user_id SET DEFAULT nextval('public.orders_user_id_seq'::regclass);


ALTER TABLE ONLY public.orders ALTER COLUMN product_id SET DEFAULT nextval('public.orders_product_id_seq'::regclass);


ALTER TABLE ONLY public.orders ALTER COLUMN delivery_id SET DEFAULT nextval('public.orders_delivery_id_seq'::regclass);


ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


ALTER TABLE ONLY public.products ALTER COLUMN seller_id SET DEFAULT nextval('public.products_seller_id_seq'::regclass);


ALTER TABLE ONLY public.sellers ALTER COLUMN id SET DEFAULT nextval('public.sellers_id_seq'::regclass);


ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


COPY public.delivery (id, address_of_pick_up_point, first_name, last_name, delivery_man_licence) FROM stdin;
1	Пискарёвский проспект, 1	Artem	Dobrynin	6549893019523033
2	Kudrovo, Kashtanovaya Alley, 2	Nikita	Valikov	9670532819293195
3	Saint Petersburg, Moskovskiy Avenue, 137Б	Kostya	Kovshutin	4273112523145519
4	Saint Petersburg, Piskaryovskiy Avenue, 59	Vanya	Kolesov	9800443462467146
5	Saint Petersburg, Sadovaya Street, 128	Andrey	Andreyev	4291898444728670
6	Saint Petersburg, Botkinskaya Street, 3к1	Andrey	Andryukhin	5357213952996221
7	derevnya Novoye Devyatkino, Energetikov Street, 5	Pasha	Pashin	6881907419969909
8	Vsevolozhsk, Leningradskaya ulitsa, 22	Aleks	Razin	6414514645984442
9	Софийская улица, 46, корп. 1	Sofa	Mefedorovna	5172205229181966
\.


COPY public.orders (id, user_id, product_id, delivery_id) FROM stdin;
1	1	1	1
4	2	1	3
6	2	5	3
7	3	6	4
8	4	3	2
9	4	4	2
10	5	7	5
11	6	7	5
12	7	8	6
13	8	9	6
14	9	5	6
15	10	10	7
16	10	1	7
17	11	11	8
18	11	14	8
19	12	13	8
20	13	12	9
21	14	15	9
22	15	16	9
\.


COPY public.products (id, seller_id, product_name, description, price, rating) FROM stdin;
1	1	Soft toy Seal 65 cm	Soft toy Seal 65 cm_dd	1188.00	4.8
4	2	Egg rack Knight King Arthur	Egg rack Knight King Arthur_dd	830.00	4.8
6	2	Vase "Bust of David" mother of pearl	Vase "Bust of David" mother of pearl_dd	582.00	4.4
5	3	Hoodie size XL black	Hoodie size XL black_dd	4060.00	0.0
8	5	McDonald's Backpack	McDonald's Backpack_dd	1000.00	4.3
3	2	Kit for spices "Seals"	Kit for spices "Seals"_dd	486.00	5.0
7	4	Magic Chess Harry Potter	Magic Chess Harry Potter_dd	6900.00	4.1
10	6	The levitating globe of the Moon	The levitating globe of the Moon_dd	8445.00	3.7
9	1	A rabbit toy with a torn heart	A rabbit toy with a torn heart_dd	1510.00	5.0
11	4	Cthulhu Dark Arts Tarot	Cthulhu Dark Arts Tarot_dd	2050.00	5.0
12	7	Tea ceremony set for 4 people	Tea ceremony set for 4 people_dd	1300.00	4.7
13	3	Slippers, size 36-41, pink	Slippers, size 36-41, pink_dd	2499.00	4.9
14	8	Seeds of Leslandia Wisteria	Seeds of Leslandia Wisteria_dd	450.00	4.4
15	7	Tea ceremony set "Dragon" for 8 people	Tea ceremony set "Dragon"_dd	4690.00	5.0
16	9	Xiaomi Humidifier 2 lite	Xiaomi Humidifier 2 lite_dd	3495.00	4.7
17	10	The one love pin	The one love pin_dd	464.00	4.9
\.


COPY public.sellers (id, first_name, last_name, email, phone_number, fulfilment_center_address) FROM stdin;
1	Caspar	Velasquez	yovowo8389@beeplush.com	+79456785445	Zayachiy prospekt, 1В, Peterhof, St. Petersburg
2	Blaine	Chambers	4cc35a656@cashbenties.com	+79456785446	St. Petersburg, Pargolovo settlement, 61 Podgornaya str., building 1, building 5
3	Kaleb	Brandt	9600c6cd@crkmnky.info	+79456785447	Saint Petersburg, Pushkinsky district, Shushary settlement, Moskovskoe shosse, 70, building 4
4	Harvey	Hanson	77539741@crkmnky.info	+79456785448	St. Petersburg, Pargolovo settlement, 59 Nadgornaya str., building 43
5	Angus	Cantu	83b8491@monkey.info	+79456785449	Energetikov Avenue, 59, Saint Petersburg
6	Elinor	Blair	bafra15@yopmail.com	+79456785450	St. Petersburg, Pushkinsky district, Shushary settlement, germany shosse, 15
7	Amelia	Cantu	fussicr6@yopmail.com	+79456785451	St. Petersburg, Pushkinsky district, Moskovskaya street, 14
8	Briony	Ortega	pannegucate-7347@yopmail.com	+79456785452	St. Petersburg, Moskovskay district, Pushkinsky street, 32
9	Eshal	Rich	feidoiu4564@yopmail.com	+79456785453	Sofiyskaya Street, 95, Saint Petersburg
10	Willie	Mccall	tappeit55@yopmail.com	+79456785454	Mahskayskay Street, 84, St. Petersburg
\.


COPY public.users (id, first_name, last_name, gender, date_of_birth, email, phone_number, bank_card_number) FROM stdin;
1	Vadim	Dmitriyev	M	1995-04-13	Dmitriyev@someone.com	+79043373443	1234567812345678
12	Tatyana	Mosina	F	2004-04-13	Mosina@net.com	+79043473443	0420107843943848
13	Sasha	Vinogradov	M	1980-10-04	Vinogradov@chel.com	+79653473443	0420107843945658
14	Nastya	Morozova	F	2002-07-28	Nastya@discrete.math	+79653573444	0420107840010658
15	Akim	Yun	M	2004-03-01	Akim@geometry.roof	+79653673445	0420107840020658
8	Nastya	Meshkova	F	2004-08-11	Meshkova@nemama.com	+79043437409	0359103048572434
3	Afanasy	Vakin	M	2004-01-28	Vakin@nepapa.com	+79043382454	1346895413468954
5	Irina	Sorokina	F	2004-10-14	Sorokina@nemama.com	+79043400476	5943875459438754
7	Anya	Kavunova	F	2000-01-01	Kavunova@mama.com	+79043428498	5930475035453934
2	Pasha	Likhosherstov	M	2003-06-16	Likhosherstov@nepapa.com	+79043365432	1256334412563344
9	Artem	Brandy	M	2004-06-23	Brandy@steppapa.com	+79043446410	0423857843901849
6	Lada	Batalova	F	2003-08-22	Batalova@nemama.com	+79043419487	4353455343534553
10	Rasul	Abdurashidov	M	2004-11-10	Abdurashidov@nepapa.com	+79043455421	0423857843943849
4	Ksenia	Kosterova	F	2005-12-19	Kosterova@sister.com	+79043391465	4539875445398754
11	Mikhail	Eremin	M	2004-12-29	Eremin@nepapa.com	+79043464432	0420007843943849
\.


SELECT pg_catalog.setval('public.delivery_id_seq', 9, true);


SELECT pg_catalog.setval('public.orders_delivery_id_seq', 1, false);


SELECT pg_catalog.setval('public.orders_id_seq', 22, true);


SELECT pg_catalog.setval('public.orders_product_id_seq', 1, false);


SELECT pg_catalog.setval('public.orders_user_id_seq', 1, false);


SELECT pg_catalog.setval('public.products_id_seq', 17, true);


SELECT pg_catalog.setval('public.products_seller_id_seq', 1, false);


SELECT pg_catalog.setval('public.sellers_id_seq', 10, true);


SELECT pg_catalog.setval('public.users_id_seq', 15, true);


ALTER TABLE ONLY public.delivery
    ADD CONSTRAINT delivery_man_licence EXCLUDE USING btree (delivery_man_licence WITH =);


ALTER TABLE ONLY public.delivery
    ADD CONSTRAINT delivery_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.sellers
    ADD CONSTRAINT sellers_email_key UNIQUE (email);


ALTER TABLE ONLY public.sellers
    ADD CONSTRAINT sellers_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


CREATE INDEX orders_delivery_id_idx ON public.orders USING btree (delivery_id);


CREATE INDEX orders_product_id_idx ON public.orders USING btree (product_id);


CREATE INDEX orders_product_id_idx1 ON public.orders USING btree (product_id);


CREATE INDEX products_price_idx ON public.products USING btree (price);


CREATE INDEX products_rating_idx ON public.products USING btree (rating);


CREATE INDEX sellers_fulfilment_center_address_idx ON public.sellers USING btree (fulfilment_center_address);


CREATE INDEX users_first_name_idx ON public.users USING btree (first_name);


ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_delivery_id_fkey FOREIGN KEY (delivery_id) REFERENCES public.delivery(id);


ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_seller_id_fkey FOREIGN KEY (seller_id) REFERENCES public.sellers(id);


DROP database "a.safonenko";
