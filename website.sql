/*
 Navicat Premium Data Transfer

 Source Server         : respect
 Source Server Type    : PostgreSQL
 Source Server Version : 90602
 Source Host           : 92.50.138.122
 Source Database       : respect
 Source Schema         : website

 Target Server Type    : PostgreSQL
 Target Server Version : 90602
 File Encoding         : utf-8

 Date: 10/30/2017 23:42:04 PM
*/

-- ----------------------------
--  Function structure for website.private_catalog(int4, int4, int4)
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."private_catalog"(int4, int4, int4);
CREATE FUNCTION "website"."private_catalog"(IN _id23032 int4, IN _id23033 int4, IN _id21309 int4)
 RETURNS TABLE("id" text, id28005 text, title text, link text, img_preview text, img_view text, preview text, "view" text, price numeric, date_start date, date_finish date, meta_image text, meta_keyword text, meta_title text, meta_description text, "type" text, dop_info json, form_event text, city_event text, id23004 int4, id23003 int4) AS
$BODY$
declare 
	_realtime integer := website.private_real();
begin

	if _realtime = 1 then
		return query
			select 
				concat('mn-', a.idkart) as id,
				null::text as id28005,
				a.name_title as title,
				x_name_translate(concat( 'mn-',a.name_title) ) as link, 
				x_name_translate(concat( 'mn-img-', a.idkart) ) as img_preview, 
				x_name_translate(concat( 'mn-img-', a.idkart) ) as img_view, 
				a.preview as preview, 
				case when a.viewfile is not null then x_get_filedata(a.viewfile) else a.view end as view,
				null::numeric as price,
				null::date as date_start, 
				null::date as date_finish,
				null::text as meta_image,
				null::text as meta_keyword,
				null::text as meta_title,
				null::text as meta_description,
				'folder'::text as type,
				null::json as dop_info,
				null::text as form_event,
				null::text as city_event,
				null::integer as id23004,
				null::integer as id23003
			from t23039 as a
			join ( 
				select a.id23039
				from website.private_events_action( _id23032, _id23033, _id21309 ) as a
				group by a.id23039
			) as b ON b.id23039 = a.idkart
			order by num_sort;

		return query
			select 
				concat('cat2-', b.id23039,'-',b.id23034 ) as id,
				concat('mn-', b.id23039) as id28005,
				a.name_view as title,
				x_name_translate(concat('cat2-', b.id23039,'-',a.idkart, a.name_view) ) as link, 
				x_name_translate(concat('cat2-img-', a.idkart) ) as img_preview, 
				x_name_translate(concat('cat2-img-', a.idkart) ) as img_view, 
				null::text as preview, 
				null::text as view,
				null::numeric as price,
				null::date as date_start, 
				null::date as date_finish,
				null::text as meta_image,
				null::text as meta_keyword,
				null::text as meta_title,
				null::text as meta_description,
				'folder'::text as type,
				null::json as dop_info,
				null::text as form_event,
				null::text as city_event,
				null::integer as id23004,
				null::integer as id23003
				from t23034 as a
				join ( 
					select a.id23039, a.id23034 
					from website.private_events_action( _id23032, _id23033, _id21309 ) as a
					group by a.id23039, a.id23034 
				) as b ON b.id23034 = a.idkart;

		return query
			select 
				concat('cat3-', a.id23004, '-', a.id23031, '-', a.id23032, '-', a.id23033, '-', a.id23034, '-', a.id21309, '-', a.id23039) as id,
				concat('cat2-', a.id23039,'-',a.id23034 ) as id28005,
				a.name_event as title,
				x_name_translate(concat('cat3-', a.id23004, '-', a.id23031, '-', a.id23032, '-', a.id23033, '-', a.id23034, '-', a.id21309, '-', a.id23039, '-',
					a.name_event) ) as link, 
				x_name_translate(concat('cat3-img-', a.id23003) )  as img_preview, 
				x_name_translate(concat('cat3-img-', a.id23003) ) as img_view, 
				null::text as preview, 
				x_get_filedata(a.file_plan) as view,
				a.cost_event as price,
				a.date_event as date_start, 
				a.date_event_end as date_finish,
				null::text as meta_image,
				null::text as meta_keyword,
				null::text as meta_title,
				null::text as meta_description,
				'item'::text as type,
				website.private_catalog_json( a.id23004 ) as dop_info,
				a.form_event,
				a.city_event,
				a.id23004,
				a.id23003
			from (
				select 
				b.id23004, b.id23031, b.id23032, b.id23033, b.id23034, b.id21309, b.id23039,
				t23003.idkart as id23003,
				t23003.name_event,
				t23003.file_plan,
				t23033.name_form as form_event, 
				v21307.city as city_event,
				t23004.cost_event,
				t23004.date_event,
				t23004.date_event_end
				from t23003
				join t23004 ON t23004.id23003 = t23003.idkart
				left join t23033 on t23004.id23033 = t23033.idkart
				left join v21307 on t23004.id21307 = v21307.idkart
				join ( 
					select a.id23004, a.id23031, min(a.id23032) as id23032, a.id23033, a.id23034, a.id21309, a.id23039
					from website.private_events_action( _id23032, _id23033, _id21309 ) as a
					group by a.id23004, a.id23031, a.id23033, a.id23034, a.id21309, a.id23039
				) as b ON b.id23004 = t23004.idkart
			) as a; 		

