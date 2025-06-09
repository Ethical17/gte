$PBExportHeader$w_gtedsf016.srw
forward
global type w_gtedsf016 from window
end type
type cb_10 from commandbutton within w_gtedsf016
end type
type cb_6 from commandbutton within w_gtedsf016
end type
type cb_5 from commandbutton within w_gtedsf016
end type
type cb_7 from commandbutton within w_gtedsf016
end type
type cb_8 from commandbutton within w_gtedsf016
end type
type cb_9 from commandbutton within w_gtedsf016
end type
type cb_4 from commandbutton within w_gtedsf016
end type
type cb_3 from commandbutton within w_gtedsf016
end type
type cb_2 from commandbutton within w_gtedsf016
end type
type cb_1 from commandbutton within w_gtedsf016
end type
type dw_1 from datawindow within w_gtedsf016
end type
type dw_2 from datawindow within w_gtedsf016
end type
end forward

global type w_gtedsf016 from window
integer width = 4645
integer height = 2548
boolean titlebar = true
string title = "Shade Tree Invoice"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_10 cb_10
cb_6 cb_6
cb_5 cb_5
cb_7 cb_7
cb_8 cb_8
cb_9 cb_9
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
dw_2 dw_2
end type
global w_gtedsf016 w_gtedsf016

type variables
long ll_ctr, ll_cnt,l_ctr,ix,ll_st_year, ll_end_year, ll_user_level,ll_ac_year,ll_gpno,ll_last,ll_stno,lledno,ll_nop,ll_season, ll_tmp, ll_tino,ll_fymm,ll_dlcno
string ls_temp,ls_del_ind,ls_item_id,ls_entry_user,ls_cons,ls_last,ls_count, ls_ref, ls_desc, ls_pinv, ls_dtpdid,ls_adv, ls_gpno, ls_waybill, ls_type,ls_iss_gstn,ls_rec_gstn, ls_tinvno,ls_dlcno,ls_count1
string ls_bname, ls_badd, ls_cname, ls_cadd, ls_gradelist, ls_cnno, ls_cust, ls_brok,ls_lotno, ls_iss_locn, ls_rec_locn,ls_wareid, ls_lutno,ls_fin_yr,ls_msi_id,ls_si_type,ls_uom,ls_rowid
boolean lb_neworder, lb_query
double ld_gwt,ld_trwt,ld_nwt,ld_tgwt,ld_quantity, ld_insval, ld_insrate,ld_totalnwt,ld_advqty,ld_hesc,ld_cess,ld_edcess,ld_adex,ld_toll,ld_igst_per,ld_cgst_per,ld_sgst_per, ld_rate,ld_tot_amt,ld_net_amt
double ld_sgst_amt,ld_cgst_amt,ld_igst_amt,ld_hsn_cd
datetime ld_condt, ld_invdt
datawindowchild idw_item
date ld_dt

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_invno)
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

public function integer wf_check_fillcol (integer fl_row);if dw_2.rowcount() > 0 and fl_row > 0 then
		if ((isnull(dw_2.getitemstring(fl_row,'item_id')) or  len(dw_2.getitemstring(fl_row,'item_id'))=0) or&
			(isnull(dw_2.getitemnumber(fl_row,'sid_quantity')) or  dw_2.getitemnumber(fl_row,'sid_quantity')=0 ) or&
			(isnull(dw_2.getitemnumber(fl_row,'sid_rate')) or  dw_2.getitemnumber(fl_row,'sid_rate')=0 )) then
			 messagebox('Warning: One Of The Following Fields Are Blank','Item ID, Quantity ,Rate Please Check !!!')
			 return -1
		end if
end if
return 1
end function

public function integer wf_check_duplicate_rec (string fs_invno);long fl_row
string ls_inv1

dw_2.SelectRow(0, FALSE)
if dw_2.rowcount() > 1 then
	for fl_row = 1 to (dw_2.rowcount() - 1)
		ls_inv1 = dw_2.getitemstring(fl_row,'item_id')
		
		if trim(ls_inv1) = trim(fs_invno) then
			dw_2.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gtedsf016.create
this.cb_10=create cb_10
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_7=create cb_7
this.cb_8=create cb_8
this.cb_9=create cb_9
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={this.cb_10,&
this.cb_6,&
this.cb_5,&
this.cb_7,&
this.cb_8,&
this.cb_9,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1,&
this.dw_2}
end on

