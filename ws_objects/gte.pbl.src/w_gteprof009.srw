$PBExportHeader$w_gteprof009.srw
forward
global type w_gteprof009 from window
end type
type cb_5 from commandbutton within w_gteprof009
end type
type cb_7 from commandbutton within w_gteprof009
end type
type cb_8 from commandbutton within w_gteprof009
end type
type cb_9 from commandbutton within w_gteprof009
end type
type dw_2 from datawindow within w_gteprof009
end type
type cb_4 from commandbutton within w_gteprof009
end type
type cb_3 from commandbutton within w_gteprof009
end type
type cb_2 from commandbutton within w_gteprof009
end type
type cb_1 from commandbutton within w_gteprof009
end type
type dw_1 from datawindow within w_gteprof009
end type
end forward

global type w_gteprof009 from window
integer width = 3794
integer height = 1752
boolean titlebar = true
string title = "(w_gteprof009) Machine Consumption Reading"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
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
global w_gteprof009 w_gteprof009

type variables
long ll_ctr,ll_last,ll_last1,ll_user_level
string ls_tmp_id,ls_mac_id,ls_temp,ls_tmp_id1,ls_perisid, ls_ctid,ls_spid, ls_exphead, ls_stind,ls_storeind
double ld_tot_hrs, ld_qnty
boolean lb_neworder, lb_query
datetime ld_pluckdt,ld_startdt,ld_enddt
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_cal_datediff (datetime fd_frdt, datetime fd_todt)
public function integer wf_check_duplicate_rec (string fs_con_id)
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
	if (isnull(dw_2.getitemstring(fl_row,'ct_id')) or  len(dw_2.getitemstring(fl_row,'ct_id'))=0 or &
		 isnull(dw_2.getitemnumber(fl_row,'ddc_unitconsumed')) or dw_2.getitemnumber(fl_row,'ddc_unitconsumed') = 0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Consumption Type, Units Consumed, Please Check !!!')
		 return -1
	end if
end if
return 1

end function

public function integer wf_cal_datediff (datetime fd_frdt, datetime fd_todt);double ld_hrs1

select round(((:fd_todt - :fd_frdt) * 24),2) into :ld_hrs1 from dual;

return ld_hrs1
end function

public function integer wf_check_duplicate_rec (string fs_con_id);long fl_row
string ls_con_id1
datetime ld_run_dt1

dw_2.SelectRow(0, FALSE)
if dw_2.rowcount() > 1 then
	for fl_row = 1 to (dw_2.rowcount() - 1)
		ls_con_id1 = dw_2.getitemstring(fl_row,'ct_id')
		
		if ls_con_id1 = fs_con_id  then
			dw_2.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gteprof009.create
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
this.Control[]={this.cb_5,&
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

on w_gteprof009.destroy
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

event open;
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
//dw_1.modify("t_co.text = '"+gs_co_name+"'")

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

type cb_5 from commandbutton within w_gteprof009
integer x = 2578
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
	dw_1.setcolumn('ind')
	dw_1.ScrolltoRow(1)
end if
end event

type cb_7 from commandbutton within w_gteprof009
integer x = 2697
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
string text = "<"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrollPriorRow()
end if
end event

type cb_8 from commandbutton within w_gteprof009
integer x = 2816
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
string text = ">"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrollnextRow()
end if
end event

type cb_9 from commandbutton within w_gteprof009
integer x = 2935
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
string text = ">>"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrolltoRow(dw_1.rowcount())
end if
end event

type dw_2 from datawindow within w_gteprof009
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 635
integer y = 724
integer width = 1806
integer height = 840
integer taborder = 40
string dataobject = "dw_gteprof009a"
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

event itemchanged;if dwo.name = 'ct_id' then
	
	ls_ctid = data
	
	if  wf_check_duplicate_rec(data) = -1 then return 1
	
	select CT_STOREIND into :ls_storeind from fb_consumptiontype where CT_ID=:ls_ctid;
	
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Store Item details !!!',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if	
	
	setitem(row,'storeind',ls_storeind)
	
end if

if row = dw_2.rowcount() and dwo.name <> 'del_flag'  then
		dw_2.insertrow(0)
end if
cb_3.enabled = true
end event

type cb_4 from commandbutton within w_gteprof009
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

type cb_3 from commandbutton within w_gteprof009
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

if dw_2.rowcount() > 1 then
	if (isnull(dw_2.getitemstring(dw_2.rowcount(),'ct_id')) or len(dw_2.getitemstring(dw_2.rowcount(),'ct_id')) = 0) then 
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

	if (isnull(dw_1.getitemstring(dw_1.getrow(),'dryer_id')) or isnull(dw_1.getitemstring(dw_1.getrow(),'dryer_id')) or &
		isnull(dw_1.getitemdatetime(dw_1.getrow(),'ddp_pluckingdate')) or &
		isnull(dw_1.getitemdatetime(dw_1.getrow(),'ddp_startruntime')) or & 
		isnull(dw_1.getitemdatetime(dw_1.getrow(),'ddp_endruntime'))) then
		messagebox('Warning:','One Of The Fields Are Blank : Machine Id, Plucking Date, Start Date Time, End Date Time !!!')
		dw_1.setfocus()
		dw_1.setcolumn('dryer_id')
		return
	end if
	
	if lb_neworder = true then
			ll_last = 0
			if ll_last=0 then
				select nvl(MAX(substr(DDP_PK,4,10)),0) into :ll_last from fb_dailydryerproduct;
			end if
			ll_last = ll_last + 1
			ls_tmp_id = 'DDP'+string(ll_last,'0000000000')
			dw_1.setitem(dw_1.getrow(),'ddp_pk',ls_tmp_id)
			for ll_ctr = 1 to dw_2.rowcount()
				dw_2.setitem(ll_ctr,'ddp_pk',ls_tmp_id)
			next
		// Remove As per discusstion with Mr. Lahiri on 17 05 2012 at 20.11 pm

//			if (dw_2.getitemnumber( 0,'storeitems') > 0 or dw_2.getitemnumber( 0,'oldstoreitems') > 0)  then
//				ll_last1 = 0
//				if ll_last1 =0 then
//					select nvl(MAX(substr(PRIS_ID,4,10)),0) into :ll_last1 from fb_productissue;
//				end if
//				ll_last1 = ll_last1 + 1
//				ls_tmp_id1 = 'REQ'+string(ll_last1,'0000000000')
//				dw_1.setitem(dw_1.getrow(),'pris_id',ls_tmp_id1)			
//			end if
	end if	
	
//	if ((dw_2.getitemnumber( 0,'storeitems') > 0 or dw_2.getitemnumber( 0,'oldstoreitems') > 0) and (dw_2.modifiedcount() > 0 or dw_2.DeletedCount ( ) > 0 )) then
//
//			ls_perisid = dw_1.getitemstring(dw_1.getrow(),'pris_id')
//			ld_pluckdt = dw_1.getitemdatetime(dw_1.getrow(),'ddp_pluckingdate')
//			
//			select distinct 'x' into :ls_temp from fb_productissue where pris_id = :ls_perisid;
//			
//			if sqlca.sqlcode = -1 then
//				messagebox('Error : While Getting Issue Detail',sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 1
//			elseif sqlca.sqlcode  = 100 then
//				
//				insert into fb_productissue(PRIS_ID, PRIS_DATE, PRIS_REQDATE, PRIS_ACTIVE, PRIS_CONFIRMFLAG, PRIS_DIVISION,PRIS_DIV_REQUID,  PRIS_ENTRY_BY, PRIS_ENTRY_DT,PRIS_STOCKIND) 
//				values(:ls_perisid,:ld_pluckdt,:ld_pluckdt,'1','1',:gs_storeid,'NA',:gs_user,:ld_pluckdt,'N');
//				
//				if sqlca.sqlcode = -1 then
//					messagebox('Error : While Inserting Record In productissue Table !!!',sqlca.sqlerrtext)
//					rollback using sqlca;
//					return 1
//				end if
//				
//				for ll_ctr = 1 to dw_2.rowcount()
//						ls_ctid = dw_2.getitemstring(ll_ctr,'ct_id') 
//						ld_qnty = dw_2.getitemnumber(ll_ctr,'ddc_unitconsumed')
//						if dw_2.getitemstring(ll_ctr,'storeind') ='Y' then
//							select CT_SPID,ct_sublegid into :ls_spid, :ls_exphead from fb_consumptiontype where CT_ID = :ls_ctid and CT_STOREIND = 'Y';
//							
//							if sqlca.sqlcode = -1 then
//								messagebox('Error : While Getting Store Item details !!!',sqlca.sqlerrtext)
//								rollback using sqlca;
//								return 1
//							end if
//							
//							insert into fb_productissuedetails (PRIS_ID, SP_ID,EACSUBHEAD_ID, PRIS_ISSUEQUANTITY, PRIS_REQQUANTITY,PRIS_VALUE)
//							values (:ls_perisid,:ls_spid,:ls_exphead,	:ld_qnty,:ld_qnty,0);
//							
//							if sqlca.sqlcode = -1 then
//								messagebox('Error : While Inserting Record In productissuedetails Table !!!',sqlca.sqlerrtext)
//								rollback using sqlca;
//								return 1
//							end if
//						end if
//				next
//			elseif sqlca.sqlcode  = 0 then	
//				
//				delete from fb_productissuedetails where pris_id = :ls_perisid;
//				if sqlca.sqlcode = -1 then
//					messagebox('Error : While Updating Record In productissuedetails Table !!!',sqlca.sqlerrtext)
//					rollback using sqlca;
//					return 1
//				end if				
//				for ll_ctr = 1 to dw_2.rowcount()
//					ls_ctid = dw_2.getitemstring(ll_ctr,'ct_id') 
//					ld_qnty = dw_2.getitemnumber(ll_ctr,'ddc_unitconsumed')
//					if dw_2.getitemstring(ll_ctr,'storeind') ='Y' then
//						select CT_SPID,ct_sublegid into :ls_spid, :ls_exphead from fb_consumptiontype where CT_ID = :ls_ctid and CT_STOREIND = 'Y';
//						if sqlca.sqlcode = -1 then
//							messagebox('Error : While Getting Store Item details !!!',sqlca.sqlerrtext)
//							rollback using sqlca;
//							return 1
//						end if
//							insert into fb_productissuedetails (PRIS_ID, SP_ID,EACSUBHEAD_ID, PRIS_ISSUEQUANTITY, PRIS_REQQUANTITY,PRIS_VALUE)
//							values (:ls_perisid,:ls_spid,:ls_exphead,	:ld_qnty,:ld_qnty,0);
//							
//							if sqlca.sqlcode = -1 then
//								messagebox('Error : While Inserting Record In productissuedetails Table !!!',sqlca.sqlerrtext)
//								rollback using sqlca;
//								return 1
//							end if
//					end if
//				next
//			end if		
//		end if
	
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
	
//	dw_2.update();
//	dw_1.update();
//	commit using sqlca;
//	cb_3.enabled = false
//	dw_1.reset()
//	dw_2.reset()

else
	return
end if 
end event

type cb_2 from commandbutton within w_gteprof009
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
	dw_1.settaborder('dryer_id',10)
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('dryer_id')
	cb_2.text = "&Run"
	cb_3.enabled = false
else
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user)
 	dw_1.TriggerEvent(rowfocuschanged!)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	cb_1.enabled = true
   	cb_5.enabled = true
   	cb_7.enabled = true
   	cb_8.enabled = true
   	cb_9.enabled = true
end if
lb_neworder = false

end event

type cb_1 from commandbutton within w_gteprof009
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
lb_neworder = true
lb_query = false

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'ddp_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'ddp_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'ddp_pluckingdate',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'ddp_startruntime',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'ddp_endruntime',datetime(today()))
	dw_1.setcolumn('dryer_id')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'ddp_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'ddp_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'ddp_pluckingdate',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'ddp_startruntime',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'ddp_endruntime',datetime(today()))	
	dw_1.setcolumn('dryer_id')