/*		return query
			select 
				concat('cat3-', a.id23039,'-',a.id23034, a.idkart ) as id,
				concat('cat2-', a.id23039,'-',a.id23034 ) as id28005,
				a.name_event as title,
				x_name_translate(concat('cat3-', a.id23039,'-',a.id23034, a.idkart,a.name_event) ) as link, 
				x_name_translate(concat('cat3-img-', a.id23003) )  as img_preview, 
				x_name_translate(concat('cat3-img-', a.id23003) ) as img_view, 
				null::text as preview, 
				x_get_filedata(a.file_plan) as view,
				a.cost_event as price,
				a.date_event as date_start, 
				a.date_event_end as date_finish,
				null::text as meta_image,
				null::text as meta_keyword,
				null::text as meta_title,
				null::text as meta_description,
				'item'::text as type,
				website.private_catalog_json( a.idkart ) as dop_info,
				a.form_event,
				a.city_event,
				a.idkart as id23004,
				a.id23003 as id23003
			from (
				select 
				b.id23039,
				t23004.idkart,
				t23003.idkart as id23003,
				t23003.id23031,
				t23003.id23034,
				t23003.name_event,
				t23003.file_plan,
				t23033.name_form as form_event, 
				v21307.city as city_event,
				t23004.cost_event,
				t23004.date_event,
				t23004.date_event_end
				from t23003
				join t23004 ON t23004.id23003 = t23003.idkart
				left join t23033 on t23004.id23033 = t23033.idkart
				left join v21307 on t23004.id21307 = v21307.idkart
				join ( 
					select a.id23039, a.id23034 , a.id23004 
					from website.private_events_action( _id23032, _id23033, _id21309 ) as a
					group by a.id23039, a.id23034 , a.id23004 
				) as b ON b.id23004 = t23004.idkart
			) as a; */
	else
		return query
			select 
				t28006.idkart::text,
				t28006.id28005::text,
				t28006.catalog_title, 
				t28006.catalog_link, 
				t28001.file_name_link,
				t28001.file_name_link,
				t28006.catalog_preview,
				t28006.catalog_view,
				t28006.catalog_price,
				t28006.catalog_date,
				t28006.catalog_date,
				met.file_name_link as meta_image,
				t28006.meta_keyword,
				t28006.meta_title,
				t28006.meta_description,
				case when t28006.is_item=true then 'item' else 'folder' end,
				json_build_object( 'Количество часов:', '20 ак.ч.', 'Стоимость:', '4 000 рублей', 'Документ:', 'Сертификат', 'Форма обучения:', 'Групповая, индивидуальная', 'Место проведения:', 'г. Уфа' ),
			null::text as form_event, 
			null::text as city_event,
			null::integer as id23004,
			null::integer as id23003
			from t28006
			left join t28001 ON t28006.id28001 = t28001.idkart
			left join t28001 as met ON t28006.id_meta_image = met.idkart
			where t28006.dttmcl is null;
	end if;

end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."private_catalog"(IN _id23032 int4, IN _id23033 int4, IN _id21309 int4) OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.get_news_property(text)
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."get_news_property"(text);
CREATE FUNCTION "website"."get_news_property"(IN _id text)
 RETURNS TABLE(title text, link text, image text, preview text, "view" text, "date" timestamptz, "source" text, source_url text, meta_image text, meta_keyword text, meta_title text, meta_description text) AS
$BODY$
begin
	return query
		select 
		a.title, 
		a.link,
		a.image,
		a.preview,
		a.view,
		a.date,
		a.source,
		a.source_url,
		a.meta_image,
		a.meta_keyword,
		a.meta_title,
		a.meta_description
		from website.private_news() as a
		where a.id =_id;

end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."get_news_property"(IN _id text) OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.get_news()
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."get_news"();
CREATE FUNCTION "website"."get_news"()
 RETURNS TABLE(title text, link text, image text, preview text, "date" timestamptz, "source" text, source_url text) AS
$BODY$
begin
	return query
		select 
		a.title, 
		a.link,
		a.image,
		a.preview,
		a.date,
		a.source,
		a.source_url
		from website.private_news() as a
		order by a.date desc;

end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."get_news"() OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.__get_file_property(text)
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."__get_file_property"(text);
CREATE FUNCTION "website"."__get_file_property"(IN _file_name_link text)
 RETURNS TABLE(title text, preview text, dttmup timestamptz) AS
$BODY$
declare
	_file_data bytea;
begin
	return query
		select t28001.title, t28001.preview,COALESCE( t28001.dttmup, t28001.dttmcr )
		from public.t28001 where t28001.dttmcl is null and t28001.file_name_link = _file_name_link;

end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."__get_file_property"(IN _file_name_link text) OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.get_catalog_tags(int4, int4, int4)
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."get_catalog_tags"(int4, int4, int4);
CREATE FUNCTION "website"."get_catalog_tags"(IN _id23032 int4, IN _id23033 int4, IN _id21309 int4)
 RETURNS TABLE("id" int4, title text, "type" int4) AS
$BODY$
declare 
	_realtime integer := website.private_real();
