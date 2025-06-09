$PBExportHeader$w_gtebgf001_old.srw
forward
global type w_gtebgf001_old from window
end type
type em_1 from editmask within w_gtebgf001_old
end type
type cb_2 from commandbutton within w_gtebgf001_old
end type
type st_1 from statictext within w_gtebgf001_old
end type
type cb_4 from commandbutton within w_gtebgf001_old
end type
type budget_detail from tab within w_gtebgf001_old
end type
type tabpage_1 from userobject within budget_detail
end type
type dw_1 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within budget_detail
dw_1 dw_1
end type
type tabpage_2 from userobject within budget_detail
end type
type dw_2 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within budget_detail
dw_2 dw_2
end type
type tabpage_3 from userobject within budget_detail
end type
type dw_3 from datawindow within tabpage_3
end type
type tabpage_3 from userobject within budget_detail
dw_3 dw_3
end type
type tabpage_4 from userobject within budget_detail
end type
type dw_4 from datawindow within tabpage_4
end type
type tabpage_4 from userobject within budget_detail
dw_4 dw_4
end type
type tabpage_5 from userobject within budget_detail
end type
type dw_5 from datawindow within tabpage_5
end type
type tabpage_5 from userobject within budget_detail
dw_5 dw_5
end type
type tabpage_6 from userobject within budget_detail
end type
type dw_6 from datawindow within tabpage_6
end type
type tabpage_6 from userobject within budget_detail
dw_6 dw_6
end type
type budget_detail from tab within w_gtebgf001_old
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type
end forward

global type w_gtebgf001_old from window
integer width = 4571
integer height = 2532
boolean titlebar = true
string title = "(w_gtebgf001) Budgeting"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
em_1 em_1
cb_2 cb_2
st_1 st_1
cb_4 cb_4
budget_detail budget_detail
end type
global w_gtebgf001_old w_gtebgf001_old

type variables
long ll_ctr, ll_cnt, ll_year,ll_unitprice,ll_qnty,ll_price
string ls_temp,ls_eacsubhead_id,ls_eachead_id,ls_spc_id
string ls_srep
double ld_area
datetime ld_date
boolean lb_neworder, lb_query
datawindowchild idw_prod,idw_subexp_salary,idw_subexp_wage,idw_subexp_store,idw_subexp_oth
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_eacsubhead_id, long fl_year)
public function integer wf_check_dupwage (integer fl_year, string fs_eacsubhead_id)
public function integer wf_check_fillcolwages (integer fl_row)
public function integer wf_check_dupstore (integer fl_year, string fs_eacsubhead_id)
public function integer wf_check_fillcolstore (integer fl_row)
public function integer wf_check_dupothers (integer fl_year, string fs_eacsubhead_id)
public function integer wf_check_fillcolothers (integer fl_row)
public function integer wf_check_dupteamade (integer fl_year)
public function integer wf_check_fillcolteamade (integer fl_row)
public function integer wf_check_dupyeararea (integer fl_year)
public function integer wf_check_fillcolyeararea (integer fl_row)
public function integer wf_inquiry (long fl_year)
end prototypes

event ue_option();//choose case gs_ueoption
//	case "PRINT"
//			OpenWithParm(w_print,this.dw_1)
//	case "PRINTPREVIEW"
//			this.dw_1.modify("datawindow.print.preview = yes")
//	case "RESETPREVIEW"
//			this.dw_1.modify("datawindow.print.preview = no")
//	case "SAVEAS"
//			this.dw_1.saveas()
//	case "FILTER"
//			setnull(gs_filtertext)
//			this.dw_1.setredraw(false)
//			this.dw_1.setfilter(gs_filtertext)
//			this.dw_1.filter()
//			this.dw_1.groupcalc()
//			if this.dw_1.rowcount() > 0 then;
//				this.dw_1.setredraw(true)
//			else
//				Messagebox('Warning','Data Not Available In Given Criteria')
//			end if
//	case "SORT"
//			setnull(gs_sorttext)
//			this.dw_1.setredraw(false)
//			this.dw_1.setsort(gs_sorttext)
//			this.dw_1.sort()
//			this.dw_1.groupcalc()
//			if this.dw_1.rowcount() > 0 then;
//				this.dw_1.setredraw(true)
//			else
//				Messagebox('Warning','Data Not Available In Given Criteria')
//			end if
//end choose
end event

public function integer wf_check_fillcol (integer fl_row);if Budget_Detail.tabpage_1.dw_1.rowcount() > 0 and fl_row > 0 then
	if (isnull(Budget_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'msab_year')) or  Budget_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'msab_year')=0 or &
		 isnull(Budget_Detail.tabpage_1.dw_1.getitemstring(fl_row,'eacsubhead_id')) or &
		 isnull(Budget_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'msab_jansalary')) or  Budget_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'msab_jansalary') = 0 or &
		 isnull(Budget_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'msab_febsalary')) or  Budget_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'msab_febsalary') = 0 or &
		 isnull(Budget_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'msab_marsalary')) or  Budget_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'msab_marsalary') = 0 or &
		 isnull(Budget_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'msab_aprsalary')) or  Budget_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'msab_aprsalary') = 0 or &
		 isnull(Budget_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'msab_maysalary')) or  Budget_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'msab_maysalary') = 0 or &
		 isnull(Budget_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'msab_junsalary')) or  Budget_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'msab_junsalary') = 0 or &
		 isnull(Budget_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'msab_julsalary')) or  Budget_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'msab_julsalary') = 0 or &
		 isnull(Budget_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'msab_augsalary')) or  Budget_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'msab_augsalary') = 0 or &
		 isnull(Budget_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'msab_sepsalary')) or  Budget_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'msab_sepsalary') = 0 or &
		 isnull(Budget_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'msab_octsalary')) or  Budget_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'msab_octsalary') = 0 or &
		 isnull(Budget_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'msab_novsalary')) or  Budget_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'msab_novsalary') = 0 or &
		 isnull(Budget_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'msab_decsalary')) or Budget_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'msab_decsalary') = 0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Budget Year, Expanse sub head, or budgeted salary of a month, Please Check !!!')
		 return -1
	end if
end if
return 1


end function

public function integer wf_check_duplicate_rec (string fs_eacsubhead_id, long fl_year);long fl_row,ll_year1
string ls_eacsubhead_id1


Budget_Detail.tabpage_1.dw_1.SelectRow(0, FALSE)
if Budget_Detail.tabpage_1.dw_1.rowcount() > 1 then
	for fl_row = 1 to (Budget_Detail.tabpage_1.dw_1.rowcount())
		ls_eacsubhead_id1 = Budget_Detail.tabpage_1.dw_1.getitemstring(fl_row,'eacsubhead_id')
		ll_year1 = Budget_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'msab_year')
		
		if ls_eacsubhead_id1 = fs_eacsubhead_id and ll_year1 = fl_year then
			Budget_Detail.tabpage_1.dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

public function integer wf_check_dupwage (integer fl_year, string fs_eacsubhead_id);long fl_row,ll_year1
string ls_eacsubhead_id1


Budget_Detail.tabpage_2.dw_2.SelectRow(0, FALSE)
if Budget_Detail.tabpage_2.dw_2.rowcount() > 1 then
	for fl_row = 1 to (Budget_Detail.tabpage_2.dw_2.rowcount())
		ls_eacsubhead_id1 = Budget_Detail.tabpage_2.dw_2.getitemstring(fl_row,'eacsubhead_id')
		ll_year1 = Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_year')
		
		if ls_eacsubhead_id1 = fs_eacsubhead_id and ll_year1 = fl_year then
			Budget_Detail.tabpage_2.dw_2.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

