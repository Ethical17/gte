$PBExportHeader$w_gtelaf009.srw
forward
global type w_gtelaf009 from window
end type
type cb_5 from commandbutton within w_gtelaf009
end type
type st_1 from statictext within w_gtelaf009
end type
type em_1 from editmask within w_gtelaf009
end type
type cb_4 from commandbutton within w_gtelaf009
end type
type cb_3 from commandbutton within w_gtelaf009
end type
type cb_2 from commandbutton within w_gtelaf009
end type
type cb_1 from commandbutton within w_gtelaf009
end type
type dw_1 from datawindow within w_gtelaf009
end type
end forward

global type w_gtelaf009 from window
integer width = 5170
integer height = 2280
boolean titlebar = true
string title = "(w_gtelaf009) Ration Chart"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_5 cb_5
st_1 st_1
em_1 em_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gtelaf009 w_gtelaf009

type variables
long ll_ctr,net, ll_cnt, ll_year, ll_last,ll_nod,ll_user_level
string ls_temp,ls_name,ls_last,ls_type,ls_id,ls_div,ls_mmflag
boolean lb_neworder, lb_query
double ld_rwt,ld_rrt,ld_ramt,ld_awt,ld_art,ld_aamt
datetime ld_dt,ld_frdt

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_div, string fs_mmflag, string fs_type, long fl_nowd, datetime fl_frdt)
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
	if (isnull(dw_1.getitemstring(fl_row,'field_id')) or  len(dw_1.getitemstring(fl_row,'field_id'))=0 or &
		 isnull(dw_1.getitemstring(fl_row,'lrc_majorminorflag')) or  len(dw_1.getitemstring(fl_row,'lrc_majorminorflag'))=0 or &
		 isnull(dw_1.getitemstring(fl_row,'lrc_labourtype')) or  len(dw_1.getitemstring(fl_row,'lrc_labourtype'))=0 or &
		 isnull(dw_1.getitemnumber(fl_row,'lrc_noworkdays')) or  dw_1.getitemnumber(fl_row,'lrc_noworkdays')=0 or & 
		 isnull(dw_1.getitemnumber(fl_row,'lrc_minworkdays')) or  dw_1.getitemnumber(fl_row,'lrc_minworkdays')=0) then
	    messagebox('Warning: One Of The Following Fields Are Blank', 'Division, Ration For, Type, Working days, Please Check !!!')
		 return -1
	end if
end if
return 1
end function

public function integer wf_check_duplicate_rec (string fs_div, string fs_mmflag, string fs_type, long fl_nowd, datetime fl_frdt);long fl_row,ll_nod1
string ls_div1,ls_mmflg1,ls_type1
datetime ld_frdt1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_div1 = dw_1.getitemstring(fl_row,'field_id')
		ls_mmflg1 = dw_1.getitemstring(fl_row,'lrc_majorminorflag')
		ls_type1 = dw_1.getitemstring(fl_row,'lrc_labourtype')
		ll_nod1 = dw_1.getitemnumber(fl_row,'lrc_noworkdays')
		ld_frdt1 = dw_1.getitemdatetime(fl_row,'lrc_frdt')
		
		if ls_div1 = fs_div and ls_mmflg1 = fs_mmflag and ls_type1 = fs_type and ll_nod1 = fl_nowd and ld_frdt1 = fl_frdt then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gtelaf009.create
this.cb_5=create cb_5
this.st_1=create st_1
this.em_1=create em_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_5,&
this.st_1,&
this.em_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gtelaf009.destroy
destroy(this.cb_5)
destroy(this.st_1)
destroy(this.em_1)
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

if GS_USER <> 'ADMIN' and GS_USER <> 'PARIDA' then
	dw_1.settaborder( 'field_id', 0)
	dw_1.settaborder( 'lrc_majorminorflag', 0)
	dw_1.settaborder( 'lrc_labourtype', 0)
	dw_1.settaborder( 'lrc_noworkdays', 0)
	dw_1.settaborder( 'lrc_minworkdays', 0)
	dw_1.settaborder( 'lrc_ricewt', 0)
	dw_1.settaborder( 'lrc_ricerate', 0)
	dw_1.settaborder( 'lrc_attawt', 0)
	dw_1.settaborder( 'lrc_attarate', 0)
	dw_1.settaborder( 'lrc_frdt', 0)
end if 

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

