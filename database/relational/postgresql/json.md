#### JSONB VS Columns
* Bunch of columns better with:
    * Static fields (e.g. address structure)
* Json better with:
    * Dynamic fields (e.g. grafana config)
    * Isolated fields (e.g. trello card)
    * Limited size lists (e.g. list of available protocols)
    * When you need to store json response from external service
        * E.g. [Charge from Stripe API](https://stripe.com/docs/api/ruby#charge_object)
    * When optimization is very important

#### JSONB features
* Creating table
    * `CREATE TABLE building (id SERIAL PRIMARY KEY, data JSONB);`
* Inserting
    * `INSERT INTO building(id, data) VALUES (1, '{"name": "Tall house", "tags": ["Business-center", "Shop"], "finished": true}')`
* Querying data
    * `SELECT data->>'name' AS name FROM building`
* Filtering
    * `SELECT * FROM building WHERE data->>'finished' = 'true'`
    * `SELECT * FROM building WHERE data->'tags' ? 'Shop'`
* Check if field exists
    * `SELECT count(*) FROM cards WHERE data ? 'finished';`
* Expanding data (returns 2 rows - "Business-center" and "Shop")
    * `SELECT jsonb_array_elements_text(data->'tags') as tag FROM cards`
* Indexing
    * `CREATE INDEX finished_index ON cards ((data->>'finished'));`