begin

	if _realtime = 1 then
		-- профиль обучения
		return query
			select 
			t23032.idkart,
			t23032.name_profile as profile_title,
			1 as type
			from public.t23032
			where t23032.dttmcl is null and 
				t23032.idkart in (select d.id23032 from website.private_events_action(COALESCE(_id23032,t23032.idkart),_id23033,_id21309) as d where d.id23032 is not null)
			order by t23032.name_profile;
		-- форма обучения
		return query
			select 
			t23033.idkart,
			t23033.name_form as form_title,
			2 as type	
			from public.t23033
			where t23033.dttmcl is null and 
				t23033.idkart in (select d.id23033 from website.private_events_action(_id23032,COALESCE(_id23033,t23033.idkart),_id21309) as d where d.id23033 is not null)
			order by t23033.name_form;
		-- место обучения
		return query
			select 
			t21309.idkart,
			t21309.city as place_title,
			3 as type	
			from public.t21309
			where t21309.dttmcl is null and
				t21309.idkart in (select d.id21309 from website.private_events_action(_id23032,_id23033,COALESCE(_id21309,t21309.idkart)) as d where d.id21309 is not null)
			order by t21309.city;
	else
		-- профиль обучения
		return query
			select 
			t28011.idkart,
			t28011.profile_title,
			1 as type
			from t28011
			where t28011.dttmcl is null;
		-- форма обучения
		return query
			select 
			t28012.idkart,
			t28012.form_title,
			2 as type
			from t28012
			where t28012.dttmcl is null;
		-- место обучения
		return query
			select 
			t28013.idkart,
			t28013.place_title,
			3 as type
			from t28013
			where t28013.dttmcl is null;
	end if;
end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."get_catalog_tags"(IN _id23032 int4, IN _id23033 int4, IN _id21309 int4) OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.get_news_bookmark()
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."get_news_bookmark"();
CREATE FUNCTION "website"."get_news_bookmark"()
 RETURNS TABLE(title text, link text, image text, preview text, "date" timestamptz, "source" text, source_url text) AS
$BODY$
begin
	return query
		select 
		a.title, 
		a.link,
		a.image,
		a.preview,
		a.date,
		a.source,
		a.source_url
		from website.private_news() as a
		where a.bookmark=true
		order by a.date;

end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."get_news_bookmark"() OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.get_breadcrumb(text)
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."get_breadcrumb"(text);
CREATE FUNCTION "website"."get_breadcrumb"(IN _page_link text)
 RETURNS TABLE(id_row text, link text, "name" text, controller text, controller_next text) AS
$BODY$
begin
	return query
		with recursive temp1 ( n, obj, obj_id, parent_obj, parent_obj_id ) as 
		(
			select -1, obj, obj_id, parent_obj, parent_obj_id
			from website.private_tree_all() a
			where a.link = _page_link
			union
			select n-1, b.obj, b.obj_id, b.parent_obj, b.parent_obj_id
			from website.private_tree_all() b
			inner join temp1 as t on (b.obj=t.parent_obj and b.obj_id=t.parent_obj_id)
		)
		select  
		a.obj_id,
		a.link,
		a.name,
		a.controller,
		a.controller_next
		from temp1 as t
		inner join  website.private_tree_all() as a on (t.obj=a.obj and t.obj_id=a.obj_id)
		order by t.n;

end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."get_breadcrumb"(IN _page_link text) OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.get_shares()
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."get_shares"();
CREATE FUNCTION "website"."get_shares"()
 RETURNS TABLE(title text, link text, preview text, "date" date, image text) AS
$BODY$
begin
		return query
			select 
			a.title,
			a.link,
			a.preview,
			a.date_start,
			a.file_name_link
			from website.private_shares() as a
			order by a.date_start;
end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."get_shares"() OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.get_page_property_json(int4)
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."get_page_property_json"(int4);
CREATE FUNCTION "website"."get_page_property_json"(IN _id int4)
 RETURNS TABLE("key" text, "value" text) AS
$BODY$
begin
	return query
		select 
			t28003.param_name,
			t28003.param_value
		from public.t28003 
		where t28003.dttmcl is null and t28003.id28002 = _id;

end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."get_page_property_json"(IN _id int4) OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.private_careers()
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."private_careers"();
CREATE FUNCTION "website"."private_careers"()
 RETURNS TABLE("id" text, title text, link text, "view" text, date_start date, meta_image text, meta_keyword text, meta_title text, meta_description text) AS
$BODY$
declare 
	_realtime integer := website.private_real();
begin
--	if _realtime = 1 then
--		return query
--	else
		return query
			select
				t28019.idkart::text,
				t28019.careers_title,
				t28019.careers_link,
				t28019.careers_view,
				t28019.careers_date,
				null::text meta_image, 
				null::text meta_keyword,
				null::text meta_title,
				null::text meta_description
			from t28019
			where t28019.dttmcl is null
			order by t28019.careers_title;
	--end if;
end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."private_careers"() OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.get_careers()
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."get_careers"();
CREATE FUNCTION "website"."get_careers"()
 RETURNS TABLE(title text, link text) AS
$BODY$
begin
		return query
			select 
			a.title,
			a.link
			from website.private_careers() as a
			order by a.title;
