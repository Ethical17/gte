$PBExportHeader$w_gteprof014.srw
forward
global type w_gteprof014 from window
end type
type cb_4 from commandbutton within w_gteprof014
end type
type cb_3 from commandbutton within w_gteprof014
end type
type cb_2 from commandbutton within w_gteprof014
end type
type cb_1 from commandbutton within w_gteprof014
end type
type dw_1 from datawindow within w_gteprof014
end type
end forward

global type w_gteprof014 from window
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
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gteprof014 w_gteprof014

type variables
long ll_ctr, ll_last,ll_from,ll_to,ll_ac_year, ll_lotno, ll_season,ll_user_level
string ls_temp,ls_del_ind,ls_tmp_id, ls_tmp_id1,ls_entry_user,ls_cons,ls_last,ls_count, ls_tpc_id,ls_ref,ls_ltno,ls_prefixcheck
string ls_inv_no, ls_prefix, ls_grade,ls_count1,ls_id1,ls_id, ls_spid
boolean lb_neworder, lb_query
double ld_hrs, ld_gross, ld_tear, ld_net, ld_sostk
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

on w_gteprof014.create
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gteprof014.destroy
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

dw_1.GetChild ("tmp_id", idw_grade)
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

type cb_4 from commandbutton within w_gteprof014
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

type cb_3 from commandbutton within w_gteprof014
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
//	for ll_ctr = dw_1.rowcount() to 1 step -1
//		if dw_1.getitemstring(ll_ctr,'del_flag') = 'Y' and dw_1.rowcount() <> dw_1.getitemnumber(ll_ctr,'sel_row') then
//			ls_id = dw_1.getitemstring(ll_ctr,'dtp_id')
//			delete from fb_dtpdetails where trim(DTP_ID) = trim(:ls_id);
//			if sqlca.sqlcode = -1 then
//				messagebox('Error : While Deleting From dtpdetails Table',sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 1
//			end if
//			dw_1.deleterow(ll_ctr)
//		end if
//	next	
	
	if dw_1.rowcount() > 0 then
		IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
			return 1
		END IF
	end if	

	if dw_1.rowcount() > 0 then		 
		for ll_ctr = 1 to dw_1.rowcount( ) 
			if dw_1.getitemstatus(ll_ctr,0,primary!) = NewModified! or dw_1.getitemstatus(ll_ctr,0,primary!) = New! or dw_1.getitemstatus(ll_ctr,0,primary!) = DataModified! then
				if dw_1.getitemstatus(ll_ctr,0,primary!) = NewModified! or dw_1.getitemstatus(ll_ctr,0,primary!) = New! then

//					if ll_lotno = 0 then
//09/04/2012						
//						if long(string(today(),'mm')) < 4 then
//							ll_ac_year = long(string(today(),'YYYY'))-1
//						else
//							ll_ac_year = long(string(today(),'YYYY'))
//						end if;
//						ll_lotno = f_get_lastno('INV',string(ll_ac_year));
//09/04/2012
//						ll_lotno = f_get_lastno('INV',string(ll_season));

//						if ll_lotno = -1 then 
//							rollback using sqlca;
//							return 1;
//						end if;	
//					else
//						ll_lotno = ll_lotno + 1
//					end if

//comment on 21/07/2020 so that user can modify prefix
//					ll_season = dw_1.getitemnumber(ll_ctr,'dtp_season')
//					ll_lotno = dw_1.getitemnumber(ll_ctr,'dtp_no')					
//					ls_prefix = dw_1.getitemstring(ll_ctr,'dtp_prefix')
//					
//					ls_inv_no = ls_prefix+'-'+string(ll_lotno)+'/'+right(string(ll_season),2)
//					dw_1.setitem(ll_ctr,'dtp_no',ll_lotno)
//					dw_1.setitem(ll_ctr,'dtp_lotno',ls_inv_no)
					if ll_last=0 then
						select nvl(MAX(substr(dtp_id,4,10)),0) into :ll_last from fb_dailyteapacked;
					end if
					ll_last = ll_last + 1
					ls_tmp_id = 'DTP'+string(ll_last,'0000000000')
					ls_tmp_id1 = 'DTPD'+string(ll_last,'00000000')
					dw_1.setitem(ll_ctr,'dtp_id',ls_tmp_id)
					dw_1.setitem(ll_ctr,'dtpd_id',ls_tmp_id1)
				end if
				ll_season = dw_1.getitemnumber(ll_ctr,'dtp_season')
				ll_lotno = dw_1.getitemnumber(ll_ctr,'dtp_no')					
				ls_prefix = dw_1.getitemstring(ll_ctr,'dtp_prefix')
				
				ls_inv_no = ls_prefix+'-'+string(ll_lotno)+'/'+right(string(ll_season),2)
				dw_1.setitem(ll_ctr,'dtp_no',ll_lotno)
				dw_1.setitem(ll_ctr,'dtp_lotno',ls_inv_no)