type cb_5 from commandbutton within w_gtelaf009
integer x = 1682
integer y = 12
integer width = 411
integer height = 100
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "&Replicate Data"
end type

event clicked;if isnull(em_1.text) then
	messagebox('Warning!','Please Enter Valid Date !!!')
	return 1
end if

ld_dt = datetime(em_1.text)

select distinct 'x' into :ls_temp from fb_labourrationchart where trunc(lrc_frdt) >= trunc(:ld_dt);
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Details',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
elseif sqlca.sqlcode  = 0 then
	messagebox('Warning!','Record Already Exists For This Date, Please Enter A Future Date!!!')
	return 1
end if

dw_1.settransobject(sqlca)
dw_1.reset()

setnull(ls_mmflag);setnull(ls_type);ld_rwt = 0;ld_awt = 0; ld_rrt = 0;ld_art = 0; ll_nod = 0; setnull(ls_div); ld_ramt = 0; ld_aamt = 0;

declare c1 cursor for
select LRC_MAJORMINORFLAG, LRC_LABOURTYPE, LRC_RICEWT, LRC_ATTAWT, LRC_RICERATE, LRC_ATTARATE, LRC_NOWORKDAYS, 
		FIELD_ID, LRC_RICEAMO, LRC_ATTAAMO 
from  fb_labourrationchart where LRC_TODT is null and nvl(LRC_ACTIVE_IND,'Y') = 'Y'
order by 1 asc;
	
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_mmflag,:ls_type,:ld_rwt,:ld_awt, :ld_rrt, :ld_art, :ll_nod,:ls_div, :ld_ramt, :ld_aamt;
	
	do while sqlca.sqlcode <> 100
				
		dw_1.scrolltorow(dw_1.insertrow(0))
		dw_1.setitem(dw_1.getrow(),'field_id',ls_div)
		dw_1.setitem(dw_1.getrow(),'lrc_majorminorflag',ls_mmflag)
		dw_1.setitem(dw_1.getrow(),'lrc_labourtype',ls_type)
		dw_1.setitem(dw_1.getrow(),'lrc_ricewt',ld_rwt)
		dw_1.setitem(dw_1.getrow(),'lrc_attawt',ld_awt)
		dw_1.setitem(dw_1.getrow(),'lrc_ricerate',ld_rrt)
		dw_1.setitem(dw_1.getrow(),'lrc_attarate',ld_art)
		dw_1.setitem(dw_1.getrow(),'lrc_noworkdays',ll_nod)
		dw_1.setitem(dw_1.getrow(),'lrc_minworkdays',2.5)
		dw_1.setitem(dw_1.getrow(),'lrc_adultallow','YES')
		dw_1.setitem(dw_1.getrow(),'lrc_childallallow','YES')
		dw_1.setitem(dw_1.getrow(),'lrc_riceamo',ld_ramt)
		dw_1.setitem(dw_1.getrow(),'lrc_attaamo',ld_aamt)
		dw_1.setitem(dw_1.getrow(),'lrc_active_ind','Y')
		dw_1.setitem(dw_1.getrow(),'lrc_frdt',ld_dt)	
		dw_1.setitem(dw_1.getrow(),'lrc_entry_by',gs_user)
		dw_1.setitem(dw_1.getrow(),'lrc_entry_dt',ld_dt)

		
		setnull(ls_mmflag);setnull(ls_type);ld_rwt = 0;ld_awt = 0; ld_rrt = 0;ld_art = 0; ll_nod = 0; setnull(ls_div); ld_ramt = 0; ld_aamt = 0;
		
		fetch c1 into :ls_mmflag,:ls_type,:ld_rwt,:ld_awt, :ld_rrt, :ld_art, :ll_nod,:ls_div, :ld_ramt, :ld_aamt;
	loop
	close c1;
	dw_1.scrolltorow(1)	
end if


end event

type st_1 from statictext within w_gtelaf009
integer x = 1125
integer y = 32
integer width = 206
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Date :"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_1 from editmask within w_gtelaf009
integer x = 1349
integer y = 20
integer width = 302
integer height = 84
integer taborder = 50
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
end type

event modified;if isnull(em_1.text) then
	messagebox('Warning!','Please Enter Valid Date !!!')
	return 1
else
	cb_5.enabled = true
end if
end event

type cb_4 from commandbutton within w_gtelaf009
integer x = 809
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

