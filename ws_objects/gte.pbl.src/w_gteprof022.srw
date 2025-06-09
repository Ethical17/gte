$PBExportHeader$w_gteprof022.srw
forward
global type w_gteprof022 from window
end type
type cbx_1 from checkbox within w_gteprof022
end type
type cb_4 from commandbutton within w_gteprof022
end type
type cb_3 from commandbutton within w_gteprof022
end type
type cb_2 from commandbutton within w_gteprof022
end type
type cb_1 from commandbutton within w_gteprof022
end type
type dw_1 from datawindow within w_gteprof022
end type
end forward

global type w_gteprof022 from window
integer width = 4622
integer height = 2276
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
cbx_1 cbx_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gteprof022 w_gteprof022

type variables
long ll_ctr, ll_last,ll_from,ll_to,ll_ac_year, ll_lotno, ll_season,ll_user_level, ll_dtp_no, ll_stno, ll_endno, ll_temp 
string ls_temp,ls_del_ind,ls_tmp_id, ls_tmp_id1,ls_entry_user,ls_cons,ls_last,ls_count, ls_tpc_id,ls_ref,ls_ltno, ls_prefixcheck, ls_invno, ls_dtp_id, ls_dtpd_id, ls_dtp_packid
string ls_inv_no, ls_prefix, ls_grade,ls_count1,ls_id1,ls_id, ls_spid, ld_dispind, ls_source, ls_locn, ls_sp_id,ls_appr_ind,ls_entry_by
boolean lb_neworder, lb_query
double ld_hrs, ld_gross, ld_tear, ld_net, ld_sostk, ld_indwt, ld_chestwt
datetime ld_rundt,ld_maxpackdt, ld_dt, ld_mfg_frdt, ld_mfg_todt
datawindowchild idw_grade



end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_cat, string fs_grade)
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
	if (isnull(dw_1.getitemstring(fl_row,'tpc_id')) or  len(dw_1.getitemstring(fl_row,'tpc_id'))=0 or &
		isnull(dw_1.getitemstring(fl_row,'dtp_source')) or  len(dw_1.getitemstring(fl_row,'dtp_source'))=0 or &
		isnull(dw_1.getitemstring(fl_row,'tmp_id')) or  len(dw_1.getitemstring(fl_row,'tmp_id'))=0 or &
		isnull(dw_1.getitemstring(fl_row,'dtp_packid')) or  len(dw_1.getitemstring(fl_row,'dtp_packid'))=0 or &
		 isnull(dw_1.getitemnumber(fl_row,'dtpd_srnostart')) or dw_1.getitemnumber(fl_row,'dtpd_srnostart') = 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'dtpd_srnoend')) or dw_1.getitemnumber(fl_row,'dtpd_srnoend') = 0 or &
		  isnull(dw_1.getitemdatetime(fl_row,'dtpd_mfg_frdt')) or isnull(dw_1.getitemdatetime(fl_row,'dtpd_mfg_todt')) or &
		 isnull(dw_1.getitemnumber(fl_row,'dtpd_indwt')) or dw_1.getitemnumber(fl_row,'dtpd_indwt') = 0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Source, Tea Category, Grade, Pack Type, Mark on Package From & To, Gross Weight, Mfg. From date, Mfg. To date Please Check !!!')
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

on w_gteprof022.create
this.cbx_1=create cbx_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cbx_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gteprof022.destroy
destroy(this.cbx_1)
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

//dw_1.GetChild ("tmp_id", idw_grade)
//idw_grade.settransobject(sqlca)	

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

type cbx_1 from checkbox within w_gteprof022
integer x = 1097
integer y = 24
integer width = 384
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Un-Approved"
boolean checked = true
end type

type cb_4 from commandbutton within w_gteprof022
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

type cb_3 from commandbutton within w_gteprof022
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

