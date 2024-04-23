// import functions from Admin model

import {
  getAllAdmin,
  getAdminByEmail,
  insertAdmin,
//   getAdminData,
} from "../models/AdminModel.js";

// get all Admin
export const allAdmin=(req,res)=>{
    getAllAdmin((err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};


// get single admin
export const showAAdmin = (req,res)=>{
    getAdminByEmail(req.params.email,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

// create user
export const createAdminAccount=(req,res)=>{
    const data = req.body;
    insertAdmin(data,(err,results)=> {
        if (err) {
            res.send(err);
        }else {
            res.json(results);
        }
    });
};

// // getAdminData
// export const getAllAdminData=(req,res)=>{
//     getAdminData((err,results)=> {
//         if (err) {
//             res.send(err);
//         }else {
//             res.json(results);
//         }
//     });
// };



