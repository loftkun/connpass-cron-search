// create user
print("create user")
var newUsers = [
  {
        user: 'connpass-user',
        pwd: '1234',
        roles: [
            {
                role: 'readWrite',
                db: 'connpass-db'
            }
        ]
    }
];

var currentUsers = db.getUsers();
if (currentUsers.length === newUsers.length) {
    quit();
}
db.dropAllUsers();

for (var i = 0, length = newUsers.length; i < length; ++i) {
    db.createUser(newUsers[i]);
}
