echo off
title Sign In to AltspaceVR
curl -v -d "user[email]=&user[password]=" https://account.altvr.com/users/sign_in.json -c cookie
