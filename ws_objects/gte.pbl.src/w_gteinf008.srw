$PBExportHeader$w_gteinf008.srw
forward
global type w_gteinf008 from window
end type
type st_1 from statictext within w_gteinf008
end type
type cb_5 from commandbutton within w_gteinf008
end type
type cb_7 from commandbutton within w_gteinf008
end type
type cb_8 from commandbutton within w_gteinf008
end type
type cb_9 from commandbutton within w_gteinf008
end type
type dw_2 from datawindow within w_gteinf008
end type
type cb_4 from commandbutton within w_gteinf008
end type
type cb_3 from commandbutton within w_gteinf008
end type
type cb_2 from commandbutton within w_gteinf008
end type
type cb_1 from commandbutton within w_gteinf008
end type
type dw_1 from datawindow within w_gteinf008
end type
end forward

global type w_gteinf008 from window
integer width = 4791
integer height = 2184
boolean titlebar = true
string title = "(w_gteinf008) Requisition To Store"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_1 st_1
cb_5 cb_5
cb_7 cb_7
cb_8 cb_8
cb_9 cb_9
dw_2 dw_2
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gteinf008 w_gteinf008

type variables
long ll_last,ll_ctr,ll_user_level
string ls_temp,ls_tmp_id,ls_sp_id,ls_cons,ls_eachead_id,ls_esubachead_id,ls_appr_ind,ls_ac_dt,ls_div,ls_secid,ls_eccid
boolean lb_neworder, lb_query
double ld_old_val,ld_stock,ld_qnty,ld_req_qty,ld_tot_val,ld_efunit_price
datetime ld_dt, ld_date
datawindowchild idw_prod,idw_eacsubhead,idw_costcentre
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_cal_datediff (datetime fd_frdt, datetime fd_todt)
public function integer wf_upd_stock_mm (string fs_sp_id, datetime fd_issue_date, double fd_issue_quantity, double fd_old_qnty)
public function integer wf_check_duplicate_rec (string fs_sp_id, string fs_eachead_id, string fs_esubachead_id, string fs_sec, string fs_cc)
end prototypes

event ue_option();choose case gs_ueoption
	case "PRINT"
			OpenWithParm(w_print,this.dw_1)
	case "PRINTPREVIEW"
			this.dw_1.modify("datawindow.print.preview = yes")
	case "RESETPREVIEW"
			this.dw_1.modify("datawindow.print.preview = no")
	case "ZOOM"
			SetPointer (HourGlass!)											
			OpenwithParm (w_zoom,dw_1)
			SetPointer (Arrow!)						
	case "SAVEAS"
			this.dw_1.saveas()
	case "FILTER"
			setnull(gs_filtertext)
			this.dw_1.setredraw(false)
			this.dw_1.setfilter(gs_filtertext)
			this.dw_1.filter()
			this.dw_1.groupcalc()
			if this.dw_1.rowcount() > 0 then;
				this.dw_1.setredraw(true)
			else
				Messagebox('Warning','Data Not Available In Given Criteria')
			end if
	case "SORT"
			setnull(gs_sorttext)
			this.dw_1.setredraw(false)
			this.dw_1.setsort(gs_sorttext)
			this.dw_1.sort()
			this.dw_1.groupcalc()
			if this.dw_1.rowcount() > 0 then;
				this.dw_1.setredraw(true)
			else
				Messagebox('Warning','Data Not Available In Given Criteria')
			end if
end choose


end event

