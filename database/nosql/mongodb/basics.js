// Haven't used MongoDB for a long time? Here is a quick reminder:

// Create database / Create table
// MongoDB creates collection automatically when first referenced in a command

// Insert data
db.customers.insert( { name: "John", rank: 7 } );

// Select data
db.customers.find({
    name: {
        $eq: "John"
    },
    rank: {
        $gt: 3
    }
});

// Update data
db.customers.updateOne(
    { id: 11 },
    {
        $set: { "name": "Rick", rank: 3 }
    }
);

// Delete data
db.customers.deleteOne( { id: 11 } );

// Aggregation - count, average, sum
db.customers.find( { rank: {$gt: 2} } ).count()
db.customers.aggregate([{$group: {
    _id: null,
    sum_rank: {$sum: "$rank"},
    avg_rank: {$avg: "$rank"}
}}]);

// Pagination - sort, offset, limit
db.customers.find()
    .sort( { "rank": 1} ) // Descending is -1
    .skip(50)
    .limit(10);

// Join
// Its possible with $lookup. But if you need relations - better use relational DB

// Create index
db.customers.createIndex({"rank": 1} ); // 1 Means index is ascending

// Check performance of a query
db.customers.find({ name: { $eq: "John" } }).explain();