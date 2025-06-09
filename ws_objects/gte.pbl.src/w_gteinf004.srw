$PBExportHeader$w_gteinf004.srw
forward
global type w_gteinf004 from window
end type
type cb_7 from commandbutton within w_gteinf004
end type
type cb_5 from commandbutton within w_gteinf004
end type
type cbx_2 from checkbox within w_gteinf004
end type
type cb_6 from commandbutton within w_gteinf004
end type
type cbx_1 from checkbox within w_gteinf004
end type
type em_1 from editmask within w_gteinf004
end type
type st_1 from statictext within w_gteinf004
end type
type cb_4 from commandbutton within w_gteinf004
end type
type cb_3 from commandbutton within w_gteinf004
end type
type cb_2 from commandbutton within w_gteinf004
end type
type cb_1 from commandbutton within w_gteinf004
end type
type dw_1 from datawindow within w_gteinf004
end type
end forward

global type w_gteinf004 from window
integer width = 4731
integer height = 2388
boolean titlebar = true
string title = "(w_gteinf004) Store (short/Excess) Adjustment"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_7 cb_7
cb_5 cb_5
cbx_2 cbx_2
cb_6 cb_6
cbx_1 cbx_1
em_1 em_1
st_1 st_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gteinf004 w_gteinf004

type variables
long ll_ctr, ll_last,ll_cnt,ll_user_level
string ls_temp,ls_appr_ind,ls_adj_id,ls_rec_ty,ls_ac_dt,ls_row_id,ls_row_id_new,ls_adj_dt
boolean lb_neworder, lb_query
double ld_old_val,ld_unitprice,ld_qnty,ld_savalue
datawindowchild idw_prod,idw_subexp
datetime ld_stock_dt, ld_dt
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

public function integer wf_check_fillcol (integer fl_row);if dw_1.rowcount() > 0 and fl_row > 0 then
	if (isnull(dw_1.getitemstring(fl_row,'sp_id')) or  len(dw_1.getitemstring(fl_row,'sp_id'))=0 or &
	    isnull(dw_1.getitemstring(fl_row,'sa_remark')) or  len(dw_1.getitemstring(fl_row,'sa_remark'))=0 or &
	    isnull(dw_1.getitemstring(fl_row,'sa_reason')) or len(dw_1.getitemstring(fl_row,'sa_reason')) = 0 or &
	    isnull(dw_1.getitemstring(fl_row,'sa_authorised_by')) or  len(dw_1.getitemstring(fl_row,'sa_authorised_by'))=0 or &	 
	    (dw_1.getitemnumber(fl_row,'sa_value') < 0 and &
		 (isnull(dw_1.getitemstring(fl_row,'eachead_id')) or  len(dw_1.getitemstring(fl_row,'eachead_id'))=0 or &
	    	 isnull(dw_1.getitemstring(fl_row,'eacsubhead_id')) or  len(dw_1.getitemstring(fl_row,'eacsubhead_id'))=0)) ) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Product, Exp A/C Head, Exp A/C Subhead, Remark,Reason,Authorised Please Check !!!')
	    return -1
	end if
	if ((isnull(dw_1.getitemnumber(fl_row,'sa_quantity')) or dw_1.getitemnumber(fl_row,'sa_quantity') = 0) and &
	     (isnull(dw_1.getitemnumber(fl_row,'sa_value')) or dw_1.getitemnumber(fl_row,'sa_value') = 0) ) then
	    messagebox('Warning: One Of The Following Fields Shoulde Be Fill','Adjusted Quantity/ Adjusted value Please Check !!!')
	    return -1
	end if
end if
return 1



end function

public function integer wf_check_duplicate_rec (string fs_con_id);long fl_row
string ls_con_id1
datetime ld_run_dt1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_con_id1 = dw_1.getitemstring(fl_row,'sp_id')
		
		if ls_con_id1 = fs_con_id  then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1


end function

on w_gteinf004.create
this.cb_7=create cb_7
this.cb_5=create cb_5
this.cbx_2=create cbx_2
this.cb_6=create cb_6
this.cbx_1=create cbx_1
this.em_1=create em_1
this.st_1=create st_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_7,&
this.cb_5,&
this.cbx_2,&
this.cb_6,&
this.cbx_1,&
this.em_1,&
this.st_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gteinf004.destroy
destroy(this.cb_7)
destroy(this.cb_5)
destroy(this.cbx_2)
destroy(this.cb_6)
destroy(this.cbx_1)
destroy(this.em_1)
destroy(this.st_1)
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
lb_query = false	
lb_neworder = false

