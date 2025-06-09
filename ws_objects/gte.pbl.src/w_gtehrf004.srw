$PBExportHeader$w_gtehrf004.srw
forward
global type w_gtehrf004 from window
end type
type st_3 from statictext within w_gtehrf004
end type
type em_1 from editmask within w_gtehrf004
end type
type st_1 from statictext within w_gtehrf004
end type
type ddlb_1 from dropdownlistbox within w_gtehrf004
end type
type st_2 from statictext within w_gtehrf004
end type
type cb_4 from commandbutton within w_gtehrf004
end type
type cb_3 from commandbutton within w_gtehrf004
end type
type cb_2 from commandbutton within w_gtehrf004
end type
type cb_1 from commandbutton within w_gtehrf004
end type
type dw_1 from datawindow within w_gtehrf004
end type
end forward

global type w_gtehrf004 from window
integer width = 3840
integer height = 2344
boolean titlebar = true
string title = "(w_gtehrf004) P. Tax Slab"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_3 st_3
em_1 em_1
st_1 st_1
ddlb_1 ddlb_1
st_2 st_2
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gtehrf004 w_gtehrf004

type variables
long ll_ctr,net, ll_cnt, ll_year, ll_last,ll_user_level
string ls_temp,ls_name,ls_last,ls_grade,ls_statecd,ls_state
boolean lb_neworder, lb_query
datetime ld_frdt, ld_todt
double ld_stslab, ld_edslab,ld_stslab1, ld_edslab1

double ld_ptax, ld_startslab,ld_endslab

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (double fd_stslab, double fd_edslab)
end prototypes

event ue_option();choose case gs_ueoption
	case "PRINT"
			OpenWithParm(w_print,this.dw_1)
	case "PRINTPREVIEW"
			this.dw_1.modify("datawindow.print.preview = yes")
	case "RESETPREVIEW"
			this.dw_1.modify("datawindow.print.preview = no")
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
	if (	 isnull(dw_1.getitemstring(fl_row,'epd_state_code')) or  len(dw_1.getitemstring(fl_row,'epd_state_code'))=0 or & 
	      isnull(dw_1.getitemdatetime(fl_row,'epd_dt_from')) or &
		 isnull(dw_1.getitemnumber(fl_row,'epd_startslab')) or  dw_1.getitemnumber(fl_row,'epd_startslab') < 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'epd_endslab')) or  dw_1.getitemnumber(fl_row,'epd_endslab')=0 ) then
	    messagebox('Warning: One Of The Following Fields Are Blank',' State, Start Slab, End Slab, From Date Please Check !!!')
		 return -1
	end if
end if
return 1
end function

public function integer wf_check_duplicate_rec (double fd_stslab, double fd_edslab);long fl_row
string ls_state1
datetime ld_dt1
double ld_stslb, ld_edslb

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1) 
		ls_state1 = dw_1.getitemstring(fl_row,'epd_state_code')
		ld_dt1 = dw_1.getitemdatetime(fl_row,'epd_dt_from')
		ld_stslb = dw_1.getitemnumber(fl_row,'epd_startslab')
		ld_edslb = dw_1.getitemnumber(fl_row,'epd_endslab')
		
		if ld_stslb = fd_stslab and ld_edslb = fd_edslab then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		elseif   fd_stslab>=ld_stslb and  fd_stslab<=ld_edslb  then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Start Slab Should not be Between Previous Start Slab And End Slab At Row : "+string(fl_row))
			return -1
		elseif ld_stslb <> 0 and fd_edslab>=ld_stslb  and  fd_edslab<=ld_edslb  then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","End Slab Should not be Between Previous Start Slab And End Slab At Row : "+string(fl_row))
			return -1
		end if
		
	next 
end if 

return 1
end function

on w_gtehrf004.create
this.st_3=create st_3
this.em_1=create em_1
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.st_2=create st_2
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.st_3,&
this.em_1,&
this.st_1,&
this.ddlb_1,&
this.st_2,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gtehrf004.destroy
destroy(this.st_3)
destroy(this.em_1)
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.st_2)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
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
if ll_user_level = 3 then
	cb_3.visible = false
	cb_1.visible = false
	cb_3.enabled = false
	cb_1.enabled = false
end if

setpointer(hourglass!)
dw_1.settransobject(sqlca)
declare c1 cursor for
select DISTINCT PD_DESC||'  '||PD_CODE from fb_param_detail where pd_doc_type='STATE CODE'
order by 1 asc;	
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_state;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(string(ls_state))
		fetch c1 into :ls_state;
	loop
	close c1;
