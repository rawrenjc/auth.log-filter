#!/bin/bash

#Goal" Create a script that parses auth.log and filter for the relevant information

#1. Create a script that tells you the number of failed attempts.

echo 'Number of Failed attempts are:'

cat auth.log | awk '$6=="Failed"' | wc -l


#2. Tells you the number of Failed attaempts as root only

echo 'Number of Failed attempts as root only:'

cat auth.log | awk '$6=="Failed"' | awk '$9=="root"' | wc -l

#3. Tells you number number of Failed attempts as invalid users only

echo 'Number of Failed attempts as invalid user:'

cat auth.log | awk '$6=="Failed"' | awk '$9=="invalid"' | wc -l

#4. Finds the number of Failed attempts as valid users only
# Thought process: Exclude root and invalid - remaining should be valid users

echo 'The number of Failed login attempt as valid users are:'

cat auth.log | awk '$6=="Failed"' | grep -v invalid | grep -v root | wc -l

#5. Finds the most number of Failed attempts made by the same IP

echo 'The number of Failed attempts made by the same IP'

cat auth.log | awk '$6=="Failed"' | awk '{print $(NF-3)}' | sort | uniq -c | sort -n | tail -n 1 

#6a. Finds invalid username that has the most number of Failed attempts

echo 'Invalid username that has the most Failed attempts:'

cat auth.log | awk '$6=="Failed"' | awk '$9=="invalid"' | awk '{print $(NF-5)}'  | sort | uniq -c | sort -n | tail -n 1 | awk '{print $2}'

#6b. How many times did the invalid user try to log in

echo 'The number of times the invalid user tried to login was:'

cat auth.log | awk '$6=="Failed"' | grep invalid | awk '{print $(NF-5)}' | sort | uniq -c | sort -n | tail -n 1 | awk '{print $1}'

#7. Most number of Failed attempts as valid user

echo 'Valid username that has the most number of Failed attempts:'

 cat auth.log | awk '$6=="Failed"' | grep -v invalid | grep -v root  | awk '{print $(NF-5)}' | sort | uniq -c | sort -n | tail -n 1 | awk '{print $2}'

#8a. Finds the number of successful attempts as root

echo 'The number of successful attempts as root is :'

cat auth.log  | awk '$6=="Accepted"' | grep root | wc -l

#8b. Finds the number of successful attempts as root

echo 'IP that has the most successful attempts as root is:'

cat auth.log | awk '$6=="Accepted"' | grep root | awk '{print $(NF -3)}' | sort | uniq -c | head -n 1

#9. Finds the time that most failed attempts happen

echo 'Time that most failed attempts happen is:'

cat auth.log | grep Failed | awk '{print $1, $2, $3}' | sort | uniq -c | sort -n | tail -n 1


#10. Finds the time for the first entry in the log

echo 'Time for first entry into log:'

cat auth.log | awk '{print $3}' | head -n 1 

#11. Time for last entry into log

echo 'Time for last entry in the log:'

cat auth.log | awk '{print $3}' | tail -n 1 

#12. Finds all unique usernames and saves them into a file

echo 'Saving usernames into authlogusernames.txt'

cat auth.log | awk '$6=="Failed"' | awk '{print $9}' | sort | uniq > authlogusernames.txt

#13. Finds the countries of top 3 IPs that has the most Failed attempts

