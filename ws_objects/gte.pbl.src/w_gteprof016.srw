$PBExportHeader$w_gteprof016.srw
forward
global type w_gteprof016 from window
end type
type cb_4 from commandbutton within w_gteprof016
end type
type cb_3 from commandbutton within w_gteprof016
end type
type cb_2 from commandbutton within w_gteprof016
end type
type cb_1 from commandbutton within w_gteprof016
end type
type dw_1 from datawindow within w_gteprof016
end type
end forward

global type w_gteprof016 from window
integer width = 4763
integer height = 2276
boolean titlebar = true
string title = "(w_gteprof016) Reprocessed Tea"
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
global w_gteprof016 w_gteprof016

type variables
string ls_temp,ls_mac_id, ls_ctid,ls_spid,ls_exphead,ls_tmp_id1,ls_perisid,ls_store_ind,ls_id1, ls_id, ls_cat_to, ls_cat_from
boolean lb_neworder, lb_query
datetime ld_rundt,ld_startdt,ld_enddt, ld_processdt
long ll_ctr,ll_user_level,ll_last1,ll_last
double ld_qnty, ld_tot_hrs
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
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
	if ( isnull(dw_1.getitemstring(fl_row,'rt_drier')) or  dw_1.getitemstring(fl_row,'rt_drier') = "" or &
		isnull(dw_1.getitemdatetime(fl_row,'rt_reprocess_dt'))  or &
		isnull(dw_1.getitemdatetime(fl_row,'rt_starttime')) or & 
		isnull(dw_1.getitemdatetime(fl_row,'rt_endtime'))  or & 
		isnull(dw_1.getitemstring(fl_row,'rt_fueltype')) or  dw_1.getitemstring(fl_row,'rt_fueltype') = "" or &
		isnull(dw_1.getitemnumber(fl_row,'rt_reprocess_tea')) or  dw_1.getitemnumber(fl_row,'rt_reprocess_tea') = 0 or &
		isnull(dw_1.getitemnumber(fl_row,'rt_quantity')) or dw_1.getitemnumber(fl_row,'rt_quantity') = 0) then
				messagebox('Warning: One Of The Following Fields Are Blank','Dryer, Reprocessing Date, Machine Start & End Time, Fuel Type, Quantity Consumed, Reporcess Tea, Please Check !!!')
			return -1
	end if
end if
return 1
end function

on w_gteprof016.create
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

on w_gteprof016.destroy
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

type cb_4 from commandbutton within w_gteprof016
integer x = 809
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

type cb_3 from commandbutton within w_gteprof016
integer x = 544
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
boolean enabled = false
string text = "&Save"
end type

event clicked;if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

if dw_1.rowcount() > 1 then
	if (isnull(dw_1.getitemnumber(dw_1.rowcount(),'rt_reprocess_tea')) or dw_1.getitemnumber(dw_1.rowcount(),'rt_reprocess_tea') = 0) then 
		dw_1.deleterow(dw_1.rowcount())
	end if
end if


IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN

	for ll_ctr = dw_1.rowcount() to 1 step -1
		IF (isnull(dw_1.getitemstring(ll_ctr,'rt_drier')) or len(dw_1.getitemstring(ll_ctr,'rt_drier')) = 0) THEN
			 dw_1.deleterow(ll_ctr)
		END IF
	next
	
	if dw_1.rowcount() > 0 then
		IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
			return 1
		END IF
		
		if lb_neworder = true then
			ll_last1 = 0
			ll_last=0
			
			if ll_last1=0 then
				select nvl(MAX(substr(DDP_PK,4,10)),0) into :ll_last1 from FB_DAILYDRYERPRODUCT;
			end if
			
			if ll_last=0 then
				select nvl(MAX(substr(GLFP_PK,4,10)),0) into :ll_last from fb_glforproduction;
			end if
			
			
			for ll_ctr = 1 to dw_1.rowcount( ) 
				ll_last1 = ll_last1 + 1
				ls_id1 = 'DDP'+string(ll_last1,'0000000000')
				
				ll_last = ll_last + 1
				ls_id = 'GFP'+string(ll_last,'0000000000')

				dw_1.setitem(ll_ctr,'ddp_pk',ls_id1)
				dw_1.setitem(ll_ctr,'glfp_pk',ls_id)
				
				ld_rundt = dw_1.getitemdatetime(ll_ctr,'rt_reprocess_dt')
				ls_cat_to  = dw_1.getitemstring(ll_ctr,'tpc_id_to')
				ls_cat_from = dw_1.getitemstring(ll_ctr,'tpc_id_from')
				ld_qnty = dw_1.getitemnumber(ll_ctr,'rt_reprocess_tea')
				ls_mac_id  = dw_1.getitemstring(ll_ctr,'rt_drier')
				ld_startdt = dw_1.getitemdatetime(ll_ctr,'rt_starttime')
				ld_enddt = dw_1.getitemdatetime(ll_ctr,'rt_endtime')
				
				select round(((:ld_enddt - :ld_startdt) * 24),2) into :ld_tot_hrs from dual;
				
				Insert into FB_DAILYDRYERPRODUCT
					(DRYER_ID, DDP_RUNHOURS, DDP_STARTRUNTIME, DDP_ENDRUNTIME, DDP_PLUCKINGDATE, 
					 DDP_CONFIRMFLAG, DDP_PK, DDP_TYPE, DDP_ENTRY_BY, DDP_ENTRY_DT)
				 Values(:ls_mac_id, :ld_tot_hrs, :ld_startdt, :ld_enddt, :ld_rundt, '1', :ls_id1, 'N',:gs_user, sysdate);
							
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Inserting Into FB_DAILYDRYERPRODUCT ',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
				
				Insert into FB_DAILYDRYERUNSORTED (DDP_PK, TPC_ID, DDU_QUANTITY, DDP_DT) 
				Values (:ls_id1,:ls_cat_to, :ld_qnty, :ld_rundt);

				if sqlca.sqlcode = -1 then
					messagebox('Error : While Inserting Into FB_DAILYDRYERUNSORTED ',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
				
				Insert into FB_GLFORPRODUCTION (GLFP_PLUCKINGDATE, GLFP_GLFORPRODUCTION, SUP_ID, GLFP_PK, GLFP_GL_QTY, GLFP_GL_TQTY, GLFP_GL_SQTY)
				Values (:ld_rundt, 0, :gs_supid,:ls_id, 0, NULL, NULL);
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Inserting Into FB_GLFORPRODUCTION ',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
				
				Insert into FB_GARDENWISETEAMADE (GWTM_TEAMADE, GWTM_TYPE, GLFP_PK)
				Values (:ld_qnty, 'N', :ls_id);

				if sqlca.sqlcode = -1 then
					messagebox('Error : While Inserting Into FB_GARDENWISETEAMADE ',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
				
				ll_last1 = ll_last1 + 1
				ls_id1 = 'DDP'+string(ll_last1,'0000000000')
				
				ll_last = ll_last + 1
				ls_id = 'GFP'+string(ll_last,'0000000000')

				Insert into FB_DAILYDRYERPRODUCT
					(DRYER_ID, DDP_RUNHOURS, DDP_STARTRUNTIME, DDP_ENDRUNTIME, DDP_PLUCKINGDATE, 
					 DDP_CONFIRMFLAG, DDP_PK, DDP_TYPE, DDP_ENTRY_BY, DDP_ENTRY_DT)
				 Values(:ls_mac_id,  :ld_tot_hrs, :ld_startdt, :ld_enddt, :ld_rundt, '1', :ls_id1, 'N',:gs_user, sysdate);
							
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Inserting Into FB_DAILYDRYERPRODUCT ',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
				
				Insert into FB_DAILYDRYERUNSORTED (DDP_PK, TPC_ID, DDU_QUANTITY, DDP_DT) 
				Values (:ls_id1,:ls_cat_from, (-1) * :ld_qnty, :ld_rundt);

				if sqlca.sqlcode = -1 then
					messagebox('Error : While Inserting Into FB_DAILYDRYERUNSORTED ',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
				
				Insert into FB_GLFORPRODUCTION (GLFP_PLUCKINGDATE, GLFP_GLFORPRODUCTION, SUP_ID, GLFP_PK, GLFP_GL_QTY, GLFP_GL_TQTY, GLFP_GL_SQTY)
				Values (:ld_rundt, 0, :gs_supid,:ls_id, 0, NULL, NULL);
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Inserting Into FB_GLFORPRODUCTION ',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
				
				Insert into FB_GARDENWISETEAMADE (GWTM_TEAMADE, GWTM_TYPE, GLFP_PK)
				Values ( (-1) * :ld_qnty, 'N', :ls_id);

				if sqlca.sqlcode = -1 then
					messagebox('Error : While Inserting Into FB_GARDENWISETEAMADE ',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if	
			next	
		end if
	end if

//	if dw_1.rowcount() > 0 then
		// Remove As per discusstion with Mr. Lahiri on 17 05 2012 at 20.11 pm
//		for ll_ctr = 1 to dw_1.rowcount()
//			ls_ctid = dw_1.getitemstring(ll_ctr,'rt_fueltype')	
//			ld_qnty = dw_1.getitemnumber(ll_ctr,'rt_quantity')
//			ld_processdt = dw_1.getitemdatetime(ll_ctr,'rt_reprocess_dt')
//
//			select CT_SPID,ct_sublegid,CT_STOREIND into :ls_spid, :ls_exphead,:ls_store_ind from fb_consumptiontype where CT_ID = :ls_ctid ;
//			if sqlca.sqlcode = -1 then
//				messagebox('Error : While Getting Store Item details !!!',sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 1
//			end if
//			
//			if ls_store_ind='Y' then
//				if dw_1.GetItemStatus(ll_ctr,0,Primary!) = New!	or dw_1.GetItemStatus(ll_ctr,0,Primary!) = NewModified!	then
//					ll_last1 = ll_last1 + 1
//					ls_tmp_id1 = 'REQ'+string(ll_last1,'0000000000')
//					if lb_neworder = true then
//						dw_1.setitem(ll_ctr,'pris_id',ls_tmp_id1)			
//					end if
//				end if
//				ls_perisid = dw_1.getitemstring(ll_ctr,'pris_id')
//				
//				if dw_1.GetItemStatus(ll_ctr,0,Primary!) = New!	or dw_1.GetItemStatus(ll_ctr,0,Primary!) = NewModified! or &
//				   dw_1.GetItemStatus(ll_ctr,0,Primary!) = DataModified! then
//					
//					select distinct 'x' into :ls_temp from fb_productissue where pris_id = :ls_perisid and nvl(PRIS_STOCKIND,'N') = 'N';
//		
//					if sqlca.sqlcode = -1 then
//						messagebox('Error : While Getting Issue Detail',sqlca.sqlerrtext)
//						rollback using sqlca;
//						return 1
//					elseif sqlca.sqlcode  = 100 then
//						insert into fb_productissue(PRIS_ID, PRIS_DATE, PRIS_REQDATE, PRIS_ACTIVE, PRIS_CONFIRMFLAG, PRIS_DIVISION,PRIS_DIV_REQUID,  PRIS_ENTRY_BY, PRIS_ENTRY_DT,PRIS_STOCKIND) 
//						values(:ls_perisid,:ld_processdt,:ld_processdt,'1','1',:gs_storeid,'NA',:gs_user,:ld_processdt,'N');
//						
//						if sqlca.sqlcode = -1 then
//							messagebox('Error : While Inserting Record In productissue Table !!!',sqlca.sqlerrtext)
//							rollback using sqlca;
//							return 1
//						end if
//						
//						insert into fb_productissuedetails (PRIS_ID, SP_ID,EACSUBHEAD_ID, PRIS_ISSUEQUANTITY, PRIS_REQQUANTITY,PRIS_VALUE)
//						values (:ls_tmp_id1,:ls_spid,:ls_exphead,:ld_qnty,:ld_qnty,0);
//						
//						if sqlca.sqlcode = -1 then
//							messagebox('Error : While Inserting Record In productissuedetails Table !!!',sqlca.sqlerrtext)
//							rollback using sqlca;
//							return 1
//						end if
//						
//					elseif sqlca.sqlcode  = 0 then		
//						
//						update fb_productissuedetails 
//							 set SP_ID = :ls_spid, EACSUBHEAD_ID = :ls_exphead,	PRIS_ISSUEQUANTITY = :ld_qnty, PRIS_REQQUANTITY =  :ld_qnty
//						where pris_id = :ls_perisid;
//						
//						if sqlca.sqlcode = -1 then
//							messagebox('Error : While Updating Record In productissuedetails Table !!!',sqlca.sqlerrtext)
//							rollback using sqlca;
//							return 1
//						end if
//					end if		
//				end if 
//			end if
//		next	
//	end if

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

type cb_2 from commandbutton within w_gteprof016
integer x = 279
integer y = 8
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

event clicked;
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
	dw_1.setcolumn('rt_drier')
	cb_2.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_neworder =false
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user,date(ld_rundt))
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gteprof016
integer x = 14
integer y = 8
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
end if

dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'rt_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'rt_entry_dt',datetime(today()))
	dw_1.setcolumn('rt_drier')
else
	dw_1.reset()
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'rt_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'rt_entry_dt',datetime(today()))
	dw_1.setcolumn('rt_drier')
end if

end event

type dw_1 from datawindow within w_gteprof016
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 116
integer width = 4709
integer height = 2052
integer taborder = 30
string dataobject = "dw_gteprof016"
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
		dw_1.setitem(newrow,'rt_entry_by',gs_user)
		dw_1.setitem(newrow,'rt_entry_dt',datetime(today()))
		dw_1.setitem(newrow,'rt_reprocess_dt',dw_1.getitemdatetime(currentrow,'rt_reprocess_dt'))
		dw_1.setcolumn('rt_drier')
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
	if lb_neworder =true then
		if row = dw_1.rowcount() then
			dw_1.insertrow(0)
		end if
	end if

	if dwo.name = 'rt_reprocess_dt'  then
		ld_processdt = datetime(data)
		ls_mac_id = dw_1.getitemstring(row,'rt_drier')
		
		if not isnull(ld_processdt) then
			dw_1.setitem(row,'rt_starttime',ld_processdt)
			dw_1.setitem(row,'rt_endtime',ld_processdt)
		end if
		
		select distinct 'x' into :ls_temp from fb_reprocess_tea where trim(rt_drier) = trim(:ls_mac_id) and trunc(rt_reprocess_dt) = trunc(:ld_processdt);
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Dryer Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 0 then
			messagebox('Warning!','Machine Consumption Reading Already Exists Of The Selected Machine For The Entered Date, Please Check !!!')
			return 1
		end if
	end if
	
	if dwo.name = 'rt_starttime'  then
		ld_startdt = datetime(data)
		ld_enddt = dw_1.getitemdatetime(row,'rt_endtime')
		ld_processdt = dw_1.getitemdatetime(row,'rt_reprocess_dt')
	
//		if left(string(ld_startdt),10) <> string(ld_processdt,'dd/mm/yyyy') then
//			messagebox('Warning!', 'Start Date Must Be Same As Reprocessing Date , Please Check !!!')
//			return 1
//		end if
		
		if isnull(right(string(ld_startdt),8)) or right(string(ld_startdt),8) = '00:00:00'  then
			messagebox('Warning!', 'Start Time Must Be Entered, Please Check !!!')
			return 1
		end if
		
		if isnull(ld_enddt) then ld_enddt = datetime(today())
		
//		ld_tot_hrs = wf_cal_datediff(ld_startdt,ld_enddt)
//		if ld_tot_hrs > 0 then
//			dw_1.setitem(row,'ddp_runhours',ld_tot_hrs)
//		end if
	end if
	
	if dwo.name = 'rt_endtime'  then
		ld_enddt = datetime(data)
		ld_startdt = dw_1.getitemdatetime(row,'rt_starttime')
		ld_processdt = dw_1.getitemdatetime(row,'rt_reprocess_dt')
	
		if left(string(ld_enddt),10) <> string(ld_processdt,'dd/mm/yyyy') then
			messagebox('Warning!', 'End Date Must Be Same As Reprocessing Date , Please Check !!!')
			return 1
		end if
		
		if right(string(ld_enddt),8) = '00:00:00' then
			messagebox('Warning!', 'End Time Must Be Entered, Please Check !!!')
			return 1
		end if
		
		if right(string(ld_enddt),8) <= right(string(ld_startdt),8) then
			messagebox('Warning!', 'End Time Must Be > Start Time, Please Check !!!')
			return 1
		end if

//		select round(((:ld_enddt - :ld_startdt) * 24),2) into :ld_tot_hrs from dual;
//		if ld_tot_hrs > 0 then
//			dw_1.setitem(row,'ddp_runhours',ld_tot_hrs)
//		end if
		
		if isnull(ld_startdt) then
			messagebox('Warning!','Please Enter Start Date First !!!')
			return 1
		end if
		
//		ld_tot_hrs = wf_cal_datediff(ld_startdt,ld_enddt)
//	
//		if ld_tot_hrs > 0 then
//			dw_1.setitem(row,'ddp_runhours',ld_tot_hrs)
//		end if
	end if
	
	
//		if dwo.name = 'ddp_startruntime'  then
//		ld_startdt = datetime(data)
////		if string(ld_startdt,'dd/mm/yyyy') <> string(dw_1.getitemdatetime(row,'ddp_pluckingdate'),'dd/mm/yyyy') then
//		if ld_startdt < dw_1.getitemdatetime(row,'ddp_pluckingdate') then
//			messagebox('Warning!', 'Start Date Must Be More or Equal to Plucking Date , Please Check !!!')
//			return 1
//		end if
//		
//		if isnull(right(string(ld_startdt),8)) or right(string(ld_startdt),8) = '00:00:00'  then
//			messagebox('Warning!', 'Start Time Must Be Entered, Please Check !!!')
//			return 1
//		end if
//
//		if isnull(ld_enddt) then ld_enddt = datetime(today())
//		
//		select round(((:ld_enddt - :ld_startdt) * 24),2) into :ld_tot_hrs from dual;
//		if ld_tot_hrs > 0 then
//			dw_1.setitem(row,'ddp_runhours',ld_tot_hrs)
//		end if
//	else
//		ld_startdt = dw_1.getitemdatetime(row,'ddp_startruntime')
//	end if
//	
//	if dwo.name = 'ddp_endruntime'  then
//		ld_enddt = datetime(data)
//		ld_startdt = dw_1.getitemdatetime(row,'ddp_startruntime')
//	
//		if right(string(ld_enddt),8) = '00:00:00' then
//			messagebox('Warning!', 'End Time Must Be Entered, Please Check !!!')
//			return 1
//		end if
//		
//		if left(string(ld_enddt),10) = left(string(ld_startdt),10) and right(string(ld_enddt),8) <= right(string(ld_startdt),8) then
//			messagebox('Warning!', 'End Time Must Be > Start Time, Please Check !!!')
//			return 1
//		end if
//		
//		select round(((:ld_enddt - :ld_startdt) * 24),2) into :ld_tot_hrs from dual;
//		if ld_tot_hrs > 0 then
//			dw_1.setitem(row,'ddp_runhours',ld_tot_hrs)
//		end if
//
//	end if
	
	dw_1.setitem(row,'rt_entry_by',gs_user)
	dw_1.setitem(row,'rt_entry_dt',datetime(today()))
	
	cb_3.enabled = true
end if

end event

