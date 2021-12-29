# README API Document

# BASE_URL: http://localhost:3000

*Headers: {
	Content-Type: application/json
	Accept: application/json
}

*Registration API
REQUEST:
Type: POST	EndPath: /api/v1/registrations
Body: 
{
    "client_id": "ZA8SAuhzsWqCuRuRBasJI9WcycpTMkfz5v1mOoHXaxo",
    "registration": {
        "email": "customer@example.com",
        "password": "123123"
    }
}
RESPONSE: 
{
	"code": 201,
    "user": {
        "access_token": "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJNeSBBcHAiLCJpYXQiOjE2NDA1Nzg4MjgsImp0aSI6ImRhNGQyY2UyLTgxOTEtNDBjNy04ZTFlLTIxOGI5ZjBhNjMyNSIsInVzZXIiOnsiaWQiOjMsImVtYWlsIjoiamFpQGdtYWlsLmNvbSJ9fQ.1x4xWGpSEkqVFbPLatQMrixUCsgmiut5DwXtFSOhdR5pqK6EZcc4F8SIJ1pnZdOrg_B39HHnIfY-sTz5C7kAgA",
        "token_type": "bearer",
        "expires_in": 7200,
        "refresh_token": "bfa9c1f9c69dd0cf0743bde18c4651fcf42086f4aaf510306a92a42090e29cae",
        "created_at": 1640578828
    }
}

*Login API
REQUEST: 
Type: POST	Endpath: /oauth/token
Body: 
{
    "client_id": "ZA8SAuhzsWqCuRuRBasJI9WcycpTMkfz5v1mOoHXaxo",
    "grant_type": "password",
    "email": "jai@gmail.com",
    "password": "password"
}
RESPONSE:
{
    "access_token": "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJNeSBBcHAiLCJpYXQiOjE2NDA2NTU2OTMsImp0aSI6ImUzMjZjMzJjLTQzZTUtNDliZi1hODNlLTgyODk5YzhkYWM1ZSIsInVzZXIiOnsiaWQiOjMsImVtYWlsIjoiamFpQGdtYWlsLmNvbSJ9fQ.wS64rUBZb44TyUwA85c4jPPyk6oux5NxH7BOUSl4Jd-ZmJUyEbF4y64yXmSNZALgc2gYReoEr_Rwk1T4ERgUZA",
    "token_type": "Bearer",
    "expires_in": 7200,
    "refresh_token": "psdJZgv0zJL7gjhf8pVX5EQQVD790dDJDkzh6sXhHD0",
    "created_at": 1640655693
}

*Region List 
REQUEST:
Type: GET 	Endpath http://localhost:3000/api/v1/regions
Query Params: ?page=1&per_page=10&access_token=JWT_ACCESS_TOKEN
RESPONSE:
{
    "code": 200,
    "message": "Sucessfully fetched",
    "region": [
        {
            "id": 1,
            "title": "Central Region",
            "country": "Thailand",
            "currency": "USD",
            "tax": 10.0
        },
        {
            "id": 2,
            "title": "East Region",
            "country": "Thailand",
            "currency": "USD",
            "tax": 10.0
        }
    ]
}

*Create Region
REQUEST: 
Type: POST	Endpath: /api/v1/regions
Body: 
{
    "access_token": "JWT_ACCESS_TOKEN",
    "region": {
            "title": "East Region",
            "country": "Thailand",
            "currency": "USD",
            "tax": 10.0
    }
}
RESPONSE:
{
    "code": 200,
    "message": "Successfully created",
    "region": {
        "id": 6,
        "title": "East Region",
        "country": "Thailand",
        "currency": "USD",
        "tax": 10.0
    }
}

*Update Region
REQUEST: 
Type: PUT	Endpath: /api/v1/regions/:id
Body: 
{
    "access_token": "JWT_ACCESS_TOKEN",
    "region": {
            "title": "East Region",
            "country": "Thailand",
            "currency": "USD",
            "tax": 10.0
    }
}
RESPONSE:
{
    "code": 200,
    "message": "Sucessfully updated",
    "region": {
    	"id": 6,
        "title": "East Region",
        "country": "Thailand",
        "currency": "USD",
        "tax": 10.0
    }
}