end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."get_careers"() OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.get_sitemap()
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."get_sitemap"();
CREATE FUNCTION "website"."get_sitemap"()
 RETURNS TABLE(parent_controller_id int4, parent_id int4, controller_id int4, "id" int4, link text, "name" text, controller text) AS
$BODY$
begin
	
	return query
		select 
			a.parent_obj,
			a.parent_obj_id,
			a.obj,
			a.obj_id,
			a.link,
			a.name,
			a.controller
		from website.private_tree_all() as a;


end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."get_sitemap"() OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.get_careers_property(text)
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."get_careers_property"(text);
CREATE FUNCTION "website"."get_careers_property"(IN _id text)
 RETURNS TABLE(title text, link text, "view" text, "date" date, meta_image text, meta_keyword text, meta_title text, meta_description text) AS
$BODY$
begin
		return query
			select 
				a.title,
				a.link,
				a.view,
				a.date_start,
				a.meta_image, 
				a.meta_keyword,
				a.meta_title,
				a.meta_description
			from website.private_careers() as a
			where a.id = _id 
			order by a.date_start;
end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."get_careers_property"(IN _id text) OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.get_page(int4)
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."get_page"(int4);
CREATE FUNCTION "website"."get_page"(IN _id int4)
 RETURNS TABLE(title text, meta_image text, meta_keyword text, meta_title text, meta_description text) AS
$BODY$
begin
	return query
		select 
			t28002.page_name, 
			met.file_name_link as meta_image,
			t28002.meta_keyword,
			t28002.meta_title,
			t28002.meta_description
		from public.t28002
		left join t28001 as met ON t28002.id_meta_image = met.idkart
		where t28002.idkart = _id;

end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."get_page"(IN _id int4) OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.get_shares_property(text)
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."get_shares_property"(text);
CREATE FUNCTION "website"."get_shares_property"(IN _id text)
 RETURNS TABLE(title text, link text, preview text, "view" text, "date" date, image text, meta_image text, meta_keyword text, meta_title text, meta_description text) AS
$BODY$
begin
		return query
			select 
				a.title,
				a.link,
				a.preview,
				a.view,
				a.date_start,
				a.file_name_link,
				a.meta_image, 
				a.meta_keyword,
				a.meta_title,
				a.meta_description
			from website.private_shares() as a
			where a.id =_id
			order by a.date_start;
end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."get_shares_property"(IN _id text) OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.private_real()
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."private_real"();
CREATE FUNCTION "website"."private_real"() RETURNS "int4" 
	AS $BODY$
begin
	
	return 1;

end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."private_real"() OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.private_catalog_json(int4)
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."private_catalog_json"(int4);
CREATE FUNCTION "website"."private_catalog_json"(IN _idkart int4) RETURNS "json" 
	AS $BODY$
declare 
	_js json;
begin
		select json_strip_nulls( row_to_json(a) ) into  _js
		from (
		select 
		t23004.time_event as "Начало",
		t23004.total_time as "Продолжительность",
		t23004.cost_event::money as "Стоимость",
		t23038.type_docum  as "Документ" ,
		t23033.name_form as "Форма обучения",
		v21307.address_full as "Место проведения"
		from t23003
		join t23004 on t23004.id23003 = t23003.idkart
		left join t23033 on t23004.id23033 = t23033.idkart
		left join t23038 on t23004.id23038 = t23038.idkart
		left join v21307 on t23004.id21307 = v21307.idkart
		where t23004.idkart = _idkart
		) as a;

		return _js;
end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."private_catalog_json"(IN _idkart int4) OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.get_file(text)
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."get_file"(text);
CREATE FUNCTION "website"."get_file"(IN _file_name_link text) RETURNS "text" 
	AS $BODY$
declare
	_file_data text;
begin

	select encode( t28001.file_data, 'base64' ) into _file_data from public.t28001 where t28001.dttmcl is null and t28001.file_name_link = _file_name_link;
	if _file_data is null then 	-- новости новый формат
		select encode( t25162.news_image, 'base64' ) into _file_data 
		from public.t25162
		where t25162.dttmcl is null 
			and concat( 'news_img_', x_name_translate(t25162.news_title) ) = _file_name_link;
	end if;
	if _file_data is null then -- отзывы
		select encode( t25172.reviews_image, 'base64' ) into _file_data 
		from public.t25172
		where t25172.dttmcl is null 
			and concat( 'rvs_img_', x_name_translate(t25172.reviews_title) ) = _file_name_link;
	end if;
	if _file_data is null then -- акции
		select encode( t25182.shares_image, 'base64' ) into _file_data 
		from public.t25182
		where t25182.dttmcl is null 
			and concat( 'shr_img_', x_name_translate(t25182.shares_title) ) = _file_name_link;
	end if;
	if _file_data is null then -- документы - small
		select encode( t23037.image_small, 'base64' ) into _file_data 
		from public.t23037
		where t23037.dttmcl is null 
			and concat( 'dc_imgs_', x_name_translate(t23037.name_document) ) = _file_name_link;
	end if;
	if _file_data is null then -- документы - large
		select encode( t23037.image_large, 'base64' ) into _file_data 
		from public.t23037
		where t23037.dttmcl is null 
			and concat( 'dc_imgl_', x_name_translate(t23037.name_document) ) = _file_name_link;
	end if;
	if _file_data is null then -- справочник мероприятия
		select encode( t23003.image, 'base64' ) into _file_data 
		from public.t23003
		where t23003.dttmcl is null 
			and x_name_translate(concat( 'cat3-img-', t23003.idkart ) ) = _file_name_link;
		if _file_data is null and _file_name_link like 'cat3-img-%' then
			select encode( t28001.file_data, 'base64' ) into _file_data from public.t28001 
			where t28001.dttmcl is null and t28001.file_name_link = 'seminar.jpg'::text;
		end if;
	end if;
	if _file_data is null then -- главная страница
		select encode( t23039.image, 'base64' ) into _file_data 
		from public.t23039
		where t23039.dttmcl is null 
			and x_name_translate(concat( 'mn-img-', t23039.idkart ) ) = _file_name_link;
	end if;

	return _file_data;
