#!/bin/bash
curl -v --cookie-jar cookies.dat -H "Content-Type: application/json" -d '{"email":"rgpass@gmail.com","password":"foobar"}' http://localhost:3000/api/v1/sessions