on w_gtedsf016.destroy
destroy(this.cb_10)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_7)
destroy(this.cb_8)
destroy(this.cb_9)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.dw_2)
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

this.tag = Message.StringParm
ll_user_level = long(this.tag)

dw_2.GetChild ("item_id", idw_item)
idw_item.settransobject(sqlca)	

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

type cb_10 from commandbutton within w_gtedsf016
integer x = 1445
integer y = 12
integer width = 457
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Delivery Challan"
end type

event clicked;opensheetwithparm(w_gtedsr017,this.tag,w_mdi,0,layered!)
end event

type cb_6 from commandbutton within w_gtedsf016
integer x = 1097
integer y = 12
integer width = 343
integer height = 100
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Tax Invoice"
end type

event clicked;opensheetwithparm(w_gtedsr016,this.tag,w_mdi,0,layered!)
end event

type cb_5 from commandbutton within w_gtedsf016
integer x = 4073
integer y = 24
integer width = 123
integer height = 88
integer taborder = 90
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

type cb_7 from commandbutton within w_gtedsf016
integer x = 4192
integer y = 24
integer width = 123
integer height = 88
integer taborder = 100
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

type cb_8 from commandbutton within w_gtedsf016
integer x = 4311
integer y = 24
integer width = 123
integer height = 88
integer taborder = 110
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

type cb_9 from commandbutton within w_gtedsf016
integer x = 4430
integer y = 24
integer width = 123
integer height = 88
integer taborder = 120
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

type cb_4 from commandbutton within w_gtedsf016
integer x = 809
integer y = 12
integer width = 265
integer height = 100
integer taborder = 80
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

type cb_3 from commandbutton within w_gtedsf016
integer x = 544
integer y = 12
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
if dw_2.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

ll_dlcno = 0;
ll_gpno = 0;
ll_tino = 0;
if dw_2.rowcount() > 1 then
	if (isnull(dw_2.getitemstring(dw_2.rowcount(),'item_id')) or len(dw_2.getitemstring(dw_2.rowcount(),'item_id')) = 0) then 
		dw_2.deleterow(dw_2.rowcount())
	end if;
end if

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN

	for ix = dw_2.rowcount() to 1 step -1
		if dw_2.getitemstring(ix,'del_flag') = 'Y' and dw_2.rowcount() = dw_2.getitemnumber(ix,'sel_row') then
			messagebox('Warning!','You Cannot Delete All Records From Detail Section !!!')
			return 1
		elseif dw_2.getitemstring(ix,'del_flag') = 'Y' and dw_2.rowcount() <> dw_2.getitemnumber(ix,'sel_row') then
			ld_invdt=dw_1.getitemdatetime(1,'si_date')
			ls_item_id=dw_2.getitemstring( ix,'item_id')
			
			update fb_shade_tree set ST_DESPATCH_DATE=null where ST_ID=:ls_item_id;
			if sqlca.sqlcode = 100 then
				messagebox('Error No Item found while updating',sqlca.sqlerrtext)
				return 1
			elseif sqlca.sqlcode= -1 then
				messagebox('Error While Updating Date in Shade Tree',sqlca.sqlerrtext)
				return 1
			else 
				commit using sqlca; 
			end if
			dw_2.deleterow(ix)
			
		end if
	next	
	
	if dw_2.rowcount() = 0 then
		messagebox('Error','Records Should Be Available In Detail Block')
		return
	end if

	ld_invdt = dw_1.getitemdatetime(dw_1.getrow(),'si_date')
	
	if long(string(today(),'mm')) < 4 then
		ll_st_year  = ((long(string(today(),'YYYY'))-1)*100)+4;
		ll_end_year = (long(string(today(),'YYYY'))*100)+3;
	else
		ll_st_year  = (long(string(today(),'YYYY'))*100)+4;
		ll_end_year = ((long(string(today(),'YYYY'))+1)*100)+3;
	end if;

	ld_invdt = dw_1.getitemdatetime(dw_1.getrow(),'si_date')
	ls_cnno = dw_1.getitemstring(dw_1.getrow(),'si_cn')
	
	
	if dw_2.rowcount() > 0 then
		for ll_ctr = 1 to dw_2.rowcount( ) 
			IF wf_check_fillcol(ll_ctr) = -1 THEN 
				return 1
			end if
			ls_item_id = dw_2.getitemstring(ll_ctr,'item_id')
			ld_quantity = dw_2.getitemnumber(ll_ctr,'sid_quantity')
			ls_lotno =  dw_2.getitemstring(ll_ctr,'sid_rate')
			
		next	
	end if
				

	if dw_1.getitemstatus(dw_1.getrow(),0,primary!) = NewModified! or dw_1.getitemstatus(dw_1.getrow(),0,primary!) = New! then
			
			if long(string(ld_invdt,'mm')) < 4 then
				ll_ac_year = long(string(ld_invdt,'YYYY'))-1
			else
				ll_ac_year = long(string(ld_invdt,'YYYY'))
			end if;
			ls_fin_yr = right(string(ll_ac_year),2)+'-'+ right(string(ll_ac_year+1),2)
		
		if isnull(ls_iss_gstn) then ls_iss_gstn = 'X';
		if isnull(ls_rec_gstn) then ls_rec_gstn = 'X';
		
