$PBExportHeader$w_gteinf010.srw
forward
global type w_gteinf010 from window
end type
type cb_10 from commandbutton within w_gteinf010
end type
type cb_9 from commandbutton within w_gteinf010
end type
type cb_8 from commandbutton within w_gteinf010
end type
type cb_7 from commandbutton within w_gteinf010
end type
type cb_5 from commandbutton within w_gteinf010
end type
type cb_6 from commandbutton within w_gteinf010
end type
type cbx_1 from checkbox within w_gteinf010
end type
type em_1 from editmask within w_gteinf010
end type
type st_1 from statictext within w_gteinf010
end type
type dw_2 from datawindow within w_gteinf010
end type
type cb_4 from commandbutton within w_gteinf010
end type
type cb_3 from commandbutton within w_gteinf010
end type
type cb_2 from commandbutton within w_gteinf010
end type
type cb_1 from commandbutton within w_gteinf010
end type
type dw_1 from datawindow within w_gteinf010
end type
end forward

global type w_gteinf010 from window
integer width = 4539
integer height = 1992
boolean titlebar = true
string title = "(w_gteinf010) Stock Receive From Other Unit"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_10 cb_10
cb_9 cb_9
cb_8 cb_8
cb_7 cb_7
cb_5 cb_5
cb_6 cb_6
cbx_1 cbx_1
em_1 em_1
st_1 st_1
dw_2 dw_2
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gteinf010 w_gteinf010

type variables
long ll_ctr,ll_cnt,ll_last,ll_user_level,ll_ctr2
string ls_temp,ls_sp_id,ls_spc_id,ls_tmp_id,ls_appr_ind,ls_ac_dt,ls_div,ls_spname,ls_date,ls_id
boolean lb_neworder, lb_query
double ld_efunit_price,ld_stock,ld_req_qty,ld_tot_val,ld_qnty,ll_value,ll_rate,ll_qty
datawindowchild idw_prod,idw_spcid
datetime ld_trandt,ld_stock_dt,ld_dt
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
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
	if (isnull(dw_2.getitemstring(fl_row,'sp_id')) or  len(dw_2.getitemstring(fl_row,'sp_id'))=0 or &
	    isnull(dw_2.getitemnumber(fl_row,'pris_reqquantity')) or dw_2.getitemnumber(fl_row,'pris_reqquantity') = 0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Product, required Quantity Please Check !!!')
	    return -1
	end if
end if
return 1



end function

public function integer wf_check_duplicate_rec (string fs_con_id);long fl_row
string ls_con_id1
datetime ld_run_dt1

dw_2.SelectRow(0, FALSE)
if dw_2.rowcount() > 1 then
	for fl_row = 1 to (dw_2.rowcount() - 1)
		ls_con_id1 = dw_2.getitemstring(fl_row,'sp_id')
		
		if ls_con_id1 = fs_con_id  then
			dw_2.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gteinf010.create
this.cb_10=create cb_10
this.cb_9=create cb_9
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_5=create cb_5
this.cb_6=create cb_6
this.cbx_1=create cbx_1
this.em_1=create em_1
this.st_1=create st_1
this.dw_2=create dw_2
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_10,&
this.cb_9,&
this.cb_8,&
this.cb_7,&
this.cb_5,&
this.cb_6,&
this.cbx_1,&
this.em_1,&
this.st_1,&
this.dw_2,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gteinf010.destroy
destroy(this.cb_10)
destroy(this.cb_9)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_5)
destroy(this.cb_6)
destroy(this.cbx_1)
destroy(this.em_1)
destroy(this.st_1)
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

dw_1.GetChild ("sup_id", idw_spcid)
idw_spcid.settransobject(sqlca)


this.tag = Message.StringParm
ll_user_level = long(this.tag)

if ll_user_level =1 then
	em_1.visible = true
     cbx_1.visible = true
	cb_6.visible = true
	st_1.visible = true	  
else
	em_1.visible = false
     cbx_1.visible = false
	cb_6.visible = false
	st_1.visible = false	  	
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

type cb_10 from commandbutton within w_gteinf010
boolean visible = false
integer x = 3346
integer width = 343
integer height = 104
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "A/C Process"
end type

