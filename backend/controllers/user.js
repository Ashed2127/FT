// import functions from User model

import {
  getAllUser,
  getUserByEmail,
  insertUser,
  getUserphone,
  getEmail,
  getPhone,
  getFirstName,
  getLastName,
  langStatus,
  updateEngIndex,
  updateOroIndex,
} from "../models/UserModel.js";

// get all Users
export const allUsers=(req,res)=>{
    getAllUser((err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};


// get single user
export const showAUser = (req,res)=>{
    getUserByEmail(req.params.email,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

// create user
export const createAccount=(req,res)=>{
    const data = req.body;
    insertUser(data,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};


//getUserId
// get single user
export const getUserId = (req,res)=>{
    getUserphone(req.params.phone,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

// getUserEmail
export const getUserEmail = (req,res)=>{
    getEmail(req.params.id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};


export const getUserPhone = (req,res)=>{
    getPhone(req.params.id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

// getUserFirstName
export const getUserFirstName = (req,res)=>{
    getFirstName(req.params.id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

// getUserLastName

export const getUserLastName = (req,res)=>{
    getLastName(req.params.id,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

/////////lanaguage status/////////////
export const getLangStatus = (req, res) => {
  langStatus(req.params.id, (err, results) => {
    if (err) {
      res.send(err);
    } else {
      res.json(results);
    }
  });
};


export const engIndex = (req, res) => {
  //   const data = req.body;
  //   const id = req.params.id;
  updateEngIndex(req.params.id, (err, results) => {
    if (err) {
      res.send(err);
    } else {
      res.json(results);
    }
  });
};

export const oroIndex = (req, res) => {
  //   const data = req.body;
  //     const id = req.params.id;
  updateOroIndex(req.params.id, (err, results) => {
    if (err) {
      res.send(err);
    } else {
      res.json(results);
    }
  });
};