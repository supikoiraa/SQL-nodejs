var express = require('express');
var app = require('express')();
var http = require('http').Server(app);
var path = require("path");
var port = 3000;
//Määritellään mistä käyttöliittymän kilkkeet löytyy
app.use(express.static(__dirname + '/client'));
app.get('/', function(req, res){
  res.sendFile(__dirname + '/client/käyttöliittymä.html');
});
// Luodaan yhteys mysql
var mysql = require('mysql');
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : '******',
  database : 'Yritys'
});


connection.connect();

//haetaan tilattuja tuotteita, jotka ovat tuotelistassa
app.get('/nimi', function(req, res) {
	var Query = 'SELECT tuotelista.tilausid,tuote.nimi,tuote.hinta FROM tuotelista,tuote WHERE tuotelista.tuote =tuote.tuotenro';
	var sendThis;

	connection.query( Query, function(err, rows, resp){
  		console.log('Found: ',rows );
  		sendThis = rows 
  		res.send(sendThis);
  	
  });
});

//Haetaan ostotapahtumia päivämäärältä 4.11.2014 (black friday)
app.get('/osto', function(req, res) {
	var Query = 'SELECT ostotapahtuma.tilausid, asiakas.etunimi, ostotapahtuma.pvm FROM ostotapahtuma,asiakas WHERE ostotapahtuma.asiakas=asiakas.asiakastunnus AND ostotapahtuma.pvm ="4.11.2014"';
	var sendThis;

	connection.query( Query, function(err, rows, resp){
  		console.log('Found: ',rows );
  		sendThis = rows 
  		res.send(sendThis);
  	
  });
});
//Haetaan palkkaerittelyitä joissa työntekijän etunimi ja palkka yli 2800€

app.get('/palkka', function(req, res) {
	var Query = 'SELECT palkkaerittely.palkkaid,työntekijä.etunimi,palkkaerittely.palkka FROM palkkaerittely,työntekijä WHERE palkkaerittely.henkilö=työntekijä.henkilötunnus AND palkkaerittely.palkka>2800';
	var sendThis;

	connection.query( Query, function(err, rows, resp){
  		console.log('Found: ',rows );
  		sendThis = rows 
  		res.send(sendThis);
  	
  });
});

//kuunnellaan porttia 3000
http.listen(3000, function(){
  console.log('listening on http://localhost:'+port);
});