event clicked; n_fames luo_fames
 luo_fames = Create n_fames
 
 if isdate(em_1.text) = false then
	messagebox('Error :','Please Enter Valid Account Process date')
	rollback using sqlca;
	return 1;
else
	ls_ac_dt=em_1.text 
end if;	

if f_check_mep(ls_ac_dt) = -1 then return 1

select max(DS_DATE) into :ld_stock_dt from fb_daily_stock;

 if date(ls_ac_dt) < date(ld_stock_dt) then
	MESSAGEBOX('Error:','The Posting date Should be greater than equal to Last Stock Transaction Date i.e. '+string(ld_stock_dt,'dd/mm/yyyy'))
	return 1;
end if;	

	 if date(ls_ac_dt) > date(today()) then
		MESSAGEBOX('Error:','The Issue date Should be Less than equal to Current System Date i.e. '+string(today(),'dd/mm/yyyy'))
		return 1;
	end if;
select distinct 'x' into :ls_temp from FB_SERIAL_NO 
where SN_DOC_TYPE in ('JV','CV','BV') and SN_ACCT_YEAR=to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm');

if sqlca.sqlcode = 100 then
	INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
	INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
	INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
	commit using sqlca;
end if

if f_check_fin_yr(datetime(ls_ac_dt)) = -1 then;	return 1;end if;
	for ll_cnt = 1 to dw_1.rowcount() 
		if dw_1.getitemstring(ll_cnt,'appr_flag') = 'Y'  and isnull(dw_1.getitemstring(ll_cnt,'pris_vou_no'))=true then
			//update stock			
				dw_1.setitem(ll_cnt,'pris_stockind','Y')	
			  
				if isnull(gs_storeid) or len(gs_storeid) = 0 then
					messagebox('Warning','Main Store Division Not Define, Please Check')
					rollback using sqlca;
					return 1;
				end if;
				
//				if f_stocktransfer_fifo(dw_1.getitemstring(dw_1.getrow(),'pris_id'),gs_storeid) = -1 then 
//					return 1
//				end if;
				  
				for ll_ctr2 = 1 to dw_2.rowcount()		
					 dw_2.setitem(ll_ctr2,'pris_id',ls_tmp_id)		
										
						//update Stock Quantity
						// for issue
//						if luo_fames.wf_upd_dailystock(dw_1.getitemstring(dw_1.getrow(),'pris_id'),string(dw_1.getitemdatetime(dw_1.getrow(),'pris_date'),'dd/mm/yyyy'),dw_2.getitemstring(ll_ctr2,'sp_id'),dw_2.getitemnumber(ll_ctr2,'pris_issuequantity'),dw_2.getitemnumber(ll_ctr2,'unitprice'),dw_2.getitemnumber(ll_ctr2,'pris_value'),'Stock Transfer','I','N',gs_storeid) = -1 then 
//							rollback using sqlca;
//							return 1;
//						end if;		

						// for Received from Unit
						//if dw_1.getitemstring(dw_1.getrow(),'pris_transferto_ind')='D'  then
							if luo_fames.wf_upd_dailystock(dw_1.getitemstring(dw_1.getrow(),'pris_id'),string(dw_1.getitemdatetime(dw_1.getrow(),'pris_date'),'dd/mm/yyyy'),dw_2.getitemstring(ll_ctr2,'sp_id'),dw_2.getitemnumber(ll_ctr2,'pris_issuequantity'),dw_2.getitemnumber(ll_ctr2,'unitprice'),dw_2.getitemnumber(ll_ctr2,'pris_value'),'Stock Transfer From Other Unit','R','N',gs_storeid) = -1 then 
								rollback using sqlca;
								return 1;
							end if;		
						//end if;
				next
			////
			  if dw_1.getitemstring(dw_1.getrow(),'pris_transferto_ind')='U'  then
				if luo_fames.wf_unitstore_transfer_ac(dw_1.getitemstring(ll_cnt,'pris_id'),ls_ac_dt) = -1 then 
					rollback using sqlca;
					return 1;
				end if;	
			else
				dw_1.setitem(ll_cnt,'pris_vou_no','99999')	
				dw_1.setitem(ll_cnt,'pris_vou_dt',datetime(today()))	
			end if;
		end if
	next	
	