end if

cb_1.enabled = false

end event

type dw_1 from datawindow within w_gteprof009
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 9
integer y = 116
integer width = 3616
integer height = 592
integer taborder = 30
string dataobject = "dw_gteprof009"
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
		dw_1.setitem(newrow,'ddp_entry_by',gs_user)
		dw_1.setitem(newrow,'ddp_entry_dt',datetime(today()))
		dw_1.setcolumn('dryer_id')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;if dwo.name = 'dryer_id'  and lb_query = false then
	if lb_neworder = true and dw_2.rowcount() = 0 then
		dw_2.setfocus()
		dw_2.insertrow(0)
		dw_1.setfocus()
		dw_1.setcolumn('dryer_id')		
	end if;	
end if

if lb_query = false then
	if dwo.name = 'ddp_pluckingdate'  then
		ld_pluckdt = datetime(data)
		ls_mac_id = dw_1.getitemstring(row,'dryer_id')
		
		if not isnull(ld_pluckdt) then
			dw_1.setitem(row,'ddp_startruntime',ld_pluckdt)
			dw_1.setitem(row,'ddp_endruntime',ld_pluckdt)
		end if
		
		select distinct 'x' into :ls_temp from fb_dailydryerproduct where trim(DRYER_ID) = trim(:ls_mac_id) and trunc(DDP_PLUCKINGDATE) = trunc(:ld_pluckdt);
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Dryer Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 0 then
			messagebox('Warning!','Machine Consumption Reading Already Exists Of The Selected Machine For The Entered Date, Please Check !!!')
			return 1
		end if
	else
		ld_pluckdt = dw_1.getitemdatetime(row,'ddp_pluckingdate')
	end if
	
	if dwo.name = 'ddp_startruntime'  then
		ld_startdt = datetime(data)