dw_1.GetChild ("sp_id", idw_prod)
idw_prod.settransobject(sqlca)	

dw_1.GetChild ("eacsubhead_id", idw_subexp)
idw_subexp.settransobject(sqlca)	

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

type cb_7 from commandbutton within w_gteinf004
boolean visible = false
integer x = 3369
integer y = 12
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
	//return 1;
end if;	

if date(ld_dt) > date(today()) then
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

   setpointer(HourGlass!)
	///check record selection
	for ll_cnt = 1 to dw_1.rowcount() 
		if dw_1.getitemstring(ll_cnt,'appr_flag') = 'Y'  and isnull(dw_1.getitemdatetime(ll_cnt,'sa_vou_dt'))=true then	
			///update stock
			dw_1.setitem(ll_cnt,'sa_stockind','Y')	
			 ls_adj_id=dw_1.getitemstring(ll_cnt,'sa_adj_id')
			ls_adj_dt = string(dw_1.getitemdatetime(ll_cnt,'sa_adj_date'),'dd/mm/yyyy')
			
			//ls_row_id=dw_1.getitemstring(ll_cnt,'rowid')
			if  dw_1.getitemnumber(ll_cnt,'sa_quantity') < 0  then
				if f_stockadjustment_fifo(dw_1.getitemstring(ll_cnt,'sa_adj_id'),gs_storeid) = -1 then
					return 1
				end if;	
				  setpointer(arrow!)
			end if;
			
			string ls_rowid,ls_sp_ID,ls_EACSUBHEAD_ID
			double ld_PRIS_qty,ld_PRIS_value,ld_uprice
			
			declare c1 cursor for 
			select rowid,SP_ID,EACSUBHEAD_ID,SA_QUANTITY,SA_VALUE
			from fb_stores_adjustment 
			where SA_ADJ_ID = :ls_adj_id;
	
			open c1;
		
			if sqlca.sqlcode = -1 then 
				messagebox('Error At Cursor','Error During Opening Cursor C1 : '+sqlca.sqlerrtext)
				return 1
			else
				setnull(ls_rowid);setnull(ls_SP_ID);setnull(ls_EACSUBHEAD_ID);ld_PRIS_qty = 0;ld_PRIS_value=0;ld_uprice=0;
				fetch c1 into :ls_rowid,:ls_SP_ID,:ls_EACSUBHEAD_ID,:ld_PRIS_qty,:ld_PRIS_value;
				
				do while sqlca.sqlcode <> 100
						
					//New/Update DailyExpense
					if luo_fames.wf_upd_mes(ls_adj_dt,ls_EACSUBHEAD_ID,round(ld_PRIS_value,2)*-1,'T','N')  = -1 then 
						rollback using sqlca;
						return 1;
					end if;
					
					///update Stock Quantity
					if ld_PRIS_qty < 0 or ld_PRIS_value < 0 then
						ls_rec_ty ='I'
//						if luo_fames.wf_upd_mes(ls_adj_dt,ls_EACSUBHEAD_ID,ld_PRIS_value,'T','N')  = -1 then 
//							rollback using sqlca;
//							return 1;
//						end if;
					elseif ld_PRIS_qty > 0 or ld_PRIS_value > 0 then
						ls_rec_ty ='R'
					end if
					
					if abs(ld_PRIS_qty) > 0 then 
					   ld_uprice = abs(ld_PRIS_value) / abs( ld_PRIS_qty)
					else
					   ld_uprice = 0
					end if;	
						
					
					if luo_fames.wf_upd_dailystock(ls_adj_id,ls_adj_dt,ls_SP_ID,abs(ld_PRIS_qty),ld_uprice,abs(ld_PRIS_value),'Store Adjustment',ls_rec_ty,'N',gs_storeid) = -1 then 
						rollback using sqlca;
						return 1;
					end if;							
					
					update fb_stores_adjustment set sa_stockind='Y' where rowid=:ls_rowid;
					
					setnull(ls_rowid);setnull(ls_SP_ID);setnull(ls_EACSUBHEAD_ID);ld_PRIS_qty = 0;ld_PRIS_value=0;ld_uprice=0;
					fetch c1 into :ls_rowid,:ls_SP_ID,:ls_EACSUBHEAD_ID,:ld_PRIS_qty,:ld_PRIS_value;
					
				loop
				close c1;
			end if
								
			// Account Posting
				if luo_fames.wf_store_adjustment(ls_adj_id,ls_ac_dt) = -1 then 
					rollback using sqlca;
					return 1;
				end if;
		end if
	next		