dw_1.update( )
commit using sqlca;

DESTROY n_fames
dw_1.reset()
dw_2.reset()
messagebox('Information;',' JV Created Successfully')
cb_6.enabled = false
end event

type cb_9 from commandbutton within w_gteinf010
integer x = 4347
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
string text = ">>"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrolltoRow(dw_1.rowcount())
end if
end event

type cb_8 from commandbutton within w_gteinf010
integer x = 4229
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
string text = ">"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrollnextRow()
end if
end event

type cb_7 from commandbutton within w_gteinf010
integer x = 4110
integer y = 24
integer width = 123
integer height = 88
integer taborder = 80
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

type cb_5 from commandbutton within w_gteinf010
integer x = 3991
integer y = 24
integer width = 123
integer height = 88
integer taborder = 70
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

type cb_6 from commandbutton within w_gteinf010
integer x = 2670
integer y = 8
integer width = 343
integer height = 104
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "A/C Process"
end type

event clicked; n_fames luo_fames
 luo_fames = Create n_fames
 
 if isdate(em_1.text) = false then
	messagebox('Error :','Please Enter Valid Account Process date')
	rollback using sqlca;
	return 1;
else
	ls_ac_dt=em_1.text 
end if;	

if f_check_mep(ls_ac_dt) = -1 then return 1

select max(DS_DATE) into :ld_stock_dt from fb_daily_stock;

 if date(ls_ac_dt) < date(ld_stock_dt) then
	MESSAGEBOX('Error:','The Posting date Should be greater than equal to Last Stock Transaction Date i.e. '+string(ld_stock_dt,'dd/mm/yyyy'))
	return 1;
end if;	

	 if date(ls_ac_dt) > date(today()) then
		MESSAGEBOX('Error:','The Issue date Should be Less than equal to Current System Date i.e. '+string(today(),'dd/mm/yyyy'))
		return 1;
	end if;
select distinct 'x' into :ls_temp from FB_SERIAL_NO 
where SN_DOC_TYPE in ('JV','CV','BV') and SN_ACCT_YEAR=to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm');

if sqlca.sqlcode = 100 then
	INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
	INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
	INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
	commit using sqlca;
end if

if f_check_fin_yr(datetime(ls_ac_dt)) = -1 then;	return 1;end if;
	for ll_cnt = 1 to dw_1.rowcount() 
		if dw_1.getitemstring(ll_cnt,'appr_flag') = 'Y'  and isnull(dw_1.getitemstring(ll_cnt,'pris_vou_no'))=true then
			//update stock			
				dw_1.setitem(ll_cnt,'pris_stockind','Y')	
			  
				if isnull(gs_storeid) or len(gs_storeid) = 0 then
					messagebox('Warning','Main Store Division Not Define, Please Check')
					rollback using sqlca;
					return 1;
				end if;
				
				
				ls_id =dw_1.getitemstring(ll_cnt,'pris_id')
			  
				declare p2 procedure for up_unit_transfer_stock (:ls_id,to_date(:ls_ac_dt,'dd/mm/yyyy'),'Stock Transfer From Other Unit',:gs_storeid,:gs_user,:gs_CO_ID,:gs_garden_snm);
						
				if sqlca.sqlcode = -1 then
					 messagebox('SQL Error: During Procedure Declare of up_unit_transfer_stock',sqlca.sqlerrtext)
					 return 1
				end if
						
				execute p2;
				if sqlca.sqlcode = -1 then
					messagebox('SQL Error: During Procedure Execute of up_unit_transfer_stock',sqlca.sqlerrtext)
					 return 1
				end if
//			  if dw_1.getitemstring(dw_1.getrow(),'pris_transferto_ind')='U'  then
//				if luo_fames.wf_unitstore_transfer_ac(dw_1.getitemstring(ll_cnt,'pris_id'),ls_ac_dt) = -1 then 
//					rollback using sqlca;
//					return 1;
//				end if;	
//			else
//				dw_1.setitem(ll_cnt,'pris_vou_no','99999')	
//				dw_1.setitem(ll_cnt,'pris_vou_dt',datetime(today()))	
//			end if;
		end if
	next	
	