//======
		if ls_iss_gstn <> ls_rec_gstn then		
			if ll_tino = 0 then
				ll_fymm  =  long(string(dw_1.getitemdatetime(dw_1.getrow(),'si_date'),'yyyymm'))
				

				
				if dw_1.getitemstring(dw_1.getrow(),'si_type') = 'SDTREE' then
					select distinct 'x' into :ls_temp from FB_SERIAL_NO where SN_DOC_TYPE in ('STI') and SN_ACCT_YEAR=:ll_ac_year;
					
					if sqlca.sqlcode = 100 then
						INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'STI', 0, :ll_ac_year); 
						commit using sqlca;
					end if
					
					ll_tino = f_get_lastno('STI',string(ll_ac_year))
				
					if ll_tino < 0 then
						messagebox('Error At Last No Getting',sqlca.sqlerrtext)
						return 1
					end if
				
	
					if ll_tino >= 0 then
						ls_count = string(ll_tino,'000')
						ls_tinvno =gs_garden_snm+"/STI/"+ls_count+"/"+ls_fin_yr					
						dw_1.setitem(dw_1.getrow(),'SI_TAXINVNO',ls_tinvno)	
					end if 
				end if	
			else
				ll_tino =ll_tino + 1
			end if
	
			if not isnull(ls_rec_gstn) and len(ls_rec_gstn) > 0 then	
				declare p2 procedure for up_post_e_invoicing ('SDTI',:ls_tinvno, 'GTEDSF016');
			
				if sqlca.sqlcode = -1 then
					 messagebox('SQL Error: During Procedure Declare',sqlca.sqlerrtext)
					 return 1
				end if
				
				execute p2;
				
				if sqlca.sqlcode = -1 then
					 messagebox('SQL Error: During Procedure Execute',sqlca.sqlerrtext)
					 return 1
				end if		
			end if
		
		elseif ls_iss_gstn = ls_rec_gstn then		
			if ll_dlcno = 0 then
				ll_fymm  =  long(string(dw_1.getitemdatetime(dw_1.getrow(),'si_date'),'yyyymm'))
				

				
				if dw_1.getitemstring(dw_1.getrow(),'si_type') = 'SDTREE' then
					select distinct 'x' into :ls_temp from FB_SERIAL_NO where SN_DOC_TYPE in ('STD') and SN_ACCT_YEAR=:ll_ac_year;
					
					if sqlca.sqlcode = 100 then
						INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'STD', 0, :ll_ac_year); 
						commit using sqlca;
					end if
					
					ll_dlcno = f_get_lastno('STD',string(ll_ac_year))
				
					if ll_dlcno < 0 then
						messagebox('Error At Last No Getting',sqlca.sqlerrtext)
						return 1
					end if
				
	
					if ll_dlcno >= 0 then
						ls_count = string(ll_dlcno,'000')
						ls_dlcno =gs_garden_snm+"/STD/"+ls_count+"/"+ls_fin_yr					
						dw_1.setitem(dw_1.getrow(),'SI_DELVCHNO',ls_dlcno)	
					end if 
				end if
			else 
				ll_dlcno = ll_dlcno + 1
			end if
		end if
			
		if ll_last=0 then
			select nvl(MAX(substr(SI_ID,4,10)),0) into :ll_last from FB_SHADETREE_SALEINVOICE;
		end if
		ll_last = ll_last + 1
		ls_msi_id = 'STI'+string(ll_last,'0000000000')
		dw_1.setitem(dw_1.getrow(),'si_id',ls_msi_id)
		for ix = 1 to dw_2.rowcount()
			dw_2.setitem(ix,'si_id',ls_msi_id)
		next
	end if	

	/////end invoice number generation
	
	if dw_1.update(true,false) = 1 and dw_2.update(true,false) = 1 then
		if dw_1.getitemstatus(dw_1.getrow(),0,primary!) = NewModified! or dw_1.getitemstatus(dw_1.getrow(),0,primary!) = New! then		
			if ll_tino > 0 then
				///update last no
				if ls_iss_gstn <> ls_rec_gstn then	

					if dw_1.getitemstring(dw_1.getrow(),'si_type') = 'SDTREE' then 
						if f_upd_lastno('STI',string(ll_ac_year),ll_tino) = -1 then
							rollback using sqlca;			
							return 1
						end if	
					end if
				end if
			end if
			if ll_dlcno > 0 then

				if dw_1.getitemstring(dw_1.getrow(),'si_type') = 'SDTREE' then 
					if f_upd_lastno('STD',string(ll_ac_year),ll_tino) = -1 then
						rollback using sqlca;			
						return 1
					end if	
				end if	
			end if
		end if
		
		
			// Update despatch date,rate,UOM in shade tree 	
		 ll_ctr  = dw_2.rowcount()
		 for ll_ctr  = dw_2.rowcount() to 1 step -1
			ld_invdt=dw_1.getitemdatetime(1,'si_date')
			ls_item_id=dw_2.getitemstring( ll_ctr,'item_id')
			ld_rate=dw_2.getitemnumber(ll_ctr,'sid_rate')
			ls_uom=dw_2.getitemstring(ll_ctr,'item_uom')
				
			update fb_shade_tree set ST_DESPATCH_DATE=:ld_invdt,ST_CURR_RATE=:ld_rate,ST_RATE_UNIT=:ls_uom where ST_ID=:ls_item_id;
			if sqlca.sqlcode = 100 then
				messagebox('Error No Item found while updating',sqlca.sqlerrtext)
				return 1
			elseif sqlca.sqlcode= -1 then
				messagebox('Error While Updating Date in Shade Tree',sqlca.sqlerrtext)
				return 1
			else 
				commit using sqlca; 
			end if
		next
	//	
		
		dw_2.resetupdate();
		dw_1.resetupdate();
		commit using sqlca;
		cb_3.enabled = false
		cb_1.enabled = true
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

