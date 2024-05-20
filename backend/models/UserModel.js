// import connection
import db from "../config/database.js";

// get all user
export const getAllUser = (result) => {
    db.query("SELECT * FROM user", (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
};


// get single user
export const getUserByEmail = (data,result) => {
    db.query("SELECT user_id, user_fname, user_password FROM user WHERE user_email = ?",[data], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
};

// insert User
export const insertUser = (data,result) => {
    db.query("INSERT INTO user SET ?",data, (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
};


//getUserphone

export const getUserphone = (data,result) => {
    db.query("SELECT user_id FROM user WHERE user_phone = ?",[data], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
};

// getEmail
export const getEmail = (data,result) => {
    db.query("SELECT user_email FROM user WHERE user_id = ?",[data], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
};

// getPhone
export const getPhone = (data,result) => {
    db.query("SELECT user_phone FROM user WHERE user_id = ?",[data], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
};


// getFirstName
export const getFirstName = (data,result) => {
    db.query("SELECT user_fname FROM user WHERE user_id = ?",[data], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
};

// getLastName
export const getLastName = (data,result) => {
    db.query("SELECT user_lname FROM user WHERE user_id = ?",[data], (err,results)=> {
        if (err){
            console.log(err);
            result(err,null);
        }else{
            result(null,results[0]);
        }
    });
};

//////////////////lang status////////////
export const langStatus = (id, result) => {
  db.query(
    "SELECT langstatus FROM user WHERE user_id = ?",
    [id],
    (err, results) => {
      if (err) {
        console.log(err);
        result(err, null);
      } else {
        result(null, results);
      }
    }
  );
};


export const updateEngIndex = (data, result) => {
  db.query(
    "UPDATE user SET langstatus = langstatus - 1  WHERE user_id = ?",
    [data],
    (err, results) => {
      if (err) {
        console.log(err);
        result(err, null);
      } else {
        result(null, results);
      }
    }
  );
};

export const updateOroIndex = (data, result) => {
  db.query(
    "UPDATE user SET langstatus = langstatus + 1 WHERE user_id = ?",
    [data],
    (err, results) => {
      if (err) {
        console.log(err);
        result(err, null);
      } else {
        result(null, results);
      }
    }
  );
};