//dw_1.update( )
commit using sqlca;

DESTROY n_fames
dw_1.reset()

messagebox('Information;',' JV Created Successfully')
cb_6.enabled = false
end event

type cb_5 from commandbutton within w_gteinf004
boolean visible = false
integer x = 2843
integer y = 12
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
string text = "Voucher"
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
 
// select max(DS_DATE) into :ld_stock_dt from fb_daily_stock;
//
// if date(ls_ac_dt) < date(ld_stock_dt) then
//	MESSAGEBOX('Error:','The Posting date Should be greater than equal to Last Stock Transaction Date i.e. '+string(ld_stock_dt,'dd/mm/yyyy'))
//	return 1;
//end if;	
//
//if date(ld_dt) > date(today()) then
//	MESSAGEBOX('Error:','The Issue date Should be Less than equal to Current System Date i.e. '+string(today(),'dd/mm/yyyy'))
//	return 1;
//end if;
 
 select distinct 'x' into :ls_temp from FB_SERIAL_NO 
where SN_DOC_TYPE in ('JV','CV','BV') and SN_ACCT_YEAR=to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm');

if sqlca.sqlcode = 100 then
	INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
	INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
	INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
	commit using sqlca;
end if

if f_check_fin_yr(datetime(ls_ac_dt)) = -1 then;	return 1;end if;

   setpointer(HourGlass!)
	///check record selection
//	for ll_cnt = 1 to dw_1.rowcount() 
//		if dw_1.getitemstring(ll_cnt,'appr_flag') = 'Y'  and isnull(dw_1.getitemdatetime(ll_cnt,'sa_vou_dt'))=true then	
//			///update stock
//			dw_1.setitem(ll_cnt,'sa_stockind','Y')	
//			 ls_adj_id=dw_1.getitemstring(ll_cnt,'sa_adj_id')
//			ls_adj_dt = string(dw_1.getitemdatetime(ll_cnt,'sa_adj_date'),'dd/mm/yyyy')
//			
//			//ls_row_id=dw_1.getitemstring(ll_cnt,'rowid')
//			if  dw_1.getitemnumber(ll_cnt,'sa_quantity') < 0  then
//				if f_stockadjustment_fifo(dw_1.getitemstring(ll_cnt,'sa_adj_id'),gs_storeid) = -1 then
//					return 1
//				end if;	
//				  setpointer(arrow!)
//			end if;
			ls_adj_id = 'ADJ0000000001'
			ls_adj_dt = '31/03/2017'
			 ll_cnt = 1
			string ls_rowid,ls_sp_ID,ls_EACSUBHEAD_ID
			double ld_PRIS_qty,ld_PRIS_value,ld_uprice
			
			declare c1 cursor for 
			select rowid,SP_ID,EACSUBHEAD_ID,SA_QUANTITY,SA_VALUE
			from fb_stores_adjustment 
			where SA_ADJ_ID = :ls_adj_id;
	
			open c1;
		
			if sqlca.sqlcode = -1 then 
				messagebox('Error At Cursor','Error During Opening Cursor C1 : '+sqlca.sqlerrtext)
				return 1
			else
				setnull(ls_rowid);setnull(ls_SP_ID);setnull(ls_EACSUBHEAD_ID);ld_PRIS_qty = 0;ld_PRIS_value=0;ld_uprice=0;
				fetch c1 into :ls_rowid,:ls_SP_ID,:ls_EACSUBHEAD_ID,:ld_PRIS_qty,:ld_PRIS_value;
				
				do while sqlca.sqlcode <> 100
					 ll_cnt =  ll_cnt + 1	
					//New/Update DailyExpense
