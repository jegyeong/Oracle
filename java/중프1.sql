select 'private ' ||
        decode(lower(data_type), 'number', 'int ', 'String ') ||
        lower(column_name) || ';'
  from FAQ
 where lower(table_name) = 'related_law';
 
 select 'private ' ||
        decode(lower(data_type), 'number', 'int ', 'String ') ||
        lower(column_name) || ';'
  from cols
 where lower(table_name) = 'FAQ';
 
 alter table a_article add (a_art_price number);
 