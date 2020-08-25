--private String mem_id;
SELECT 'private '||DECODE(DATA_TYPE, 'NUMBER', 'Integer ', 'String ')
        || LOWER(COLUMN_NAME) ||';'
FROM COLS
WHERE TABLE_NAME = 'OR_RET_PLIST';