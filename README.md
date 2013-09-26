Scripts
=======

Scripts that do some neat tasks. 

Billmonk-Parser :
-----------------

The code takes in the billmonk exported data, parses it and outputs a nested hash. The output is not formatted and is in the raw form. So is the input (does not read the file to be parsed from the command line). You would need to edit the line that opens the file and add the name of file to be parsed manually. Then run the script with

ruby BillmonkParser.rb

The output nested hash is of the form @billmonk_matrix[person1][person2], where @billmonk_matrix[person1][person2] would be the amount person1 owes person2



ODBC-trace-split :
------------------

This perl script splits a standard Unix ODBC trace based on the thread ID or process ID making it easier to analyse the traces. This script assumes that the input ODBC trace is well formed.



Teefury-Wallpaper :
-------------------

Changes the desktop background of a Mac computer with the days tee image of the teefury website

All you would need to do is to save the teefury.rb file on your system and add this cron rule 

00 */22 *  * * ruby <location-of-the-script>/teefury.rb