type cb_3 from commandbutton within w_gtelaf009
integer x = 544
integer y = 12
integer width = 265
integer height = 100
integer taborder = 30
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

IF (isnull(dw_1.getitemstring(dw_1.rowcount(),'field_id')) or len(dw_1.getitemstring(dw_1.rowcount(),'field_id'))=0) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
	if dw_1.rowcount() > 0 then
		IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
			return 1
		END IF
	end if
	
	if dw_1.rowcount() > 0 then
		for ll_ctr = 1 to dw_1.rowcount( ) 
			ls_div = dw_1.getitemstring(ll_ctr,'field_id')
			ls_mmflag = dw_1.getitemstring(ll_ctr,'lrc_majorminorflag')
			ls_type = dw_1.getitemstring(ll_ctr,'lrc_labourtype')
			ll_nod = dw_1.getitemnumber(ll_ctr,'lrc_noworkdays')
			ld_frdt = dw_1.getitemdatetime(ll_ctr,'lrc_frdt')
					
			select distinct 'x' into :ls_temp from fb_labourrationchart
			 where field_id = :ls_div and lrc_majorminorflag = :ls_mmflag and lrc_labourtype = :ls_type and lrc_noworkdays = :ll_nod and lrc_frdt >= :ld_frdt and lrc_todt is null;
			
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Rate Details',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode  = 0 then
				messagebox("Warning!","Record Already Exists, Please Check !!!")
				return 1
			end if
			
		     update fb_labourrationchart set lrc_todt = (:ld_frdt - 1), lrc_active_ind = 'N'
			 where field_id = :ls_div and lrc_majorminorflag = :ls_mmflag and lrc_labourtype = :ls_type and lrc_noworkdays = :ll_nod  and lrc_todt is null and lrc_frdt < :ld_frdt;
			 
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

type cb_2 from commandbutton within w_gtelaf009
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
	dw_1.setcolumn('field_id')
	cb_2.text = "&Run"
	dw_1.settaborder( 'lrc_frdt', 0)
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_neworder =false
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user)
	dw_1.SetRedraw (TRUE)
	dw_1.settaborder( 'lrc_frdt', 0)
	cb_2.text = "&Query"
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gtelaf009
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
end if

dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false
dw_1.settaborder( 'lrc_frdt', 90)

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'lrc_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'lrc_entry_dt',datetime(today()))
	dw_1.setcolumn('field_id')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'lrc_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'lrc_entry_dt',datetime(today()))
	dw_1.setcolumn('field_id')
end if


end event

type dw_1 from datawindow within w_gtelaf009
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 116
integer width = 5024
integer height = 2052
string dataobject = "dw_gtelaf009"
boolean hscrollbar = true
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
		dw_1.setitem(newrow,'lrc_entry_by',gs_user)
		dw_1.setitem(newrow,'lrc_entry_dt',datetime(today()))
		dw_1.setcolumn('field_id')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_1.deleterow(dw_1.rowcount())
	end if
	if dw_1.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

end event

event ue_keydwn;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_1.deleterow(dw_1.rowcount())
	end if
	if dw_1.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

end event

