//use inventory;
//Create collections
db.createCollection("users")
db.createCollection("products")
db.createCollection("categories")
db.createCollection("orders")
db.createCollection("order_items")

//Insert Data
db.users.insertOne({
    "user_name":"idongesit",
    "password_hash":"wercsyyfifonkbogjgoggpgighbvjvnvmzmvawqewexrdrctcvvygybubbjnin",
    "email":"idongesit@gmail.com",
    "phone_number":"09021345678",
    "role":"user",
    "gender":"male",
    "created_at": Date()
});

db.categories.insertMany([
    {
        "cat_name":"Groceries",
        "cat_desc":"Food to be eaten"
    },
    {
        "cat_name":"Clothing",
        "cat_desc":"Apparrel and accessories"
    }
]);
db.product.insertMany([
    {
        "name":"SmartPhone",
        "price":699.99,
        "size":"medium",
        "category_id":ObjectId('6749dec512307752ea27f070'),
        "stock_quantity":50,
        "description":"Latest model smartphone",
        "created_at":Date(),
        "updated_at":Date()
    },
    {
        "name":"T-shirt",
        "price":200,
        "size":"small",
        "category_id":ObjectId('6749dec512307752ea27f071'),
        "stock_quantity":10,
        "description":"Cotton t-shirt",
        "created_at":Date(),
        "updated_at":Date()
    },
    {
        "name":"Bubu Gown",
        "price":200,
        "size":"Large",
        "category_id":ObjectId('6749dec512307752ea27f071'),
        "stock_quantity":10,
        "description":"Ankara",
        "created_at":Date(),
        "updated_at":Date()
    },
])

db.orders.insertMany([
    {
        "user_id":ObjectId('6749de8c12307752ea27f06f'),
        "status":"pending",
        "created_at": Date()
    },
    {
        "user_id":ObjectId('6749de8c12307752ea27f06f'),
        "status":"approved",
        "created_at": Date()
    }
])

db.order_items.insertMany([
    {
        "order_id":ObjectId('6749e05812307752ea27f075'),
        "prod_id":ObjectId('6749df5912307752ea27f072'),
        "quantity":2
    },
    {
        "order_id":ObjectId('6749e05812307752ea27f076'),
        "prod_id":ObjectId('6749df5912307752ea27f073'),
        "quantity":2
    }
])

//Getting records from a database
db.product.find({_id:ObjectId('6749df5912307752ea27f072')})
db.users.find({_id:ObjectId('6749de8c12307752ea27f06f')})

//Updating a database
db.product.updateOne(
    {_id:ObjectId('6749df5912307752ea27f073')},
    {$set:{category_id:ObjectId('6749e38d12307752ea27f079')}}
)

db.users.updateOne(
    {_id:ObjectId('6749de8c12307752ea27f06f')},
    {$set:{user_name:"Fran Garcia",role:"Admin"}}
)

//deleting records from a database
db.product.deleteOne(
    {_id:ObjectId('6749df5912307752ea27f074')}
)

db.users.deleteOne(
    {
        _id:ObjectId('6749de8c12307752ea27f06f')
    }
)

//Querying records with lookup
db.product.aggregate([
    {
       $lookup:{from: 'Users',localField:'user_id',foreignField:'prod_id', as:'Users'}
    }
])