end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."get_file"(IN _file_name_link text) OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.private_get_functions()
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."private_get_functions"();
CREATE FUNCTION "website"."private_get_functions"()
 RETURNS TABLE(proname name, proargnames _text, proargtypes oidvector, prosrc text) AS
$BODY$
begin
	return query
		SELECT p.proname, p.proargnames, p.proargtypes, p.prosrc 
		FROM pg_catalog.pg_namespace n 
		LEFT JOIN pg_catalog.pg_proc p ON p.pronamespace = n.oid 
		WHERE n.nspname = 'website' AND p.proname NOT LIKE 'private_%';
end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."private_get_functions"() OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.get_blueimp_gallery(text)
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."get_blueimp_gallery"(text);
CREATE FUNCTION "website"."get_blueimp_gallery"(IN _id text)
 RETURNS TABLE(navigation int4, preview int4, controls int4, fullscreen int4, auto_slide int4, slide_interval int4, slides jsonb) AS
$BODY$
begin
		return query
			select
				a.navigation,
				a.preview,
				a.controls,
				a.fullscreen,
				a.auto_slide,
				a.slide_interval,
				a.slides jsonb
			from website.private_gallery() as a
			where a.id  = _id;
end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."get_blueimp_gallery"(IN _id text) OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.private_gallery()
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."private_gallery"();
CREATE FUNCTION "website"."private_gallery"()
 RETURNS TABLE("id" text, navigation int4, preview int4, controls int4, fullscreen int4, auto_slide int4, slide_interval int4, slides jsonb) AS
$BODY$
declare 
	_realtime integer := website.private_real();
begin
	if _realtime = 1 then
		return query
			select 
				case when a.id23036 = 1 then '3'::text else '2'::text end,
				0,
				0,
				0,
				0,
				0,
				0,
				jsonb_agg(a.js)
			from (
				select t23037.id23036,
				json_build_object( 
					'title',t23037.name_document,
					'description','Описание - ' || t23037.name_document,
					'img_view',concat( 'dc_imgl_' ,x_name_translate(t23037.name_document) ),
					'img_preview',concat( 'dc_imgs_' ,x_name_translate(t23037.name_document) )
				) as js
				from t23037
				where t23037.dttmcl is null
				group by t23037.id23036,t23037.name_document
				order by t23037.name_document
			) as a
			group by a.id23036;

	else
		return query
			select 
				t28016.idkart::text,
				case when t28016.navigation=true then 1 else 0 end,
				case when t28016.preview=true then 1 else 0 end,
				case when t28016.controls=true then 1 else 0 end,
				case when t28016.fullscreen=true then 1 else 0 end,
				case when t28016.auto_slide=true then 1 else 0 end,
				t28016.slide_interval,
				jsonb_agg(a.js)
			from t28016
			left join (
				select
				t28017.id28016,
				json_build_object( 
					'title',t28001.title,
					'description',t28001.description,
					'img_view',t28010.file_name_link,
					'img_preview',t28001.file_name_link
				) as js
				from t28017
				left join t28001 ON t28017.id28001 = t28001.idkart
				left join t28001 as t28010 ON t28017.id28010 = t28010.idkart
			) as a on a.id28016 = t28016.idkart
			where t28016.dttmcl is null
			group by 
				t28016.idkart,
				case when t28016.navigation=true then 1 else 0 end,
				case when t28016.preview=true then 1 else 0 end,
				case when t28016.controls=true then 1 else 0 end,
				case when t28016.fullscreen=true then 1 else 0 end,
				case when t28016.auto_slide=true then 1 else 0 end,
				t28016.slide_interval;
	end if;
end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."private_gallery"() OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.get_reviews()
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."get_reviews"();
CREATE FUNCTION "website"."get_reviews"()
 RETURNS TABLE(title text, link text, preview text, company text, "date" date, image text) AS
$BODY$
begin
		return query
			select 
			a.title,
			a.link,
			a.preview,
			a.company,
			a.date,
			a.image
			from website.private_reviews() as a
			order by a.date;
end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."get_reviews"() OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.get_reviews_property(text)
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."get_reviews_property"(text);
CREATE FUNCTION "website"."get_reviews_property"(IN _id text)
 RETURNS TABLE(title text, link text, preview text, "view" text, company text, "date" date, image text, meta_image text, meta_keyword text, meta_title text, meta_description text) AS
