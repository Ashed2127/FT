import {
    updateEngIndex,
    updateOroIndex,
    langStatus
} from "../models/lang.js"

export const engIndex = (req, res) => {
//   const data = req.body;
//   const id = req.params.id;
  updateEngIndex((err, results) => {
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
  updateOroIndex((err, results) => {
    if (err) {
      res.send(err);
    } else {
      res.json(results);
    }
  });
};

//getAllStatus
export const getAllStatus = (req, res) => {
  getStatus((err, results) => {
    if (err) {
      res.send(err);
    } else {
      res.json(results);
    }
  });
};

// getLangStatus
export const getLangStatus = (req, res) => {
  langStatus((err, results) => {
    if (err) {
      res.send(err);
    } else {
      res.json(results);
    }
  });
};