const functions = require('firebase-functions');
const admin = require('firebase-admin');

exports.userUpdate(userId) = functions.firestore
    .document(`users/${userId}`).onUpdate((change,context)=>{
        
    })