dw_1.update( )
commit using sqlca;

DESTROY n_fames
dw_1.reset()
dw_2.reset()
messagebox('Information;',' JV Created Successfully')
cb_6.enabled = false
end event

type cbx_1 from checkbox within w_gteinf010
integer x = 1198
integer y = 24
integer width = 475
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Un Approved"
boolean checked = true
end type

type em_1 from editmask within w_gteinf010
integer x = 2181
integer y = 20
integer width = 411
integer height = 84
integer taborder = 60
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
	messagebox('Error At Process date','Please Enter Account Process date...!')
	cb_6.enabled = false	
	return 1
else
	ls_temp=em_1.text
	if cb_3.enabled = true then
		messagebox('Warning!','You Have Made Some Changes, Please Save First !!!');
		return 1
	end if
	if dw_1.getitemstring(dw_1.getrow(),'appr_flag') = 'Y' then
		cb_6.enabled = true
	end if
end if;	
end event

type st_1 from statictext within w_gteinf010
integer x = 1669
integer y = 32
integer width = 498
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = " A/C Process Date :"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_gteinf010
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 5
integer y = 708
integer width = 4471
integer height = 1160
integer taborder = 40
string dataobject = "dw_gteinf010a"
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

event itemchanged;if dwo.name = 'spc_id' then
	ls_spc_id = data
	idw_prod.SetFilter ("spc_id = '"+trim(data)+"'") 
	idw_prod.filter( )
end if

if row = dw_2.rowcount() and dwo.name <> 'del_flag'  then
		  dw_2.insertrow(0)
end if


if dwo.name = 'sp_id' then
	ld_dt = dw_1.getitemdatetime(dw_1.getrow(),'pris_reqdate')
	ls_sp_id = trim(data)
	
	select max(DS_DATE) into :ld_stock_dt from fb_daily_stock where  DS_ITEM_CD = :ls_sp_id;
	
	select sp_name into :ls_spname from fb_storeproduct where sp_id = :ls_sp_id;

	 if date(ld_dt) < date(ld_stock_dt) then
		MESSAGEBOX('Error:','The Transfer date Should be greater than equal to Last Stock Transaction Date i.e. '+string(ld_stock_dt,'dd/mm/yyyy')+' Of Item '+ls_spname+' ('+ls_sp_id+')')
		return 1;
	end if;

	ls_div=dw_1.getitemstring(dw_1.getrow(),'pris_from_sup_id')
	
	//current stock Shyamguri T.E. = :gs_storeid 
	select sum(decode(ds_rec_ind,'I',-1,1)*ds_QTY) into  :ld_stock
	   from fb_daily_stock
	 where trunc(ds_date) <= trunc(sysdate) and ds_item_cd=:ls_sp_id and DS_SECTION_ID=:ls_div
	  group by ds_item_cd;
	
	if sqlca.sqlcode = -1 then
	   messagebox('Error During Select Of Available Stock',sqlca.sqlerrtext)
	   rollback using sqlca;
	   return 1
	end if	

	if  wf_check_duplicate_rec(data) = -1 then return 1
	dw_2.setitem(row,'avl_stock',ld_stock)	
	
//	select spp_effectiveunitprice into  :ld_efunit_price from fb_storeproductprice 
//     where spp_stock > 0 and sp_id=(select sp_id from FB_storeproduct where sp_id=:ls_sp_id);
//	  
//	 if sqlca.sqlcode = -1 then
//	   messagebox('Error During Select Of Unit Price',sqlca.sqlerrtext)
//	   rollback using sqlca;
//	   return 1
//	end if	

//	ld_efunit_price =100
//	
//	dw_2.setitem(row,'unitprice',ld_efunit_price)	 
//	
//	if ld_efunit_price=0 then
//		messagebox('Error:','Please Check unit price of this item not present in master')
//		return 1;
//	end if;	
	
end if;	

