$PBExportHeader$w_gteprof013.srw
forward
global type w_gteprof013 from window
end type
type em_3 from editmask within w_gteprof013
end type
type st_3 from statictext within w_gteprof013
end type
type st_2 from statictext within w_gteprof013
end type
type st_1 from statictext within w_gteprof013
end type
type dp_1 from datepicker within w_gteprof013
end type
type cb_4 from commandbutton within w_gteprof013
end type
type cb_3 from commandbutton within w_gteprof013
end type
type cb_2 from commandbutton within w_gteprof013
end type
type cb_1 from commandbutton within w_gteprof013
end type
type ddlb_1 from dropdownlistbox within w_gteprof013
end type
type dw_2 from datawindow within w_gteprof013
end type
type dw_1 from datawindow within w_gteprof013
end type
end forward

global type w_gteprof013 from window
integer width = 3145
integer height = 2488
boolean titlebar = true
string title = "(w_gteprof013) Sorting"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
em_3 em_3
st_3 st_3
st_2 st_2
st_1 st_1
dp_1 dp_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
ddlb_1 ddlb_1
dw_2 dw_2
dw_1 dw_1
end type
global w_gteprof013 w_gteprof013

type variables
long ll_ctr,net, ll_cnt,l_ctr,ll_user_level,ll_season
string ls_temp,ls_del_ind,ls_tpc_id,ls_tmp_id,ls_entry_user,ls_name,ls_cat_id
boolean lb_neworder, lb_query
double ld_totqnty, ld_uns_bal_ctc, ld_uns_bal_ort, ld_uns_bal_green, ld_uns_bal_samp
datetime ld_rundt, ld_maxsortdt,ld_maxpackdt
string ls_rundate

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fl_mac_id, datetime fd_run_dt)
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

public function integer wf_check_fillcol (integer fl_row);if dw_1.rowcount() > 0 and fl_row > 0 then
	if (isnull(dw_1.getitemnumber(fl_row,'peg_elect')) or  dw_1.getitemnumber(fl_row,'peg_elect') = 0 or &
		isnull(dw_1.getitemnumber(fl_row,'peg_hrs')) or  dw_1.getitemnumber(fl_row,'peg_hrs') = 0 or &
		(dw_1.getitemnumber(fl_row,'peg_hsd') = 0 and dw_1.getitemnumber(fl_row,'peg_gas') = 0 and dw_1.getitemstring(fl_row,'machine_type') = 'PGEN') or &
		(dw_1.getitemnumber(fl_row,'manufacture') = 0 and dw_1.getitemnumber(fl_row,'domestic') = 0 and dw_1.getitemnumber(fl_row,'irregation') = 0)) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Electricity Units Received/Generated, Total Run Time, HSD Oil/Gas, Manufacture/Domestic/Irregation, Please Check !!!')
		 return -1
	end if
end if
return 1
end function

public function integer wf_check_duplicate_rec (string fl_mac_id, datetime fd_run_dt);long fl_row
string ls_mac_id1
datetime ld_run_dt1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_mac_id1 = dw_1.getitemstring(fl_row,'machine_id')
		ld_run_dt1 = dw_1.getitemdatetime(fl_row,'peg_date')
		
		if ls_mac_id1 = fl_mac_id and ld_run_dt1 = fd_run_dt then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gteprof013.create
this.em_3=create em_3
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.dp_1=create dp_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.ddlb_1=create ddlb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.em_3,&
this.st_3,&
this.st_2,&
this.st_1,&
this.dp_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.ddlb_1,&
this.dw_2,&
this.dw_1}
end on

on w_gteprof013.destroy
destroy(this.em_3)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dp_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.ddlb_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
lb_query = false	
lb_neworder = false

//dw_1.modify("t_co.text = '"+gs_co_name+"'")

if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if
//if date(gd_dt) <> today() then
//	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
//	return 1
//end if

this.tag = Message.StringParm
ll_user_level = long(this.tag)

DECLARE c1 CURSOR FOR  
select distinct a.TPC_ID,TPC_NAME from fb_teamadeproduct a,fb_teamadeproductcategory b where a.TPC_ID = b.TPC_ID order by 1;

open c1;
	
IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_tpc_id,:ls_name;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_name+'                                                                   ('+ls_tpc_id+')')
		fetch c1 into :ls_tpc_id,:ls_name;
	loop
END IF
close c1;

em_3.text = string(today(),'YYYY')
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

type em_3 from editmask within w_gteprof013
integer x = 2318
integer y = 28
integer width = 197
integer height = 84
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "0000"
end type

type st_3 from statictext within w_gteprof013
integer x = 2085
integer y = 36
integer width = 247
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Season :"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_gteprof013
integer x = 713
integer y = 32
integer width = 320
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tea Category"
boolean focusrectangle = false
end type

type st_1 from statictext within w_gteprof013
integer x = 14
integer y = 32
integer width = 302
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Reading Date"
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_gteprof013
integer x = 315
integer y = 20
integer width = 384
integer height = 84
integer taborder = 10
boolean border = true
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2024-09-05"), Time("14:37:42.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type cb_4 from commandbutton within w_gteprof013
integer x = 2834
integer y = 136
integer width = 265
integer height = 100
integer taborder = 90
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

type cb_3 from commandbutton within w_gteprof013
integer x = 2569
integer y = 136
integer width = 265
integer height = 100
integer taborder = 70
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

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN

	for ll_ctr = dw_1.rowcount() to 1 step -1
		IF (isnull(dw_1.getitemnumber(ll_ctr,'dtmp_sortquantodayty')) or dw_1.getitemnumber(ll_ctr,'dtmp_sortquantodayty') = 0) THEN
			 dw_1.deleterow(ll_ctr)
		END IF
	next	
	
	
	if dw_1.update(true,false) = 1 then
		dw_1.resetupdate();
		commit using sqlca;
		cb_3.enabled = false
		dw_1.reset()
		dw_2.reset()
	else
		messagebox('SQL Error : During Save',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
else
	return
end if 
end event

type cb_2 from commandbutton within w_gteprof013
integer x = 2304
integer y = 136
integer width = 265
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Query"
end type

event clicked;if date(dp_1.text) > date(today()) then
	messagebox('Warning!','Reading Date should not be Greater Than Current date, Please Check !!!')
	return 1
end if

if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
	messagebox('Warning!','Please Select A Tea Category !!!')
	return 1
end if

select max(DTMP_SORTDATE) into :ld_maxsortdt from fb_dailysortedteamadeproduct;
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Max Stock Date !!!',sqlca.sqlerrtext)
	return 1
end if

select max(DTP_DATE) into :ld_maxpackdt from fb_dailyteapacked;
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Max Stock Date !!!',sqlca.sqlerrtext)
	return 1
end if

ld_rundt = datetime(dp_1.text)

select distinct 'x' into :ls_temp from fb_dailysortedteamadeproduct where trunc(DTMP_SORTDATE) = trunc(:ld_rundt);
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Sorted Tea Details',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
elseif sqlca.sqlcode  = 100 then
	messagebox('Warning!','Sorting Data For Selected Date Not Exists, Please Check !!!')
	return 1
end if

if cb_2.text = "&Query" then
	lb_neworder = true
	if dw_1.modifiedcount() > 0 then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	dw_1.reset()
	dw_1.settaborder('tpc_id',5)
	dw_1.settaborder('dtmp_sortdate',7)
	dw_1.settaborder('tmp_id',9)
	lb_query = true
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('tpc_id')
	cb_2.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_neworder =false
 	dw_1.settransobject(sqlca)
	dw_2.settransobject(sqlca)
	dw_2.RETRIEVE(dp_1.text,gs_garden_snm)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user,date(ld_rundt),date(ld_maxsortdt),date(ld_maxpackdt))
	dw_1.settaborder('tpc_id',0)
	dw_1.settaborder('dtmp_sortdate',0)
	dw_1.settaborder('tmp_id',0)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	lb_query = false
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gteprof013
integer x = 2039
integer y = 136
integer width = 265
integer height = 100
integer taborder = 40
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
end if
dw_1.reset()
dw_2.reset()

dw_1.settransobject(sqlca)

ls_cat_id = left(right(ddlb_1.text,8),7)

if date(dp_1.text) > date(today()) then
	messagebox('Warning!','Reading Date should not be Greater Than Current date, Please Check !!!')
	return 1
