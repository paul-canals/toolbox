/*!
 ******************************************************************************
 * \file       test_m_utl_json2ds.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-06-30 00:00:00
 * \version    24.1.06
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_json2ds.sas
 * 
 * \copyright  Copyright 2008-2025 Paul Alexander Canals y Trocha
 * 
 *     This program is free software: you can redistribute it and/or modify
 *     it under the terms of the GNU General Public License as published by
 *     the Free Software Foundation, either version 3 of the License, or
 *     (at your option) any later version.
 * 
 *     This program is distributed in the hope that it will be useful,
 *     but WITHOUT ANY WARRANTY; without even the implied warranty of
 *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *     GNU General Public License for more details.
 * 
 *     You should have received a copy of the GNU General Public License
 *     along with this program. If not, see <https://www.gnu.org/licenses/>.
 * 
 ******************************************************************************
 */
 
%* Example 1: Show help information: ;
%m_utl_json2ds(?)
 
%* Example 2: Step 1 - Create a JSON file representing a person with no arrays: ;
filename person "%sysfunc(getoption(WORK))/person.json";

data _null_;
   file person;
   put '{';
   put '  "firstName": "John",';
   put '  "lastName": "Smith",';
   put '  "isAlive": true,';
   put '  "age_is_too_long_for_sas_to_handle": 25,';
   put '  "address": {';
   put '    "streetAddress": "21 2nd Street",';
   put '    "city": "New York",';
   put '    "state": "NY",';
   put '    "postalCode": "10021-3100"';
   put '  },';
   put '  "phoneNumber": "212 555-1234"';
   put '  "children": false,';
   put '  "spouse": null';
   put '}';
run;

data _null_;
   infile person;
   input;
   put _infile_;
run;
 
%* Example 2: Step 2 - Convert person.json file into WORK.person: ;
%m_utl_json2ds(
   json_file = %quote(%sysfunc(getoption(WORK))/person.json)
 , out_ds    = person
 , pretty    = Y
 , debug     = Y
   );

title 'Person';
proc print data=WORK.person;
run;
 
%* Example 3: Step 1 - Create a JSON file representing a person with arrays: ;
filename person "%sysfunc(getoption(WORK))/person.json";

data _null_;
   file person;
   put '{';
   put '  "firstName": "John",';
   put '  "lastName": "Smith",';
   put '  "isAlive": true,';
   put '  "age": 25,';
   put '  "address": {';
   put '    "streetAddress": "21 2nd Street",';
   put '    "city": "New York",';
   put '    "state": "NY",';
   put '    "postalCode": "10021-3100"';
   put '  },';
   put '  "phoneNumbers": [';
   put '    [';
   put '      "type",';
   put '      "number"';
   put '    ],';
   put '    [';
   put '      "home",';
   put '      "212 555-1234"';
   put '    ],';
   put '    [';
   put '      "office",';
   put '      "646 555-4567"';
   put '    ],';
   put '    [';
   put '      "mobile",';
   put '      "123 456-7890"';
   put '    ]';
   put '  ],';
   put '  "children": [';
   put '    {';
   put '      "type": "daughter",';
   put '      "name": "Susanne"';
   put '    },';
   put '    {';
   put '      "type": "son",';
   put '      "name": "William"';
   put '    },';
   put '  ],';
   put '  "spouse": null';
   put '}';
run;

data _null_;
   infile person;
   input;
   put _infile_;
run;
 
%* Example 3: Step 2 - Convert person.json file into WORK.person: ;
%m_utl_json2ds(
   json_file = %quote(%sysfunc(getoption(WORK))/person.json)
 , out_ds    = person
 , pretty    = Y
 , debug     = N
   );

title 'Person';
proc print data=WORK.person;
run;

title 'Person_Children';
proc print data=WORK.person_children;
run;

title 'Person_Phonenumbers';
proc print data=WORK.person_phonenumbers;
run;
 
%* Example 4: Step 1 - Create a JSON file representing a person using wrong json format: ;
filename person "%sysfunc(getoption(WORK))/person.json";

data _null_;
   file person;
   put '{';
   put '  "firstName": "John"';
   put ' ,"lastName": "Smith"';
   put ' ,"isAlive": true';
   put ' ,"age": 25';
   put ' ,"address": {';
   put '    "streetAddress": "21 2nd Street"';
   put '   ,"city": "New York"';
   put '   ,"state": "NY"';
   put '   ,"postalCode": "10021-3100"';
   put '  }';
   put ' ,"phoneNumbers": [';
   put ' ]';
   put ' ,"children": [';
   put ' ]';
   put ' ,"spouse": null';
   put '}';
run;

data _null_;
   infile person;
   input;
   put _infile_;
run;
 
%* Example 4: Step 2 - Reformat, and convert person.json file into WORK.person: ;
%m_utl_json2ds(
   json_file = %quote(%sysfunc(getoption(WORK))/person.json)
 , out_ds    = person
 , pretty    = N
 , debug     = Y
   );

title 'Person';
proc print data=WORK.person;
run;
 