type cb_2 from commandbutton within w_gtedsf016
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
	cb_1.enabled = false
	dw_1.settaborder('si_id',5)
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('si_id')
	cb_2.text = "&Run"
	cb_3.enabled = false
else
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user,gs_garden_snm)
 	dw_1.TriggerEvent(rowfocuschanged!)
	dw_1.SetRedraw (TRUE)
	dw_1.settaborder('si_id',0)
	cb_2.text = "&Query"
   	cb_5.enabled = true
   	cb_7.enabled = true
   	cb_8.enabled = true
   	cb_9.enabled = true
	cb_1.enabled = true
end if
lb_neworder = false

end event

type cb_1 from commandbutton within w_gtedsf016
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
	dw_1.setitem(dw_1.getrow(),'si_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'si_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'si_date',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'ra_gsn',gs_garden_snm)
	dw_1.setitem(dw_1.getrow(),'si_iss_locn',gs_gstn_stcd)
	dw_1.setitem(dw_1.getrow(),'si_iss_gstnno',gs_gstnno)	
	dw_1.setcolumn('si_type')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'si_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'si_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'si_date',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'ra_gsn',gs_garden_snm)
	dw_1.setitem(dw_1.getrow(),'si_iss_locn',gs_gstn_stcd)
	dw_1.setitem(dw_1.getrow(),'si_iss_gstnno',gs_gstnno)	
	dw_1.setcolumn('si_type')
end if
cb_1.enabled = false

end event