end if

setpointer(arrow!)
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

type st_3 from statictext within w_gtehrf004
integer x = 3086
integer y = 2084
integer width = 635
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16711680
long backcolor = 67108864
string text = "Press F6 to Delete a Record "
boolean focusrectangle = false
end type

type em_1 from editmask within w_gtehrf004
integer x = 1787
integer y = 16
integer width = 389
integer height = 84
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean dropdowncalendar = true
end type

event modified;if isdate(em_1.text) = false then 
	messagebox('Error At Process date','Please Enter From Date...!')
//	cb_6.enabled = false	
	return -1
else
	ls_temp=em_1.text
//	cb_6.enabled = true
end if;	
end event

type st_1 from statictext within w_gtehrf004
integer x = 1458
integer y = 36
integer width = 325
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From Date :"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gtehrf004
integer x = 265
integer y = 20
integer width = 1047
integer height = 684
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean allowedit = true
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_gtehrf004
integer x = 32
integer y = 36
integer width = 238
integer height = 56
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "State :"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_gtehrf004
integer x = 3017
integer y = 8
integer width = 265
integer height = 100
integer taborder = 70
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

type cb_3 from commandbutton within w_gtehrf004
integer x = 2752
integer y = 8
integer width = 265
integer height = 100
integer taborder = 60
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

IF dw_1.getitemnumber(dw_1.rowcount(),'epd_startslab')=0 and dw_1.getitemnumber(dw_1.rowcount(),'epd_endslab')=0 THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
	if dw_1.rowcount() > 0 then
		if wf_check_fillcol(dw_1.getrow()) = -1 then return 1
	end if

	if dw_1.rowcount() > 0 then
		for ll_ctr = 1 to dw_1.rowcount( ) 			
			ld_frdt = dw_1.getitemdatetime(ll_ctr,'epd_dt_from')
			ld_stslab = dw_1.getitemnumber(ll_ctr,'epd_startslab')
			ld_edslab = dw_1.getitemnumber(ll_ctr,'epd_endslab')	
			ls_statecd = dw_1.getitemstring(ll_ctr,'epd_state_code')	

			select distinct 'x' into :ls_temp from fb_empptaxdeduction
			where  epd_state_code = :ls_statecd and epd_startslab = :ld_stslab and 
			            epd_endslab = :ld_edslab and epd_dt_from > :ld_frdt and epd_dt_to is null;
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Tax Details',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode  = 0 then
				messagebox("Warning!","Record Already Exists, Please Check !!!")
				return 1
			end if
		  
		  delete from  fb_empptaxdeduction  where epd_state_code = :ls_statecd and epd_dt_to is null and epd_dt_from = :ld_frdt;			
			if sqlca.sqlcode = -1 then
				messagebox('Error : While delete Same date Record 1',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1				
			end if	
			
		   update fb_empptaxdeduction set epd_dt_to = (:ld_frdt - 1)
		   where epd_state_code = :ls_statecd and epd_dt_to is null and epd_dt_from < :ld_frdt;
			
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Updating Record 1',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1				
			end if	
			
		next	
	end if

	if dw_1.update(true,false) = 1 then
		dw_1.resetupdate();
		commit using sqlca;
		cb_3.enabled = false
		dw_1.reset()
	else
		messagebox('SQL Error : During Save',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
else
	return
end if 
end event

type cb_2 from commandbutton within w_gtehrf004
integer x = 2487
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
string text = "&Query"
end type

event clicked;if trim(ddlb_1.text) = "" or isnull(ddlb_1.text) then 
	messagebox('Error At State ','The State Should Not Be Blank, Please Check...!')
	return -1
end if;
ls_state = right(ddlb_1.text,2)


if cb_2.text = "&Query" then
	lb_neworder = true
	if dw_1.modifiedcount() > 0 then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	dw_1.reset()
	lb_query = true
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('epd_startslab')
	cb_2.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_neworder =false
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user,ls_state)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gtehrf004
integer x = 2222
integer y = 8
integer width = 270
integer height = 100
integer taborder = 30
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
end if

dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false


if trim(ddlb_1.text) = "" or isnull(ddlb_1.text) then 
	messagebox('Error At State ','The State Should Not Be Blank, Please Check...!')
	return -1
end if;
ls_state = right(ddlb_1.text,2)

if isdate(em_1.text) = false then
	messagebox('Error :','Please Enter Valid From Date')
	rollback using sqlca;
	return 1;
else
	ld_frdt=datetime(em_1.text)	
end if;	

if f_check_fin_yr(ld_frdt) = -1 then;	return 1;end if;

select distinct 'x' into :ls_temp from fb_empptaxdeduction
where  epd_state_code = :ls_state and epd_dt_from > :ld_frdt and epd_dt_to is null;
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Tax Details',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode  = 0 then
		messagebox("Warning!","Record Already Exists From Greater Than This Date, Please Check !!!")
		return 1
	end if

///////////

dw_1.reset()

	ld_startslab=0;	ld_endslab=0;	ld_ptax=0;
	
	declare c1 cursor for
	select EPD_STARTSLAB, EPD_ENDSLAB, EPD_PTAX
       from fb_empptaxdeduction where EPD_STATE_CODE=:ls_state and EPD_DT_TO is null
	order by 1 ;
	 
	open c1;
	
	IF sqlca.sqlcode = 0 THEN
		fetch c1 into :ld_startslab,:ld_endslab,:ld_ptax;
		
		do while sqlca.sqlcode <> 100
					
			dw_1.scrolltorow(dw_1.insertrow(0))
			dw_1.setitem(dw_1.getrow(),'epd_startslab',ld_startslab)
			dw_1.setitem(dw_1.getrow(),'epd_endslab',ld_endslab)
			dw_1.setitem(dw_1.getrow(),'epd_ptax',ld_ptax)
			dw_1.setitem(dw_1.getrow(),'epd_entry_by',gs_user)
			dw_1.setitem(dw_1.getrow(),'epd_entry_dt',datetime(today()))
			dw_1.setitem(dw_1.getrow(),'epd_state_code',ls_state)
			dw_1.setitem(dw_1.getrow(),'epd_dt_from',ld_frdt)	         
			
			ld_startslab=0;	ld_endslab=0;	ld_ptax=0;	
			fetch c1 into :ld_startslab,:ld_endslab,:ld_ptax;
		loop
		close c1;	
	end if
///////////

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'epd_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'epd_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'epd_state_code',ls_state)
	dw_1.setitem(dw_1.getrow(),'epd_dt_from',ld_frdt)	                
	dw_1.setcolumn('epd_startslab')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'epd_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'epd_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'epd_state_code',ls_state)
	dw_1.setitem(dw_1.getrow(),'epd_dt_from',ld_frdt)
	dw_1.setcolumn('epd_startslab')
