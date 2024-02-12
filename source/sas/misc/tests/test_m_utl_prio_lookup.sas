/*!
 ******************************************************************************
 * \file       test_m_utl_prio_lookup.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-01-30 00:00:00
 * \version    24.1.01
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_prio_lookup.sas
 * 
 * \copyright  Copyright 2008-2024 Paul Alexander Canals y Trocha
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
%m_utl_prio_lookup(?)
 
%* Example 2: Step 1 - Create an example source table: ;
data WORK.counterparty_data;
   input
      cpy_id      : $char5.
      cpy_type    : $char30.
      method_cd   : $char15.
      version_cd  : $char4.
      ;
datalines;
10001     Sovereign     100         301
10002     Sovereign     100         201
10003     Sovereign     300         201
10004     Country       300         999
10005     Retail        7           1
20001     Corporate     921         500
20002     Corporate     TRS_EUR     7
30001     Goverment     800         444
30002     Goverment     801         402
30003     Financial     300         301
;
run;

 
%* Example 2: Step 2 - Create an mapping table (priority: CHAR): ;
data WORK.map_asset_class;
   input
      priority     : $char2.
      cpy_type     : $char30.
      method_cd    : $char15.
      version_cd   : $char4.
      asset_class  : $char30.
      ;
   datalines;
1    #                 TRS_EUR   #     Transfer_EUR
4    #                 100       #     Sovereign
9    #                 300       201   SubSovereign
11   #                 300       301   Financial
12   #                 300       #     Sovereign
18   #                 1         #     NonFinancial
19   #                 921       #     NonFinancial
40   Fin.Institution   999       #     Financial
45   Goverment         999       #     Sovereign
46   #                 999       #     NonFinancial
47   Fin.Institution   #         #     Financial
52   Goverment         #         #     Sovereign
53   #                 #         #     NonFinancial
;
run;

 
%* Example 2: Step 3 - Perform priority hash lookup: ;
%m_utl_prio_lookup(
   src_tbl = WORK.counterparty_data
 , map_tbl = WORK.map_asset_class
 , trg_tbl = WORK.counterparty_map
 , prio    = %str(priority)
 , keys    = %str(cpy_type method_cd version_cd)
 , cols    = %str(asset_class)
 , null    = %str(#)
 , print   = Y
 , debug   = Y
   );

 
%* Example 3: Perform lookup again different order: ;
%m_utl_prio_lookup(
   src_tbl = WORK.counterparty_data
 , map_tbl = WORK.map_asset_class
 , trg_tbl = WORK.counterparty_map
 , prio    = %str(priority)
 , keys    = %str(method_cd version_cd cpy_type)
 , cols    = %str(asset_class)
 , debug   = Y
   );

proc print data=WORK.counterparty_map;
   title 'Ex.3 Perform lookup with different Key order';
   footnote 'Keys: method_cd version_cd cpy_type';
   footnote2 'Cols: asset_class';
run; title; footnote; footnote2;

 
%* Example 4: Perform lookup again different order: ;
%m_utl_prio_lookup(
   src_tbl = WORK.counterparty_data
 , map_tbl = WORK.map_asset_class
 , trg_tbl = WORK.counterparty_map
 , prio    = %str(priority)
 , keys    = %str(method_cd cpy_type version_cd)
 , cols    = %str(asset_class)
 , debug   = Y
   );

proc print data=WORK.counterparty_map;
   title 'Ex.4 Perform lookup with different Key order';
   footnote 'Keys: method_cd cpy_type version_cd';
   footnote2 'Cols: asset_class';
run; title; footnote; footnote2;

 
%* Example 5: Step 1 - Create an example source table: ;
data WORK.counterparty;
   input
      cpy_id      : $char5.
      cpy_type    : $char30.
      method_cd   : $char15.
      version_cd  : $char4.
      ;
datalines;
10001     Sovereign     100     301
10002     Sovereign     100     201
10003     Sovereign     300     201
10004     Country       300     999
10005     Retail        7       1
20001     Corporate     921     500
20002     Corporate     999     7
30001     Goverment     800     444
30002     Goverment     801     402
30003     Financial     300     301
;
run;

 
%* Example 5: Step 2 - Create an mapping table (priority: NUM): ;
data WORK.map_product_type;
   input
      priority
      cpy_type     : $char30.
      method_cd    : $char15.
      version_cd   : $char4.
      prod_type    : $char30.
      ;
   datalines;
4    #             100     #       Sovereign
9    #             300     201     SubSovereign
11   #             300     301     Financial
12   #             300     #       Sovereign
18   #             1       #       NonFinancial
19   #             800     #       Sovereign
20   #             999     #       NonFinancial
40   Financial     999     #       Financial
45   Goverment     999     #       Subsovereign
46   Goverment     #       402     Subsovereign
47   Financial     #       #       Financial
53   Goverment     #       #       Sovereign
55   #             #       #       NonFinancial
;
run;

 
%* Example 5: Step 3 - Perform priority hash lookup: ;
%m_utl_prio_lookup(
   src_tbl = WORK.counterparty
 , map_tbl = WORK.map_product_type
 , trg_tbl = WORK.counterparty
 , prio    = %str(priority)
 , keys    = %str(cpy_type method_cd version_cd)
 , cols    = %str(prod_type)
 , print   = Y
 , debug   = Y
   );

 
%* Example 6: Step 1 - Create an example source table: ;
data WORK.counterparty;
   input
      cpy_id      : $char5.
      cpy_type    : $char30.
      method_cd   : $char15.
      version_cd  : $char4.
      ;
datalines;
10001     Sovereign     100     301
10002     Sovereign     100     201
10003     Sovereign     300     201
10004     Country       300     999
10005     Retail        1       7
20001     Corporate     921     500
20002     Corporate     999     7
30001     Goverment     800     444
30002     Goverment     801     402
30003     Financial     300     301
;
run;

proc print data=WORK.counterparty;
   title 'Ex.6 WORK.COUNTERPARTY (SRC)';
run; title; footnote;

 
%* Example 6: Step 2 - Create an mapping table (No default): ;
data WORK.map_product_type;
   input
      priority
      cpy_type     : $char30.
      method_cd    : $char15.
      version_cd   : $char4.
      prod_cluster : $char3.
      prod_type    : $char30.
      ;
   datalines;
1    #             100     #       SOV    Sovereign
2    #             300     201     SOV    SubSovereign
3    #             300     301     FIN    Financial
4    #             300     #       SOV    Sovereign
5    #             1       #       RET    NonFinancial
6    #             800     #       SOV    Sovereign
10   Financial     999     #       FIN    Financial
25   Goverment     999     #       SOV    Subsovereign
26   Goverment     #       402     SOV    Subsovereign
27   Goverment     #       #       SOV    Sovereign
35   Financial     #       #       FIN    Financial
;
run;

proc print data=WORK.map_product_type;
   title 'Ex.6 WORK.MAP_PRODUCT_TYPE (MAP)';
run; title; footnote;

 
%* Example 6: Step 3 - Perform priority lookup (No default): ;
%m_utl_prio_lookup(
   src_tbl = WORK.counterparty
 , map_tbl = WORK.map_product_type
 , trg_tbl = WORK.counterparty_def
 , prio    = %str(priority)
 , keys    = %str(cpy_type method_cd version_cd)
 , cols    = _ALL_
 , print   = N
 , debug   = N
   );

proc print data=WORK.counterparty_def;
   title 'Ex.6 Perform lookup with no default';
   footnote 'Keys: cpy_type method_cd version_cd';
   footnote2 'Cols: _ALL_';
run; title; footnote; footnote2;

 