end if

ll_season = long(em_3.text)

if isnull(ll_season) or ll_season = 0 or len(em_3.text) = 0  then
	messagebox('Warning !','Please Enter The Season !!!')
	return 1
end if

//select max(DTMP_SORTDATE) into :ld_maxsortdt from fb_dailysortedteamadeproduct ;
select max(DTMP_SORTDATE) into :ld_maxsortdt from fb_dailysortedteamadeproduct a, fb_teamadeproduct b where a.tmp_id = b.tmp_id and b.tpc_id = :ls_cat_id;
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Max Stock Date !!!',sqlca.sqlerrtext)
	return 1
end if

select max(DTP_DATE) into :ld_maxpackdt from fb_dailyteapacked;
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Max Stock Date !!!',sqlca.sqlerrtext)
	return 1
end if


if isnull(ld_maxsortdt) then ld_maxsortdt = datetime('01/01/2000');

if isnull(ld_maxpackdt) then ld_maxpackdt = datetime('01/01/2000');

if date(dp_1.text) < date(ld_maxsortdt) then
	messagebox('Warning !','You Have Already Done Sorting Entry Of Date '+string(ld_maxsortdt,'dd/mm/yyyy')+' ,So You cannot Do Entry Before This Date !!')
	return 1
end if

if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
	messagebox('Warning!','Please Select A Tea Category !!!')
	return 1
end if

ld_rundt = datetime(dp_1.text)
ls_rundate=string(ld_rundt,'dd/mm/yyyy')

dw_2.settransobject(sqlca)
dw_2.RETRIEVE(dp_1.text,gs_garden_snm)

//select distinct 'x' into :ls_temp from fb_pegeneration where trunc(dtmp_date) = trunc(:ld_rundt);
//if sqlca.sqlcode = -1 then
//	messagebox('Error : While Getting Machine Details',sqlca.sqlerrtext)
//	rollback using sqlca;
//	return 1
//elseif sqlca.sqlcode  = 0 then
//	messagebox('Warning!','Machine Reading For Selected Date Already Exists, Please Check !!!')
//	return 1
//end if	
//

DECLARE c1 CURSOR FOR  
select distinct TPC_ID,TMP_ID from fb_teamadeproduct a
where TPC_ID = :ls_cat_id and not exists (select distinct TMP_ID from fb_dailysortedteamadeproduct b where to_char(DTMP_SORTDATE,'dd/mm/yyyy') = :ls_rundate and a.TMP_ID = b.TMP_ID)
order by TPC_ID,TMP_ID;

open c1;
	
IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_tpc_id,:ls_tmp_id;
	
	do while sqlca.sqlcode <> 100
		dw_1.scrolltorow(dw_1.insertrow(0))
		dw_1.setitem(dw_1.getrow(),'tpc_id',ls_tpc_id)
		dw_1.setitem(dw_1.getrow(),'ra_date',date(dp_1.text))
		dw_1.setitem(dw_1.getrow(),'ra_maxsortdt',date(ld_maxsortdt))
		dw_1.setitem(dw_1.getrow(),'ra_maxpacdt',date(ld_maxpackdt))
		dw_1.setitem(dw_1.getrow(),'dtmp_sortdate',date(dp_1.text))
		dw_1.setitem(dw_1.getrow(),'dtmp_season',ll_season)
		dw_1.setitem(dw_1.getrow(),'tmp_id',ls_tmp_id)		
		dw_1.setitem(dw_1.getrow(),'dtmp_entry_by',gs_user)
		dw_1.setitem(dw_1.getrow(),'dtmp_entry_dt',datetime(today()))
		fetch c1 into :ls_tpc_id,:ls_tmp_id;
	loop
END IF
close c1;
dw_1.setfocus()
dw_1.scrolltorow(1)
dw_1.setcolumn('dtmp_sortquantodayty')
lb_neworder = true
lb_query = false



end event

type ddlb_1 from dropdownlistbox within w_gteprof013
integer x = 1042
integer y = 16
integer width = 997
integer height = 808
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
end type

type dw_2 from datawindow within w_gteprof013
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 236
integer width = 3095
integer height = 472
integer taborder = 80
string dataobject = "dw_gteprof013a"
boolean hscrollbar = true
end type

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