end if


end event

type dw_1 from datawindow within w_gtehrf004
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 120
integer width = 3726
integer height = 2052
integer taborder = 40
string dataobject = "dw_gtehrf004"
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
		dw_1.setitem(newrow,'epd_entry_by',gs_user)
		dw_1.setitem(newrow,'epd_entry_dt',datetime(today()))
		dw_1.setitem(newrow,'epd_state_code',dw_1.getitemstring(currentrow,'epd_state_code'))
		dw_1.setitem(newrow,'epd_dt_from',dw_1.getitemdatetime(currentrow,'epd_dt_from'))
		dw_1.setcolumn('epd_startslab')		
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_1.deleterow(dw_1.getrow())
	end if
	if dw_1.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

end event

event ue_keydwn;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_1.deleterow(dw_1.getrow())
	end if
	if dw_1.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

end event

event itemchanged;if lb_query = false then
	
	if dwo.name = 'epd_startslab'  then
		ld_stslab = double(data)
		ld_edslab = dw_1.getitemnumber(row,'epd_endslab')	
		ls_statecd = dw_1.getitemstring(row,'epd_state_code')	
		if  wf_check_duplicate_rec(ld_stslab,ld_edslab) = -1 then return 1
		
		
		select distinct epd_startslab,epd_endslab into :ld_stslab1, :ld_edslab1 from fb_empptaxdeduction
		where EPD_STATE_CODE=:ls_statecd and 
		           :ld_stslab between epd_startslab and epd_endslab  and 
			      epd_dt_from = :ld_frdt and epd_dt_to is null;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Slab Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 0 then
			messagebox('Warning!','Start Slab Should Not Be Between The Existing Start And End Slab ('+string(ld_stslab1)+' - '+string(ld_edslab1)+') , Please Check !!!')
			return 1
		end if
	end if
	
	if dwo.name = 'epd_endslab'  then
		ld_edslab = double(data)
		ld_stslab = dw_1.getitemnumber(row,'epd_startslab')

		if ld_edslab < ld_stslab then
			messagebox('Warning!','End Slab Should Be > Start Slab, Please Check !!!')
			return 1
		end if
	end if
	
