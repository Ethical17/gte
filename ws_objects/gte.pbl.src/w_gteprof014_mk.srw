$PBExportHeader$w_gteprof014_mk.srw
forward
global type w_gteprof014_mk from window
end type
type cb_7 from commandbutton within w_gteprof014_mk
end type
type cb_8 from commandbutton within w_gteprof014_mk
end type
type cb_9 from commandbutton within w_gteprof014_mk
end type
type cb_5 from commandbutton within w_gteprof014_mk
end type
type dw_2 from datawindow within w_gteprof014_mk
end type
type cb_4 from commandbutton within w_gteprof014_mk
end type
type cb_3 from commandbutton within w_gteprof014_mk
end type
type cb_2 from commandbutton within w_gteprof014_mk
end type
type cb_1 from commandbutton within w_gteprof014_mk
end type
type dw_1 from datawindow within w_gteprof014_mk
end type
end forward

global type w_gteprof014_mk from window
integer width = 4622
integer height = 2580
boolean titlebar = true
string title = "(w_gteprof014) Pack Tea"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_7 cb_7
cb_8 cb_8
cb_9 cb_9
cb_5 cb_5
dw_2 dw_2
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gteprof014_mk w_gteprof014_mk

type variables
long ll_ctr, ll_last,ll_last2,ll_from,ll_to,ll_ac_year, ll_lotno, ll_season,ll_user_level,ix
string ls_temp,ls_del_ind,ls_tmp_id, ls_tmp_id1,ls_entry_user,ls_cons,ls_last,ls_count, ls_tpc_id,ls_ref,ls_ltno
string ls_inv_no, ls_prefix, ls_grade,ls_count1,ls_id1,ls_id, ls_spid
boolean lb_neworder, lb_query
double ld_hrs, ld_gross, ld_tear, ld_net, ld_sostk
datetime ld_rundt,ld_maxpackdt, ld_dt
datawindowchild idw_grade
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_cat, string fs_grade)
public function integer wf_check_fillcol_a (integer fl_row)
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
	if (isnull(dw_1.getitemstring(fl_row,'dtp_source')) or  len(dw_1.getitemstring(fl_row,'dtp_source'))=0 or &
		isnull(dw_1.getitemstring(fl_row,'dtp_prefix')) or  len(dw_1.getitemstring(fl_row,'dtp_prefix'))=0 or &
		isnull(dw_1.getitemnumber(fl_row,'dtp_no')) or  dw_1.getitemnumber(fl_row,'dtp_no')=0 or &
		isnull(dw_1.getitemstring(fl_row,'dtp_packid')) or  len(dw_1.getitemstring(fl_row,'dtp_packid'))=0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Source, Prefix, Invoice No., Lot No., Pack Type, Please Check !!!')
		 return -1
	end if
end if
return 1




end function

public function integer wf_check_duplicate_rec (string fs_cat, string fs_grade);long fl_row
string ls_tpc_id1, ls_grade1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_tpc_id1 = dw_1.getitemstring(fl_row,'tpc_id')
		ls_grade1 = dw_1.getitemstring(fl_row,'tmp_id')
		
		if ls_tpc_id1 = fs_cat and ls_grade1 = fs_grade then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

public function integer wf_check_fillcol_a (integer fl_row);if dw_2.rowcount() > 0 and fl_row > 0 then
	if (isnull(dw_2.getitemstring(fl_row,'tpc_id')) or  len(dw_2.getitemstring(fl_row,'tpc_id'))=0 or &
		isnull(dw_2.getitemstring(fl_row,'tmp_id')) or  len(dw_2.getitemstring(fl_row,'tmp_id'))=0 or &
		 isnull(dw_2.getitemnumber(fl_row,'dtpd_srnostart')) or dw_2.getitemnumber(fl_row,'dtpd_srnostart') = 0 or &
		 isnull(dw_2.getitemnumber(fl_row,'dtpd_srnoend')) or dw_2.getitemnumber(fl_row,'dtpd_srnoend') = 0 or &
		 isnull(dw_2.getitemnumber(fl_row,'dtpd_indwt')) or dw_2.getitemnumber(fl_row,'dtpd_indwt') = 0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Tea Category, Grade, Mark on Package From & To, Gross Weight, Please Check !!!')
		 return -1
	end if
end if
return 1

end function

on w_gteprof014_mk.create
this.cb_7=create cb_7
this.cb_8=create cb_8
this.cb_9=create cb_9
this.cb_5=create cb_5
this.dw_2=create dw_2
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_7,&
this.cb_8,&
this.cb_9,&
this.cb_5,&
this.dw_2,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gteprof014_mk.destroy
destroy(this.cb_7)
destroy(this.cb_8)
destroy(this.cb_9)
destroy(this.cb_5)
destroy(this.dw_2)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
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

dw_2.GetChild ("tmp_id", idw_grade)
idw_grade.settransobject(sqlca)	

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

type cb_7 from commandbutton within w_gteprof014_mk
integer x = 4192
integer y = 20
integer width = 123
integer height = 88
integer taborder = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "<"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.ScrollPriorRow()
end if
end event

type cb_8 from commandbutton within w_gteprof014_mk
integer x = 4311
integer y = 20
integer width = 123
integer height = 88
integer taborder = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = ">"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.ScrollnextRow()
end if
end event

type cb_9 from commandbutton within w_gteprof014_mk
integer x = 4430
integer y = 20
integer width = 123
integer height = 88
integer taborder = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = ">>"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.ScrolltoRow(dw_1.rowcount())
end if
end event

type cb_5 from commandbutton within w_gteprof014_mk
integer x = 4073
integer y = 20
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
	dw_1.ScrolltoRow(1)
end if
end event

type dw_2 from datawindow within w_gteprof014_mk
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 9
integer y = 788
integer width = 4553
integer height = 1260
integer taborder = 40
string dataobject = "dw_gteprof014a_mk"
boolean vscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_2.rowcount() then
		IF wf_check_fillcol_a(currentrow) = -1 THEN
			return 1
		END IF
	END If
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;if lb_query = false then
	
	if dwo.name = 'tpc_id' then
		idw_grade.SetFilter ("tpc_id = '"+trim(data)+"'")
		idw_grade.settransobject(sqlca)	
		idw_grade.retrieve()		
	end if
	
	if dwo.name = 'tmp_id' then
		ls_grade = data
		ls_tpc_id = dw_2.getitemstring(row,'tpc_id')
		//if  wf_check_duplicate_rec(ls_tpc_id,ls_grade) = -1 then return 1
		idw_grade.accepttext( )
		ld_sostk = idw_grade.getitemnumber(idw_grade.getrow(),'sortstocktodate')
		dw_2.setitem(row,'dtpd_sortedstk',ld_sostk)	
	end if
	
	if dwo.name = 'dtpd_mfg_frdt' or dwo.name = 'dtpd_mfg_todt' then
		ld_dt = dw_1.getitemdatetime(dw_1.getrow(),'dtp_date')
		if not isnull(dw_1.getitemdatetime(dw_1.getrow(),'dtp_date')) then
			if ld_dt <= datetime(data) then
				messagebox('Warning','Manufacturing From and To date should be smaller than packing date')
				return 1
			end if
		end if
		
		if dwo.name = 'dtpd_mfg_frdt' then
			if not isnull(dw_2.getitemdatetime(row,'dtpd_mfg_todt')) then
				if dw_2.getitemdatetime(row,'dtpd_mfg_todt') < datetime(data) then
					messagebox('Warning','Manufacturing From Date should be smaller than To date')
					return 1
				end if 
			end if
		end if
		
		if dwo.name = 'dtpd_mfg_todt' then
			if not isnull(dw_2.getitemdatetime(row,'dtpd_mfg_frdt')) then
				if dw_2.getitemdatetime(row,'dtpd_mfg_frdt') > datetime(data) then
					messagebox('Warning','Manufacturing From Date should be smaller than To date')
					return 1
				end if 
			end if
		end if
	end if
	
	if dwo.name = 'dtpd_srnostart' then
		ll_from = long(data)
//		select distinct 'x' into :ls_temp from fb_dtpdetails where :ll_from between DTPD_SRNOSTART and DTPD_SRNOEND;
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Start No details !',sqlca.sqlerrtext)
//			return 1
//		elseif sqlca.sqlcode = 0 then
//			messagebox('Warniing !' ,'This Start No. Already Exists, Please Check !!!')
//			return 1			
//		end if
		
		ll_to = dw_2.getitemnumber(row,'dtpd_srnoend')
		ld_gross = dw_2.getitemnumber(row,'dtpd_indwt')
		ld_tear = dw_2.getitemnumber(row,'dtpd_chestwt')
		
		if ((ll_to - ll_from) +1) > 0 then
			dw_2.setitem(row,'nop',((ll_to - ll_from) +1))
			if (ld_gross - ld_tear) * ((ll_to - ll_from) +1) > ld_sostk then
				messagebox('Warning!','Packing Quantity ('+string((ld_gross - ld_tear) * ((ll_to - ll_from) +1)) +') Should Not Be Greater Than Sorted Stock ('+string(ld_sostk)+') Available, Please Check !!!')
				return 1
			end if

			dw_2.setitem(row,'net_wt',(ld_gross - ld_tear))
			dw_2.setitem(row,'indwttotal',(ld_gross) * ((ll_to - ll_from) +1))
			dw_2.setitem(row,'netwttotal',(ld_gross - ld_tear) * ((ll_to - ll_from) +1))			
		end if
	end if

	if dwo.name = 'dtpd_srnoend' then
		ll_to = long(data)
//		select distinct 'x' into :ls_temp from fb_dtpdetails where :ll_to between DTPD_SRNOSTART and DTPD_SRNOEND;
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting End No details !',sqlca.sqlerrtext)
//			return 1
//		elseif sqlca.sqlcode = 0 then
//			messagebox('Warniing !' ,'This End No. Already Exists, Please Check !!!')
//			return 1			
//		end if
		
		ll_from = dw_2.getitemnumber(row,'dtpd_srnostart')
		ld_gross = dw_2.getitemnumber(row,'dtpd_indwt')
		ld_tear = dw_2.getitemnumber(row,'dtpd_chestwt')

		if ((ll_to - ll_from) +1) > 0 then
			dw_2.setitem(row,'nop',((ll_to - ll_from) +1))
			
			if (ld_gross - ld_tear) * ((ll_to - ll_from) +1) > ld_sostk then
				messagebox('Warning!','Packing Quantity ('+string((ld_gross - ld_tear) * ((ll_to - ll_from) +1)) +') Should Not Be Greater Than Sorted Stock ('+string(ld_sostk)+') Available, Please Check !!!')
				return 1
			end if

			dw_2.setitem(row,'net_wt',(ld_gross - ld_tear))
			dw_2.setitem(row,'indwttotal',(ld_gross) * ((ll_to - ll_from) +1))
			dw_2.setitem(row,'netwttotal',(ld_gross - ld_tear) * ((ll_to - ll_from) +1))
			
		else
			messagebox('Warning!','Mark on Package From Should Be <= Mark on Package To, Please Check !!!')
			return 1
		end if
	end if
	
	
	
	if dwo.name = 'dtpd_indwt' then
		ld_gross = double(data)
		ld_tear = dw_2.getitemnumber(row,'dtpd_chestwt')
		ll_to 	  = dw_2.getitemnumber(row,'dtpd_srnoend')
		ll_from = dw_2.getitemnumber(row,'dtpd_srnostart')
		
		if ld_tear > ld_gross then
			messagebox('Warning!','Tare Weight Should Not Be Greater Than Gross Weight, Please Check !!!')
			return 1
		else
			if idw_grade.getrow() > 0 then
				ld_sostk = idw_grade.getitemnumber(idw_grade.getrow(),'sortstocktodate')
			end if
			if isnull(ld_sostk) then ld_sostk = 0
			if ld_sostk = 0 then
				messagebox('Warning!','There Is No Stock For This Grade, Please Check !!!')
				return 1
			else
				if (ld_gross - ld_tear) * ((ll_to - ll_from) +1) > ld_sostk then
					messagebox('Warning!','Packing Quantity ('+string((ld_gross - ld_tear) * ((ll_to - ll_from) +1)) +') Should Not Be Greater Than Sorted Stock ('+string(ld_sostk)+') Available, Please Check !!!')
					return 1
				end if
			end if
			dw_2.setitem(row,'net_wt',(ld_gross - ld_tear))
			dw_2.setitem(row,'indwttotal',(ld_gross) * ((ll_to - ll_from) +1))
			dw_2.setitem(row,'netwttotal',(ld_gross - ld_tear) * ((ll_to - ll_from) +1))
			
		end if
	end if
	
	if dwo.name = 'dtpd_chestwt' then
		ld_tear = double(data)
		ld_gross = dw_2.getitemnumber(row,'dtpd_indwt')
		
		if ld_tear > ld_gross then
			messagebox('Warning!','Tare Weight Should Not Be Greater Than Gross Weight, Please Check !!!')
			return 1
		else
			dw_2.setitem(row,'net_wt',(ld_gross - ld_tear))
			dw_2.setitem(row,'indwttotal',(ld_gross) * ((ll_to - ll_from) +1))
			dw_2.setitem(row,'netwttotal',(ld_gross - ld_tear) * ((ll_to - ll_from) +1))
		end if
	end if
	
	
		ls_spid = dw_1.getitemstring(dw_1.getrow(),'dtp_packid')
		setnull(ld_tear)
		
		select SP_TAREWT into :ld_tear from fb_storeproduct where SP_ID = :ls_spid;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Tare Weight !',sqlca.sqlerrtext)
			return 1
		end if
		if isnull(ld_tear) then ld_tear = 0;
		dw_2.setitem(row,'dtpd_chestwt',ld_tear)
		dw_2.setitem(row,'sp_id',ls_spid)

end if	

if lb_query = false then
 if lb_neworder = true then	
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
end if
end if



if dw_2.getrow() = dw_2.rowcount() and lb_neworder =true then
	dw_2.insertrow(0)
end if

cb_3.enabled = true
end event

type cb_4 from commandbutton within w_gteprof014_mk
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

type cb_3 from commandbutton within w_gteprof014_mk
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
if dw_2.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

IF (isnull(dw_2.getitemnumber(dw_2.rowcount(),'dtpd_srnostart')) or dw_2.getitemnumber(dw_2.rowcount(),'dtpd_srnostart')=0) THEN
	 dw_2.deleterow(dw_2.rowcount())
END IF

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN	
	ll_lotno = 0;ll_last=0;ll_last2=0
	
	if dw_1.rowcount() > 0 then
		IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
			return 1
		END IF
	end if	

	if dw_1.rowcount() > 0 then		 
		for ll_ctr = 1 to dw_1.rowcount( ) 
			if dw_1.getitemstatus(ll_ctr,0,primary!) = NewModified! or dw_1.getitemstatus(ll_ctr,0,primary!) = New! or dw_1.getitemstatus(ll_ctr,0,primary!) = DataModified! then
				if dw_1.getitemstatus(ll_ctr,0,primary!) = NewModified! or dw_1.getitemstatus(ll_ctr,0,primary!) = New! then
					ll_season = dw_1.getitemnumber(ll_ctr,'dtp_season')
					ll_lotno = dw_1.getitemnumber(ll_ctr,'dtp_no')
					
					ls_prefix = dw_1.getitemstring(ll_ctr,'dtp_prefix')
					
					ls_inv_no = ls_prefix+'-'+string(ll_lotno)+'/'+right(string(ll_season),2)
					dw_1.setitem(ll_ctr,'dtp_no',ll_lotno)
					dw_1.setitem(ll_ctr,'dtp_lotno',ls_inv_no)
					if ll_last=0 then
						select nvl(MAX(substr(dtp_id,4,10)),0) into :ll_last from fb_dailyteapacked;
					end if
					if ll_last2=0 then
						select nvl(MAX(substr(dtpd_id,5,8)),0) into :ll_last2 from fb_dtpdetails;
					end if
					ll_last = ll_last + 1
					ls_tmp_id = 'DTP'+string(ll_last,'0000000000')
					dw_1.setitem(ll_ctr,'dtp_id',ls_tmp_id)
					for ix = 1 to dw_2.rowcount()
						ll_last2 = ll_last2 + 1
						ls_tmp_id1 = 'DTPD'+string(ll_last2,'00000000')
						dw_2.setitem(ix,'dtpd_id',ls_tmp_id1)
						dw_2.setitem(ix,'dtp_id',ls_tmp_id)
						ld_tear = dw_2.getitemnumber(ix,'dtpd_chestwt')
						ld_gross = dw_2.getitemnumber(ix,'dtpd_indwt')
						dw_2.setitem(ix,'dtpd_indwt',(ld_gross - ld_tear))
					next
				end if
//				dtpd_indwt is net weight in old system so changed accordingly on 11/05/2012
			end if	// new or modify
		next
	end if
	
	if dw_1.update(true,false) = 1 and dw_2.update(true,false) = 1 then
		dw_2.resetupdate();
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

type cb_2 from commandbutton within w_gteprof014_mk
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

event clicked;select max(DTP_DATE) into :ld_maxpackdt from fb_dailyteapacked;
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Max Packing Date !!!',sqlca.sqlerrtext)
	return 1
end if

if cb_2.text = "&Query" then
	if dw_1.modifiedcount() > 0  then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	lb_query = true
	lb_neworder = true
	dw_1.reset()
	dw_2.reset()
	dw_1.settaborder('dtp_lotno',4)
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('dtp_source')
	cb_2.text = "&Run"
	cb_3.enabled = false
	cb_1.enabled = false
else
	lb_query = false
	lb_neworder = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user,date(ld_maxpackdt),gs_garden_snm)
 	dw_1.TriggerEvent(rowfocuschanged!)
	dw_1.SetRedraw (TRUE)
	dw_1.settaborder('dtp_lotno',0)
	cb_2.text = "&Query"
	cb_1.enabled = true
end if


end event

type cb_1 from commandbutton within w_gteprof014_mk
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

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
lb_neworder = true
lb_query = false

//select DTP_LOTNO into :ls_ltno from fb_dailyteapacked 
//where DTP_NO = (select max(DTP_NO)  from fb_dailyteapacked 
//							where DTP_SEASON =  (select DTP_SEASON from fb_dailyteapacked 
//																where DTP_ID = (select max(DTP_ID) from fb_dailyteapacked))) and 
// 		DTP_SEASON =  (select DTP_SEASON from fb_dailyteapacked where DTP_ID = (select max(DTP_ID) from fb_dailyteapacked));
//if sqlca.sqlcode = -1 then
//	messagebox('Error : While Getting Max Packing Invoice No ',sqlca.sqlerrtext)
//	rollback using sqlca;
//	return 1
//elseif sqlca.sqlcode  = 0 then
//	messagebox('Information !','Last Packing Invoice No Generated Is : ('+ls_ltno+')')
//end if	

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'dtp_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'gsn',gs_garden_snm)
	dw_1.setitem(dw_1.getrow(),'dtp_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'dtp_date',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'dtp_season',long(string(today(),'YYYY')))
	dw_1.setcolumn('dtp_source')
else
//	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
//		return 1
//	END IF
//	dw_1.scrolltorow(dw_1.insertrow(0))
//	dw_1.setfocus()
//	dw_1.setitem(dw_1.getrow(),'dtp_entry_by',gs_user)
//	dw_1.setitem(dw_1.getrow(),'gsn',gs_garden_snm)
//	dw_1.setitem(dw_1.getrow(),'dtp_entry_dt',datetime(today()))
//	dw_1.setitem(dw_1.getrow(),'dtp_date',datetime(today()))
//	dw_1.setitem(dw_1.getrow(),'dtp_season',long(string(today(),'YYYY')))
//	dw_1.setcolumn('dtp_source')
	messagebox('Warning','Save this record first then proceed for further entries.')
	return 1
end if


end event

type dw_1 from datawindow within w_gteprof014_mk
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 9
integer y = 124
integer width = 4553
integer height = 644
integer taborder = 30
string dataobject = "dw_gteprof014_mk"
end type

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;if lb_query = false then
	if dwo.name = 'dtp_no' then
		select max(DTP_DATE) into :ld_maxpackdt from fb_dailyteapacked;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Max Packing Date !!!',sqlca.sqlerrtext)
			return 1
		end if
		if date(dw_1.getitemdatetime(row,'dtp_date')) < date(ld_maxpackdt) then
			messagebox('Warning !','You Have Already Done Packing Entry Of Date '+string(ld_maxpackdt,'dd/mm/yyyy')+' ,So You cannot Do Entry Before This Date !!!')
			return 1
		end if	
	end if
	
	if dwo.name = 'dtp_date' then
		ld_dt = datetime(data)
		select max(DTP_DATE) into :ld_maxpackdt from fb_dailyteapacked;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Max Packing Date !!!',sqlca.sqlerrtext)
			return 1
		end if
		if date(data) < date(ld_maxpackdt) then
			messagebox('Warning !','You Have Already Done Packing Entry Of Date '+string(ld_maxpackdt,'dd/mm/yyyy')+' ,So You cannot Do Entry Before This Date !!!')
			return 1
		end if	
		if date(ld_dt) > today() then
			messagebox('Warning !','Packing date Should Not Be > Current Date, Please Check !!!')
			return
		end if
	end if
	
	
	if dwo.name = 'dtp_season' then
		ll_season= long(data)
		if ll_season < (long(string(today(),'YYYY')) - 1) or ll_season > (long(string(today(),'YYYY')) + 1) then
			messagebox('Warning!','Season Can Be Between (Current Year - 1 To Current Year + 1), Please Check !!!')
			return 1
		end if
	end if
	
	if dwo.name = 'dtp_packid' then
		ls_spid = data
		setnull(ld_tear)
		
		select SP_TAREWT into :ld_tear from fb_storeproduct where SP_ID = :ls_spid;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Tare Weight !',sqlca.sqlerrtext)
			return 1
		end if
		if isnull(ld_tear) then ld_tear = 0;
	end if
end if	

if lb_neworder = true and dw_2.rowcount() = 0 then
		dw_2.setfocus() 
		dw_2.insertrow(0)
		dw_1.setfocus()
end if;

cb_3.enabled = true
end event

event rowfocuschanged;if lb_query = false then
	if lb_neworder = false  then
		if dw_1.rowcount() > 0 then
			ls_ref = dw_1.getitemstring(dw_1.getrow(),'dtp_id')
			dw_2.reset()
			dw_2.Retrieve(gs_user,date(ld_maxpackdt),gs_garden_snm,ls_ref)
		end if
	end if
end if
end event