//				dtpd_indwt is net weight in old system so changed accordingly on 11/05/2012
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
					
				select distinct 'x' into :ls_temp from fb_dtpdetails where trim(DTP_ID) = trim(:ls_id);
					
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Detail From dtpdetails Table',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode  = 100 then
					insert into fb_dtpdetails(DTP_ID, TMP_ID, dtpd_sortedstk,DTPD_SRNOSTART, DTPD_SRNOEND, DTPD_INDWT, DTPD_CHESTWT, SP_ID, DTPD_ID, DTPD_MFG_FRDT, DTPD_MFG_TODT)
					values(:ls_id,:ls_grade,:ld_sostk,:ll_from,:ll_to,(nvl(:ld_gross,0) - nvl(:ld_tear,0)),:ld_tear,:ls_spid,:ls_id1, trunc(:ld_mfg_frdt), trunc(:ld_mfg_todt));
					
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Insert Detail Table',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					end if
				elseif sqlca.sqlcode  = 0 then	
					update fb_dtpdetails set  TMP_ID = :ls_grade, DTPD_SRNOSTART = :ll_from, DTPD_SRNOEND = :ll_to,dtpd_sortedstk = :ld_sostk,
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
//		if f_upd_lastno('INV',string(ll_season),ll_lotno) = -1 then 
//			rollback using sqlca;
//			return 1
//		end if;

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

type cb_2 from commandbutton within w_gteprof014
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