*Shops List
REQUEST: 
Type: GET	Endpath: /api/v1/shops
Query Params: ?page=1&per_page=10&access_token=JWT_ACCESS_TOKEN
RESPONSE:
{
    "code": 200,
    "message": "Sucessfully fetched",
    "shops": [
        {
            "id": 1,
            "title": "Zara Store",
            "region": {
                "id": 1,
                "title": "Central Region",
                "country": "Thailand",
                "currency": "INR",
                "tax": 10.0
            }
        }
    ]
}

*Product create
REQUEST:
Type: POST 	Endpath: /api/v1/shops/:shop_id/products
Body: 
{
    "access_token": "JWT_ACCESS_TOKEN",
    "product": {
        	"title": "T-Shirt",
            "description": "Color: white, Size: XL",
            "price": "25",
            "sku": "Number",
            "stock": "50"
    }
}
RESPONSE
{
    "code": 200,
    "message": "Successfully created",
    "product": {
        "id": 5,
        "title": "T-Shirt",
        "description": "Color: white, Size: XL",
        "image_url": null,
        "price": 25.0,
        "sku": "Number",
        "stock": 50,
        "shop_id": 1
    }
}

*Product Update
REQUEST:
Type: PUT 	Endpath: api/v1/shops/:shop_id/products/:id
Body: 
{
    "access_token": "JWT_ACCESS_TOKEN",
    "product": {
        	"title": "T-Shirt",
            "description": "Color: white, Size: L",
            "price": "25",
            "sku": "Number",
            "stock": "50"
    }
}
RESPONSE:
{
    "code": 200,
    "message": "Updated successfully",
    "user": {
        "title": "T-Shirt",
        "description": "Color: white, Size: L",
        "price": 25.0,
        "sku": "Number",
        "stock": 50,
        "id": 5,
        "image_url": null,
        "shop": {
            "title": "Zara Store"
        }
    }
}

*Products List
REQUEST:
Type: GET 	Endpath: /api/v1/shops/:shop_id/products
Query Params: ?page=1&per_page=10&access_token=JWT_ACCESS_TOKEN
RESPONSE:
{
    "code": 200,
    "message": "Sucessfully fetched",
    "products": [
        {
            "id": 6,
            "title": "T-Shirt",
            "description": "Color: white, Size: XL",
            "image_url": null,
            "price": 25.0,
            "sku": "Number",
            "stock": 50
        }
    ]
}

*Product details
REQUEST:
Type: GET 	Endpath: /api/v1/shops/:shop_id/products/:id
Query Params: ?access_token=JWT_ACCESS_TOKEN
RESPONSE:
{
    "code": 200,
    "message": "Successfully fetched",
    "product": {
        "id": 5,
        "title": "T-Shirt",
        "description": "Color: white, Size: L",
        "image_url": null,
        "price": 25.0,
        "sku": "Number",
        "stock": 50,
        "shop": {
            "title": "Zara Store"
        }
    }
}

*Initiate Order
REQUEST:
Type: POST 	Endpath: /api/v1/orders
Body:
{
    "access_token": "JWT_ACCESS_TOKEN",
    "order": {
        	"customer_name": "User Customer",
            "shipping_address": "A 453, sector 02, Noida"
    }
}
RESPONSE:
{
    "code": 200,
    "message": "Successfully created",
    "order": {
        "id": 1,
        "customer_name": "User Customer",
        "shipping_address": "A 453, sector 02, Noida",
        "order_total": 0.0,
        "paid_at": null,
        "paid": false,
        "created_at": "2021-12-28T07:38:28.499Z",
        "order_items": []
    }
}

*Update Order
REQUEST:
Type: PUT 	Endpath: /api/v1/orders/:id
Body:
{
    "access_token": "JWT_ACCESS_TOKEN",
    "order": {
        	"customer_name": "User Customer",
            "shipping_address": "A 453, sector 02, Noida"
    }
}
RESPONSE:
{
    "code": 200,
    "message": "Successfully updated",
    "order": {
        "id": 1,
        "customer_name": "User Customer",
        "shipping_address": "A 453, sector 02, Noida",
        "order_total": 0.0,
        "paid_at": null,
        "paid": false,
        "created_at": "2021-12-28T07:38:28.499Z",
        "order_items": []
    }
}