IF (isnull(dw_1.getitemnumber(dw_1.rowcount(),'dtpd_srnostart')) or dw_1.getitemnumber(dw_1.rowcount(),'dtpd_srnostart')=0) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN	
	ll_lotno = 0;ll_last=0	
	if dw_1.rowcount() > 0 then
		IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
			return 1
		END IF
	end if	

	if dw_1.rowcount() > 0 then		 
		for ll_ctr = 1 to dw_1.rowcount( ) 
			if dw_1.getitemstatus(ll_ctr,0,primary!) = NewModified! or dw_1.getitemstatus(ll_ctr,0,primary!) = New! or dw_1.getitemstatus(ll_ctr,0,primary!) = DataModified! then
				ll_season = dw_1.getitemnumber(ll_ctr,'dtp_season')
				ll_lotno = dw_1.getitemnumber(ll_ctr,'dtp_no')					
				ls_prefix = dw_1.getitemstring(ll_ctr,'dtp_prefix')				
				ls_inv_no = ls_prefix+'-'+string(ll_lotno)+'/'+right(string(ll_season),2)
				dw_1.setitem(ll_ctr,'dtp_no',ll_lotno)
				dw_1.setitem(ll_ctr,'dtp_lotno',ls_inv_no)
				ls_id = dw_1.getitemstring(ll_ctr,'dtp_id')
				ls_id1 = dw_1.getitemstring(ll_ctr,'dtpd_id')
				ls_grade = dw_1.getitemstring(ll_ctr,'tmp_id')
				ll_from = dw_1.getitemnumber(ll_ctr,'dtpd_srnostart')
				ll_to = dw_1.getitemnumber(ll_ctr,'dtpd_srnoend')
				ld_gross = dw_1.getitemnumber(ll_ctr,'dtpd_indwt')
				ld_tear = dw_1.getitemnumber(ll_ctr,'dtpd_chestwt')
				ls_spid = dw_1.getitemstring(ll_ctr,'dtp_packid')
				ld_sostk =  dw_1.getitemnumber(ll_ctr,'dtpd_sortedstk')
				ld_mfg_frdt = dw_1.getitemdatetime(ll_ctr,'dtpd_mfg_frdt')
				ld_mfg_todt = dw_1.getitemdatetime(ll_ctr,'dtpd_mfg_todt')
					
				select distinct 'x' into :ls_temp from fb_dtpdetails_new where trim(DTP_ID) = trim(:ls_id);
					
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Detail From dtpdetails Table',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode  = 100 then
					insert into fb_dtpdetails_new(DTP_ID, TMP_ID, dtpd_sortedstk,DTPD_SRNOSTART, DTPD_SRNOEND, DTPD_INDWT, DTPD_CHESTWT, SP_ID, DTPD_ID, DTPD_MFG_FRDT, DTPD_MFG_TODT)
					values(:ls_id,:ls_grade,:ld_sostk,:ll_from,:ll_to,(nvl(:ld_gross,0) - nvl(:ld_tear,0)),:ld_tear,:ls_spid,:ls_id1, trunc(:ld_mfg_frdt), trunc(:ld_mfg_todt));
					
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Insert Detail Table',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					end if
					
					update fb_dailyteapacked set DTP_DISPIND='Y' where trim(DTP_ID)=trim(:ls_id);
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Updating Table Dispatch Indicator',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					end if
					
				elseif sqlca.sqlcode  = 0 then	
					update fb_dtpdetails_new set  TMP_ID = :ls_grade, DTPD_SRNOSTART = :ll_from, DTPD_SRNOEND = :ll_to,dtpd_sortedstk = :ld_sostk,
													DTPD_INDWT = (nvl(:ld_gross,0) - nvl(:ld_tear,0)), DTPD_CHESTWT = :ld_tear, SP_ID = :ls_spid, DTPD_MFG_FRDT = trunc(:ld_mfg_frdt), DTPD_MFG_TODT = trunc(:ld_mfg_todt)
					where trim(DTP_ID) = trim(:ls_id);
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Updating Detail Table',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					end if
				end if				
			end if	// new or modify
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

type cb_2 from commandbutton within w_gteprof022
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

if cbx_1.checked then
	ls_appr_ind = 'Y';
else
	ls_appr_ind = 'N';
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
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	cb_2.text = "&Run"
	cb_3.enabled = false
	cb_1.enabled = false
else
	lb_query = false
	lb_neworder = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user,date(ld_maxpackdt),gs_garden_snm,ls_appr_ind)
 	dw_1.TriggerEvent(rowfocuschanged!)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	cb_1.enabled = true
end if


end event

type cb_1 from commandbutton within w_gteprof022
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


if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'dtp_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'dtp_entry_dt',datetime(today()))
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'dtp_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'dtp_entry_dt',datetime(today()))
end if


end event