$BODY$
begin
		return query
			select 
				a.title,
				a.link,
				a.preview,
				a.view,
				a.company,
				a.date,
				a.image,
				null::text meta_image, 
				null::text meta_keyword,
				null::text meta_title,
				null::text meta_description
			from website.private_reviews() as a
			where a.id =_id
			order by a.date;
end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."get_reviews_property"(IN _id text) OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.private_reviews()
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."private_reviews"();
CREATE FUNCTION "website"."private_reviews"()
 RETURNS TABLE("id" text, title text, link text, preview text, "view" text, company text, "date" date, image text, meta_image text, meta_keyword text, meta_title text, meta_description text) AS
$BODY$
declare 
	_realtime integer := website.private_real();
begin
--	if _realtime = 1 then	
		return query
			select
				concat( 'rvs_', t25172.idkart),
				t25172.reviews_title,
				x_name_translate(t25172.reviews_title),
				t25172.reviews_preview,
				case when t25172.reviews_viewfile is not null then x_get_filedata(t25172.reviews_viewfile) else t25172.reviews_view end,
				t25172.reviews_company,
				t25172.reviews_date,
				concat( 'rvs_img_', x_name_translate(t25172.reviews_title) ),
				null::text meta_image, 
				null::text meta_keyword,
				null::text meta_title,
				null::text meta_description
			from t25172
			where t25172.dttmcl is null;
--	else
		return query
			select
				t28014.idkart::text,
				t28014.reviews_title,
				t28014.reviews_link,
				t28014.reviews_preview,
				t28014.reviews_view,
				t28014.reviews_company,
				t28014.reviews_date,
				t28001.file_name_link,
				null::text meta_image, 
				null::text meta_keyword,
				null::text meta_title,
				null::text meta_description
			from t28014
			left join t28001 ON t28014.id28001 = t28001.idkart
			where t28014.dttmcl is null;
--	end if;
end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."private_reviews"() OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.get_menu_footer(text)
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."get_menu_footer"(text);
CREATE FUNCTION "website"."get_menu_footer"(IN "id" text)
 RETURNS TABLE(title text, href text, selected int4) AS
$BODY$
begin
	return query
		select 
			t28002.page_name, 
			concat( '/', t28002.page_link, '/' ), 
			case when t28002.idkart::text = id then 1 else 0 end as selected
		from public.t28002
		where t28002.page_num_sort<>0
		order by page_num_sort;

	return query
		select 
			t28002.page_name, 
			t28002.page_link,
			case when t28002.idkart::text = id then 1 else 0 end as selected
		from public.t28002
		where t28002.idkart = '11';

end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."get_menu_footer"(IN "id" text) OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.get_catalog(text)
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."get_catalog"(text);
CREATE FUNCTION "website"."get_catalog"(IN _id text)
 RETURNS TABLE(title text, link text, img_preview text, img_view text, preview text, price numeric, date_start date, date_finish date, "type" text, form_event text, city_event text) AS
$BODY$
begin
	if _id is null then 
		return query
			select 
			a.title, 
			a.link,
			a.img_preview,
			a.img_view,
			a.preview,
			a.price,
			a.date_start,
			a.date_finish,
			a.type,
			a.form_event, 
			a.city_event
			from website.private_catalog(null,null,null) as a
			where a.id28005 is null;
	else 
		return query
			select 
			a.title, 
			a.link,
			a.img_preview,
			a.img_view,
			a.preview,
			a.price,
			a.date_start,
			a.date_finish,
			a.type,
			a.form_event, 
			a.city_event
			from website.private_catalog(null,null,null) as a
			where a.id28005=_id
			order by a.date_start, a.title;
	end if;
end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."get_catalog"(IN _id text) OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.get_menu_header(text)
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."get_menu_header"(text);
CREATE FUNCTION "website"."get_menu_header"(IN "id" text)
 RETURNS TABLE(title text, href text, selected int4) AS
$BODY$
begin
	return query
		select 
			t28002.page_name, 
			concat( '/', t28002.page_link, '/' ), 
			case when t28002.idkart::text = id then 1 else 0 end as selected
		from public.t28002
		where t28002.page_num_sort<>0
		order by page_num_sort;

end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."get_menu_header"(IN "id" text) OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.private_news()
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."private_news"();
CREATE FUNCTION "website"."private_news"()
 RETURNS TABLE("id" text, title text, link text, image text, preview text, "view" text, "date" timestamptz, "source" text, source_url text, meta_image text, meta_keyword text, meta_title text, meta_description text, bookmark bool) AS
$BODY$
declare 
	_realtime integer := website.private_real();
begin
	if _realtime = 1 then
		return query
			select 
			concat( 'news_', t25162.idkart) as id,
			t25162.news_title, 
			x_name_translate(t25162.news_title),
			concat( 'news_img_', x_name_translate(t25162.news_title) ) ,
			t25162.news_preview,
			case when t25162.news_viewfile is not null then x_get_filedata(t25162.news_viewfile) else t25162.news_view end,
			t25162.news_date,
			t25162.news_source,
			t25162.news_source_url,
			null::text as meta_image,
			null::text as meta_keyword,
			null::text as meta_title,
			null::text as meta_description,
			t25162.news_bookmark
			from t25162
			where t25162.dttmcl is null;
	else
		return query
			select 
			t28008.idkart::text as id,
			t28008.news_title, 
			t28008.news_link,
			t28001.file_name_link,
			t28008.news_preview,
			t28008.news_view,
			t28008.news_date,
			t28008.news_source,
			t28008.news_source_url,
			met.file_name_link as meta_image,
			t28008.meta_keyword,
			t28008.meta_title,
			t28008.meta_description,
			t28008.bookmark
			from t28008
			left join t28001 ON t28008.id28001 = t28001.idkart
			left join t28001 as met ON t28008.id_meta_image = met.idkart
			where t28008.dttmcl is null;
	end if;