type dw_1 from datawindow within w_gtedsf016
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 9
integer y = 116
integer width = 4576
integer height = 1016
integer taborder = 30
string dataobject = "dw_gtedsf016"
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'si_entry_by',gs_user)
		dw_1.setitem(newrow,'si_entry_dt',datetime(today()))
		dw_1.setcolumn('si_type')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;if lb_query = false then
	if dwo.name = 'si_type' then
		idw_item.settransobject(sqlca)	
		ls_si_type = data
		idw_item.SetFilter ("item_type = '"+trim(ls_si_type)+"'") 
		idw_item.filter( )
	end if

	
	if dwo.name = 'si_date'  then
		ld_invdt = datetime(data)
		if date(ld_invdt) > today() then
			messagebox('Warning!','Invoice Date Should Not Be > Current date, Please Check !!!')
			return 1
		end if
		
		if long(string(today(),'mm')) < 4 then
			ll_st_year  = ((long(string(today(),'YYYY'))-1)*100)+4;
			ll_end_year = (long(string(today(),'YYYY'))*100)+3;
		else
			ll_st_year  = (long(string(today(),'YYYY'))*100)+4;
			ll_end_year = ((long(string(today(),'YYYY'))+1)*100)+3;
		end if;
	else 
		ld_invdt = dw_1.getitemdatetime(row,'si_date')
	end if
	
	if dwo.name = 'cus_id'  then
		ls_cust = trim(data)
		
		select CUS_GSTN_STCD, cus_gstnno  into :ls_rec_locn, :ls_rec_gstn from fb_customer  where CUS_ID = :ls_cust;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error During Select Of Customer Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 100 then
			messagebox('Warning!','Customer Not In Master, Please Check !!!')
			rollback using sqlca;
			return 1
		end if	
		dw_1.setitem(row,'si_rec_locn',ls_rec_locn)	
		dw_1.setitem(row,'si_rec_gstnno',ls_rec_gstn)		
		ls_iss_locn = dw_1.getitemstring(row,'si_iss_locn')
		ls_rec_locn = dw_1.getitemstring(row,'si_rec_locn')	
		if isnull(ls_rec_locn) or len(ls_rec_locn) = 0 then
			messagebox('Warning!','Customer GSTN State Is Blank, Please Update Now !!!')
			rollback using sqlca;
			return 1
		end if
		select cus_gstnno into :ls_rec_gstn from fb_customer where cus_id = :ls_cust;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Recving GSTIN',sqlca.sqlerrtext)
			return 1
		end if 
		select UNIT_GSTNNO into :ls_iss_gstn from fb_gardenmaster where unit_active_ind = 'Y';
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Issue GSTIN',sqlca.sqlerrtext)
			return 1
		end if 
	end if
		
	if lb_neworder = true and dw_2.rowcount() = 0 then
		dw_2.setfocus() 
		dw_2.insertrow(0)
		dw_1.setfocus()
	end if;

	
	if dwo.name = 'si_cndate'  then
		ld_invdt = dw_1.getitemdatetime(row,'si_date')
		ld_condt = datetime(data)
		if date(ld_condt) < date(ld_invdt) then
			messagebox('Warning!','Consignment Date Should Be >= Invoice Date, Please Check !!!')
			return 1
		end if
		
		if long(string(today(),'mm')) < 4 then
			ll_st_year  = ((long(string(today(),'YYYY'))-1)*100)+4;
			ll_end_year = (long(string(today(),'YYYY'))*100)+3;
		else
			ll_st_year  = (long(string(today(),'YYYY'))*100)+4;
			ll_end_year = ((long(string(today(),'YYYY'))+1)*100)+3;
		end if;	
	end if
	
	if dwo.name = 'si_cn'  then	
		if f_check_initial_space(data) = -1 then return 1