if dwo.name = 'pris_reqquantity' then
	ld_req_qty = double(data)
	dw_2.setitem(row,'pris_issuequantity',ld_req_qty)	
	
	if not isnull(dw_2.getitemnumber(row,'unitprice')) then
		ld_efunit_price =dw_2.getitemnumber(row,'unitprice')
		ld_tot_val = truncate((ld_req_qty * ld_efunit_price),2)
		dw_2.setitem(row,'pris_value',ld_tot_val)
	end if
	
end if;	

if dwo.name = 'pris_issuequantity' then
	ld_qnty = double(data)
	
	ld_stock = dw_2.getitemnumber(row,'avl_stock')
	ld_req_qty = dw_2.getitemnumber(row,'pris_reqquantity')
		
	if ld_qnty > ld_stock then
		messagebox('Error:','Issue quantity should be less or equal to Stock quantity')
		return 1;
	end if;	
	
	if ld_qnty > ld_req_qty then
		messagebox('Error:','Issue quantity should be less than Required quantity')
		return 1;
	end if;	
	
	if not isnull(dw_2.getitemnumber(row,'unitprice')) then
		ld_tot_val =0
		ld_efunit_price =dw_2.getitemnumber(row,'unitprice')
		ld_tot_val = truncate((ld_qnty * ld_efunit_price),2)
		dw_2.setitem(row,'pris_value',ld_tot_val)
	end if
end if;

if dwo.name = 'unitprice' then
	if not isnull(dw_2.getitemnumber(row,'pris_issuequantity')) then
		ld_qnty = dw_2.getitemnumber(row,'pris_issuequantity')
		ld_efunit_price =double(data)
		ld_tot_val = truncate((ld_qnty * ld_efunit_price),2)
		dw_2.setitem(row,'pris_value',ld_tot_val)
	end if
end if

cb_3.enabled = true
end event

type cb_4 from commandbutton within w_gteinf010
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

type cb_3 from commandbutton within w_gteinf010
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
	if (isnull(dw_2.getitemstring(dw_2.rowcount(),'pris_id')) or len(dw_2.getitemstring(dw_2.rowcount(),'pris_id')) = 0) then 
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

	if (isnull(dw_1.getitemdatetime(dw_1.getrow(),'pris_reqdate')) or isnull(dw_1.getitemdatetime(dw_1.getrow(),'pris_reqdate'))) then
		messagebox('Warning:','One Of The Fields Are Blank : Required/Issue Date !!!')
		dw_1.setfocus()
		dw_1.setcolumn('pris_reqdate')
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
			select nvl(MAX(substr(pris_id,4,10)),0) into :ll_last from fb_producttransfer;
		end if
			ld_trandt = dw_1.getitemdatetime(dw_1.getrow(),'pris_reqdate')
			ll_last = ll_last + 1
			ls_tmp_id = 'REC'+string(ll_last,'0000000000') 
			dw_1.setitem(dw_1.getrow(),'pris_id',ls_tmp_id)	
			dw_1.setitem(dw_1.getrow(),'pris_date',ld_trandt)
		else
			ls_tmp_id =dw_1.getitemstring(dw_1.getrow(),'pris_id')
		end if;		
		
		for ll_ctr = 1 to dw_2.rowcount()		
			 dw_2.setitem(ll_ctr,'pris_id',ls_tmp_id)		
		next

	end if		
	
	if dw_1.update(true,false) = 1 then
		if dw_2.update(true,false) = 1 then
			dw_2.resetupdate();
			dw_1.resetupdate();
			commit using sqlca;
			cb_3.enabled = false
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

end event

type cb_2 from commandbutton within w_gteinf010
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

event clicked;if cbx_1.checked then
	ls_appr_ind = 'Y';
else
	ls_appr_ind = 'N';
end if

if cb_2.text = "&Query" then
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
	dw_1.settaborder('pris_reqdate',10)
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('pris_reqdate')
	cb_2.text = "&Run"
	cb_3.enabled = false
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
   	cb_7.enabled = true
   	cb_8.enabled = true
   	cb_9.enabled = true
end if
lb_neworder = false

end event