public function integer wf_check_fillcol (integer fl_row);//if dw_1.rowcount() > 0 and fl_row > 0 then
//	if (isnull(dw_1.getitemstring(fl_row,'machine_id')) or  len(dw_1.getitemstring(fl_row,'machine_id'))=0 or &
//		 isnull(dw_1.getitemdatetime(fl_row,'peg_date'))) then
//	    messagebox('Warning: One Of The Following Fields Are Blank','Machine ID, Run Date, Please Check !!!')
//		 return -1
//	end if
//end if
if dw_2.rowcount() > 0 and fl_row > 0 then
	if (isnull(dw_2.getitemstring(fl_row,'sp_id')) or  len(dw_2.getitemstring(fl_row,'sp_id'))=0 or &
	   isnull(dw_2.getitemstring(fl_row,'pr_eacsubhead_id')) or  len(dw_2.getitemstring(fl_row,'pr_eacsubhead_id'))=0 or &
	   isnull(dw_2.getitemnumber(fl_row,'pr_reqquantity')) or dw_2.getitemnumber(fl_row,'pr_reqquantity') = 0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Product, Required Quantity, Expense, A/C Subhead. Please Check !!!')
	    return -1
	end if
end if
return 1



end function

public function integer wf_cal_datediff (datetime fd_frdt, datetime fd_todt);double ld_hrs1

select get_diff(:fd_todt,:fd_frdt,'A') into :ld_hrs1 from dual;//round(((:fd_todt - :fd_frdt) * 24),2)
if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Date Diff',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
end if

return ld_hrs1
end function

public function integer wf_upd_stock_mm (string fs_sp_id, datetime fd_issue_date, double fd_issue_quantity, double fd_old_qnty);	select distinct 'x' into :ls_temp from fb_stock_mm
  	 where sm_item_cd = :fs_sp_id and
		   	 to_number(sm_month) = to_number(to_char(:fd_issue_date,'mm')) and
		      sm_year  = to_number(to_char(:fd_issue_date,'yyyy'));
				
//     select distinct 'x' into :ls_temp from fb_daily_stock
//	  where ds_item_cd = :fs_sp_id and
//	             DS_REF_NO=:fs_ref_no and
// 			  DS_DATE=:fd_issue_date;	
					
	  if sqlca.sqlcode = -1 then
		messagebox('Sql Error During geting stock detail : ',sqlca.sqlerrtext);
		return -1;
	elseif sqlca.sqlcode = 100 then
	
	insert into fb_stock_mm (SM_ITEM_CD,SM_CO_ID,SM_Unit_ID,SM_MOP_VAL,SM_MOP_QTY,sm_mtd_isu_qty,SM_MONTH,SM_YEAR,SM_LISS_DATE)
	     values (:fs_sp_id,:gs_CO_ID,:gs_garden_snm,0,0,nvl(:fd_issue_quantity,0),
			  	  to_number(to_char(:fd_issue_date,'mm')),to_number(to_char(:fd_issue_date,'yyyy')),:fd_issue_date);
		
		if sqlca.sqlcode = -1 then
			messagebox('Sql Error During stock Insert : ',sqlca.sqlerrtext);
			return -1;
		end if;
		
	elseif sqlca.sqlcode = 0 then
	 	update fb_stock_mm
				set sm_mtd_isu_qty = nvl(sm_mtd_isu_qty,0) - nvl(:fd_old_qnty,0) + nvl(:fd_issue_quantity,0),
					  sm_liss_date   = :fd_issue_date
			  where sm_item_cd  =  :fs_sp_id and
					  to_number(sm_month)    = to_number(to_char(:fd_issue_date,'mm')) and
					  sm_year  = to_number(to_char(:fd_issue_date,'yyyy'));
		if sqlca.sqlcode = -1 then
			messagebox('Sql Error During stock Update : ',sqlca.sqlerrtext);
			return -1;
		end if;				
	end if;
  return 1;
end function

public function integer wf_check_duplicate_rec (string fs_sp_id, string fs_eachead_id, string fs_esubachead_id, string fs_sec, string fs_cc);long fl_row
string ls_sp_id1,ls_eachead_id1,ls_esubachead_id1,ls_secid1,ls_eccid1
datetime ld_run_dt1

dw_2.SelectRow(0, FALSE)
if dw_2.rowcount() > 1 then
	for fl_row = 1 to (dw_2.rowcount() - 1)
		ls_sp_id1 = dw_2.getitemstring(fl_row,'sp_id')
		ls_eachead_id1 = dw_2.getitemstring(fl_row,'eachead_id')
		ls_esubachead_id1 = dw_2.getitemstring(fl_row,'eachead_id')
		ls_secid1 = dw_2.getitemstring(fl_row,'pr_section_id')
		ls_eccid1 = dw_2.getitemstring(fl_row,'pr_ecc_id')

		
		if ls_sp_id1 = fs_sp_id and ls_eachead_id1 = fs_eachead_id and ls_esubachead_id1 = fs_esubachead_id and ls_eccid1 = fs_cc and ls_secid1 = fs_sec then
			dw_2.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gteinf008.create
this.st_1=create st_1
this.cb_5=create cb_5
this.cb_7=create cb_7
this.cb_8=create cb_8
this.cb_9=create cb_9
this.dw_2=create dw_2
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.cb_5,&
this.cb_7,&
this.cb_8,&
this.cb_9,&
this.dw_2,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gteinf008.destroy
destroy(this.st_1)
destroy(this.cb_5)
destroy(this.cb_7)
destroy(this.cb_8)
destroy(this.cb_9)
destroy(this.dw_2)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;//dw_1.modify("t_co.text = '"+gs_CO_name+"'")
if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if
//if date(gd_dt) <> today() then
//	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
//	return 1
//end if

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
lb_query = false	
lb_neworder = false

dw_2.GetChild ("sp_id", idw_prod)
idw_prod.settransobject(sqlca)	

dw_2.GetChild ("pr_eacsubhead_id", idw_eacsubhead)
idw_eacsubhead.settransobject(sqlca)	

dw_2.GetChild ("pr_ecc_id", idw_costcentre)
idw_costcentre.settransobject(sqlca)	

this.tag = Message.StringParm
ll_user_level = long(this.tag)


end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if
IF KeyDown(KeyF1!) THEN
	cb_1.triggerevent(clicked!)
end if
IF KeyDown(KeyF2!) THEN
	cb_2.triggerevent(clicked!)
end if
IF KeyDown(KeyF3!) THEN
	if dw_1.rowcount() > 0  then
		cb_3.triggerevent(clicked!)
	end if
end if
end event

type st_1 from statictext within w_gteinf008
integer x = 1317
integer y = 20
integer width = 1198
integer height = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_5 from commandbutton within w_gteinf008
integer x = 3982
integer y = 28
integer width = 123
integer height = 88
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "<<"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrolltoRow(1)
end if
end event

type cb_7 from commandbutton within w_gteinf008
integer x = 4101
integer y = 28
integer width = 123
integer height = 88
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "<"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrollPriorRow()
end if
end event

type cb_8 from commandbutton within w_gteinf008
integer x = 4219
integer y = 28
integer width = 123
integer height = 88
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = ">"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrollnextRow()
end if
end event

type cb_9 from commandbutton within w_gteinf008
integer x = 4338
integer y = 28
integer width = 123
integer height = 88
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = ">>"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrolltoRow(dw_1.rowcount())
end if
end event

type dw_2 from datawindow within w_gteinf008
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 608
integer width = 4731
integer height = 1348
integer taborder = 40
string dataobject = "dw_gteinf008a"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_2.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_2.deleterow(dw_2.getrow())
	end if
	if dw_2.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

end event

event ue_keydwn;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_2.deleterow(dw_2.getrow())
	end if
	if dw_2.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

end event

event itemchanged;if lb_query = false then
	if dwo.name = 'spc_id' then
		idw_prod.SetFilter ("spc_id = '"+trim(data)+"'") 
		idw_prod.filter( )
	end if
	if dwo.name = 'sp_id' then
		ls_sp_id = data
		
		ld_stock=0
		
		 select sum(decode(ds_rec_ind,'I',-1,1)* ds_QTY) ld_stock into :ld_stock
		   from  fb_daily_stock 
		  where trunc(ds_date) <= trunc(sysdate) and DS_SECTION_ID = :gs_storeid and ds_item_cd =:ls_sp_id;

		iF sqlca.sqlcode = -1 THEN 
				MESSAGEBOX('SQL Error:','During Selecting Stock '+sqlca.sqlerrtext)
			return 1;
		elseif sqlca.sqlcode = 100 THEN 
			ld_stock=0
		end if;	
		
		if isnull(ld_stock) then ld_stock=0
		dw_2.setitem(row,'pr_avl_stock',ld_stock)
		
	else
		ls_sp_id = dw_2.getitemstring(row,'sp_id')
	end if

	if dwo.name = 'eachead_id' then
		ls_eachead_id = data
		idw_eacsubhead.SetFilter ("eachead_id= '"+trim(data)+"'") 
		idw_eacsubhead.filter( )
		setnull(ls_temp)
		dw_2.setitem(row,'pr_eacsubhead_id',ls_temp)
		dw_2.setitem(row,'pr_section_id',ls_temp)
		dw_2.setitem(row,'pr_ecc_id',ls_temp)
	end if
	
	if dwo.name = 'pr_eacsubhead_id' then
		ls_esubachead_id = data
		ls_eachead_id = dw_2.getitemstring(row,'eachead_id')
		ls_secid = dw_2.getitemstring(row,'pr_section_id')
		ls_eccid = dw_2.getitemstring(row,'pr_ecc_id')

		if  wf_check_duplicate_rec(ls_sp_id,ls_eachead_id,ls_esubachead_id,ls_secid,ls_eccid) = -1 then return 1

		if ls_esubachead_id ='ESUB0006' then
			idw_costcentre.SetFilter ("cc_type like 'V'") 
			idw_costcentre.filter( )
		elseif ls_esubachead_id ='ESUB0007' then
			idw_costcentre.SetFilter ("cc_type like 'B'") 
			idw_costcentre.filter( )
		elseif ls_esubachead_id ='ESUB0008' then
			idw_costcentre.SetFilter ("cc_type like 'R'") 
			idw_costcentre.filter( )
		elseif ls_esubachead_id ='ESUB0010' or ls_esubachead_id ='ESUB0017' or ls_esubachead_id ='ESUB0018'   then
			idw_costcentre.SetFilter ("cc_type like 'M'") 
			idw_costcentre.filter( )
		end if;				
		setnull(ls_temp)
		dw_2.setitem(row,'pr_ecc_id',ls_temp)
		dw_2.setitem(row,'pr_section_id',ls_temp)		
	end if
	
	if dwo.name = 'pr_section_id' then 		
		ls_secid= data
		ls_esubachead_id = dw_2.getitemstring(row,'pr_eacsubhead_id')
		ls_eachead_id = dw_2.getitemstring(row,'eachead_id')
		ls_eccid = dw_2.getitemstring(row,'pr_ecc_id')

		if  wf_check_duplicate_rec(ls_sp_id,ls_eachead_id,ls_esubachead_id,ls_secid,ls_eccid) = -1 then return 1

		 if not isnull(ls_secid) or len(ls_secid)<>0 then
			dw_2.setitem(row,'pr_ecc_id',ls_temp)
		 end if		
		
		if ls_eachead_id ='SLEG0012' or ls_eachead_id = 'SLEG0013' or ls_eachead_id ='SLEG0014' then
			if ls_esubachead_id='ESUB0012' or ls_esubachead_id='ESUB0013'or ls_esubachead_id='ESUB0014'or ls_esubachead_id='ESUB0022'or ls_esubachead_id='ESUB0023'or ls_esubachead_id='ESUB0024' then	
				if isnull(ls_secid) or len(ls_secid)=0 then
					messagebox('Error:','Please Enter A valid Section ID')
					return 1;
				end if;           	
			end if	
		end if
	end if;		
	
	if dwo.name = 'pr_ecc_id' then 
		ls_eccid=data
		ls_esubachead_id =dw_2.getitemstring(row,'pr_eacsubhead_id')		
		ls_eachead_id = dw_2.getitemstring(row,'eachead_id')
		ls_secid = dw_2.getitemstring(row,'pr_section_id')

		if  wf_check_duplicate_rec(ls_sp_id,ls_eachead_id,ls_esubachead_id,ls_secid,ls_eccid) = -1 then return 1

		if ls_eachead_id='ESUB0006' or ls_eachead_id='ESUB0007'or ls_eachead_id='ESUB0008'or ls_eachead_id='ESUB0010'or ls_eachead_id='ESUB0017'or ls_eachead_id='ESUB0018' then dw_2.setitem(row,'pr_section_id',ls_temp)
		if not isnull(ls_eccid) or len(ls_eccid)<>0 then
			dw_2.setitem(row,'pr_section_id',ls_temp)
		 end if		
	end if;	

	if dwo.name = 'pr_reqquantity' then
		ld_req_qty = double(data)
		
		if ld_req_qty < 0 then
			messagebox('Error:','Required quantity should be Greater Than Zero')
			return 1;
		end if;	
	end if;
	
	cb_3.enabled = true
end if
if row = dw_2.rowcount() and dwo.name <> 'del_flag'  then
	dw_2.insertrow(0)
end if
end event

type cb_4 from commandbutton within w_gteinf008
integer x = 809
integer y = 12
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

event clicked;if dw_1.modifiedcount() > 0 or dw_1.deletedcount() > 0 then
	IF MessageBox("Exit Alert", 'Do You Want To Exit....?' ,Exclamation!, YesNo!, 1) = 1 THEN
		close(parent)
	else
		return
	end if
else
	close(parent)
end if
end event

type cb_3 from commandbutton within w_gteinf008
integer x = 544
integer y = 12
integer width = 265
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "&Save"
end type

event clicked;if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

if dw_1.rowcount() > 1 then
	if isnull(dw_1.getitemdatetime(dw_1.getrow(),'pr_date')) or isnull(dw_1.getitemdatetime(dw_1.getrow(),'pr_reqdate')) or isnull(dw_1.getitemstring(dw_1.getrow(),'pr_division')) or len(dw_1.getitemstring(dw_1.getrow(),'pr_division')) = 0 then
		messagebox('Warning!','One Of The Fields Is blank, Requisition Date, Required Date, Division, Please Check !!!')
		return 1
	end if
end if

if dw_2.rowcount() > 1 then
	if (isnull(dw_2.getitemstring(dw_2.rowcount(),'pr_id')) or len(dw_2.getitemstring(dw_2.rowcount(),'pr_id')) = 0) then 
		dw_2.deleterow(dw_2.rowcount())
	end if;
end if

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN

	for ll_ctr = dw_2.rowcount() to 1 step -1
				
		if dw_2.getitemstring(ll_ctr,'del_flag') = 'Y' and dw_2.rowcount() = dw_2.getitemnumber(ll_ctr,'sel_row') then
			messagebox('Warning!','You Cannot Delete All Records From Detail Section !!!')
			return 1
		elseif dw_2.getitemstring(ll_ctr,'del_flag') = 'Y' and dw_2.rowcount() <> dw_2.getitemnumber(ll_ctr,'sel_row') then
			dw_2.deleterow(ll_ctr)
		end if
	next	
	
	if dw_2.rowcount() = 0 then
		messagebox('Error','Records Should Be Available In Detail Block')
		return
	end if

	if (isnull(dw_1.getitemdatetime(dw_1.getrow(),'pr_reqdate')) or isnull(dw_1.getitemdatetime(dw_1.getrow(),'pr_reqdate'))) then
		messagebox('Warning:','One Of The Fields Are Blank : Required Date !!!')
		dw_1.setfocus()
		dw_1.setcolumn('pr_reqdate')
		return
	end if
	
	if dw_2.rowcount() > 0 then
		for ll_ctr = 1 to dw_2.rowcount( ) 
			IF wf_check_fillcol(ll_ctr) = -1 THEN 
				return 1
			end if
		next	
	end if
	
	if lb_neworder = true then
		ll_last=0
		if ll_last=0 then
			select nvl(MAX(substr(pr_id,4,10)),0) into :ll_last from fb_product_requ;
		end if

		ll_last = ll_last + 1
		ls_tmp_id = 'DRQ'+string(ll_last,'0000000000') 
		dw_1.setitem(dw_1.getrow(),'pr_id',ls_tmp_id)	
	else
		ls_tmp_id =dw_1.getitemstring(dw_1.getrow(),'pr_id')		
     end if
	  

	  for ll_ctr = 1 to dw_2.rowcount()		
			 dw_2.setitem(ll_ctr,'pr_id',ls_tmp_id)		
	  next

	if lb_neworder = true then
		Messagebox('Information!','Requisition No Generated Is ('+ls_tmp_id+')')
	end if
			
	
	if dw_1.update(true,false) = 1 then
		if dw_2.update(true,false) = 1 then
			dw_2.resetupdate();
			dw_1.resetupdate();
			commit using sqlca;
			cb_3.enabled = false
			cb_1.enabled = true
			dw_1.reset()
			dw_2.reset()
		else
			rollback using sqlca;
			return 1
		end if
	else
		messagebox('SQL Error : During Save',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
end if 
end event

type cb_2 from commandbutton within w_gteinf008
integer x = 279
integer y = 12
integer width = 265
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Query"
end type

event clicked;if cb_2.text = "&Query" then
	if dw_1.modifiedcount() > 0 or dw_2.modifiedcount() > 0 then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	lb_query = true
	lb_neworder = true
	dw_1.reset()
	dw_2.reset()
   	cb_3.enabled = false
  	cb_5.enabled = false
	cb_7.enabled = false
	cb_8.enabled = false
	cb_9.enabled = false
	dw_1.settaborder('pr_id',5)
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('pr_date')
	cb_2.text = "&Run"
	cb_3.enabled = false
	cb_1.enabled = false
else
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user,ls_appr_ind)
 	dw_1.TriggerEvent(rowfocuschanged!)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
   	cb_5.enabled = true
	cb_1.enabled = true
   	cb_7.enabled = true
   	cb_8.enabled = true
   	cb_9.enabled = true
	dw_1.settaborder('pr_id',0)	
end if
lb_neworder = false

end event

type cb_1 from commandbutton within w_gteinf008
integer x = 14
integer y = 12
integer width = 265
integer height = 100
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&New"
end type

event clicked;if lb_neworder = false then
	if dw_1.modifiedcount() > 0 then
		if messagebox("Confirmation","Row has been modified, Do You Want To Add New Record ...!",question!,yesno!,1) = 2 then
			return
		end if
	end if
	dw_1.reset()
	dw_2.reset()
end if
///check Issue for previous date A/c posting	
	select max(PR_DATE) into :ld_dt from FB_PRODUCT_Requ;
	if sqlca.sqlcode = -1 then 
	      messagebox('Sql Error','Error During check Max Requisition Date : '+sqlca.sqlerrtext)
	      return 1
	elseif sqlca.sqlcode = 0 then 
	     st_1.text = 'Last Requision Date Is : '+ string(ld_dt,'dd/mm/yyyy')
	end if;		

///check Issue for Stock/MES posting	
//	select distinct 'x' into :ls_temp from fb_productissue where  nvl(PRIS_STOCKIND,'N')='N' ;
//	
//	if sqlca.sqlcode = -1 then 
//	      messagebox('Sql Error','Error During check Issue for Stock/MES Posting : '+sqlca.sqlerrtext)
//	      return 1
//	elseif sqlca.sqlcode = 0 then 
//	     messagebox('Error',' Issue for Stock/MES Posting Already Available for  Posting...Please Check ')
//		return 1
//	end if;	

dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false


if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'pr_division',gs_storeid)
	dw_1.setitem(dw_1.getrow(),'pr_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'pr_entry_dt',datetime(today()))
	dw_1.setcolumn('pr_date')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'pr_division',gs_storeid)
	dw_1.setitem(dw_1.getrow(),'pr_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'pr_entry_dt',datetime(today()))
	dw_1.setcolumn('pr_date')
end if
cb_1.enabled = false

end event

type dw_1 from datawindow within w_gteinf008
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 9
integer y = 116
integer width = 4727
integer height = 488
integer taborder = 30
string dataobject = "dw_gteinf008"
boolean hscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'pr_entry_by',gs_user)
		dw_1.setitem(newrow,'pr_entry_dt',datetime(today()))
		dw_1.setcolumn('pr_reqdate')
	end if
 end if
