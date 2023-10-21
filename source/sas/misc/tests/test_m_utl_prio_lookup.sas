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
 * \date       2023-10-21 09:14:17
 * \version    23.1.10
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_prio_lookup.sas
 * 
 * \copyright  Copyright 2008-2023 Paul Alexander Canals y Trocha
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
      support_cd  : $char4.
      ;
datalines;
10001   Sovereign    100       301
10002   Sovereign    100       201
10003   Sovereign    300       201
10004   Country      300       999
10005   Retail       7         1
20001   Corporate    921       500
20002   Corporate    trf_eur   7
30001   Goverment    800       444
30002   Goverment    801       402
30003   Financial    300       301
;
run;

proc print data=WORK.counterparty_data noobs;
   title 'Counterparty Data';
run;

 
%* Example 2: Step 2 - Create an example mapping table: ;
data WORK.map_asset_class;
   input
      priority     : $char2.
      cpy_type     : $char30.
      method_cd    : $char15.
      support_cd   : $char4.
      asset_class  : $char30.
      ;
   datalines;
1    #                 trf_eur   #     Transfer_EUR
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

proc print data=WORK.map_asset_class noobs;
   title 'Map Asset Class Data';
run;

 
%* Example 2: Step 3 - Perform priority hash lookup: ;
%m_utl_prio_lookup(
   src_tbl = WORK.counterparty_data
 , map_tbl = WORK.map_asset_class
 , trg_tbl = WORK.counterparty_mapped
 , keys    = %str(cpy_type method_cd support_cd)
 , cols    = %str(asset_class)
 , prio    = %str(priority)
 , null    = %str(#)
 , print   = Y
 , debug   = N
   );

 
%* Example 3: Perform lookup again different order: ;
%m_utl_prio_lookup(
   src_tbl = WORK.counterparty_data
 , map_tbl = WORK.map_asset_class
 , trg_tbl = WORK.counterparty_mapped
 , keys    = %str(method_cd support_cd cpy_type)
 , cols    = %str(asset_class)
 , prio    = %str(priority)
 , debug   = N
   );

proc print data=WORK.counterparty_mapped;
run;

 
%* Example 4: Perform lookup again different order: ;
%m_utl_prio_lookup(
   src_tbl = WORK.counterparty_data
 , map_tbl = WORK.map_asset_class
 , trg_tbl = WORK.counterparty_mapped
 , keys    = %str(method_cd cpy_type support_cd)
 , cols    = %str(asset_class)
 , prio    = %str(priority)
 , debug   = N
   );

proc print data=WORK.counterparty_mapped;
run;

 