//					if luo_fames.wf_upd_mes(ls_adj_dt,ls_EACSUBHEAD_ID,ld_PRIS_value,'T','N')  = -1 then 
//						rollback using sqlca;
//						return 1;
//					end if;
					
					///update Stock Quantity
					if ld_PRIS_qty < 0 or ld_PRIS_value < 0 then
						ls_rec_ty ='I'
						if luo_fames.wf_upd_mes(ls_adj_dt,ls_EACSUBHEAD_ID,ld_PRIS_value,'T','N')  = -1 then 
							rollback using sqlca;
							return 1;
						end if;
					elseif ld_PRIS_qty > 0 or ld_PRIS_value > 0 then
						ls_rec_ty ='R'
					end if
					
					if abs(ld_PRIS_qty) > 0 then 
					   ld_uprice = abs(ld_PRIS_value) / abs( ld_PRIS_qty)
					else
					   ld_uprice = 0
					end if;	
						
					
					if luo_fames.wf_upd_dailystock(ls_adj_id,ls_adj_dt,ls_SP_ID,abs(ld_PRIS_qty),ld_uprice,abs(ld_PRIS_value),'Store Adjustment',ls_rec_ty,'N',gs_storeid) = -1 then 
						rollback using sqlca;
						return 1;
					end if;							
					
					update fb_stores_adjustment set sa_stockind='Y' where rowid=:ls_rowid;
					
					setnull(ls_rowid);setnull(ls_SP_ID);setnull(ls_EACSUBHEAD_ID);ld_PRIS_qty = 0;ld_PRIS_value=0;ld_uprice=0;
					fetch c1 into :ls_rowid,:ls_SP_ID,:ls_EACSUBHEAD_ID,:ld_PRIS_qty,:ld_PRIS_value;
					
					w_mdi.setmicrohelp('Inserting Item ('+string(ll_cnt)+'): '+ls_SP_ID);
				loop
				close c1;
			end if
								
			// Account Posting
//				if luo_fames.wf_store_adjustment(ls_adj_id,ls_ac_dt) = -1 then 
//					rollback using sqlca;
//					return 1;
//				end if;
//		end if
//	next		
//dw_1.update( ) 

if luo_fames.wf_store_adjustment('ADJ0000000001','31/03/2017') = -1 then 
	rollback using sqlca;
	return 1;
end if;

commit using sqlca;

DESTROY n_fames
dw_1.reset()

messagebox('Information;',' JV Created Successfully')
cb_6.enabled = false
end event

type cbx_2 from checkbox within w_gteinf004
integer x = 3749
integer y = 32
integer width = 494
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "For Account ALL"
end type

event clicked;for ll_ctr = 1 to dw_1.rowcount()
	if cbx_1.checked then
		dw_1.setitem(ll_ctr,'appr_flag','Y')
	else
		dw_1.setitem(ll_ctr,'appr_flag','N')
	end if;	
next;
end event

type cb_6 from commandbutton within w_gteinf004
integer x = 2491
integer y = 12
integer width = 343
integer height = 104
integer taborder = 70
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
 
 long ll_temp
 
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
	//return 1;
end if;	

if date(ld_dt) > date(today()) then
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

   setpointer(HourGlass!)
	///check record selection
	for ll_cnt = 1 to dw_1.rowcount() 
		if dw_1.getitemstring(ll_cnt,'appr_flag') = 'Y'  and isnull(dw_1.getitemdatetime(ll_cnt,'sa_vou_dt'))=true then	
			///update stock
			dw_1.setitem(ll_cnt,'sa_stockind','Y')	
			 ls_adj_id=dw_1.getitemstring(ll_cnt,'sa_adj_id')
			ls_adj_dt = string(dw_1.getitemdatetime(ll_cnt,'sa_adj_date'),'dd/mm/yyyy')
			
			//ls_row_id=dw_1.getitemstring(ll_cnt,'rowid')
			if  dw_1.getitemnumber(ll_cnt,'sa_quantity') < 0  then
				if f_stockadjustment_fifo(dw_1.getitemstring(ll_cnt,'sa_adj_id'),gs_storeid) = -1 then
					return 1
				end if;	
				  setpointer(arrow!)
			end if;
		
			select fn_sTORE_ADJUSTMENT (:ls_adj_id,:ls_adj_dt,'',:gs_storeid, :gs_CO_ID,:gs_garden_snm,:GS_USER) into :ll_temp from dual;
			if sqlca.sqlcode = -1 then
	   			messagebox('Error ! During Function Call fn_sTORE_ADJUSTMENT',sqlca.sqlerrtext)
	   			return 1
			end if	
			
			if(ll_temp=1) then
				dw_1.setitem(ll_ctr,'sa_stockind','Y')	
				messagebox('Information;',' JV Created Successfully')
			elseif (ll_temp=2) then
				messagebox('Warning;',' Return Qty has been Issued')
			elseif (ll_temp=3) then
				messagebox('Warning;',' Indent Not Found For Adjustment')
			elseif (ll_temp=4) then
				messagebox('Warning;',' Item NOt Found In Indent')
			end if
			
			
		end if
	next		