//		if string(ld_startdt,'dd/mm/yyyy') <> string(dw_1.getitemdatetime(row,'ddp_pluckingdate'),'dd/mm/yyyy') then
		if ld_startdt < dw_1.getitemdatetime(row,'ddp_pluckingdate') then
			messagebox('Warning!', 'Start Date Must Be More or Equal to Plucking Date , Please Check !!!')
			return 1
		end if
		
		if isnull(right(string(ld_startdt),8)) or right(string(ld_startdt),8) = '00:00:00'  then
			messagebox('Warning!', 'Start Time Must Be Entered, Please Check !!!')
			return 1
		end if

		if isnull(ld_enddt) then ld_enddt = datetime(today())
		
		SELECT get_hours_diff(:ld_startdt,:ld_enddt) into :ld_tot_hrs FROM dual;
		if ld_tot_hrs > 0 then
			dw_1.setitem(row,'ddp_runhours',ld_tot_hrs)
		end if
	else
		ld_startdt = dw_1.getitemdatetime(row,'ddp_startruntime')
	end if
	
	if dwo.name = 'ddp_endruntime'  then
		ld_enddt = datetime(data)
		ld_startdt = dw_1.getitemdatetime(row,'ddp_startruntime')
	
		if right(string(ld_enddt),8) = '00:00:00' then
			messagebox('Warning!', 'End Time Must Be Entered, Please Check !!!')
			return 1
		end if
		
		if left(string(ld_enddt),10) = left(string(ld_startdt),10) and right(string(ld_enddt),8) <= right(string(ld_startdt),8) then
			messagebox('Warning!', 'End Time Must Be > Start Time, Please Check !!!')
			return 1
		end if
		
		SELECT get_hours_diff(:ld_startdt,:ld_enddt) into :ld_tot_hrs FROM dual;
		if ld_tot_hrs > 0 then
			dw_1.setitem(row,'ddp_runhours',ld_tot_hrs)
		end if

	end if
	
	dw_1.setitem(row,'ddp_entry_by',gs_user)
	dw_1.setitem(row,'ddp_entry_dt',datetime(today()))
	
	cb_3.enabled = true
end if
end event

event rowfocuschanged;if lb_query = false then
	if lb_neworder = false  then
		if dw_1.rowcount() > 0 then
			dw_2.reset()
			dw_2.retrieve(dw_1.getitemstring(dw_1.getrow(),'ddp_pk'))
		end if
	end if
end if
end event

