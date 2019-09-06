-- Table: public.tb_localizacao_pt
CREATE SEQUENCE tb_localizacao_pt_id_seq START 1;
-- DROP TABLE public.tb_localizacao_pt;

CREATE TABLE public.tb_localizacao_pt
(
    id integer NOT NULL DEFAULT nextval('tb_localizacao_pt_id_seq'::regclass),
    logradouro character varying(500) COLLATE pg_catalog."default" NOT NULL,
    numero character varying(50) COLLATE pg_catalog."default" NOT NULL,
    bairro character varying(500) COLLATE pg_catalog."default" NOT NULL,
    municipio character varying(500) COLLATE pg_catalog."default" NOT NULL,
    estado character varying(2) COLLATE pg_catalog."default" NOT NULL,
    cep integer NOT NULL,
    situacao character varying(100) COLLATE pg_catalog."default" NOT NULL,
    longitude numeric(10,8),
    latitude numeric(10,8),
    geom geometry(Point,4674),
    CONSTRAINT tb_localizacao_pt_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.tb_localizacao_pt
    OWNER to postgres;

INSERT INTO public.tb_localizacao_pt(
	logradouro, numero, bairro, municipio, estado, cep, situacao, longitude, latitude, geom)
	VALUES ('Rua A', '12', 'Centro', 'São Paulo','SP', 05328000, 'CADASTRADO',-46.6880149,-23.59387, (ST_GeomFromText('POINT(-46.6880149 -23.59387)', 4674)));
	
	
	
CREATE OR REPLACE FUNCTION public.criar_localizacao(
    logradouro character varying(500),
    numero character varying(50),
    bairro character varying(500),
    municipio character varying(500),
    estado character varying(2),
    cep integer,
    situacao character varying(100),
    longitude numeric(10,8),
    latitude numeric(10,8))
    RETURNS INTEGER
    LANGUAGE 'plpgsql'

AS $BODY$
	DECLARE
		codigo INTEGER;
	BEGIN
	
	codigo := ((SELECT last_value FROM tb_localizacao_pt_id_seq) :: INTEGER);
	
	INSERT INTO public.tb_localizacao_pt(
	logradouro, numero, bairro, municipio, estado, cep, situacao, longitude, latitude, geom)
	VALUES (''|| logradouro || '', ''|| numero || '', ''|| bairro || '', ''|| municipio || '',''|| estado || '', cep, ''|| situacao || '',longitude,latitude, (ST_GeomFromText('POINT(' || longitude || ' ' || latitude || ')', 4674)));

	IF (codigo = ((SELECT last_value FROM tb_localizacao_pt_id_seq) :: INTEGER)) THEN
		RETURN 0;
	ELSE
		RETURN  codigo;
	END IF;
	
	END;
	$BODY$;
	
	
	SELECT public.criar_localizacao('Rua A', '12', 'Centro', 'São Paulo','SP', 05328000, 'CADASTRADO',-46.6880149,-23.59387);
	
	
	DELETE FROM public.tb_localizacao_pt;

SELECT * FROM public.tb_localizacao_pt;

SELECT public.criar_localizacao('Rua A', '12', 'Centro', 'São Paulo','SP', 05328000, 'CADASTRADO',-46.6880149,-23.59387);


{
  "logradouro": "Avenida Brasil",
  "numero": "1500",
  "bairro": "Centro",
  "municipio": "São Paulo",
  "estado": "SP",
  "cep": 05328000,
  "situacao": "CADASTRADO",
  "longitude": -46.6880149,
  "latitude": -23.59387
}




DELETE FROM public.tb_localizacao_pt;

SELECT * FROM public.tb_localizacao_pt ORDER BY 1 DESC;

SELECT criar_localizacao AS codigo FROM public.criar_localizacao('Rua B', '12', 'Centro', 'São Paulo','SP', 05328000, 'CADASTRADO',-46.6480149,-23.29387);

ALTER TABLE tb_localizacao_pt 
    ALTER COLUMN cep TYPE VARCHAR(8);

SELECT criar_localizacao


SELECT criar_localizacao AS codigo FROM public.criar_localizacao('Avenida XXXXXX', '1500', 'Centro', 'São Paulo','SP', 19814110, 'CADASTRADO',Avenida XXXXXX,-23.59387);

SELECT * FROM public.tb_localizacao_pt WHERE id = 13

SELECT * FROM public.tb_localizacao_pt ORDER BY logradouro ASC