//dw_1.update( )
commit using sqlca;

DESTROY n_fames
dw_1.reset()

messagebox('Information;',' JV Created Successfully')
cb_6.enabled = false
end event

type cbx_1 from checkbox within w_gteinf004
integer x = 1134
integer y = 28
integer width = 434
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

type em_1 from editmask within w_gteinf004
integer x = 2030
integer y = 24
integer width = 411
integer height = 84
integer taborder = 70
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
	cb_6.enabled = true
end if;	
end event

type st_1 from statictext within w_gteinf004
integer x = 1577
integer y = 36
integer width = 443
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

type cb_4 from commandbutton within w_gteinf004
integer x = 795
integer y = 16
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

type cb_3 from commandbutton within w_gteinf004
integer x = 530
integer y = 16
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
	if (isnull(dw_1.getitemstring(dw_1.rowcount(),'sp_id')) or len(dw_1.getitemstring(dw_1.rowcount(),'sp_id')) = 0) then 
		dw_1.deleterow(dw_1.rowcount())
	end if;
end if


IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
	if dw_1.rowcount() > 0 then
		IF wf_check_fillcol(dw_1.getrow()) = -1 THEN 
			return 1
		end if
	end if

	for ll_ctr = dw_1.rowcount() to 1 step -1
		if dw_1.getitemstring(ll_ctr,'del_flag') = 'Y' and dw_1.rowcount() = dw_1.getitemnumber(ll_ctr,'sel_row') then
			messagebox('Warning!','You Cannot Delete All Records From Detail Section !!!')
			return 1
		elseif dw_1.getitemstring(ll_ctr,'del_flag') = 'Y' and dw_1.rowcount() <> dw_1.getitemnumber(ll_ctr,'sel_row') then
			dw_1.deleterow(ll_ctr)
		end if
	next	
	
ll_last =0
			  
	for ll_ctr = 1 to dw_1.rowcount()	
		if lb_neworder = true then
			if ll_last=0 then
				select nvl(MAX(substr(sa_adj_id,4,10)),0) into :ll_last from fb_stores_adjustment;
			end if

			ll_last = ll_last + 1
			ls_adj_id = 'ADJ'+string(ll_last,'0000000000') 
			dw_1.setitem(ll_ctr,'sa_adj_id',ls_adj_id)
//			dw_1.setitem(ll_ctr,'sa_adj_date',datetime(today()))	
		end if		
	next	
	
	if dw_1.update(true,false) = 1  then
		dw_1.resetupdate();
		commit using sqlca;
		cb_3.enabled = false
		cb_1.enabled = true
		dw_1.reset()
	else
		messagebox('SQL Error : During Save',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
//end if	
else
	return
end if 
end event

type cb_2 from commandbutton within w_gteinf004
integer x = 265
integer y = 16
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
	if dw_1.modifiedcount() > 0  then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	lb_query = true
	lb_neworder = true
	dw_1.reset()
	cb_3.enabled = false
  	dw_1.settaborder('spc_id',10) 
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('spc_id')
	cb_2.text = "&Run"
	cb_3.enabled = false
	cb_1.enabled = false
else
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(ls_appr_ind)
 	dw_1.TriggerEvent(rowfocuschanged!)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"   
	cb_1.enabled = true
end if
lb_neworder = false



end event

type cb_1 from commandbutton within w_gteinf004
integer y = 16
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
///check Issue for previous date A/c posting	
	select distinct 'x' into :ls_temp from fb_stores_adjustment
	where  trunc(SA_ADJ_DATE) < trunc(sysdate) and nvl(SA_VOU_NO,'N')='N' ;
	
	if sqlca.sqlcode = -1 then 
	      messagebox('Sql Error','Error During check Store Adjustment for previous date A/c posting : '+sqlca.sqlerrtext)
	      return 1
	elseif sqlca.sqlcode = 0 then 
	     messagebox('Error','Previous Date Store Adjustment Already Available for  A/c Posting ....Please check ')
		return 1
	end if;		

///check Issue for Stock/MES posting	
	select distinct 'x' into :ls_temp from fb_stores_adjustment where  nvl(SA_STOCKIND,'N')='N' ;
	
	if sqlca.sqlcode = -1 then 
	      messagebox('Sql Error','Error During check Store Adjustment for Stock/MES Posting : '+sqlca.sqlerrtext)
	      return 1
	elseif sqlca.sqlcode = 0 then 
	     messagebox('Error',' Store Adjustment  Already Available for Stock/MES Posting...Please Check ')
		return 1
	end if;	

dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'sa_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'sa_entry_dt',datetime(today()))	
	dw_1.setitem(dw_1.getrow(),'sa_stockind','N')	
	dw_1.setitem(dw_1.getrow(),'stkind_old','N')	
	dw_1.setitem(dw_1.getrow(),'sa_division',gs_storeid)
	dw_1.setcolumn('sa_adj_date')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'sa_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'sa_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'sa_stockind','N')	
	dw_1.setitem(dw_1.getrow(),'stkind_old','N')	
	dw_1.setitem(dw_1.getrow(),'sa_division',gs_storeid)
	dw_1.setcolumn('sa_adj_date')