//		if f_check_string_sp(data) = -1 then return 1
	end if
	
	if dwo.name = 'si_ship_to_add' then
		dw_2.setfocus()
		dw_2.setcolumn('item_id')
	end if

	if not isnull(dw_1.getitemstring(row,'si_taxinvno')) and dwo.name = 'si_einv_ind' and data = 'Y' then
		if MessageBox("Alert", 'Do You Want To Confirm For E-invoice ....?' ,Exclamation!, YesNo!, 1) = 1 then
			ls_tinvno = dw_1.getitemstring(row,'si_taxinvno')
			select distinct 'x' into :ls_temp from fb_einvoice where docno = :ls_tinvno;
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error: During checking existing records',sqlca.sqlerrtext)
				return 1
			elseif sqlca.sqlcode = 0 then
				messagebox('Warning','Record already exists for this taxinvoice in E-invoice data')
				return 1
			end if
			declare p2 procedure for up_post_e_invoicing ('SDTI',:ls_tinvno, 'GTEDSF016');
			
			if sqlca.sqlcode = -1 then
				 messagebox('SQL Error: During Procedure Declare',sqlca.sqlerrtext)
				 return 1
			end if
			
			execute p2;
			
			if sqlca.sqlcode = -1 then
				 messagebox('SQL Error: During Procedure Execute',sqlca.sqlerrtext)
				 return 1
			end if			
		else
			return 1
		end if
	end if
	
	dw_1.setitem(row,'si_entry_by',gs_user)
	dw_1.setitem(row,'si_entry_dt',datetime(today()))
	dw_1.setitem(row,'unit_id',gs_unit)

	
	cb_3.enabled = true
end if
end event

event rowfocuschanged;if lb_query = false then
	if lb_neworder = false  then
		if dw_1.rowcount() > 0 then
			ls_ref = dw_1.getitemstring(dw_1.getrow(),'si_id')
			dw_2.reset()
			dw_2.retrieve(ls_ref)
		end if
	end if
end if
end event

type dw_2 from datawindow within w_gtedsf016
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 402
integer y = 1152
integer width = 3726
integer height = 1200
integer taborder = 40
string dataobject = "dw_gtedsf016a"
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
	if dw_2.rowcount() > 1 then
		dw_2.setitem(newrow,'si_id',dw_2.getitemstring(currentrow,'si_id'))
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;//if lb_neworder = true then
//	IF KeyDown(KeyF6!) THEN
//		dw_2.deleterow(dw_2.getrow())
//	end if
//	if dw_2.rowcount() = 0 then
//		cb_3.enabled = false
//	end if
//end if
//
end event

event ue_keydwn;//if lb_neworder = true then
//	IF KeyDown(KeyF6!) THEN
//		dw_2.deleterow(dw_2.getrow())
//	end if
//	if dw_2.rowcount() = 0 then
//		cb_3.enabled = false
//	end if
//end if
//
end event

event itemchanged;if dwo.name = 'item_id' then
	if  wf_check_duplicate_rec(data) = -1 then return 1
	ld_quantity = 0; 
	ld_rate = 0;
	ld_tot_amt = 0;
	ld_net_amt= 0;
	ld_sgst_per= 0;
	ld_sgst_amt= 0;
	ld_cgst_per= 0;
	ld_cgst_amt= 0;
	ld_igst_per= 0;
	ld_igst_amt= 0;
	dw_2.setitem(dw_2.getrow(),'sid_quantity',ld_quantity)
	dw_2.setitem(dw_2.getrow(),'sid_rate',ld_rate)
	dw_2.setitem(dw_2.getrow(),'tot_amt',ld_tot_amt)
	dw_2.setitem(dw_2.getrow(),'net_amt',ld_net_amt)
	dw_2.setitem(dw_2.getrow(),'sid_sgst_per',ld_sgst_per)
	dw_2.setitem(dw_2.getrow(),'sid_sgst_amt',ld_sgst_amt)
	dw_2.setitem(dw_2.getrow(),'sid_cgst_per',ld_cgst_per)
	dw_2.setitem(dw_2.getrow(),'sid_cgst_amt',ld_cgst_amt)
	dw_2.setitem(dw_2.getrow(),'sid_igst_per',ld_igst_per)
	dw_2.setitem(dw_2.getrow(),'sid_igst_amt',ld_igst_amt)