type cb_1 from commandbutton within w_gteprof014
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
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'dtp_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'gsn',gs_garden_snm)
	dw_1.setitem(dw_1.getrow(),'dtp_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'dtp_date',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'dtp_season',long(string(today(),'YYYY')))
	dw_1.setcolumn('dtp_source')
end if


end event

type dw_1 from datawindow within w_gteprof014
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 9
integer y = 116
integer width = 4571
integer height = 2052
integer taborder = 30
string dataobject = "dw_gteprof014"
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
	if(dwo.name ='dtp_prefix') then 
	 	if(gs_garden_snm='MV')  then 
		 	ls_prefixcheck=data			 			 
			 if(ls_prefixcheck='P') then
			 	messagebox('Warning !','You Cannot select Pouch from Here')
				return 1
			 end if
     	end if
	end if
	
	if dwo.name = 'dtp_date' then
		ld_dt = datetime(data)
		ld_mfg_frdt = dw_1.getitemdatetime(row,'dtpd_mfg_frdt')
		ld_mfg_todt = dw_1.getitemdatetime(row,'dtpd_mfg_todt')
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
		if not isnull(dw_1.getitemdatetime(row,'dtpd_mfg_frdt')) then
			if ld_dt <= ld_mfg_frdt then 
				messagebox('Warning','Manufacturing From date should be smaller than packing date')
				return 1
			end if
		end if
		if not isnull(dw_1.getitemdatetime(row,'dtpd_mfg_todt')) then
			if ld_dt <= ld_mfg_todt then 
				messagebox('Warning','Manufacturing To date should be smaller than packing date')
				return 1
			end if
		end if
	end if
	
	if dwo.name = 'dtpd_mfg_frdt' or dwo.name = 'dtpd_mfg_todt' then
		ld_dt = dw_1.getitemdatetime(row,'dtp_date')
		if not isnull(dw_1.getitemdatetime(row,'dtp_date')) then
			if ld_dt <= datetime(data) then
				messagebox('Warning','Manufacturing From and To date should be smaller than packing date')
				return 1
			end if
		end if
		
		if dwo.name = 'dtpd_mfg_frdt' then
			if not isnull(dw_1.getitemdatetime(row,'dtpd_mfg_todt')) then
				if dw_1.getitemdatetime(row,'dtpd_mfg_todt') < datetime(data) then
					messagebox('Warning','Manufacturing From Date should be smaller than To date')
					return 1
				end if 
			end if
		end if
		
		if dwo.name = 'dtpd_mfg_todt' then
			if not isnull(dw_1.getitemdatetime(row,'dtpd_mfg_frdt')) then
				if dw_1.getitemdatetime(row,'dtpd_mfg_frdt') > datetime(data) then
					messagebox('Warning','Manufacturing From Date should be smaller than To date')
					return 1
				end if 
			end if
		end if
	end if
	
	
	
	if dwo.name = 'dtp_season' then
		ll_season= long(data)
		if ll_season < (long(string(today(),'YYYY')) - 1) or ll_season > (long(string(today(),'YYYY')) + 1) then
			messagebox('Warning!','Season Can Be Between (Current Year - 1 To Current Year + 1), Please Check !!!')
			return 1
		end if
	end if

	if dwo.name = 'tpc_id' then
		idw_grade.SetFilter ("tpc_id = '"+trim(data)+"'")
		idw_grade.settransobject(sqlca)	
		idw_grade.retrieve()		
		ls_prefix = dw_1.getitemstring(row,'dtp_prefix')	
	end if
	
	if dwo.name = 'tmp_id' then
		ls_grade = data
		ls_tpc_id = dw_1.getitemstring(row,'tpc_id')
		//if  wf_check_duplicate_rec(ls_tpc_id,ls_grade) = -1 then return 1
		idw_grade.accepttext( )
		ld_sostk = idw_grade.getitemnumber(idw_grade.getrow(),'sortstocktodate')
		dw_1.setitem(row,'dtpd_sortedstk',ld_sostk)	
	end if
	
	if dwo.name = 'dtpd_srnostart' then
		ll_from = long(data)
		ll_Season = dw_1.getitemnumber(row,'dtp_season')		
	
		select 'x' into :ls_temp from fb_dailyteapacked a, fb_dtpdetails b where a.dtp_id = b.dtp_id and dtp_season = :ll_season and :ll_from between 
		dtpd_srnostart and dtpd_srnoend;

		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Start No details !',sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 0 then
			messagebox('Warniing !' ,'This Start No. Already Exists, Please Check !!!')
			return 1			
		end if
		
		ll_to = dw_1.getitemnumber(row,'dtpd_srnoend')
		ld_gross = dw_1.getitemnumber(row,'dtpd_indwt')
		ld_tear = dw_1.getitemnumber(row,'dtpd_chestwt')
		
		if ((ll_to - ll_from) +1) > 0 then
			dw_1.setitem(row,'nop',((ll_to - ll_from) +1))
			if (ld_gross - ld_tear) * ((ll_to - ll_from) +1) > ld_sostk then
				messagebox('Warning!','Packing Quantity ('+string((ld_gross - ld_tear) * ((ll_to - ll_from) +1)) +') Should Not Be Greater Than Sorted Stock ('+string(ld_sostk)+') Available, Please Check !!!')
				return 1
			end if

			dw_1.setitem(row,'net_wt',(ld_gross - ld_tear))
			dw_1.setitem(row,'indwttotal',(ld_gross) * ((ll_to - ll_from) +1))
			dw_1.setitem(row,'netwttotal',(ld_gross - ld_tear) * ((ll_to - ll_from) +1))			
		end if
	end if

	if dwo.name = 'dtpd_srnoend' then
		ll_to = long(data)
		ll_season = dw_1.getitemnumber(row,'dtp_season')
		
		select 'x' into :ls_temp from fb_dailyteapacked a, fb_dtpdetails b where a.dtp_id = b.dtp_id and dtp_season = :ll_season and :ll_to between 
		dtpd_srnostart and dtpd_srnoend;

		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting End No details !',sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 0 then
			messagebox('Warniing !' ,'This End No. Already Exists, Please Check !!!')
			return 1			
		end if
		
		ll_from = dw_1.getitemnumber(row,'dtpd_srnostart')
		ld_gross = dw_1.getitemnumber(row,'dtpd_indwt')
		ld_tear = dw_1.getitemnumber(row,'dtpd_chestwt')

		if ((ll_to - ll_from) +1) > 0 then
			dw_1.setitem(row,'nop',((ll_to - ll_from) +1))
			
			if (ld_gross - ld_tear) * ((ll_to - ll_from) +1) > ld_sostk then
				messagebox('Warning!','Packing Quantity ('+string((ld_gross - ld_tear) * ((ll_to - ll_from) +1)) +') Should Not Be Greater Than Sorted Stock ('+string(ld_sostk)+') Available, Please Check !!!')
				return 1
			end if

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