type cb_1 from commandbutton within w_gteinf010
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
//	select distinct 'x' into :ls_temp from fb_producttransfer
//	where  trunc(PRIS_DATE) < trunc(sysdate) and nvl(PRIS_VOU_NO,'N')='N' and PRIS_TRANSFERTO_IND='U'  ;
//	
//	if sqlca.sqlcode = -1 then 
//	      messagebox('Sql Error','Error During check Stock Transfer for previous date A/c posting : '+sqlca.sqlerrtext)
//	      return 1
//	elseif sqlca.sqlcode = 0 then 
//	     messagebox('Error','Previous Date Stock Transfer Already Available for  A/c Posting ....Please check ')
//		return 1
//	end if;		
//
///check Issue for Stock/MES posting	
//	select distinct 'x' into :ls_temp from fb_producttransfer where  nvl(PRIS_STOCKIND,'N')='N' ;
//	
//	if sqlca.sqlcode = -1 then 
//	      messagebox('Sql Error','Error During check Stock Transfer for Stock/MES Posting : '+sqlca.sqlerrtext)
//	      return 1
//	elseif sqlca.sqlcode = 0 then 
//	     messagebox('Error',' Stock Transfer Already Available for  Stock/MES Posting...Please Check ')
//		return 1
//	end if;	

dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'pris_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'pris_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'pris_from_sup_id',gs_storeid)
	dw_1.setitem(dw_1.getrow(),'pris_rec_type','R')
	dw_1.setcolumn('pris_reqdate')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'pris_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'pris_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'pris_from_sup_id',gs_storeid)
	dw_1.setitem(dw_1.getrow(),'pris_rec_type','R')
	dw_1.setcolumn('pris_reqdate')
end if


end event

type dw_1 from datawindow within w_gteinf010
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 5
integer y = 116
integer width = 4471
integer height = 588
integer taborder = 30
string dataobject = "dw_gteinf010"
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
		dw_1.setitem(newrow,'pris_entry_by',gs_user)
		dw_1.setitem(newrow,'pris_entry_dt',datetime(today()))
		dw_1.setitem(newrow,'pris_from_sup_id',gs_storeid)
		dw_1.setitem(newrow,'pris_rec_type','R')
		dw_1.setcolumn('pris_reqdate')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;if dwo.name = 'pris_reqdate'  and lb_query = false then
	ld_trandt = datetime(data)
	select distinct 'x' into :ls_temp from fb_producttransfer
	where  trunc(PRIS_DATE) < trunc(:ld_trandt) and nvl(PRIS_VOU_NO,'N')='N' and PRIS_TRANSFERTO_IND='U'  ;
	
	if sqlca.sqlcode = -1 then 
	      messagebox('Sql Error','Error During check Stock Transfer for previous date A/c posting : '+sqlca.sqlerrtext)
	      return 1
	elseif sqlca.sqlcode = 0 then 
	     messagebox('Error','Previous Date Stock Transfer Already Available for  A/c Posting ....Please check ')
		return 1
	end if;		
	
	select max(DS_DATE) into :ld_stock_dt from fb_daily_stock;
	
	 if date(ld_trandt) < date(ld_stock_dt) then
		MESSAGEBOX('Error:','The Issue date Should be greater than equal to Last Stock Transaction Date i.e. '+string(ld_stock_dt,'dd/mm/yyyy'))
		return 1;
	end if;	

	
	if lb_neworder = true and dw_2.rowcount() = 0 then
		dw_2.setfocus()
		dw_2.insertrow(0)
		dw_1.setfocus()
		dw_1.setcolumn('pris_reqdate')		
	end if;	
end if

//if dwo.name = 'pris_transferto_ind' then
	idw_spcid.SetFilter ("transfer_type  = '"+'U'+"'") 
	idw_spcid.filter( )
//end if
if dwo.name = 'appr_flag' then
	if data = 'N' or isnull(data) then
		cb_6.enabled = false
	end if
end if

dw_1.setitem(row,'pris_entry_by',gs_user)
dw_1.setitem(row,'pris_entry_dt',datetime(today()))

//cb_3.enabled = true

if dwo.name<>'appr_flag' then
	cb_3.enabled = true
end if
end event

event rowfocuschanged;if lb_query = false then
	if lb_neworder = false  then
		if dw_1.rowcount() > 0 then
			dw_2.reset()
			dw_2.retrieve( dw_1.getitemstring(dw_1.getrow(),'pris_id'))
		end if
	end if
end if
end event

