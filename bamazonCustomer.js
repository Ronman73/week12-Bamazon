var mysql = require('mysql');
var secret_keys = require('./secret_keys')
var inquirer = require("inquirer");

var conn = mysql.createConnection(secret_keys);

conn.connect(function(err){
	if(err){
		console.log(err);
		throw err;
	}
});

var getProductsQuery = "SELECT p.itemID, p.productName, d.departmentName, p.price, p.stockQuantity FROM Products p, Department d WHERE p.departmentId = d.departmentID AND p.stockQuantity > 0;";
var getProductQuery = "SELECT productName, price, stockQuantity FROM Products WHERE itemID=?";
var updateProductsQuery = "UPDATE Products SET stockQuantity = ? WHERE itemID=?";

// Show available products
conn.query(getProductsQuery, function(err, res)
{
	if(err)
	{
		throw err;
	}
	for(var i = 0; i < res.length; i++)
	{
		console.log('==========================');
		var r = res[i];
		console.log("ID: "+r.itemID+"\nProduct: "+r.productName+"\nDepartment Name: "+r.departmentName+"\nPrice: "+r.price+"\nStock Quantity: "+r.stockQuantity);
		console.log('==========================');
	}
	inquirer.prompt([{
		name: "itemID",
		message: "Insert the ID of the product that you would like to buy"
	}, {
		name: "units",
		message: "How many units would you like to buy"
	}]).then(function(answers) {
		// Get info of selected product
		conn.query(getProductQuery,[answers.itemID], function(er, prods)
		{
			if(er)
			{
				throw er;
			}
			// If there is a product with that ID
			if( prods.length > 0 )
			{
				// Check if units requested are 0 or negative
				if( parseInt(answers.units) <= 0)
				{
					console.log("Units must be higher than 0");
				}
				else
				{
					var newStockQty = parseInt(prods[0].stockQuantity) - parseInt(answers.units);
					// If there is enough stock
					if ( newStockQty >= 0 )
					{
						// Update products
						conn.query(updateProductsQuery,[newStockQty,answers.itemID], function(e, msg)
						{
							if(e)
							{
								throw e;
							}
							else
							{
								console.log("Product: " + prods[0].productName + " with ID " + answers.itemID + " has now " + newStockQty + " unit(s) in stock.");
								var totalCost = parseInt(answers.units) * parseFloat(prods[0].price);
								console.log("The total cost of the purchase was: $" + totalCost);
							}
						});
					}
					else
					{
						console.log("The product with the ID " + answers.itemID + " does not have enough stock.");
					}
				}
			}
			else
			{
				console.log("The product with the ID " + answers.itemID + " does not exit.");
			}
			conn.end();
		});
	});
});