public function integer wf_check_fillcolwages (integer fl_row);if Budget_Detail.tabpage_2.dw_2.rowcount() > 0 and fl_row > 0 then
	if (isnull(Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'msab_year')) or  Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'msab_year')=0 or &
		 isnull(Budget_Detail.tabpage_2.dw_2.getitemstring(fl_row,'eacsubhead_id')) or &
		 isnull(Budget_Detail.tabpage_2.dw_2.getitemstring(fl_row,'mwb_perrestflag')) or &
		 isnull(Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_janrate')) or  Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_janrate') = 0 or &
		 isnull(Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_febrate')) or  Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_febrate') = 0 or &
		 isnull(Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_marrate')) or  Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_marrate') = 0 or &
		 isnull(Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_aprrate')) or  Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_aprrate') = 0 or &
		 isnull(Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_mayrate')) or  Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_mayrate') = 0 or &
		 isnull(Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_junrate')) or  Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_junrate') = 0 or &
		 isnull(Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_julrate')) or  Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_julrate') = 0 or &
		 isnull(Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_augrate')) or  Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_augrate') = 0 or &
		 isnull(Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_seprate')) or  Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_seprate') = 0 or &
		 isnull(Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_octrate')) or  Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_octrate') = 0 or &
		 isnull(Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_novrate')) or  Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_novrate') = 0 or &
		 isnull(Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_decrate')) or Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_decsalary') = 0 or &
	    	 isnull(Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_janmandays')) or  Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_janmandays') = 0 or &
		 isnull(Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_febmandays')) or  Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_febmandays') = 0 or &
		 isnull(Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_marmandays')) or  Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_marmandays') = 0 or &
		 isnull(Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_aprmandays')) or  Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_aprmandays') = 0 or &
		 isnull(Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_maymandays')) or  Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_maymandays') = 0 or &
		 isnull(Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_junmandays')) or  Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_junmandays') = 0 or &
		 isnull(Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_julmandays')) or  Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_julmandays') = 0 or &
		 isnull(Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_augmandays')) or  Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_augmandays') = 0 or &
		 isnull(Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_sepmandays')) or  Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_sepmandays') = 0 or &
		 isnull(Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_octmandays')) or  Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_octmandays') = 0 or &
		 isnull(Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_novmandays')) or  Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_novmandays') = 0 or &
		 isnull(Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_decmandays')) or Budget_Detail.tabpage_2.dw_2.getitemnumber(fl_row,'mwb_decsalary') = 0) then
	   	 messagebox('Warning: One Of The Following Fields Are Blank','Budget Year, Expanse sub head, or budgeted Wages Rate/Mandays of a month, Please Check !!!')
		 return -1
	end if
end if
return 1


end function

public function integer wf_check_dupstore (integer fl_year, string fs_eacsubhead_id);long fl_row,ll_year1
string ls_eacsubhead_id1


Budget_Detail.tabpage_3.dw_3.SelectRow(0, FALSE)
if Budget_Detail.tabpage_3.dw_3.rowcount() > 1 then
	for fl_row = 1 to (Budget_Detail.tabpage_3.dw_3.rowcount())
		ls_eacsubhead_id1 = Budget_Detail.tabpage_3.dw_3.getitemstring(fl_row,'eacsubhead_id')
		ll_year1 = Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_year')
		
		if ls_eacsubhead_id1 = fs_eacsubhead_id and ll_year1 = fl_year then
			Budget_Detail.tabpage_3.dw_3.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

public function integer wf_check_fillcolstore (integer fl_row);if Budget_Detail.tabpage_3.dw_3.rowcount() > 0 and fl_row > 0 then
	if (isnull(Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msab_year')) or  Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msab_year')=0 or &
		 isnull(Budget_Detail.tabpage_3.dw_3.getitemstring(fl_row,'eacsubhead_id')) or &
		 isnull(Budget_Detail.tabpage_3.dw_3.getitemstring(fl_row,'sp_id')) or &
		 isnull(Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_janunitprice')) or  Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_janprice') = 0 or &
		 isnull(Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_febprice')) or  Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_febprice') = 0 or &
		 isnull(Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_marprice')) or  Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_marprice') = 0 or &
		 isnull(Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_aprprice')) or  Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_aprprice') = 0 or &
		 isnull(Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_mayprice')) or  Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_mayprice') = 0 or &
		 isnull(Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_junprice')) or  Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_junprice') = 0 or &
		 isnull(Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_julprice')) or  Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_julprice') = 0 or &
		 isnull(Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_augprice')) or  Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_augprice') = 0 or &
		 isnull(Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_sepprice')) or  Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_sepprice') = 0 or &
		 isnull(Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_octprice')) or  Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_octprice') = 0 or &
		 isnull(Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_novprice')) or  Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_novprice') = 0 or &
		 isnull(Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_decprice')) or Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_decsalary') = 0 or &
	    	 isnull(Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_janquantity')) or  Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_janquantity') = 0 or &
		 isnull(Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_febquantity')) or  Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_febquantity') = 0 or &
		 isnull(Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_marquantity')) or  Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_marquantity') = 0 or &
		 isnull(Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_aprquantity')) or  Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_aprquantity') = 0 or &
		 isnull(Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_mayquantity')) or  Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_mayquantity') = 0 or &
		 isnull(Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_junquantity')) or  Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_junquantity') = 0 or &
		 isnull(Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_julquantity')) or  Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_julquantity') = 0 or &
		 isnull(Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_augquantity')) or  Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_augquantity') = 0 or &
		 isnull(Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_sepquantity')) or  Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_sepquantity') = 0 or &
		 isnull(Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_octquantity')) or  Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_octquantity') = 0 or &
		 isnull(Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_novquantity')) or  Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_novquantity') = 0 or &
		 isnull(Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_decquantity')) or Budget_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'msb_decquantity') = 0) then
	   	 messagebox('Warning: One Of The Following Fields Are Blank','Budget Year, Expanse sub head, or budgeted Store Unit Price /Quantity of a month, Please Check !!!')
		 return -1
	end if
end if
return 1


end function

public function integer wf_check_dupothers (integer fl_year, string fs_eacsubhead_id);long fl_row,ll_year1
string ls_eacsubhead_id1


Budget_Detail.tabpage_4.dw_4.SelectRow(0, FALSE)
if Budget_Detail.tabpage_4.dw_4.rowcount() > 1 then
	for fl_row = 1 to (Budget_Detail.tabpage_4.dw_4.rowcount())
		ls_eacsubhead_id1 = Budget_Detail.tabpage_4.dw_4.getitemstring(fl_row,'eacsubhead_id')
		ll_year1 = Budget_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mob_year')
		
		if ls_eacsubhead_id1 = fs_eacsubhead_id and ll_year1 = fl_year then
			Budget_Detail.tabpage_4.dw_4.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

public function integer wf_check_fillcolothers (integer fl_row);if Budget_Detail.tabpage_4.dw_4.rowcount() > 0 and fl_row > 0 then
	if (isnull(Budget_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mob_year')) or  Budget_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'msab_year')=0 or &
		 isnull(Budget_Detail.tabpage_4.dw_4.getitemstring(fl_row,'eacsubhead_id')) or &
		 isnull(Budget_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mob_janprice')) or  Budget_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mob_janprice') = 0 or &
		 isnull(Budget_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mob_febprice')) or  Budget_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mob_febprice') = 0 or &
		 isnull(Budget_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mob_marprice')) or  Budget_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mob_marprice') = 0 or &
		 isnull(Budget_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mob_aprprice')) or  Budget_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mob_aprprice') = 0 or &
		 isnull(Budget_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mob_mayprice')) or  Budget_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mob_mayprice') = 0 or &
		 isnull(Budget_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mob_junprice')) or  Budget_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mob_junprice') = 0 or &
		 isnull(Budget_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mob_julprice')) or  Budget_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mob_julprice') = 0 or &
		 isnull(Budget_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mob_augprice')) or  Budget_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mob_augprice') = 0 or &
		 isnull(Budget_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mob_sepprice')) or  Budget_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mob_sepprice') = 0 or &
		 isnull(Budget_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mob_octprice')) or  Budget_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mob_octprice') = 0 or &
		 isnull(Budget_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mob_novprice')) or  Budget_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mob_novprice') = 0 or &
		 isnull(Budget_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mob_decprice')) or Budget_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mob_decprice') = 0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Budget Year, Expanse sub head, or budgeted price of a month, Please Check !!!')
		 return -1
	end if
end if
return 1


end function

public function integer wf_check_dupteamade (integer fl_year);long fl_row,ll_year1
//string ls_eacsubhead_id1


Budget_Detail.tabpage_5.dw_5.SelectRow(0, FALSE)
if Budget_Detail.tabpage_5.dw_5.rowcount() > 1 then
	for fl_row = 1 to (Budget_Detail.tabpage_5.dw_5.rowcount())
		//ls_eacsubhead_id1 = Budget_Detail.tabpage_2.dw_2.getitemstring(fl_row,'eacsubhead_id')
		ll_year1 = Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mtmb_year')
		
		if  ll_year1 = fl_year then
			Budget_Detail.tabpage_5.dw_5.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

public function integer wf_check_fillcolteamade (integer fl_row);if Budget_Detail.tabpage_5.dw_5.rowcount() > 0 and fl_row > 0 then
	if (isnull(Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mtmb_year')) or  Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mtmb_year')=0 or &
		 isnull(Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_janteamadeown')) or  Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_janteamadeown') = 0 or &
		 isnull(Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_febteamadeown')) or  Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_febteamadeown') = 0 or &
		 isnull(Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_marteamadeown')) or  Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_marteamadeown') = 0 or &
		 isnull(Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_aprteamadeown')) or  Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_aprteamadeown') = 0 or &
		 isnull(Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_mayteamadeown')) or  Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_mayteamadeown') = 0 or &
		 isnull(Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_junteamadeown')) or  Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_junteamadeown') = 0 or &
		 isnull(Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_julteamadeown')) or  Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_julteamadeown') = 0 or &
		 isnull(Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_augteamadeown')) or  Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_augteamadeown') = 0 or &
		 isnull(Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_septeamadeown')) or  Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_septeamadeown') = 0 or &
		 isnull(Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_octteamadeown')) or  Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_octteamadeown') = 0 or &
		 isnull(Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_novteamadeown')) or  Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_novteamadeown') = 0 or &
		 isnull(Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_decteamadeown')) or Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_decsalary') = 0 or &
	    	 isnull(Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_janteamadepur')) or  Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_janteamadepur') = 0 or &
		 isnull(Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_febteamadepur')) or  Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_febteamadepur') = 0 or &
		 isnull(Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_marteamadepur')) or  Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_marteamadepur') = 0 or &
		 isnull(Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_aprteamadepur')) or  Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_aprteamadepur') = 0 or &
		 isnull(Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_mayteamadepur')) or  Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_mayteamadepur') = 0 or &
		 isnull(Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_junteamadepur')) or  Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_junteamadepur') = 0 or &
		 isnull(Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_julteamadepur')) or  Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_julteamadepur') = 0 or &
		 isnull(Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_augteamadepur')) or  Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_augteamadepur') = 0 or &
		 isnull(Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_septeamadepur')) or  Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_septeamadepur') = 0 or &
		 isnull(Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_octteamadepur')) or  Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_octteamadepur') = 0 or &
		 isnull(Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_novteamadepur')) or  Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_novteamadepur') = 0 or &
		 isnull(Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_decteamadepur')) or Budget_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'mwb_decsalary') = 0) then
	   	 messagebox('Warning: One Of The Following Fields Are Blank','Budget Year or budgeted Tea Made Own/ Purchase of a month, Please Check !!!')
		 return -1
	end if
end if
return 1


end function

public function integer wf_check_dupyeararea (integer fl_year);long fl_row,ll_year1
//string ls_eacsubhead_id1


Budget_Detail.tabpage_6.dw_6.SelectRow(0, FALSE)
if Budget_Detail.tabpage_6.dw_6.rowcount() > 1 then
	for fl_row = 1 to (Budget_Detail.tabpage_6.dw_6.rowcount())
		//ls_eacsubhead_id1 = Budget_Detail.tabpage_2.dw_2.getitemstring(fl_row,'eacsubhead_id')
		ll_year1 = Budget_Detail.tabpage_6.dw_6.getitemnumber(fl_row,'year')
		
		if  ll_year1 = fl_year then
			Budget_Detail.tabpage_6.dw_6.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

public function integer wf_check_fillcolyeararea (integer fl_row);if Budget_Detail.tabpage_6.dw_6.rowcount() > 0 and fl_row > 0 then
	if (isnull(Budget_Detail.tabpage_6.dw_6.getitemnumber(fl_row,'year')) or  Budget_Detail.tabpage_6.dw_6.getitemnumber(fl_row,'year')=0 or &
		 isnull(Budget_Detail.tabpage_6.dw_6.getitemnumber(fl_row,'mt_area')) or  Budget_Detail.tabpage_6.dw_6.getitemnumber(fl_row,'mt_area') = 0 or &
		 isnull(Budget_Detail.tabpage_6.dw_6.getitemnumber(fl_row,'yt_area')) or  Budget_Detail.tabpage_6.dw_6.getitemnumber(fl_row,'yt_area') = 0 or &
		 isnull(Budget_Detail.tabpage_6.dw_6.getitemnumber(fl_row,'zt_area')) or  Budget_Detail.tabpage_6.dw_6.getitemnumber(fl_row,'zt_area') = 0 or &
		 isnull(Budget_Detail.tabpage_6.dw_6.getitemnumber(fl_row,'up_area')) or  Budget_Detail.tabpage_6.dw_6.getitemnumber(fl_row,'up_area') = 0) then
	   	 messagebox('Warning: One Of The Following Fields Are Blank','Budget Year or budgeted MT Area/ YT Area/ ZT Area/UP Area for the Year, Please Check !!!')
		 return -1
	end if
end if
return 1


end function

public function integer wf_inquiry (long fl_year);Budget_Detail.tabpage_1.dw_1.settransobject(sqlca)
Budget_Detail.tabpage_1.dw_1.retrieve(gs_user,fl_year)

Budget_Detail.tabpage_2.dw_2.settransobject(sqlca)
Budget_Detail.tabpage_2.dw_2.retrieve(gs_user,fl_year)

Budget_Detail.tabpage_3.dw_3.settransobject(sqlca)
Budget_Detail.tabpage_3.dw_3.retrieve(gs_user,fl_year)

Budget_Detail.tabpage_4.dw_4.settransobject(sqlca)
Budget_Detail.tabpage_4.dw_4.retrieve(gs_user,fl_year)

Budget_Detail.tabpage_5.dw_5.settransobject(sqlca)
Budget_Detail.tabpage_5.dw_5.retrieve(gs_user,fl_year)

Budget_Detail.tabpage_6.dw_6.settransobject(sqlca)
Budget_Detail.tabpage_6.dw_6.retrieve(gs_user,fl_year)

return 1
end function

on w_gtebgf001_old.create
this.em_1=create em_1
this.cb_2=create cb_2
this.st_1=create st_1
this.cb_4=create cb_4
this.budget_detail=create budget_detail
this.Control[]={this.em_1,&
this.cb_2,&
this.st_1,&
this.cb_4,&
this.budget_detail}
end on

on w_gtebgf001_old.destroy
destroy(this.em_1)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.cb_4)
destroy(this.budget_detail)
end on

event open;lb_query = false	
lb_neworder = false

if f_openwindow(Budget_Detail.tabpage_1.dw_1) = -1 then	
	close(this)
	return 1
end if

Budget_Detail.tabpage_1.dw_1.modify("t_co.text = '"+gs_CO_name+"'")
Budget_Detail.tabpage_2.dw_2.modify("t_co.text = '"+gs_CO_name+"'")
Budget_Detail.tabpage_3.dw_3.modify("t_co.text = '"+gs_CO_name+"'")
Budget_Detail.tabpage_4.dw_4.modify("t_co.text = '"+gs_CO_name+"'")
Budget_Detail.tabpage_5.dw_5.modify("t_co.text = '"+gs_CO_name+"'")
Budget_Detail.tabpage_6.dw_6.modify("t_co.text = '"+gs_CO_name+"'")

setpointer(hourglass!)
Budget_Detail.tabpage_1.dw_1.GetChild ("eacsubhead_id", idw_subexp_salary)
idw_subexp_salary.settransobject(sqlca)	

Budget_Detail.tabpage_2.dw_2.GetChild ("eacsubhead_id", idw_subexp_wage)
idw_subexp_wage.settransobject(sqlca)	

Budget_Detail.tabpage_3.dw_3.GetChild ("eacsubhead_id", idw_subexp_store)
idw_subexp_store.settransobject(sqlca)	


Budget_Detail.tabpage_3.dw_3.GetChild ("sp_id", idw_prod)
idw_prod.settransobject(sqlca)	

Budget_Detail.tabpage_4.dw_4.GetChild ("eacsubhead_id", idw_subexp_oth)
idw_subexp_oth.settransobject(sqlca)	

em_1.text = string(today(),"yyyy")
setpointer(arrow!)

//this.tag = Message.StringParm
//ll_user_level = long(this.tag)

end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if

end event

type em_1 from editmask within w_gtebgf001_old
integer x = 187
integer y = 20
integer width = 283
integer height = 80
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "YYYY"
boolean dropdowncalendar = true
end type

type cb_2 from commandbutton within w_gtebgf001_old
integer x = 526
integer y = 8
integer width = 265
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&OK"
end type

event clicked;if isnull(em_1.text) or len(em_1.text) = 0 then
	messagebox('Warning!','Please Select A Year !!!')
	return 1
end if

if  long(em_1.text) < long(string(today(),'YYYY'))-1 then
     messagebox('Warning!','Please Select A Valid Budget Year !!!')
	 return 1 
elseif  long(em_1.text) > long(string(today(),'YYYY'))+1 then
     messagebox('Warning!','Please Select A Valid Budget Year !!!')
	 return 1 
end if

//if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
//	messagebox('Warning!','Please Select A Expense Head !!!')
//	return 1
//end if
//
//if isnull(ddlb_2.text) or len(ddlb_2.text) = 0 then
//	messagebox('Warning!','Please Select A Expense Sub Head !!!')
//	return 1
//end if

ll_year = long(em_1.text)
//ls_eachead_id = left(right(string(ddlb_1.text),9),8)
//ls_eacsubhead_id = left(right(string(ddlb_2.text),9),8)
//wf_inquiry (ll_year,ls_eachead_id,ls_eacsubhead_id)
wf_inquiry (ll_year)
end event

type st_1 from statictext within w_gtebgf001_old
integer x = 37
integer y = 24
integer width = 169
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year"
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_gtebgf001_old
integer x = 795
integer y = 8
integer width = 265
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
end type

event clicked;IF MessageBox("Exit Alert", 'Do You Want To Exit....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	close(parent)
else
 	return
end if
end event

type budget_detail from tab within w_gtebgf001_old
event create ( )
event destroy ( )
integer x = 14
integer y = 128
integer width = 4503
integer height = 2288
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type

on budget_detail.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6}
end on

on budget_detail.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
end on

type tabpage_1 from userobject within budget_detail
event create ( )
event destroy ( )
integer x = 18
integer y = 108
integer width = 4466
integer height = 2164
long backcolor = 67108864
string text = "Salary"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_1 dw_1
end type

on tabpage_1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_1.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within tabpage_1
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 14
integer y = 28
integer width = 4411
integer height = 1652
integer taborder = 40
string dataobject = "dw_gtebgf001"
boolean vscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'spd_entry_by',gs_user)
		dw_1.setitem(newrow,'spd_entry_dt',datetime(today()))
		dw_1.setcolumn('msab_jansalary')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_1.deleterow(1)
	end if
	if dw_1.rowcount() = 0 then
		Budget_Detail.tabpage_1.dw_1.modify(' b_2.visible = true')
		Budget_Detail.tabpage_1.dw_1.modify(' b_2.enabled = true')
	end if
end if

end event

event ue_keydwn;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_1.deleterow(1)
	end if
	if dw_1.rowcount() = 0 then
		Budget_Detail.tabpage_1.dw_1.modify(' b_2.visible = true')
		Budget_Detail.tabpage_1.dw_1.modify(' b_2.enabled = true')
	end if
end if

end event

event itemchanged;long ix
if dwo.name = 'eachead_id' then
	ls_eachead_id = data
	idw_subexp_salary.SetFilter ("eachead_id = '"+trim(data)+"'")
	idw_subexp_salary.filter( )
end if


if dwo.name = 'msab_year'  then
	ll_year = long(data)
	ls_eacsubhead_id = dw_1.getitemstring(row,'eacsubhead_id')
	
    if  wf_check_duplicate_rec(ls_eacsubhead_id,ll_year) = -1 then return 1
end if

dw_1.setitem(row,'msab_entry_by',gs_user)
dw_1.setitem(row,'msab_entry_dt',datetime(today()))
		
Budget_Detail.tabpage_1.dw_1.modify(' b_2.visible = true')
Budget_Detail.tabpage_1.dw_1.modify(' b_2.enabled = true')



end event

event clicked;if dwo.name = 'b_1' then	
	if isnull(em_1.text) or len(em_1.text) = 0 then
		messagebox('Warning!','Please Select A Budget Year !!!')
		return 1
	end if
    dw_1.reset()

		dw_1.scrolltorow(dw_1.insertrow(1))
		dw_1.setitem(1,'msab_year',ll_year)
		dw_1.setitem(1,'eachead_id',ls_eachead_id)
		dw_1.setitem(1,'eacsubhead_id',ls_eacsubhead_id)
		dw_1.setitem(1,'msab_entry_by',gs_user)
		dw_1.setitem(1,'msab_entry_dt',datetime(today()))
		dw_1.setcolumn('msab_jansalary')

end if

if dwo.name = 'b_2' then
	if dw_1.accepttext() = -1 then
		messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
		return 
	end if 
	
	IF (isnull(dw_1.getitemnumber(dw_1.rowcount(),'msab_year')) or dw_1.getitemnumber(dw_1.rowcount(),'msab_year')=0) THEN
		 dw_1.deleterow(dw_1.rowcount())
	END IF
	
	IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
		for ll_ctr = dw_1.rowcount() to 1 step -1
			if dw_1.getitemstring(ll_ctr,'del_flag') = 'Y' then
				dw_1.deleterow(ll_ctr)
			end if
		next	
		
		if dw_1.rowcount() > 0 then
			for ll_ctr = 1 to dw_1.rowcount( ) 
				IF wf_check_fillcol(ll_ctr) = -1 THEN 
					return 1
				end if
			next	
		end if
		
		if dw_1.update(true,false) = 1 then
			dw_1.resetupdate();
			commit using sqlca;
			dw_1.modify(' b_2.visible = true')
			dw_1.modify(' b_2.enabled = true')
			dw_1.reset()
		else
			messagebox('SQL Error : During Save',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
	else
		return
	end if 
end if
end event

type tabpage_2 from userobject within budget_detail
event create ( )
event destroy ( )
integer x = 18
integer y = 108
integer width = 4466
integer height = 2164
long backcolor = 67108864
string text = "Wages"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_2 dw_2
end type

on tabpage_2.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_2.destroy
destroy(this.dw_2)
end on

type dw_2 from datawindow within tabpage_2
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 5
integer y = 28
integer width = 4407
integer height = 1784
integer taborder = 50
string dataobject = "dw_gtebgf002"
boolean vscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_2.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = dw_2.rowcount() and dw_2.rowcount() > 1  then
		dw_2.setitem(newrow,'mwb_entry_by',gs_user)
		dw_2.setitem(newrow,'mwb_entry_dt',datetime(today()))
		dw_2.setcolumn('mwb_perrestflag')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_2.deleterow(1)
	end if
	if dw_2.rowcount() = 0 then
		Budget_Detail.tabpage_2.dw_2.modify(' b_2.visible = true')
		Budget_Detail.tabpage_2.dw_2.modify(' b_2.enabled = true')
	end if
end if

end event

event ue_keydwn;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_2.deleterow(1)
	end if
	if dw_2.rowcount() = 0 then
		Budget_Detail.tabpage_2.dw_2.modify(' b_2.visible = true')
		Budget_Detail.tabpage_2.dw_2.modify(' b_2.enabled = true')
	end if
end if

end event

event clicked;if dwo.name = 'b_1' then	
	if isnull(em_1.text) or len(em_1.text) = 0 then
		messagebox('Warning!','Please Select A Budget Year !!!')
		return 1
	end if

          dw_2.reset()
		dw_2.scrolltorow(dw_2.insertrow(1))
		dw_2.setitem(1,'mwb_year',ll_year)
		dw_2.setitem(1,'eachead_id',ls_eachead_id)
		dw_2.setitem(1,'eacsubhead_id',ls_eacsubhead_id)
		dw_2.setitem(1,'mwb_entry_by',gs_user)
		dw_2.setitem(1,'mwb_entry_dt',datetime(today()))
		dw_2.setcolumn('mwb_perrestflag')

end if

if dwo.name = 'b_2' then
	if dw_2.accepttext() = -1 then
		messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
		return 
	end if 
	
	IF (isnull(dw_2.getitemnumber(dw_2.rowcount(),'mwb_year')) or dw_2.getitemnumber(dw_2.rowcount(),'mwb_year')=0) THEN
		 dw_2.deleterow(dw_2.rowcount())
	END IF

	IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
		for ll_ctr = dw_2.rowcount() to 1 step -1
			if dw_2.getitemstring(ll_ctr,'del_flag') = 'Y' then
				dw_2.deleterow(ll_ctr)
			end if
		next	
		
		if dw_2.rowcount() > 0 then
			for ll_ctr = 1 to dw_2.rowcount( ) 
				IF wf_check_fillcol(ll_ctr) = -1 THEN 
					return 1
				end if
			next	
		end if
		
		if dw_2.update(true,false) = 1 then
			dw_2.resetupdate();
			commit using sqlca;
			dw_2.modify(' b_2.visible = true')
			dw_2.modify(' b_2.enabled = true')
			dw_2.reset()
		else
			messagebox('SQL Error : During Save',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
	else
		return
	end if 
end if
end event

event itemchanged;if dwo.name = 'eachead_id' then
	ls_eachead_id = data
	idw_subexp_wage.SetFilter ("eachead_id = '"+trim(data)+"'") 
	idw_subexp_wage.filter( )
end if

if dwo.name = 'mwb_year'  then
	ll_year = long(data)
	ls_eacsubhead_id = dw_2.getitemstring(row,'eacsubhead_id')
	
    if  wf_check_dupwage(ll_year,ls_eacsubhead_id) = -1 then return 1
end if

 
dw_2.setitem(1,'mwb_entry_by',gs_user)
dw_2.setitem(1,'mwb_entry_dt',datetime(today()))

Budget_Detail.tabpage_2.dw_2.modify(' b_2.visible = true')
Budget_Detail.tabpage_2.dw_2.modify(' b_2.enabled = true')



end event

type tabpage_3 from userobject within budget_detail
event create ( )
event destroy ( )
integer x = 18
integer y = 108
integer width = 4466
integer height = 2164
long backcolor = 67108864
string text = "Store"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_3 dw_3
end type

on tabpage_3.create
this.dw_3=create dw_3
this.Control[]={this.dw_3}
end on

on tabpage_3.destroy
destroy(this.dw_3)
end on

type dw_3 from datawindow within tabpage_3
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 5
integer y = 28
integer width = 4421
integer height = 1828
integer taborder = 50
string dataobject = "dw_gtebgf003"
boolean vscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_3.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = dw_3.rowcount() and dw_3.rowcount() > 1  then
		dw_3.setitem(newrow,'msb_entry_by',gs_user)
		dw_3.setitem(newrow,'msb_entry_dt',datetime(today()))
		dw_3.setcolumn('spc_id')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_3.deleterow(1)
	end if
	if dw_3.rowcount() = 0 then
		Budget_Detail.tabpage_3.dw_3.modify(' b_2.visible = true')
		Budget_Detail.tabpage_3.dw_3.modify(' b_2.enabled = true')
	end if
end if

end event

event ue_keydwn;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_3.deleterow(1)
	end if
	if dw_3.rowcount() = 0 then
		Budget_Detail.tabpage_3.dw_3.modify(' b_2.visible = true')
		Budget_Detail.tabpage_3.dw_3.modify(' b_2.enabled = true')
	end if
end if

end event

event clicked;if dwo.name = 'b_1' then	
	if isnull(em_1.text) or len(em_1.text) = 0 then
		messagebox('Warning!','Please Select A Budget Year !!!')
		return 1
	end if
          dw_3.reset()
		dw_3.scrolltorow(dw_3.insertrow(1))
		dw_3.setitem(1,'msb_year',ll_year)
		dw_3.setitem(1,'eachead_id',ls_eachead_id)
		dw_3.setitem(1,'eacsubhead_id',ls_eacsubhead_id)
		dw_3.setitem(1,'msb_entry_by',gs_user)
		dw_3.setitem(1,'msb_entry_dt',datetime(today()))
		dw_3.setcolumn('spc_id')

end if

if dwo.name = 'b_2' then
	if dw_3.accepttext() = -1 then
		messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
		return 
	end if 
	
	IF (isnull(dw_3.getitemnumber(dw_3.rowcount(),'msb_year')) or dw_3.getitemnumber(dw_3.rowcount(),'msb_year')=0) THEN
		 dw_3.deleterow(dw_3.rowcount())
	END IF
	
	IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
		for ll_ctr = dw_3.rowcount() to 1 step -1
			if dw_3.getitemstring(ll_ctr,'del_flag') = 'Y' then
				dw_3.deleterow(ll_ctr)
			end if
		next	
		
		if dw_3.rowcount() > 0 then
			for ll_ctr = 1 to dw_3.rowcount( ) 
				IF wf_check_fillcol(ll_ctr) = -1 THEN 
					return 1
				end if
			next	
		end if
		
		if dw_3.update(true,false) = 1 then
			dw_3.resetupdate();
			commit using sqlca;
			dw_3.modify(' b_2.visible = true')
			dw_3.modify(' b_2.enabled = true')
			dw_3.reset()
		else
			messagebox('SQL Error : During Save',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
	else
		return
	end if 
end if
end event

event itemchanged;if dwo.name = 'eachead_id' then
	ls_eachead_id = data
	idw_subexp_store.SetFilter ("eachead_id = '"+trim(data)+"'") 
	idw_subexp_store.filter( )
end if

if dwo.name = 'msb_year'  then
	ll_year = long(data)
	ls_eacsubhead_id = dw_3.getitemstring(row,'eacsubhead_id')
	
    if  wf_check_dupstore(ll_year,ls_eacsubhead_id) = -1 then return 1
end if

if dwo.name = 'spc_id' then
	ls_spc_id = data
	idw_prod.SetFilter ("spc_id = '"+trim(data)+"'") 
	idw_prod.filter( )
end if
 
 if dwo.name = 'msb_janunitprice' then
	ll_unitprice=0 
	ll_qnty=0
	ll_price=0
	ll_unitprice = long(data)
	 ll_qnty=dw_3.getitemnumber(row,'msb_janquantity') 
	 ll_price=ll_unitprice * ll_qnty
	dw_3.setitem(1,'msb_janprice',ll_price)
 end if;	
	
 if dwo.name ='msb_janquantity'  then
	ll_unitprice=0 
	ll_qnty=0 
	ll_price=0
	ll_qnty = long(data)
	 ll_unitprice=dw_3.getitemnumber(row,'msb_janunitprice') 
	 ll_price=ll_unitprice * ll_qnty
	dw_3.setitem(1,'msb_janprice',ll_price)
 end if;	
 
  if dwo.name = 'msb_febunitprice' then
	ll_unitprice=0
	ll_qnty=0
	ll_price=0
	ll_unitprice = long(data)
	 ll_qnty=dw_3.getitemnumber(row,'msb_febquantity') 
	 ll_price=ll_unitprice * ll_qnty
	dw_3.setitem(1,'msb_febprice',ll_price)
 end if;	
	
 if dwo.name ='msb_febquantity'  then
	ll_unitprice=0
	ll_qnty=0
	ll_price=0
	ll_qnty = long(data)
	 ll_unitprice=dw_3.getitemnumber(row,'msb_febunitprice') 
	 ll_price=ll_unitprice * ll_qnty
	dw_3.setitem(1,'msb_febprice',ll_price)
 end if;	
 
 if dwo.name = 'msb_marunitprice' then
	ll_unitprice=0
	ll_qnty=0
	ll_price=0
	ll_unitprice = long(data)
	 ll_qnty=dw_3.getitemnumber(row,'msb_marquantity') 
	 ll_price=ll_unitprice * ll_qnty
	dw_3.setitem(1,'msb_marprice',ll_price)
 end if;	
	
 if dwo.name ='msb_marquantity'  then
	ll_unitprice=0
	ll_qnty=0
	ll_price=0
	ll_qnty = long(data)
	 ll_unitprice=dw_3.getitemnumber(row,'msb_marunitprice') 
	 ll_price=ll_unitprice * ll_qnty
	dw_3.setitem(1,'msb_marprice',ll_price)
 end if;	
 
 if dwo.name = 'msb_aprunitprice' then
	ll_unitprice=0
	ll_qnty=0
	ll_price=0
	ll_unitprice = long(data)
	 ll_qnty=dw_3.getitemnumber(row,'msb_aprquantity') 
	 ll_price=ll_unitprice * ll_qnty
	dw_3.setitem(1,'msb_aprprice',ll_price)
 end if;	
	
 if dwo.name ='msb_mayquantity'  then
	ll_unitprice=0
	ll_qnty=0
	ll_price=0	
	ll_qnty = long(data)
	 ll_unitprice=dw_3.getitemnumber(row,'msb_mayunitprice') 
	 ll_price=ll_unitprice * ll_qnty
	dw_3.setitem(1,'msb_mayprice',ll_price)
 end if;	

 if dwo.name = 'msb_mayunitprice' then
	ll_unitprice=0
	ll_qnty=0
	ll_price=0	
	ll_unitprice = long(data)
	 ll_qnty=dw_3.getitemnumber(row,'msb_mayquantity') 
	 ll_price=ll_unitprice * ll_qnty
	dw_3.setitem(1,'msb_mayprice',ll_price)
 end if;	
	
 if dwo.name ='msb_mayquantity'  then
	ll_unitprice=0
	ll_qnty=0
	ll_price=0	
	ll_qnty = long(data)
	 ll_unitprice=dw_3.getitemnumber(row,'msb_mayunitprice') 
	 ll_price=ll_unitprice * ll_qnty
	dw_3.setitem(1,'msb_mayprice',ll_price)
 end if;	
 
  if dwo.name = 'msb_jununitprice' then
	ll_unitprice=0
	ll_qnty=0
	ll_price=0	
	ll_unitprice = long(data)
	 ll_qnty=dw_3.getitemnumber(row,'msb_junquantity') 
	 ll_price=ll_unitprice * ll_qnty
	dw_3.setitem(1,'msb_junprice',ll_price)
 end if;	
	
 if dwo.name ='msb_junquantity'  then
	ll_unitprice=0
	ll_qnty=0
	ll_price=0	
	ll_qnty = long(data)
	 ll_unitprice=dw_3.getitemnumber(row,'msb_jununitprice') 
	 ll_price=ll_unitprice * ll_qnty
	dw_3.setitem(1,'msb_junprice',ll_price)
 end if;	
 
 if dwo.name = 'msb_julunitprice' then
	ll_unitprice=0
	ll_qnty=0
	ll_price=0	
	ll_unitprice = long(data)
	 ll_qnty=dw_3.getitemnumber(row,'msb_julquantity') 
	 ll_price=ll_unitprice * ll_qnty
	dw_3.setitem(1,'msb_julprice',ll_price)
 end if;	
	
 if dwo.name ='msb_julquantity'  then
	ll_unitprice=0
	ll_qnty=0
	ll_price=0	
	ll_qnty = long(data)
	 ll_unitprice=dw_3.getitemnumber(row,'msb_julunitprice') 
	 ll_price=ll_unitprice * ll_qnty
	dw_3.setitem(1,'msb_julprice',ll_price)
 end if;	
  
  if dwo.name = 'msb_augunitprice' then
	ll_unitprice=0
	ll_qnty=0
	ll_price=0	
	ll_unitprice = long(data)
	 ll_qnty=dw_3.getitemnumber(row,'msb_augquantity') 
	 ll_price=ll_unitprice * ll_qnty
	dw_3.setitem(1,'msb_augprice',ll_price)
 end if;	
	
 if dwo.name ='msb_augquantity'  then
	ll_unitprice=0
	ll_qnty=0
	ll_price=0	
	ll_qnty = long(data)
	 ll_unitprice=dw_3.getitemnumber(row,'msb_augunitprice') 
	 ll_price=ll_unitprice * ll_qnty
	dw_3.setitem(1,'msb_augprice',ll_price)
 end if;
 
  if dwo.name = 'msb_sepunitprice' then
	ll_unitprice=0
	ll_qnty=0
	ll_price=0	
	ll_unitprice = long(data)
	 ll_qnty=dw_3.getitemnumber(row,'msb_sepquantity') 
	 ll_price=ll_unitprice * ll_qnty
	dw_3.setitem(1,'msb_sepprice',ll_price)
 end if;	
	
 if dwo.name ='msb_sepquantity'  then
	ll_unitprice=0
	ll_qnty=0
	ll_price=0	
	ll_qnty = long(data)
	 ll_unitprice=dw_3.getitemnumber(row,'msb_sepunitprice') 
	 ll_price=ll_unitprice * ll_qnty
	dw_3.setitem(1,'msb_sepprice',ll_price)
 end if;
 
  if dwo.name = 'msb_octunitprice' then
	ll_unitprice=0
	ll_qnty=0
	ll_price=0	
	ll_unitprice = long(data)
	 ll_qnty=dw_3.getitemnumber(row,'msb_octquantity') 
	 ll_price=ll_unitprice * ll_qnty
	dw_3.setitem(1,'msb_octprice',ll_price)
 end if;	
 
 if dwo.name ='msb_octquantity'  then
	ll_unitprice=0
	ll_qnty=0
	ll_price=0	
	ll_qnty = long(data)
	 ll_unitprice=dw_3.getitemnumber(row,'msb_octunitprice') 
	 ll_price=ll_unitprice * ll_qnty
	dw_3.setitem(1,'msb_octprice',ll_price)
 end if;	
 
  if dwo.name = 'msb_novunitprice' then
	ll_unitprice=0
	ll_qnty=0
	ll_price=0	
	ll_unitprice = long(data)
	 ll_qnty=dw_3.getitemnumber(row,'msb_novquantity') 
	 ll_price=ll_unitprice * ll_qnty
	dw_3.setitem(1,'msb_novprice',ll_price)
 end if;	

 if dwo.name ='msb_novquantity'  then
	ll_unitprice=0
	ll_qnty=0
	ll_price=0	
	ll_qnty = long(data)
	 ll_unitprice=dw_3.getitemnumber(row,'msb_novunitprice') 
	 ll_price=ll_unitprice * ll_qnty
	dw_3.setitem(1,'msb_novprice',ll_price)
 end if;
 
  if dwo.name = 'msb_decunitprice' then
	ll_unitprice=0
	ll_qnty=0
	ll_price=0	
	ll_unitprice = long(data)
	 ll_qnty=dw_3.getitemnumber(row,'msb_decquantity') 
	 ll_price=ll_unitprice * ll_qnty
	dw_3.setitem(1,'msb_decprice',ll_price)
 end if;	

 if dwo.name ='msb_decquantity'  then
	ll_unitprice=0
	ll_qnty=0
	ll_price=0	
	ll_qnty = long(data)
	 ll_unitprice=dw_3.getitemnumber(row,'msb_decunitprice') 
	 ll_price=ll_unitprice * ll_qnty
	dw_3.setitem(1,'msb_decprice',ll_price)
 end if;

dw_3.setitem(1,'msb_entry_by',gs_user)
dw_3.setitem(1,'msb_entry_dt',datetime(today()))

Budget_Detail.tabpage_3.dw_3.modify(' b_2.visible = true')
Budget_Detail.tabpage_3.dw_3.modify(' b_2.enabled = true')

end event

type tabpage_4 from userobject within budget_detail
event create ( )
event destroy ( )
integer x = 18
integer y = 108
integer width = 4466
integer height = 2164
long backcolor = 67108864
string text = "Cash "
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_4 dw_4
end type

on tabpage_4.create
this.dw_4=create dw_4
this.Control[]={this.dw_4}
end on

on tabpage_4.destroy
destroy(this.dw_4)
end on

type dw_4 from datawindow within tabpage_4
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 14
integer y = 28
integer width = 4421
integer height = 1308
integer taborder = 50
string dataobject = "dw_gtebgf004"
boolean vscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_4.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = dw_4.rowcount() and dw_4.rowcount() > 1  then
		dw_4.setitem(newrow,'mob_entry_by',gs_user)
		dw_4.setitem(newrow,'mob_entry_dt',datetime(today()))
		dw_4.setcolumn('mob_janprice')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_4.deleterow(1)
	end if
	if dw_4.rowcount() = 0 then
		Budget_Detail.tabpage_4.dw_4.modify(' b_2.visible = true')
		Budget_Detail.tabpage_4.dw_4.modify(' b_2.enabled = true')
	end if
end if

end event

event ue_keydwn;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_4.deleterow(1)
	end if
	if dw_4.rowcount() = 0 then
		Budget_Detail.tabpage_4.dw_4.modify(' b_2.visible = true')
		Budget_Detail.tabpage_4.dw_4.modify(' b_2.enabled = true')
	end if
end if

end event

event clicked;if dwo.name = 'b_1' then	
	if isnull(em_1.text) or len(em_1.text) = 0 then
		messagebox('Warning!','Please Select A Budget Year !!!')
		return 1
	end if

          dw_4.reset()
		dw_4.scrolltorow(dw_4.insertrow(1))
		dw_4.setitem(1,'mob_year',ll_year)
		dw_4.setitem(1,'eachead_id',ls_eachead_id)
		dw_4.setitem(1,'eacsubhead_id',ls_eacsubhead_id)
		dw_4.setitem(1,'mob_entry_by',gs_user)
		dw_4.setitem(1,'mob_entry_dt',datetime(today()))
		dw_4.setcolumn('mob_janprice')

end if

if dwo.name = 'b_2' then
	if dw_4.accepttext() = -1 then
		messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
		return 
	end if 
	
	IF (isnull(dw_4.getitemnumber(dw_4.rowcount(),'mob_year')) or dw_4.getitemnumber(dw_4.rowcount(),'mob_year')=0) THEN
		 dw_4.deleterow(dw_4.rowcount())
	END IF
	
	IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
		for ll_ctr = dw_4.rowcount() to 1 step -1
			if dw_4.getitemstring(ll_ctr,'del_flag') = 'Y' then
				dw_4.deleterow(ll_ctr)
			end if
		next	
		
		if dw_4.rowcount() > 0 then
			for ll_ctr = 1 to dw_4.rowcount( ) 
				IF wf_check_fillcol(ll_ctr) = -1 THEN 
					return 1
				end if
			next	
		end if
		
		if dw_4.update(true,false) = 1 then
			dw_4.resetupdate();
			commit using sqlca;
			dw_4.modify(' b_2.visible = true')
			dw_4.modify(' b_2.enabled = true')
			dw_4.reset()
		else
			messagebox('SQL Error : During Save',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
	else
		return
	end if 
end if
end event

event itemchanged;if dwo.name = 'eachead_id' then
	ls_eachead_id = data
	idw_subexp_oth.SetFilter ("eachead_id = '"+trim(data)+"'") 
	idw_subexp_oth.filter( )
end if

if dwo.name = 'msab_year'  then
	ll_year = long(data)
	ls_eacsubhead_id = dw_4.getitemstring(row,'eacsubhead_id')
	
    //if  wf_check_dupothers(ls_eacsubhead_id,ll_year) = -1 then return 1
end if

dw_4.setitem(1,'mob_entry_by',gs_user)
dw_4.setitem(1,'mob_entry_dt',datetime(today()))
		
Budget_Detail.tabpage_4.dw_4.modify(' b_2.visible = true')
Budget_Detail.tabpage_4.dw_4.modify(' b_2.enabled = true')



end event

type tabpage_5 from userobject within budget_detail
event create ( )
event destroy ( )
integer x = 18
integer y = 108
integer width = 4466
integer height = 2164
long backcolor = 67108864
string text = "Tea Made"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_5 dw_5
end type

on tabpage_5.create
this.dw_5=create dw_5
this.Control[]={this.dw_5}
end on

on tabpage_5.destroy
destroy(this.dw_5)
end on

type dw_5 from datawindow within tabpage_5
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 5
integer y = 28
integer width = 4430
integer height = 1612
integer taborder = 50
string dataobject = "dw_gtebgf005"
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_5.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = dw_5.rowcount() and dw_5.rowcount() > 1  then
		dw_5.setitem(newrow,'mtmb_entry_by',gs_user)
		dw_5.setitem(newrow,'mtmb_entry_dt',datetime(today()))
		dw_5.setcolumn('mtmb_janteamadeown')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_5.deleterow(1)
	end if
	if dw_5.rowcount() = 0 then
		Budget_Detail.tabpage_5.dw_5.modify(' b_2.visible = true')
		Budget_Detail.tabpage_5.dw_5.modify(' b_2.enabled = true')
	end if
end if

end event

event ue_keydwn;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_5.deleterow(1)
	end if
	if dw_5.rowcount() = 0 then
		Budget_Detail.tabpage_5.dw_5.modify(' b_2.visible = true')
		Budget_Detail.tabpage_5.dw_5.modify(' b_2.enabled = true')
	end if
end if

end event

event clicked;long ll_year_clk,ll_mth_clk
string ls_ind

if row > 0 then
   ll_year_clk = dw_5.getitemnumber(row,'mtmb_year')
	
	choose case dwo.name
		case 'mtmb_aprtmown_of' 
				ll_mth_clk  = 4 ; ls_ind='Y'
		case  'mtmb_aprtmof_own'
				ll_mth_clk  = 4; ls_ind='N'	
		case 'mtmb_aprtmown_of'
				ll_mth_clk  = 5; ls_ind='Y'
		case  'mtmb_aprtmof_own'
				ll_mth_clk  = 5; ls_ind='N'	
		case 'mtmb_aprtmown_of'
				ll_mth_clk  = 6; ls_ind='Y'
		case  'mtmb_aprtmof_own'
				ll_mth_clk  = 6; ls_ind='N'	
		case 'mtmb_aprtmown_of'
				ll_mth_clk  = 7; ls_ind='Y'
		case  'mtmb_aprtmof_own'
				ll_mth_clk  = 7; ls_ind='N'	
		case 'mtmb_aprtmown_of'
				ll_mth_clk  = 8; ls_ind='Y'
		case  'mtmb_aprtmof_own'
				ll_mth_clk  = 8; ls_ind='N'	
		case 'mtmb_aprtmown_of'
				ll_mth_clk  = 9; ls_ind='Y'
		case  'mtmb_aprtmof_own'
				ll_mth_clk  = 9; ls_ind='N'	
		case 'mtmb_aprtmown_of'
				ll_mth_clk  = 10; ls_ind='Y'
		case  'mtmb_aprtmof_own'
				ll_mth_clk  = 10; ls_ind='N'	
		case 'mtmb_aprtmown_of'
				ll_mth_clk  = 11; ls_ind='Y'
		case  'mtmb_aprtmof_own'
				ll_mth_clk  = 11; ls_ind='N'	
		case 'mtmb_aprtmown_of'
				ll_mth_clk  = 12; ls_ind='Y'
		case  'mtmb_aprtmof_own'
				ll_mth_clk  = 12; ls_ind='N'	
		case 'mtmb_aprtmown_of'
				ll_mth_clk  = 1; ls_ind='Y'
		case  'mtmb_aprtmof_own'
				ll_mth_clk  = 1; ls_ind='N'	
		case 'mtmb_aprtmown_of'
				ll_mth_clk  = 2; ls_ind='Y'
		case  'mtmb_aprtmof_own'
				ll_mth_clk  = 2; ls_ind='N'	
		case 'mtmb_aprtmown_of'
				ll_mth_clk  = 3; ls_ind='Y'
		case  'mtmb_aprtmof_own'
				ll_mth_clk  = 3; ls_ind='N'	
		case else 
				ll_mth_clk =0
		end choose
		
	if ll_mth_clk > 0 then
		openwithparm(w_gtebgf001a,string(((ll_year_clk * 100) + ll_mth_clk))+ls_ind)
	end if
end if
	
if dwo.name = 'b_1' then	
	if isnull(em_1.text) or len(em_1.text) = 0 then
		messagebox('Warning!','Please Select A Budget Year !!!')
		return 1
	end if

         dw_5.reset()
		dw_5.scrolltorow(dw_5.insertrow(1))
		dw_5.setitem(1,'mtmb_year',ll_year)
//		dw_5.setitem(1,'eachead_id',ls_eachead_id)
//		dw_5.setitem(1,'eacsubhead_id',ls_eacsubhead_id)
		dw_5.setitem(1,'mtmb_entry_by',gs_user)
		dw_5.setitem(1,'mtmb_entry_dt',datetime(today()))
		dw_5.setcolumn('mtmb_janteamadeown')

end if

if dwo.name = 'b_2' then
	if dw_5.accepttext() = -1 then
		messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
		return 
	end if 
	
	IF (isnull(dw_5.getitemnumber(dw_5.rowcount(),'mtmb_year')) or dw_5.getitemnumber(dw_5.rowcount(),'mtmb_year')=0) THEN
		 dw_5.deleterow(dw_5.rowcount())
	END IF
	
	IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
		for ll_ctr = dw_5.rowcount() to 1 step -1
			if dw_5.getitemstring(ll_ctr,'del_flag') = 'Y' then
				dw_5.deleterow(ll_ctr)
			end if
		next	
		
		if dw_5.rowcount() > 0 then
			for ll_ctr = 1 to dw_5.rowcount( ) 
				IF wf_check_fillcol(ll_ctr) = -1 THEN 
					return 1
				end if
			next	
		end if
		
		if dw_5.update(true,false) = 1 then
			dw_5.resetupdate();
			commit using sqlca;
			dw_5.modify(' b_2.visible = true')
			dw_5.modify(' b_2.enabled = true')
			dw_5.reset()
		else
			messagebox('SQL Error : During Save',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
	else
		return
	end if 
end if
end event

event itemchanged;
if dwo.name = 'mtmb_year'  then
	ll_year = long(data)
	//ls_eacsubhead_id = dw_5.getitemstring(row,'eacsubhead_id')
	
    if  wf_check_dupteamade(ll_year) = -1 then return 1
end if
                       
 
dw_5.setitem(1,'mtmb_entry_by',gs_user)
dw_5.setitem(1,'mtmb_entry_dt',datetime(today()))

Budget_Detail.tabpage_5.dw_5.modify(' b_2.visible = true')
Budget_Detail.tabpage_5.dw_5.modify(' b_2.enabled = true')



end event

type tabpage_6 from userobject within budget_detail
event create ( )
event destroy ( )
integer x = 18
integer y = 108
integer width = 4466
integer height = 2164
long backcolor = 67108864
string text = "Yearly Area"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_6 dw_6
end type

on tabpage_6.create
this.dw_6=create dw_6
this.Control[]={this.dw_6}
end on

on tabpage_6.destroy
destroy(this.dw_6)
end on

type dw_6 from datawindow within tabpage_6
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 14
integer y = 28
integer width = 4315
integer height = 1656
integer taborder = 50
string dataobject = "dw_gtebgf006"
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_6.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = dw_6.rowcount() and dw_6.rowcount() > 1  then
		dw_6.setitem(newrow,'yt_entry_by',gs_user)
		dw_6.setitem(newrow,'yt_entry_dt',datetime(today()))
		dw_6.setcolumn('mt_area')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_6.deleterow(1)
	end if
	if dw_6.rowcount() = 0 then
		Budget_Detail.tabpage_6.dw_6.modify(' b_2.visible = true')
		Budget_Detail.tabpage_6.dw_6.modify(' b_2.enabled = true')
	end if
end if

end event

event ue_keydwn;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_6.deleterow(1)
	end if
	if dw_6.rowcount() = 0 then
		Budget_Detail.tabpage_6.dw_6.modify(' b_2.visible = true')
		Budget_Detail.tabpage_6.dw_6.modify(' b_2.enabled = true')
	end if
end if

end event

event clicked;if dwo.name = 'b_1' then	
	if isnull(em_1.text) or len(em_1.text) = 0 then
		messagebox('Warning!','Please Select A Budget Year !!!')
		return 1
	end if
	
	 ll_year=long(em_1.text)
	
	select distinct 'x' into :ls_temp  from FB_YEARLYAREA where YEAR=:ll_year;
	
	if sqlca.sqlcode = -1 then
		messagebox('Error During Select Of Yearly Area Budget',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif 	sqlca.sqlcode = 0 then	
		messagebox('Error :',' Yearly Area Budget Record Already Present for this Year ')
		rollback using sqlca;
		return 1
	end if	
	
          dw_6.reset()
		dw_6.scrolltorow(dw_6.insertrow(1))
		dw_6.setitem(1,'year',ll_year)
//		dw_6.setitem(1,'eachead_id',ls_eachead_id)
//		dw_6.setitem(1,'eacsubhead_id',ls_eacsubhead_id)
		dw_6.setitem(1,'yt_entry_by',gs_user)
		dw_6.setitem(1,'yt_entry_dt',datetime(today()))
		dw_6.setcolumn('mt_area')

end if

if dwo.name = 'b_2' then
	if dw_6.accepttext() = -1 then
		messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
		return 
	end if 
	
	IF (isnull(dw_6.getitemnumber(dw_6.rowcount(),'year')) or dw_6.getitemnumber(dw_6.rowcount(),'year')=0) THEN
		 dw_6.deleterow(dw_6.rowcount())
	END IF
	
	
	IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
		for ll_ctr = dw_6.rowcount() to 1 step -1
			if dw_6.getitemstring(ll_ctr,'del_flag') = 'Y' then
				dw_6.deleterow(ll_ctr)
			end if
		next	
		
		if dw_6.rowcount() > 0 then
			for ll_ctr = 1 to dw_6.rowcount( ) 
				IF wf_check_fillcol(ll_ctr) = -1 THEN 
					return 1
				end if
			next	
		end if
		
		if dw_6.update(true,false) = 1 then
			dw_6.resetupdate();
			commit using sqlca;
			dw_6.modify(' b_2.visible = true')
			dw_6.modify(' b_2.enabled = true')
			dw_6.reset()
		else
			messagebox('SQL Error : During Save',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
	else
		return
	end if 
end if
end event

event itemchanged;//if dwo.name = 'eachead_id' then
//	ls_eachead_id = data
//	idw_expsub.SetFilter ("eachead_id = '"+trim(data)+"'") 
//	idw_expsub.filter( )
//end if

if dwo.name = 'year'  then
	ll_year = long(data)
	//ls_eacsubhead_id = dw_6.getitemstring(row,'eacsubhead_id')
	
    if  wf_check_dupyeararea(ll_year) = -1 then return 1
end if

dw_6.setitem(1,'yt_entry_by',gs_user)
dw_6.setitem(1,'yt_entry_dt',datetime(today()))

Budget_Detail.tabpage_6.dw_6.modify(' b_2.visible = true')
Budget_Detail.tabpage_6.dw_6.modify(' b_2.enabled = true')



end event