type dw_1 from datawindow within w_gteprof013
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 712
integer width = 3095
integer height = 1644
integer taborder = 60
string dataobject = "dw_gteprof013"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
//	if currentrow <> dw_1.rowcount() then
//		IF wf_check_fillcol(currentrow) = -1 THEN
//			return 1
//		END IF
//	END If
	
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'dtmp_entry_by',gs_user)
		dw_1.setitem(newrow,'dtmp_entry_dt',datetime(today()))
		dw_1.setcolumn('dtmp_sortquantodayty')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;//if lb_neworder = true then
//	IF KeyDown(KeyF6!) THEN
//		dw_1.deleterow(dw_1.rowcount())
//	end if
//	if dw_1.rowcount() = 0 then
//		cb_3.enabled = false
//	end if
//end if
end event

event ue_keydwn;//if lb_neworder = true then
//	IF KeyDown(KeyF6!) THEN
//		dw_1.deleterow(dw_1.rowcount())
//	end if
//	if dw_1.rowcount() = 0 then
//		cb_3.enabled = false
//	end if
//end if
//
end event

event itemchanged;if lb_query = false then
	
	ls_tpc_id = left(right(ddlb_1.text,8),7)
	
	if dwo.name = 'dtmp_sortquantodayty' then
		ld_totqnty = double(data) + dw_1.getitemnumber(row,'tot_qnty')
		if dw_2.getrow() > 0 then
			ld_uns_bal_ctc = dw_2.getitemnumber(dw_2.getrow(),'ctc_stk')
			ld_uns_bal_ort = dw_2.getitemnumber(dw_2.getrow(),'ortho_stk')
			ld_uns_bal_green = dw_2.getitemnumber(dw_2.getrow(),'green_stk')
			ld_uns_bal_samp = dw_2.getitemnumber(dw_2.getrow(),'sample_stk')
		else
			ld_uns_bal_ctc = 0; ld_uns_bal_ort = 0; ld_uns_bal_green = 0; ld_uns_bal_samp = 0;
		end if
		if gs_garden_snm = 'ME' then
			if (ls_tpc_id = 'TPC0002' and ld_uns_bal_ctc = 0) or (ls_tpc_id = 'TPC0003' and ld_uns_bal_ort = 0) or &
				(ls_tpc_id = 'TPC0004' and ld_uns_bal_green = 0) then
				messagebox('Warning!','Unsorted Stock For This Category Is 0, Please Check !!!')
				return 1
			end if
			if (ls_tpc_id = 'TPC0002' and ld_totqnty > ld_uns_bal_ctc) or (ls_tpc_id = 'TPC0003' and ld_totqnty > ld_uns_bal_ort) or &
				(ls_tpc_id = 'TPC0004' and ld_totqnty > ld_uns_bal_green) then
				messagebox('Warning!','Sorted Quantity Should Not Be > Unsorted Balance, Please Check !!!')
				return 1
			end if		
		else
			if (ls_tpc_id = 'TPC0001' and ld_uns_bal_ctc = 0) or (ls_tpc_id = 'TPC0002' and ld_uns_bal_ort = 0) or &
				(ls_tpc_id = 'TPC0003' and ld_uns_bal_green = 0) or (ls_tpc_id = 'TPC0004' and ld_uns_bal_samp = 0) then
				messagebox('Warning!','Unsorted Stock For This Category Is 0, Please Check !!!')
				return 1
			end if
			if (ls_tpc_id = 'TPC0001' and ld_totqnty > ld_uns_bal_ctc) or (ls_tpc_id = 'TPC0002' and ld_totqnty > ld_uns_bal_ort) or &
				(ls_tpc_id = 'TPC0003' and ld_totqnty > ld_uns_bal_green) or (ls_tpc_id = 'TPC0004' and ld_totqnty > ld_uns_bal_samp) then
				messagebox('Warning!','Sorted Quantity Should Not Be > Unsorted Balance, Please Check !!!')
				return 1
			end if
		end if
	end if

	dw_1.setitem(row,'dtmp_entry_by',gs_user)
	dw_1.setitem(row,'dtmp_entry_dt',datetime(today()))
	
	cb_3.enabled = true
End if
end event