//	if dwo.name = 'epd_dt_from'  then
//		ld_frdt = datetime(data)
//		ld_stslab = dw_1.getitemnumber(row,'epd_startslab')
//		ld_edslab = dw_1.getitemnumber(row,'epd_endslab')	
//		if  wf_check_duplicate_rec(ld_stslab,ld_edslab) = -1 then return 1
//		
//		select distinct 'x' into :ls_temp from fb_empptaxdeduction
//		where epd_startslab = :ld_stslab and epd_endslab = :ld_edslab and epd_dt_from >= :ld_frdt and epd_dt_to is null;
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Tax Details',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		elseif sqlca.sqlcode  = 0 then
//			messagebox("Warning!","Record Already Exists, Please Check !!!")
//			return 1
//		end if
//	end if
	
	dw_1.setitem(row,'epd_entry_by',gs_user)
	dw_1.setitem(row,'epd_entry_dt',datetime(today()))

	if ll_user_level <> 3 then	
		cb_3.enabled = true
	else
		cb_3.enabled = false
	end if
end if

if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
	dw_1.insertrow(0)
end if

end event

event updatestart;//
integer li_column, li_row // variables to hold the column index and row number
string ls_old_value, ls_new_value // variables to hold the old and new values
long ll_coumnid
string ls_columnname,ls_unique_id




// Loop through all rows in the DataWindow control
FOR li_row = 1 TO This.RowCount()
//SELECT max(COLUMN_ID) COLUMN_id, into :ll_cnt  FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fb_teamadeproduct') and column_id not in (9,10);
////ll_no =  
//    // Loop through all data columns in the DataWindow control
//    FOR li_column = 1 TO ll_cnt
//
//        // Get the old value for the data column
//        ls_old_value = dw_1.GetItemString(li_row, li_column, Primary!, true)
//
//        // Get the new value for the data column
//        ls_new_value = This.GetItemString(li_row, li_column)
//
//        // Compare the old and new values
//        if ls_old_value <> ls_new_value then
//            // Code to execute if the values are different
//				
//				insert into fb_log(OBJECT, SUBOBJECT, U_ACTION, U_FIELD, U_OLDVALUE, U_NEWVALUE, U_USERCODE, U_DATE, U_COMMENT) values
//				('fb_teamadeproduct','fb_teamadeproduct','U',:li_column,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
//				if sqlca.sqlcode = -1 then
//							messagebox("SQL Error : While Inserting Into LOg Table ",SQLCA.SQLErrtext,Information!)
//							rollback using sqlca;
//							return -1 
//				end if		
//				
//				
//				
//        end if
//
//    NEXT

DECLARE c1 CURSOR FOR  

SELECT COLUMN_ID,COLUMN_Name FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fb_empptaxdeduction');

close c1;
open c1;
if sqlca.sqlcode = -1 then
				messagebox('Error', 'Error occured while opening cursor c1 : '+sqlca.sqlerrtext)
				rollback using sqlca;
				return 1;
		
elseIF sqlca.sqlcode = 0 THEN
	setnull(ll_coumnid);setnull(ls_columnname);
	fetch c1 into :ll_coumnid,:ls_columnname;

		do while sqlca.sqlcode <> 100
 			// Get the old value for the data column
			       ls_old_value = dw_1.GetItemString(li_row, ll_coumnid, Primary!, true)
			 // Get the new value for the data column
			       ls_new_value = This.GetItemString(li_row, ll_coumnid)
			
			// Get the unique Value of Row
			
			ls_unique_id=dw_1.GetItemString(li_row, 1, Primary!, true)
					 
					 
					 if ls_old_value <> ls_new_value then
						insert into fb_log(table_name, Unique_key, U_ACTION, U_FIELD, U_OLDVALUE, U_NEWVALUE, U_USERCODE, U_DATE, U_COMMENT) values
												('fb_empptaxdeduction',:ls_unique_id,'U',:ls_columnname,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
							if sqlca.sqlcode = -1 then
								messagebox("SQL Error : While Inserting Into Log Table ",SQLCA.SQLErrtext,Information!)
								rollback using sqlca;
								return -1 
							 end if
						end if
					 
					 
					 
		setnull(ll_coumnid);setnull(ls_columnname);

	fetch c1 into :ll_coumnid,:ls_columnname;
	loop
end if	
NEXT
close c1;

end event