end if


end event

type dw_1 from datawindow within w_gteinf004
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 5
integer y = 116
integer width = 4667
integer height = 2040
integer taborder = 30
string dataobject = "dw_gteinf004"
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
		dw_1.setitem(newrow,'sa_entry_by',gs_user)
		dw_1.setitem(newrow,'sa_entry_dt',datetime(today()))
		dw_1.setitem(newrow,'sa_stockind','N')	
		dw_1.setitem(newrow,'stkind_old','N')	
		dw_1.setcolumn('sa_adj_date')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;if lb_query = false then
	if dwo.name = 'sa_adj_date' then
		ld_dt = datetime(data)
		
			select distinct 'x' into :ls_temp from fb_stores_adjustment where  trunc(SA_ADJ_DATE) < trunc(:ld_dt) and nvl(SA_VOU_NO,'N')='N' ;
	
			if sqlca.sqlcode = -1 then 
					messagebox('Sql Error','Error During check Stock Adjestment for previous date A/c posting : '+sqlca.sqlerrtext)
					return 1
			elseif sqlca.sqlcode = 0 then 
				  messagebox('Error','Previous Date Stock Adjestment Already Available for  A/c Posting : ')
				return 1
			end if;
			
		 select max(DS_DATE) into :ld_stock_dt from fb_daily_stock;
	
		 if date(ld_dt) < date(ld_stock_dt) then
			MESSAGEBOX('Error:','The Posting date Should be greater than equal to Last Stock Transaction Date i.e. '+string(ld_stock_dt,'dd/mm/yyyy'))
			return 1;
		end if;	
		 if date(ld_dt) > date(today()) then
			MESSAGEBOX('Error:','The Issue date Should be Less than equal to Current System Date i.e. '+string(today(),'dd/mm/yyyy'))
			return 1;
		end if;
	
	end if

	if dwo.name = 'spc_id' then
		idw_prod.SetFilter ("spc_id = '"+trim(data)+"'") 
		idw_prod.filter( )
	end if

	if dwo.name = 'eachead_id' then
		idw_subexp.SetFilter ("eachead_id = '"+trim(data)+"'") 
		idw_subexp.filter( )
	end if
	
	if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
		dw_1.insertrow(0)
	end if

	if dwo.name = 'sa_quantity' then
		ld_qnty = double(data)
	else
		ld_qnty=dw_1.getitemnumber(dw_1.getrow(),'sa_quantity')
	end if
	
	if dwo.name = 'sa_unitprice' then
		ld_unitprice = double(data)
	else
		ld_unitprice=dw_1.getitemnumber(dw_1.getrow(),'sa_unitprice')
	end if
	
	if dwo.name = 'sa_quantity'  or  dwo.name = 'sa_unitprice' then
		if isnull(ld_qnty) then ld_qnty=0
		if isnull(ld_unitprice) then ld_unitprice=0
		dw_1.setitem(row,'sa_value',ld_qnty * ld_unitprice)
	end if
	
	if dwo.name = 'sa_value' then
		ld_savalue = double(data)
	else
		ld_savalue=dw_1.getitemnumber(dw_1.getrow(),'sa_value')
	end if
	
	dw_1.setitem(row,'sa_entry_by',gs_user)
	dw_1.setitem(row,'sa_entry_dt',datetime(today()))
	
//	if dw_1.getitemstring(row,'appr_flag') = 'Y' then
//		cb_3.enabled = false
//	end if

	if dwo.name<>'appr_flag' then
		cb_3.enabled = true
	end if
	
end if
end event