type dw_1 from datawindow within w_gteprof022
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 9
integer y = 116
integer width = 4571
integer height = 2052
integer taborder = 30
string dataobject = "dw_gteprof022"
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
		dw_1.setitem(newrow,'dtp_entry_by',gs_user)
		dw_1.setitem(newrow,'dtp_entry_dt',datetime(today()))
		dw_1.setitem(newrow,'dtp_date',datetime(today()))
		dw_1.setitem(newrow,'dtp_date',dw_1.getitemdatetime(currentrow,'dtp_date'))
		dw_1.setitem(newrow,'dtp_prefix',dw_1.getitemstring(currentrow,'dtp_prefix'))
		dw_1.setitem(newrow,'dtp_source',dw_1.getitemstring(currentrow,'dtp_source'))
		dw_1.setitem(newrow,'dtp_season',dw_1.getitemnumber(currentrow,'dtp_season'))
		dw_1.setitem(newrow,'tpc_id',dw_1.getitemstring(currentrow,'tpc_id'))
		dw_1.setcolumn('dtp_date')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;if lb_query = false then
	if dwo.name = 'dtp_lotno' then
		ls_invno =trim(data)
		select a.dtp_id, DTP_DATE, DTPD_ID, TMP_ID, DTP_SEASON, DTP_NO, DTP_PREFIX, DTP_PACKID, DTP_DISPIND, DTP_SOURCE, DTP_LOCATION, DTPD_SRNOSTART, DTPD_SRNOEND, DTPD_INDWT, DTPD_CHESTWT, SP_ID, DTPD_MFG_FRDT, DTPD_MFG_TODT 
			into :ls_dtp_id, :ld_dt, :ls_dtpd_id, :ls_tmp_id, :ll_season, :ll_dtp_no, :ls_prefixcheck, :ls_dtp_packid, :ld_dispind, :ls_source, :ls_locn, :ll_stno, :ll_endno, :ld_indwt, :ld_chestwt, :ls_sp_id, :ld_mfg_frdt, :ld_mfg_todt
		from fb_dailyteapacked a, fb_dtpdetails b where a.dtp_id = b.dtp_id and dtp_lotno = :ls_invno and nvl(DTP_DISPIND,'N') = 'N';
		if sqlca.sqlcode = -1 then
			messagebox('Sql Error During Select ',sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 100 then
			messagebox('Information !','Entered Invoice No. Not Found / Or Despatched !!!')
			setnull(ls_temp); ll_temp = 0
			dw_1.setitem(row,'dtp_id',ls_temp)
			dw_1.setitem(row,'dtp_date',ls_temp)
			dw_1.setitem(row,'dtpd_id',ls_temp)
			dw_1.setitem(row,'tmp_id',ls_temp)
			dw_1.setitem(row,'dtp_season',ll_temp)
			dw_1.setitem(row,'dtp_no',ll_temp)
			dw_1.setitem(row,'dtp_prefix',ls_temp)
			dw_1.setitem(row,'dtp_dispind',ll_temp)
			dw_1.setitem(row,'dtp_source',ls_temp)
			dw_1.setitem(row,'dtp_packid',ls_temp)
			dw_1.setitem(row,'dtp_source',ls_temp)
			dw_1.setitem(row,'nop',ll_temp)
			dw_1.setitem(row,'net_wt',ll_temp)
			dw_1.setitem(row,'indwttotal',ll_temp)
			dw_1.setitem(row,'netwttotal',ll_temp)
			dw_1.setitem(row,'dtpd_srnostart',ll_temp)
			dw_1.setitem(row,'dtpd_srnoend',ll_temp)			
			dw_1.setitem(row,'dtpd_indwt',ll_temp)
			dw_1.setitem(row,'dtpd_chestwt',ll_temp)
			dw_1.setitem(row,'sp_id',ls_temp)
			dw_1.setitem(row,'dtpd_mfg_frdt',ls_temp)
			dw_1.setitem(row,'dtpd_mfg_todt',ls_temp)			
			return 1
		else
			dw_1.setitem(row,'dtp_id',ls_dtp_id)
			dw_1.setitem(row,'dtp_date',ld_dt)
			dw_1.setitem(row,'dtpd_id',ls_dtpd_id)
			dw_1.setitem(row,'tmp_id',ls_tmp_id)
			dw_1.setitem(row,'dtp_season',ll_season)
			dw_1.setitem(row,'dtp_no',ll_dtp_no)
			dw_1.setitem(row,'dtp_prefix',ls_prefixcheck)
			dw_1.setitem(row,'dtp_dispind',ld_dispind)
			dw_1.setitem(row,'dtp_source',ls_source)
			dw_1.setitem(row,'dtp_packid',ls_dtp_packid)
			dw_1.setitem(row,'dtp_source',ls_source)
			dw_1.setitem(row,'nop',((ll_endno - ll_stno) + 1))
			dw_1.setitem(row,'net_wt',ld_indwt)
			dw_1.setitem(row,'indwttotal',(ld_indwt + ld_chestwt) * ((ll_endno - ll_stno) + 1))
			dw_1.setitem(row,'netwttotal',ld_indwt * ((ll_endno - ll_stno) + 1))
			dw_1.setitem(row,'dtpd_srnostart',ll_stno)
			dw_1.setitem(row,'dtpd_srnoend',ll_endno)			
			dw_1.setitem(row,'dtpd_indwt',(ld_indwt + ld_chestwt))
			dw_1.setitem(row,'dtpd_chestwt',ld_chestwt)
			dw_1.setitem(row,'sp_id',ls_sp_id)
			dw_1.setitem(row,'dtpd_mfg_frdt',ld_mfg_frdt)
			dw_1.setitem(row,'dtpd_mfg_todt',ld_mfg_todt)
		end if
	end if
	
	if dw_1.getcolumnname() = 'appr_flag' then
		ls_appr_ind = dw_1.gettext()
		
		ls_entry_by=dw_1.getitemstring(row,'dtp_entry_by')
		
		if(ls_entry_by=gs_user) then
			messagebox('Warniing !' ,'Approval cannot be done by the same person as Entry. Please check!!!')
			return 1			
		else
			if ls_appr_ind = 'Y' then
				dw_1.setitem(dw_1.getrow(),'dtp_approved_by',gs_user)
				dw_1.setitem(dw_1.getrow(),'dtp_approved_dt',today())
				cb_2.enabled = true
			elseif ls_appr_ind = 'N' then
				datetime ld_dt1;setnull(ld_dt1);
				setnull(ls_temp);
				dw_1.setitem(dw_1.getrow(),'dtp_approved_by',ls_temp)
				dw_1.setitem(dw_1.getrow(),'dtp_approved_dt',ld_dt1)
			end if			
		end if
	end if		
	
	if dwo.name = 'dtpd_srnostart' then
		ll_from = long(data)
		ll_Season = dw_1.getitemnumber(row,'dtp_season')		
	
//		select 'x' into :ls_temp from fb_dailyteapacked a, fb_dtpdetails b where a.dtp_id = b.dtp_id and dtp_season = :ll_season and :ll_from between 
//		dtpd_srnostart and dtpd_srnoend;
//
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Start No details !',sqlca.sqlerrtext)
//			return 1
//		elseif sqlca.sqlcode = 0 then
//			messagebox('Warniing !' ,'This Start No. Already Exists, Please Check !!!')
//			return 1			
//		end if
		
		ll_to = dw_1.getitemnumber(row,'dtpd_srnoend')
		ld_gross = dw_1.getitemnumber(row,'dtpd_indwt')
		ld_tear = dw_1.getitemnumber(row,'dtpd_chestwt')
		
		if ((ll_to - ll_from) +1) > 0 then
			dw_1.setitem(row,'nop',((ll_to - ll_from) +1))
//			if (ld_gross - ld_tear) * ((ll_to - ll_from) +1) > ld_sostk then
//				messagebox('Warning!','Packing Quantity ('+string((ld_gross - ld_tear) * ((ll_to - ll_from) +1)) +') Should Not Be Greater Than Sorted Stock ('+string(ld_sostk)+') Available, Please Check !!!')
//				return 1
//			end if

			dw_1.setitem(row,'net_wt',(ld_gross - ld_tear))
			dw_1.setitem(row,'indwttotal',(ld_gross) * ((ll_to - ll_from) +1))
			dw_1.setitem(row,'netwttotal',(ld_gross - ld_tear) * ((ll_to - ll_from) +1))			
		end if
	end if

	if dwo.name = 'dtpd_srnoend' then
		ll_to = long(data)
		ll_season = dw_1.getitemnumber(row,'dtp_season')
		
//		select 'x' into :ls_temp from fb_dailyteapacked a, fb_dtpdetails b where a.dtp_id = b.dtp_id and dtp_season = :ll_season and :ll_to between 
//		dtpd_srnostart and dtpd_srnoend;
//
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting End No details !',sqlca.sqlerrtext)
//			return 1
//		elseif sqlca.sqlcode = 0 then
//			messagebox('Warniing !' ,'This End No. Already Exists, Please Check !!!')
//			return 1			
//		end if
		
		ll_from = dw_1.getitemnumber(row,'dtpd_srnostart')
		ld_gross = dw_1.getitemnumber(row,'dtpd_indwt')
		ld_tear = dw_1.getitemnumber(row,'dtpd_chestwt')

		if ((ll_to - ll_from) +1) > 0 then
			dw_1.setitem(row,'nop',((ll_to - ll_from) +1))
			
//			if (ld_gross - ld_tear) * ((ll_to - ll_from) +1) > ld_sostk then
//				messagebox('Warning!','Packing Quantity ('+string((ld_gross - ld_tear) * ((ll_to - ll_from) +1)) +') Should Not Be Greater Than Sorted Stock ('+string(ld_sostk)+') Available, Please Check !!!')
//				return 1
//			end if

			dw_1.setitem(row,'net_wt',(ld_gross - ld_tear))
			dw_1.setitem(row,'indwttotal',(ld_gross) * ((ll_to - ll_from) +1))
			dw_1.setitem(row,'netwttotal',(ld_gross - ld_tear) * ((ll_to - ll_from) +1))
			
		else
			messagebox('Warning!','Mark on Package From Should Be <= Mark on Package To, Please Check !!!')
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
		dw_1.setitem(row,'dtpd_chestwt',ld_tear)
	end if
	
	if dwo.name = 'dtpd_indwt' then
		ld_gross = double(data)
		ld_tear = dw_1.getitemnumber(row,'dtpd_chestwt')
		ll_to 	  = dw_1.getitemnumber(row,'dtpd_srnoend')
		ll_from = dw_1.getitemnumber(row,'dtpd_srnostart')
		
		if ld_tear > ld_gross then
			messagebox('Warning!','Tare Weight Should Not Be Greater Than Gross Weight, Please Check !!!')
			return 1
		else

//03-09-2024 commented by Piyush. Reason we don't check sorting qty as we are not interfering with sorting data, Sorting data will be of same grade  Inform via mail (Grade Change. TMF Taylor Contact.) dated Sat 24/08/2024 12:30 pm 

//			if idw_grade.getrow() > 0 then
//				ld_sostk = idw_grade.getitemnumber(idw_grade.getrow(),'sortstocktodate')
//			end if
//			if isnull(ld_sostk) then ld_sostk = 0
//			if ld_sostk = 0 then
//				messagebox('Warning!','There Is No Stock For This Grade, Please Check !!!')
//				return 1
//			else
//				if (ld_gross - ld_tear) * ((ll_to - ll_from) +1) > ld_sostk then
//					messagebox('Warning!','Packing Quantity ('+string((ld_gross - ld_tear) * ((ll_to - ll_from) +1)) +') Should Not Be Greater Than Sorted Stock ('+string(ld_sostk)+') Available, Please Check !!!')
//					return 1
//				end if
//			end if

			dw_1.setitem(row,'net_wt',(ld_gross - ld_tear))
			dw_1.setitem(row,'indwttotal',(ld_gross) * ((ll_to - ll_from) +1))
			dw_1.setitem(row,'netwttotal',(ld_gross - ld_tear) * ((ll_to - ll_from) +1))
			
		end if
	end if
	
	if dwo.name = 'dtpd_chestwt' then
		ld_tear = double(data)
		ld_gross = dw_1.getitemnumber(row,'dtpd_indwt')
		
		if ld_tear > ld_gross then
			messagebox('Warning!','Tare Weight Should Not Be Greater Than Gross Weight, Please Check !!!')
			return 1
		else
			dw_1.setitem(row,'net_wt',(ld_gross - ld_tear))
			dw_1.setitem(row,'indwttotal',(ld_gross) * ((ll_to - ll_from) +1))
			dw_1.setitem(row,'netwttotal',(ld_gross - ld_tear) * ((ll_to - ll_from) +1))
		end if
	end if
end if	

if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
	dw_1.insertrow(0)
end if

cb_3.enabled = true
end event