end if


end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;if dwo.name = 'pr_date'   then
	if lb_neworder = true and dw_2.rowcount() = 0 then
		ld_dt = datetime(data)
		
		if date(ld_dt) > date(today()) then
			messagebox('Warning!','Requisition Date Should Not Be > Current Date, Please Check !!!')
			return 1
		end if

		select max(pr_date) into :ld_date from FB_PRODUCT_Requ;  		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Maximum Requisition Date',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		
		if ld_date > ld_dt then
			messagebox('Warning!','Requisition Date Should Be >= '+string(ld_date,'dd/mm/yyyy')+', Please Check !!!')
			return 1
		end if
		dw_1.setitem(row,'pr_reqdate',datetime(data))
		dw_2.setfocus()
		dw_2.insertrow(0)
		dw_1.setfocus()
		dw_1.setcolumn('pr_date')
	end if;	
end if

if dwo.name = 'pr_reqdate'   then
	if lb_neworder = true and dw_2.rowcount() = 0 then
		ld_dt = datetime(data)
		ld_date = dw_1.getitemdatetime(row,'pr_date')
		if ld_dt < ld_date then
			messagebox('Warning!','Required Date Should Be >= Requisition Date, Please Check !!!')
			return 1
		end if
	end if;	
end if


//if dwo.name = 'pr_reqdate'   then

//	 if date(ld_dt) < today() then
//		MESSAGEBOX('Error:','Required date should be greater than equal to current date')
//		return 1;
//	end if;	
//end if
if dwo.name = 'pr_division'   then 
	ls_div = data	
	 if isnull(ls_div) or len(ls_div)=0 then
		MESSAGEBOX('Error:','Division should be Select for Product Issue')
		return 1;
	end if;	
end if

if lb_query = false then
	dw_1.setitem(row,'pr_entry_by',gs_user)
	dw_1.setitem(row,'pr_entry_dt',datetime(today()))
	cb_3.enabled = true
end if
end event

event rowfocuschanged;if lb_query = false then
	if lb_neworder = false  then
		if dw_1.rowcount() > 0 then
			dw_2.reset()
			dw_2.retrieve(dw_1.getitemstring(dw_1.getrow(),'pr_id'))
		end if
	end if
end if
end event

