print("mongo-check start");
db.connpass.insert({name:'data1',age:1});
db.connpass.insert({name:'data2',age:2});
print (JSON.stringify(db.connpass.findOne(), null, "  "));
var query = {age:2};
db.connpass.find(query).forEach(function(x){ print(x.name); });
print("mongo-check end");