-- select n_header as header,min(n_dt) as date from news group by n_id having n_header is not null; 
-- select n_header as header,min(datediff(now(),n_dt)) from news having min(datediff(now(),n_dt)) group by n_header;

-- 1.
Select count(n_id)+(Select count(r_id) from reviews) as Sum from news;

-- 2.
select nc_name,count(n_id) from news_categories left join news on n_category=nc_id
	group by(nc_id);

-- 3.
select rc_name, count(r_id) from reviews_categories left join reviews on rc_id=r_category
		group by (rc_id);

-- 4.
select nc_name,max(n_dt)as last_date from news_categories,news where n_category=nc_id 
	group by nc_name
	union
		select rc_name,max(r_dt) from reviews,reviews_categories where r_category=rc_id 
        group by rc_name
        order by last_date; 

-- 5.
select p_name,m2m_banners_pages.b_id,b_url from pages, m2m_banners_pages,banners 
	where m2m_banners_pages.p_id=pages.p_id and 
		p_parent is null and 
			banners.b_id=m2m_banners_pages.b_id;

-- 6.
select p_name from pages where p_id in
	(select p_id from m2m_banners_pages where b_id in
		(select b_id from banners));

-- 7.
select p_name from pages where p_id not in
	(select p_id from m2m_banners_pages where b_id in
		(select b_id from banners));

-- 8.
select b_id,b_url from banners where b_id in(
	select b_id from m2m_banners_pages);

-- 9.
select b_id,b_url from banners where b_id not in(
	select b_id from m2m_banners_pages);

-- 10.
select b_id,b_url,(b_click/b_show)*100 as rate from banners 
	where (b_click/b_show)>=0.8 and b_show>0;

-- 11.
select distinct p_name from pages,m2m_banners_pages,banners
	where m2m_banners_pages.p_id=pages.p_id and 
			banners.b_id=m2m_banners_pages.b_id and 
				banners.b_text is not null;

-- 12.
select distinct p_name from pages,m2m_banners_pages,banners
	where m2m_banners_pages.p_id=pages.p_id and 
			banners.b_id=m2m_banners_pages.b_id and 
				banners.b_text is null;

-- 13.
select n_header as header,n_dt as date from news where year(n_dt)=2011
	union
		select r_header ,r_dt from reviews where year(r_dt)=2011;

-- 14.
select nc_name as category from news right join news_categories on nc_id=n_category where n_header is null
	union
		select rc_name from reviews right join reviews_categories on rc_id=r_category where r_header is null;

-- 15.
select n_header,n_dt as date from news 
	where year(n_dt)=2012 and n_category=3;
        
-- 16.
select year(n_dt),count(year(n_dt)) from news group by year(n_dt);

-- 17.
select b_url,b_id from banners where b_url in 
	(select b_url from banners group by b_url having count(b_id) > 1);

-- 18.
select p_name,m2m_banners_pages.b_id,b_url from pages,m2m_banners_pages,banners
	where pages.p_parent=1 and 
		pages.p_id= m2m_banners_pages.p_id and
			banners.b_id=m2m_banners_pages.b_id;

-- 19.
select b_id,b_url,(b_click/b_show) as rate from banners 
	where b_pic is not null order by (b_click/b_show) desc;

-- 20.

-- 21.
select b_url,b_id from banners where b_url in 
	(select b_url from banners group by b_url having count(b_id) = 1);

22.