*Show Order
REQUEST:
Type: GET 	Endpath: /api/v1/orders/:id
Query Params: ?access_token=JWT_ACCESS_TOKEN
RESPONSE:
{
    "code": 200,
    "message": "Successfully fetched",
    "order": {
        "id": 1,
        "customer_name": "User Customer",
        "shipping_address": "A 453, sector 02, Noida",
        "order_total": 0.0,
        "paid_at": null,
        "paid": false,
        "created_at": "2021-12-28T07:38:28.499Z",
        "order_items": []
    }
}

*Delete Order
REQUEST:
Type: DELETE 	Endpath: /api/v1/orders/:id
Query Params: ?access_token=JWT_ACCESS_TOKEN
RESPONSE:
{
    "code": 200,
    "message": "Successfully deleted"
}

*Add Order Item
REQUEST:
Type: POST  	Endpath: /api/v1/orders/:order_id/order_items
Body:
{
    "access_token": "JWT_ACCESS_TOKEN",
    "order_item": {
        	"product_id": 1,
            "quantity": 5
    }
}
RESPONSE:
{
    "code": 200,
    "message": "Successfully created",
    "order_item": {
        "id": 5,
        "quantity": 5,
        "title": "tshirt",
        "base_price": 320.0,
        "total_price": 1600.0,
        "order_id": 1,
        "product_id": 1
    }
}

*Update Order Item
REQUEST:
Type: PUT  	Endpath: /api/v1/orders/:order_id/order_items/:id
Body:
{
    "access_token": "JWT_ACCESS_TOKEN",
    "order_item": {
        	"product_id": 1,
            "quantity": 2
    }
}
RESPONSE:
{
    "code": 200,
    "message": "Successfully updated",
    "order_item": {
        "order_id": 1,
        "product_id": 1,
        "quantity": 2,
        "id": 4,
        "base_price": 320.0,
        "title": "tshirt",
        "total_price": 640.0
    }
}

*List Order Items
REQUEST:
Type: GET  	Endpath: /api/v1/orders/:order_id/order_items
Query Params: ?page=1&per_page=10&access_token=JWT_ACCESS_TOKEN
RESPONSE:
{
    "code": 200,
    "message": "Successfully updated",
    "order_item": {
        "order_id": 1,
        "product_id": 1,
        "quantity": 2,
        "id": 4,
        "base_price": 320.0,
        "title": "tshirt",
        "total_price": 640.0
    }
}

*Delete Order Item
REQUEST:
Type: DELETE  	Endpath: /api/v1/orders/:order_id/order_items/:id
Query Params: ?access_token=JWT_ACCESS_TOKEN
RESPONSE:
{
    "code": 200,
    "message": "Successfully deleted"
}

*Initiate Payment To Checkout Order On Fake Payment Gateway
REQUEST:
Type: POST 	Endpath: /api/v1/orders/:order_id/fake_payments
Body: 
{
    "access_token": "JWT_ACCESS_TOKEN"
}
RESPONSE:
{
    "code": 200,
    "message": "Sucessfully Initiated",
    "orders": {
        "id": 7,
        "order_id": 1,
        "user_id": 3,
        "amount": "1600.0",
        "transaction_number": "7DSQEIGVVHSDEWRIDEIEWD",
        "payment_status": "initiated",
        "created_at": "2021-12-28T10:45:44.861Z",
        "updated_at": "2021-12-28T10:45:44.868Z"
    }
}

*Update Payment Status To Success/Failed on Fake Payment Gateway
REQUEST:
Type: POST 	Endpath: /api/v1/orders/:order_id/fake_payments/:id
Body: 
{
    "access_token": "JWT_ACCESS_TOKEN",
    "status": "success"
}
RESPONSE:
{
    "code": 200,
    "message": "Sucessfully updated",
    "orders": {
        "id": 7,
        "order_id": 1,
        "user_id": 3,
        "amount": "1600.0",
        "transaction_number": "7DSQEIGVVHSDEWRIDEIEWD",
        "payment_status": "success",
        "created_at": "2021-12-28T10:45:44.861Z",
        "updated_at": "2021-12-28T10:45:44.868Z"
    }
}