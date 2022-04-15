importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js");
var firebaseConfig = {
  apiKey: "AIzaSyBiJdKPkjD4V4PZ5k03EPkA8sUne3BYLaI",
  authDomain: "shiped-7b848.firebaseapp.com",
  databaseURL: "https://shiped-7b848.firebaseio.com",
  projectId: "shiped-7b848",
  storageBucket: "shiped-7b848.appspot.com",
  messagingSenderId: "219386321464",
  appId: "1:219386321464:web:b73b2780951671785924cd",
  measurementId: "G-PD866J5GH7"
};
firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});