event itemchanged;if lb_query = false then
	if dwo.name = 'lrc_noworkdays'  then
		ll_nod = long(data)
		ls_div = dw_1.getitemstring(row,'field_id')
		ls_mmflag = dw_1.getitemstring(row,'lrc_majorminorflag')
		ls_type = dw_1.getitemstring(row,'lrc_labourtype')

		
		if f_check_initial_space(string(ll_nod)) = -1 then return 1
		
		select distinct LRC_RICEWT, LRC_ATTAWT, LRC_RICERATE, LRC_ATTARATE, LRC_RICEAMO, LRC_ATTAAMO
		into :ld_rwt,:ld_awt, :ld_rrt, :ld_art, :ld_ramt, :ld_aamt 
		from fb_labourrationchart 
		where field_id = :ls_div and trim(lrc_majorminorflag) = :ls_mmflag and trim(lrc_labourtype) = :ls_type and lrc_noworkdays = :ll_nod and lrc_todt is null;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Ration Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 0 then
			if isnull(ld_rwt) then ld_rwt = 0;
			if isnull(ld_awt) then ld_awt = 0;
			if isnull(ld_rrt) then ld_rrt = 0;
			if isnull(ld_art) then ld_art = 0;
			if isnull(ld_ramt) then ld_ramt = 0;
			if isnull(ld_aamt) then ld_aamt = 0;

			dw_1.setitem(row,'lrc_ricewt',ld_rwt)
			dw_1.setitem(row,'lrc_attawt',ld_awt)
			dw_1.setitem(row,'lrc_ricerate',ld_rrt)
			dw_1.setitem(row,'lrc_attarate',ld_art)
			dw_1.setitem(row,'lrc_riceamo',ld_ramt)
			dw_1.setitem(row,'lrc_attaamo',ld_aamt)
		elseif sqlca.sqlcode = 100 then
			ld_rwt = 0;	ld_awt = 0;	ld_rrt = 0; ld_art = 0; ld_ramt = 0; ld_aamt = 0;

			dw_1.setitem(row,'lrc_ricewt',ld_rwt)
			dw_1.setitem(row,'lrc_attawt',ld_awt)
			dw_1.setitem(row,'lrc_ricerate',ld_rrt)
			dw_1.setitem(row,'lrc_attarate',ld_art)
			dw_1.setitem(row,'lrc_riceamo',ld_ramt)
			dw_1.setitem(row,'lrc_attaamo',ld_aamt)
		end if
	end if
	
	if dwo.name = 'lrc_ricewt'  then
		ld_rwt = double(data)
		ld_rrt = dw_1.getitemnumber(row,'lrc_ricerate')
				
		if isnull(ld_rwt) then ld_rwt = 0
		if isnull(ld_rrt) then ld_rrt = 0	
		ld_ramt = round((ld_rwt * ld_rrt),2)
		dw_1.setitem(row,'lrc_riceamo',ld_ramt)
	end if
	
	if dwo.name = 'lrc_ricerate'  then
		ld_rrt = double(data)
		ld_rwt = dw_1.getitemnumber(row,'lrc_ricewt')
				
		if isnull(ld_rwt) then ld_rwt = 0
		if isnull(ld_rrt) then ld_rrt = 0	
		ld_ramt = round((ld_rwt * ld_rrt),2)
		dw_1.setitem(row,'lrc_riceamo',ld_ramt)
	end if
	
	if dwo.name = 'lrc_attawt'  then
		ld_awt = double(data)
		ld_art = dw_1.getitemnumber(row,'lrc_attarate')
				
		if isnull(ld_awt) then ld_awt = 0
		if isnull(ld_art) then ld_art = 0	
		ld_aamt = round((ld_awt * ld_art),2)
		dw_1.setitem(row,'lrc_attaamo',ld_aamt)
	end if
	
	if dwo.name = 'lrc_attarate'  then
		ld_art = double(data)
		ld_awt = dw_1.getitemnumber(row,'lrc_attawt')
				
		if isnull(ld_awt) then ld_awt = 0
		if isnull(ld_art) then ld_art = 0	
		ld_aamt = round((ld_awt * ld_art),2)
		dw_1.setitem(row,'lrc_attaamo',ld_aamt)
	end if
	
	if dwo.name = 'lrc_frdt' then
		ld_frdt = datetime(data)
		ll_nod = dw_1.getitemnumber(row,'lrc_noworkdays')
		ls_div = dw_1.getitemstring(row,'field_id')
		ls_mmflag = dw_1.getitemstring(row,'lrc_majorminorflag')
		ls_type = dw_1.getitemstring(row,'lrc_labourtype')

		if  wf_check_duplicate_rec(ls_div,ls_mmflag,ls_type,ll_nod,ld_frdt) = -1 then return 1
		
		select distinct 'x' into :ls_temp from fb_labourrationchart 
		where field_id = :ls_div and trim(lrc_majorminorflag) = :ls_mmflag and trim(lrc_labourtype) = :ls_type and lrc_noworkdays = :ll_nod and lrc_frdt = trunc(:ld_frdt);
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Ration Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 0 then
			messagebox('Warning!','Record Already Exists, Please Check !!!')
			return 1
		end if
	end if
	
	dw_1.setitem(row,'lrc_entry_by',gs_user)
	dw_1.setitem(row,'lrc_entry_dt',datetime(today()))

cb_3.enabled = true
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

SELECT COLUMN_ID,COLUMN_Name FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fb_labourrationchart');

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
												('fb_labourrationchart',:ls_unique_id,'U',:ls_columnname,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
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