end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."private_news"() OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.private_shares()
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."private_shares"();
CREATE FUNCTION "website"."private_shares"()
 RETURNS TABLE("id" text, title text, link text, preview text, "view" text, date_start date, date_end date, file_name_link text, meta_image text, meta_keyword text, meta_title text, meta_description text) AS
$BODY$
declare 
	_realtime integer := website.private_real();
begin
	if _realtime = 1 then
		return query
			select
				concat( 'shr_', t25182.idkart),
				t25182.shares_title,
				concat( 'shr_' ,x_name_translate(t25182.shares_title) ),
				t25182.shares_preview,
				case when t25182.shares_viewfile is not null then x_get_filedata(t25182.shares_viewfile) else t25182.shares_view end,
				t25182.shares_date_start,
				t25182.shares_date_end,
				concat( 'shr_img_', x_name_translate(t25182.shares_title) ) ,
				null::text meta_image, 
				null::text meta_keyword,
				null::text meta_title,
				null::text meta_description
			from t25182
			where t25182.dttmcl is null and t25182.shares_date_start <= current_date and 
				(t25182.shares_date_end is null or t25182.shares_date_end >= current_date);
	else
		return query
			select
				t28015.idkart::text,
				t28015.shares_title,
				t28015.shares_link,
				t28015.shares_preview,
				t28015.shares_view,
				t28015.shares_date,
				null::date as shares_date,
				t28001.file_name_link,
				null::text meta_image, 
				null::text meta_keyword,
				null::text meta_title,
				null::text meta_description
			from t28015
			left join t28001 ON t28015.id28001 = t28001.idkart
			where t28015.dttmcl is null
			order by t28015.shares_date;
	end if;
end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."private_shares"() OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.get_catalog_property(text)
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."get_catalog_property"(text);
CREATE FUNCTION "website"."get_catalog_property"(IN _id text)
 RETURNS TABLE(title text, img_preview text, img_view text, preview text, "view" text, price numeric, date_start date, date_finish date, meta_image text, meta_keyword text, meta_title text, meta_description text, "type" text, dop_info json, form_event text, city_event text) AS
$BODY$
begin
	return query
		select 
			a.title, 
			a.img_preview,
			a.img_view,
			a.preview,
			a.view,
			a.price,
			a.date_start,
			a.date_finish,
			a.meta_image,
			a.meta_keyword,
			a.meta_title,
			a.meta_description,
			a.type,
			a.dop_info,
			a.form_event, 
			a.city_event
		from website.private_catalog(null,null,null) as a
		where a.id =_id;

end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."get_catalog_property"(IN _id text) OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.get_catalog_by_tags(int4, int4, int4)
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."get_catalog_by_tags"(int4, int4, int4);
CREATE FUNCTION "website"."get_catalog_by_tags"(IN _id1 int4, IN _id2 int4, IN _id3 int4)
 RETURNS TABLE(title text, link text, img_preview text, img_view text, preview text, price numeric, date_start date, date_finish date, "type" text, form_event text, city_event text) AS
$BODY$
declare 
	_realtime integer := website.private_real();
begin

	if _id1 is null and _id2 is null and _id3 is null then
		return;
	end if;

	if _realtime = 1 then
		return query
			select 
			a.title, 
			a.link,
			a.img_preview,
			a.img_view,
			a.preview,
			a.price,
			a.date_start,
			a.date_finish,
			a.type,
			a.form_event, 
			a.city_event
			from website.private_catalog( _id1, _id2, _id3 ) as a
			where a.id23004 is not null
			order by a.date_start, a.title;
	else
		return query
			select 
			t28006.catalog_title, 
			t28006.catalog_link,
			t28001.file_name_link,
			t28001.file_name_link,
			t28006.catalog_preview,
			t28006.catalog_price,
			t28006.catalog_date,
			t28006.catalog_date,
			case when t28006.is_item=true then 'item' else 'folder' end,
			null::text as form_event, 
			null::text as city_event
			from t28006
			left join t28001 ON t28006.id28001 = t28001.idkart
			where t28006.dttmcl is null and t28006.is_item=true
				and (t28006.id28011 = _id1 or _id1 is null)
				and (t28006.id28012 = _id2 or _id2 is null)
				and (t28006.id28013 = _id3 or _id3 is null)
			order by t28006.catalog_date, t28006.catalog_title;
	end if;
end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."get_catalog_by_tags"(IN _id1 int4, IN _id2 int4, IN _id3 int4) OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.private_tree_all()
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."private_tree_all"();
CREATE FUNCTION "website"."private_tree_all"()
 RETURNS TABLE(parent_obj text, parent_obj_id text, obj text, obj_id text, link text, "name" text, controller text, controller_next text) AS
