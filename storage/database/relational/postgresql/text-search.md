### Trigrams
* TLDR - fast search anywhere in the string `name like '%enjamin%'`
* Replace your old index with GIN trigrams:
    ```
    CREATE EXTENSION IF NOT EXISTS pg_trgm; -- sometimes its necessary to specify schema, e.g. "WITH SCHEMA PATIENT"
    CREATE INDEX CONCURRENTLY idx_guest_address ON VISIT USING GIN(guest_address gin_trgm_ops);
    ```
* (Optional) To search multiple columns at once - combine them:
    ```
    ALTER TABLE visit
    ADD COLUMN guest_address text GENERATED ALWAYS AS (city || ' ' ||  street || ' ' || house) STORED;
    ```
* (Optional) To make search less strict - replace everything except letters, numbers and spaces with `-`:
    * `SELECT regexp_replace('!A1/B2. C3,D4:E5;', '[^\w\s]+', '-', 'g');`
    * (Optional) also convert to upper/lower case
    * When searching - apply same changes to query

### Fuzzy search
* Example - Look for `GUMBO`, find `DUMBO`
* Install - `CREATE EXTENSION if not exists fuzzystrmatch;`
* Check:
    * `SELECT levenshtein('GUMBO', 'DUMBO');` -> `1`
    * `SELECT levenshtein('GUMBO', 'WORLD');` -> `5`
* Search query example (will find John)
    ```
    SELECT * 
    FROM user
    WHERE levenshtein(first_name , 'Jeohn') <= 2
    ```

### Full-text search
* Warning №1!
    * Full-text search ignores some characters (!@#$&%^*)
    * To use them - `ALTER TEXT SEARCH CONFIGURATION your_config_name ALTER MAPPING FOR blank WITH simple`
* Warning №2!
    * You have to sanitize user input, a lot of characters (!<:) can lead to "Incorrect syntax" error
* Find exact match (strict search)
    * Examples:
        * Look for `specially`, find `specially`, not find `special`
        * Look for `аа` (rus), find `АА753`, not find `А123`
        * Look for `a`, find `absorb` and `aaron`
    * Check it:
        * `select * from to_tsvector('simple', 'specially:*');` -> `'specially':1`
        * `select * from to_tsvector('simple', 'аа:*');` -> `'аа':1`
        * `select * from to_tsvector('simple', 'a:*');` -> `'a':1`
* Find partial match
    * Examples:
        * Look for `specially`, find `specially` and `special` 
        * Look for `аа` (rus), find `А123`, find `АА753`
        * Look for `a`, find nothing (because of stop words)
    * Check it:
        * `select * from to_tsvector('english', 'specially:*');` -> `'special':1`
        * `select * from to_tsvector('russian', 'аа:*');` -> `'а':1`
        * `select * from to_tsvector('english', 'a:*');` -> ``
* Expand word delimiters
    * Examples:
        * `SELECT to_tsquery('simple', 'ab&cd:*') @@ to_tsvector('simple', 'ab_cdef');` -> `true`
        * `SELECT to_tsquery('simple', 'ab_cd:*') @@ to_tsvector('simple', 'ab#cdef');` -> `true`
        * `SELECT to_tsquery('simple', 'ab-cd:*') @@ to_tsvector('simple', 'ab.cdef');` -> `false`
            * To fix - `SELECT regexp_replace('А/B-C.D./-', '[/\.-]', '&', 'g');`
            * Fix is necessary, because otherwise parser will think it's just a long word (hyphen, file, host)
                * `SELECT alias, description, token FROM ts_debug('foo/bar');` -> `file`
    * User input may throw "Incorrect syntax" error. To fix it:
        * `SELECT regexp_replace('А<B!C:D|E<!:|F', '[<!:|]', '&', 'g');`
* Examples
    * Simple examples:
        * `SELECT to_tsquery('big & dog') @@ to_tsvector('dog is pretty big');` -> `true`
        * `SELECT to_tsquery('big & !dog') @@ to_tsvector('dog is pretty big');` -> `false`
        * `SELECT to_tsquery('big | cat') @@ to_tsvector('dog is pretty big');` -> `true`
    * Search query example (will find Obama):
        ```
        select * from 
            user,
            to_tsquery('simple', 'Bara:* & Husse:* & Obam:*') q
        where (
            to_tsvector('simple', first_name) ||
            to_tsvector('simple', middle_name) ||
            to_tsvector('simple', last_name)
        ) @@ q
        ```