end if 
if dwo.name ='item_uom' then
	ls_Uom=data
	if ls_Uom='CFT' then
		ld_hsn_cd =dw_2.getitemnumber(row,'item_hsn')
		ls_item_id=dw_2.getitemstring(row,'item_id')
		select ST_VOLUME into :ld_quantity from fb_shade_tree where  ST_ID=:ls_item_id;
		if sqlca.sqlcode = -1 then 
			messagebox('Sql Error','Error During Getting Rate & Quantity : '+sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 100 then 
			messagebox('Error','Item Rate/Quanatity Missing, Please Check !!!')
			return 1
		else
		dw_2.setitem(row,'sid_quantity',ld_quantity)
		end if
	else 
		dw_2.setitem(row,'sid_quantity',0)
		dw_2.setitem(row,'sid_rate',0)
		dw_2.setitem(row,'sid_igst_per',0)
		dw_2.setitem(row,'sid_cgst_amt',0) 
		dw_2.setitem(row,'sid_sgst_amt',0) 
	 	dw_2.setitem(row,'sid_cgst_per',0) 
		dw_2.setitem(row,'sid_sgst_per',0) 				
		dw_2.setitem(row,'sid_igst_amt',0) 			
	end if	
end if

if dwo.name = 'sid_rate' then
	ls_item_id=dw_2.getitemstring(row,'item_id')
	ld_hsn_cd =dw_2.getitemnumber(row,'item_hsn')
		ld_quantity = double(dw_2.getitemnumber(dw_2.getrow(),'sid_quantity'))	
		ld_rate = double(data)
		ld_tot_amt = ld_quantity*ld_rate
	
		if ls_iss_gstn <> ls_rec_gstn then
			select nvl(HM_CGST_RATE,0), nvl(HM_SGST_RATE,0), nvl(HM_IGST_RATE,0) into :ld_cgst_per, :ld_sgst_per, :ld_igst_per
			from fb_hsn_master where HM_HSN_code = :ld_hsn_cd and trunc(:ld_invdt) between trunc(HM_FROM_DT) and trunc(nvl(HM_TO_DT,sysdate)) and HM_APPROVED_DT is not null;
			if sqlca.sqlcode = -1 then 
				messagebox('Sql Error','Error During Getting HSN Code : '+sqlca.sqlerrtext)
				return 1
			elseif sqlca.sqlcode = 100 then 
				messagebox('Error','Item HSN Code/Rate Is Missing, Please Check !!!')
				return 1
			end if;				
			if ls_iss_locn = ls_rec_locn then
				ld_igst_per = 0
			elseif ls_iss_locn <> ls_rec_locn then
				ld_cgst_per = 0; ld_sgst_per = 0;
			end if
		
			if ld_igst_per > 0 then
				ld_cgst_per = 0
				ld_sgst_per = 0
				dw_2.setitem(row,'sid_cgst_per',0)
				dw_2.setitem(row,'sid_sgst_per',0)
				ld_igst_amt = ((ld_quantity * ld_rate) *(ld_igst_per/100))
				dw_2.setitem(row,'sid_igst_amt',ld_igst_amt) 
				dw_2.setitem(row,'sid_igst_per',ld_igst_per)
				dw_2.setitem(row,'sid_cgst_amt',0) 
				dw_2.setitem(row,'sid_sgst_amt',0) 
			elseif ld_cgst_per > 0 or ld_sgst_per > 0 then
				ld_igst_per = 0
				dw_2.setitem(row,'sid_igst_per',0)
				ld_cgst_amt = ((ld_quantity * ld_rate) *(ld_cgst_per/100))
				ld_sgst_amt = ((ld_quantity * ld_rate) *(ld_sgst_per/100))
				dw_2.setitem(row,'sid_cgst_amt',ld_cgst_amt) 
				dw_2.setitem(row,'sid_sgst_amt',ld_sgst_amt) 
				dw_2.setitem(row,'sid_cgst_per',ld_cgst_per) 
				dw_2.setitem(row,'sid_sgst_per',ld_sgst_per) 				
				dw_2.setitem(row,'sid_igst_amt',0) 				
			end if
		else
			ld_cgst_per = 0; ld_cgst_per = 0; ld_igst_per = 0;
			dw_2.setitem(row,'sid_igst_per',0)
			dw_2.setitem(row,'sid_cgst_amt',0) 
			dw_2.setitem(row,'sid_sgst_amt',0) 
			dw_2.setitem(row,'sid_cgst_per',0) 
			dw_2.setitem(row,'sid_sgst_per',0) 				
			dw_2.setitem(row,'sid_igst_amt',0) 			
		end if
		ld_net_amt = ld_tot_amt+ld_cgst_amt+ld_sgst_amt+ld_igst_amt
	end if


if lb_neworder = true then
	if row = dw_2.rowcount() and dwo.name <> 'del_flag'  then
		dw_2.insertrow(0)
	end if
end if
cb_3.enabled = true
end event

