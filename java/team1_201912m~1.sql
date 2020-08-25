alter table a_article add (a_art_price number);


 select 'private ' ||
        decode(lower(data_type), 'number', 'int ', 'String ') ||
        lower(column_name) || ';'
  from cols
 where lower(table_name) = 'court';