$BODY$
declare 
	_realtime integer := website.private_real();
begin

	return query
		select 
			null::text,
			null::text,
			0::text,
			t28002.idkart::text,
			t28002.page_link,
			t28002.page_name,
			'page'::text,
			t28002.page_controller
		from t28002
		where t28002.dttmcl is null and t28002.page_num_sort is not null;
	-- каталог
	return query
		select 
			case when a.id28005 is null then 0 else 4 end::text,
			COALESCE(a.id28005,4::text),
			4::text,
			a.id,
			a.link,
			a.title,
			'catalog'::text,
			'catalog'::text
		from website.private_catalog(null,null,null) as a;
	-- новости
	return query
		select 
			0::text,
			7::text,
			7::text,
			a.id,
			a.link,
			a.title,
			'news'::text,
			'news'::text
		from website.private_news() as a;
	-- отзывы
	return query
		select 
			0::text,
			5::text,
			5::text,
			a.id,
			a.link,
			a.title,
			'reviews'::text,
			'reviews'::text
		from website.private_reviews() as a;
	-- акции
	return query
		select 
			0::text,
			8::text,
			8::text,
			a.id,
			a.link,
			a.title,
			'shares'::text,
			'shares'::text
		from website.private_shares() as a;
	-- вакансии
	return query
		select 
			0::text,
			9::text,
			9::text,
			a.id,
			a.link,
			a.title,
			'careers'::text,
			'careers'::text
		from website.private_careers() as a;

end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."private_tree_all"() OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.get_blueimp_slider(int4)
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."get_blueimp_slider"(int4);
CREATE FUNCTION "website"."get_blueimp_slider"(IN _id int4)
 RETURNS TABLE(navigation int4, preview int4, controls int4, auto_slide int4, slide_interval int4, slides jsonb) AS
$BODY$
begin
		return query
			select 
				case when t28016.navigation=true then 1 else 0 end,
				case when t28016.preview=true then 1 else 0 end,
				case when t28016.controls=true then 1 else 0 end,
				case when t28016.auto_slide=true then 1 else 0 end,
				t28016.slide_interval,
				jsonb_agg(a.js)
			from t28016
			left join (
				select
				t28017.id28016,
				json_build_object( 
					'title',t28001.title,
					'description',t28001.description,
					'image',t28001.file_name_link,
					'url',t28017.url
				) as js
				from t28017
				left join t28001 ON t28017.id28001 = t28001.idkart
--				where t28017.idkart = -1
			) as a on a.id28016 = t28016.idkart
			where t28016.idkart  = _id
			group by 
				case when t28016.navigation=true then 1 else 0 end,
				case when t28016.preview=true then 1 else 0 end,
				case when t28016.controls=true then 1 else 0 end,
				case when t28016.auto_slide=true then 1 else 0 end,
				t28016.slide_interval;
end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."get_blueimp_slider"(IN _id int4) OWNER TO "postgres";

-- ----------------------------
--  Function structure for website.private_events_action(int4, int4, int4)
-- ----------------------------
DROP FUNCTION IF EXISTS "website"."private_events_action"(int4, int4, int4);
CREATE FUNCTION "website"."private_events_action"(IN _id23032 int4, IN _id23033 int4, IN _id21309 int4)
 RETURNS TABLE(id23004 int4, id23031 int4, id23032 int4, id23033 int4, id23034 int4, id21309 int4, id23039 int4) AS
$BODY$
begin
	return query
			select a.id23004, a.id23031, a.id23032, a.id23033, a.id23034, a.id21309, COALESCE(t23039.idkart,9) as id23039
			from (
				select t23004.idkart as id23004, t23003.id23031, t23035.id23032, t23004.id23033, t23003.id23034, t21307.id21309
				from t23003
				join t23004 on t23004.id23003 = t23003.idkart
				left join t23035 on t23003.idkart = t23035.id23003 and t23035.dttmcl is null
				left join t21307 on t23004.id21307 = t21307.idkart
				where t23003.dttmcl is null 
					and t23004.cancel is null 
					and t23003.date_archive is null 
					and (t23004.date_event is null or t23004.date_event >= 'now'::text::date)
					and t23003.file_plan is not null
					and (
						(t23035.id23032 = _id23032 or _id23032 is null) and
						(t23004.id23033 = _id23033 or _id23033 is null) and
						(t21307.id21309 = _id21309 or _id21309 is null)
					)
			) as a
			left join ( select * from t23039 where idkart <>9 ) as t23039 on 
				(t23039.id23031=a.id23031 or t23039.id23031 is null ) and
				(t23039.id23032=a.id23032 or t23039.id23032 is null ) and
				(t23039.id23033=a.id23033 or t23039.id23033 is null ) and
				(t23039.id23034=a.id23034 or t23039.id23034 is null );
end;
$BODY$
	LANGUAGE plpgsql
	COST 100
	ROWS 1000
	CALLED ON NULL INPUT
	SECURITY INVOKER
	VOLATILE;
ALTER FUNCTION "website"."private_events_action"(IN _id23032 int4, IN _id23033 int4, IN _id21309 int4) OWNER TO "postgres";

