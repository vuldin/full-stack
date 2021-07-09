const express = require("express");

const PORT = process.env.PORT || 3001;

const app = express();

// app.get("/api", (req, res) => {
//   res.json({ message: "Hello from server!" });
// });

// app.listen(PORT, () => {
//   console.log(`Server listening on ${PORT}`);
// });

console.log("Hello nodejs");

var ibmdb = require('ibm_db');
var connStr = "DATABASE=BLUDB;HOSTNAME=10.130.0.11;UID=admin;PWD=cyM1bFZAaGQyM0BENFNHPw==;PORT=32195;PROTOCOL=TCPIP";

ibmdb.open(connStr, function (err,conn) {
  if (err) return console.log(err);
  
  conn.query('select * from customer', function (err, data) {
    if (err) console.log(err);
    else {
      console.log(data);
    }

    conn.close(function () {
      console.log('done');
    });
  });
});



// DRIVER=/Users/Ritu.Patel@ibm.com/Desktop/full-stack/odbc_cli_32;DATABASE=testdb;UID=db2inst1;PWD=password;HOSTNAME=localhost;port=50000