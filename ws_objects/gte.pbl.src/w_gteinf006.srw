$PBExportHeader$w_gteinf006.srw
forward
global type w_gteinf006 from window
end type
type cb_10 from commandbutton within w_gteinf006
end type
type cb_6 from commandbutton within w_gteinf006
end type
type cbx_1 from checkbox within w_gteinf006
end type
type em_1 from editmask within w_gteinf006
end type
type st_1 from statictext within w_gteinf006
end type
type cb_5 from commandbutton within w_gteinf006
end type
type cb_7 from commandbutton within w_gteinf006
end type
type cb_8 from commandbutton within w_gteinf006
end type
type cb_9 from commandbutton within w_gteinf006
end type
type dw_2 from datawindow within w_gteinf006
end type
type cb_4 from commandbutton within w_gteinf006
end type
type cb_3 from commandbutton within w_gteinf006
end type
type cb_2 from commandbutton within w_gteinf006
end type
type cb_1 from commandbutton within w_gteinf006
end type
type dw_1 from datawindow within w_gteinf006
end type
end forward

global type w_gteinf006 from window
integer width = 4498
integer height = 2224
boolean titlebar = true
string title = "(W_gteinf006) Return To Supplier"
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
cbx_1 cbx_1
em_1 em_1
st_1 st_1
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
global w_gteinf006 w_gteinf006

type variables
long ll_ctr, ll_last,ll_cnt,ll_user_level,ll_ctr2
string ls_tmp_id,ls_sp_id,ls_sup_id,ls_lpi_hpi_id,ls_supname,ls_temp,ls_invoic_id,ls_appr_ind,ls_eacsubhead_id,ls_ac_dt,ls_spname, ls_iss_locn, ls_rec_locn,ls_hsn_cd
boolean lb_neworder, lb_query
double ld_unit_price,ld_tot_val,ld_qnty,ld_inv_qty,ld_efunit_price,ld_tot_retqnty,ld_adjqnty,ld_cgst_per, ld_sgst_per,ld_igst_per
datawindowchild idw_prod,idw_invid
datetime ld_stock_dt,ld_dt
string ls_spr_id
long ll_temp
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_con_id)
public function integer wf_upd_indent_recvqnty (string fs_indent_id, string fs_sp_id, double fd_po_quantity, string fs_rec_old)
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
	    isnull(dw_2.getitemnumber(fl_row,'spr_quantity')) or dw_2.getitemnumber(fl_row,'spr_quantity') = 0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Product, Return Quantity, Please Check !!!')
	    return -1
	end if
end if
return 1

end function

public function integer wf_check_duplicate_rec (string fs_con_id);long fl_row
string ls_con_id1

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

public function integer wf_upd_indent_recvqnty (string fs_indent_id, string fs_sp_id, double fd_po_quantity, string fs_rec_old);double ld_temp_recqty, ld_temp_indqty

select distinct 'x' into :ls_temp from fb_indentdetails b
where INDENT_ID= :fs_indent_id and SP_ID = :fs_sp_id ; 
 
if sqlca.sqlcode = -1 then
	messagebox('Sql Error During geting stock detail : ',sqlca.sqlerrtext);
	return -1;
elseif sqlca.sqlcode = 100 then
	messagebox('Missing Indent/Item','The Indent Detail Not found in Indent Master, Please checck..!');
	return -1;
end if
	
if fs_rec_old = 'N' then	
	select nvl(INDDET_RECEIVEDQUANTITY,0), nvl(INDDET_QUANTITY,0) into :ld_temp_recqty, :ld_temp_indqty from fb_indentdetails 
	where INDENT_ID= :fs_indent_id and SP_ID = :fs_sp_id;
			
	if sqlca.sqlcode = -1 then
		messagebox('Sql Error During geting recieved quantity : ',sqlca.sqlerrtext);
		return -1;
	elseif sqlca.sqlcode  = 100 then
		messagebox('Missing Indent/Item','No such item found, Please check..!');
		return -1;
	elseif sqlca.sqlcode = 0 then
		
		update fb_indentdetails b set INDDET_RECEIVEDQUANTITY = nvl(INDDET_RECEIVEDQUANTITY,0) - nvl(:fd_po_quantity,0)
		where INDENT_ID= :fs_indent_id and SP_ID = :fs_sp_id;
	end if			
			 
else 
	update fb_indentdetails b set INDDET_RECEIVEDQUANTITY = nvl(INDDET_RECEIVEDQUANTITY,0) - nvl(:fd_po_quantity,0) 
	 where INDENT_ID= :fs_indent_id and SP_ID = :fs_sp_id;			
end if;
		
		if sqlca.sqlcode = -1 then
			messagebox('Sql Error During Received Quantity Update : ',sqlca.sqlerrtext);
			return -1;
		end if;	

  return 1;
end function

on w_gteinf006.create
this.cb_10=create cb_10
this.cb_6=create cb_6
this.cbx_1=create cbx_1
this.em_1=create em_1
this.st_1=create st_1
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
this.Control[]={this.cb_10,&
this.cb_6,&
this.cbx_1,&
this.em_1,&
this.st_1,&
this.cb_5,&
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

on w_gteinf006.destroy
destroy(this.cb_10)
destroy(this.cb_6)
destroy(this.cbx_1)
destroy(this.em_1)
destroy(this.st_1)
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

dw_1.GetChild ("spr_lpi_hpi_id", idw_invid)
idw_invid.settransobject(sqlca)	

dw_2.GetChild ("sp_id", idw_prod)
idw_prod.settransobject(sqlca)	

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

type cb_10 from commandbutton within w_gteinf006
boolean visible = false
integer x = 2898
integer y = 4
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
string ls_indentno
setnull(ls_indentno)
 
 if isdate(em_1.text) = false then
	messagebox('Error :','Please Enter Valid Account Process date')
	rollback using sqlca;
	return 1;
else
	ls_ac_dt=em_1.text
end if;	

if f_check_mep(ls_ac_dt) = -1 then return 1

//if(upper(GS_USER)<>'ADMIN') then 
 	select max(DS_DATE) into :ld_stock_dt from fb_daily_stock;

 	if date(ls_ac_dt) < date(ld_stock_dt) then
		MESSAGEBOX('Error:','The Posting date Should be greater than equal to Last Stock Transaction Date i.e. '+string(ld_stock_dt,'dd/mm/yyyy'))
		return 1;
	end if;	
	if date(ld_dt) > date(today()) then
		MESSAGEBOX('Error:','The Issue date Should be Less than equal to Current System Date i.e. '+string(today(),'dd/mm/yyyy'))
		return 1;
	end if;
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

	for ll_ctr = 1 to dw_1.rowcount() 
		if dw_1.getitemstring(ll_ctr,'appr_flag') = 'Y'  and isnull(dw_1.getitemdatetime(ll_ctr,'spr_vou_dt'))=true then
			///update Stock
			dw_1.setitem(ll_ctr,'spr_stockind','Y')	
			
			for ll_ctr2 = 1 to dw_2.rowcount()
				
				ls_sp_id = dw_2.getitemstring(ll_ctr2,'sp_id')
									
				///update Stock Quantity
				if luo_fames.wf_upd_dailystock(dw_1.getitemstring(ll_ctr,'spr_id'),string(dw_1.getitemdatetime(ll_ctr,'spr_date'),'dd/mm/yyyy'),dw_2.getitemstring(ll_ctr2,'sp_id'),dw_2.getitemnumber(ll_ctr2,'spr_quantity'),dw_2.getitemnumber(ll_ctr2,'spr_unitprice'),dw_2.getitemnumber(ll_ctr2,'amount'),'Return To supplier','I','N',gs_storeid) = -1 then 
					rollback using sqlca;
					return 1;
				end if;

				
				/// update adj quantity to related invoice id in daily stock
				     ls_lpi_hpi_id=dw_1.getitemstring(ll_ctr,'spr_lpi_hpi_id')
					ls_sp_id=dw_2.getitemstring(ll_ctr2,'sp_id') 
					ld_qnty=dw_2.getitemnumber(ll_ctr2,'spr_quantity')
					  
					update fb_daily_stock set DS_ADJ_QTY = nvl(DS_ADJ_QTY,0) + :ld_qnty where DS_REF_NO= :ls_lpi_hpi_id and  DS_ITEM_CD = :ls_sp_id;
					if sqlca.sqlcode = -1 then 
						messagebox('SQL Error','Error During Updation Adjust quantity : '+sqlca.sqlerrtext)
						return 1
					end if;
					
					
					select indent_id into :ls_indentno from (
						select INDENT_ID  from fb_localpurchaseinvoice a,fb_localpurchaseorder c where a.LPO_ID=c.LPO_ID and LPI_ID=:ls_lpi_hpi_id
						union 
						select INDENT_ID from fb_hopurchaseinvoice a where a.HOPI_ID=:ls_lpi_hpi_id);
					
					if wf_upd_indent_recvqnty(ls_indentno,ls_sp_id,ld_qnty,'N') = -1 then 
							rollback using sqlca;
							return 1
					end if;
					
			next
			///
			if luo_fames.wf_return_to_supplier(dw_1.getitemstring(ll_ctr,'spr_id'),ls_ac_dt) = -1 then 
				rollback using sqlca;
				return 1;
			end if;
		end if
	next	
	
dw_1.update( )
commit using sqlca;
dw_1.reset()
dw_2.reset()
DESTROY n_fames
messagebox('Information;',' JV Created Successfully')
cb_6.enabled = false
end event

type cb_6 from commandbutton within w_gteinf006
integer x = 2446
integer y = 8
integer width = 347
integer height = 104
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "A/C Process"
end type

event clicked;string ls_indentno
setnull(ls_indentno)
 
 if isdate(em_1.text) = false then
	messagebox('Error :','Please Enter Valid Account Process date')
	rollback using sqlca;
	return 1;
else
	ls_ac_dt=em_1.text
end if;	

if f_check_mep(ls_ac_dt) = -1 then return 1

//if(upper(GS_USER)<>'ADMIN') then 
 	select max(DS_DATE) into :ld_stock_dt from fb_daily_stock;

 	if date(ls_ac_dt) < date(ld_stock_dt) then
		MESSAGEBOX('Error:','The Posting date Should be greater than equal to Last Stock Transaction Date i.e. '+string(ld_stock_dt,'dd/mm/yyyy'))
		return 1;
	end if;	
	if date(ld_dt) > date(today()) then
		MESSAGEBOX('Error:','The Issue date Should be Less than equal to Current System Date i.e. '+string(today(),'dd/mm/yyyy'))
		return 1;
	end if;
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

	for ll_ctr = 1 to dw_1.rowcount() 
		if dw_1.getitemstring(ll_ctr,'appr_flag') = 'Y'  and isnull(dw_1.getitemdatetime(ll_ctr,'spr_vou_dt'))=true then
			
			ls_spr_id=dw_1.getitemstring(ll_ctr,'spr_id')
			
			select fn_return_to_supp (:ls_spr_id,:ls_ac_dt,'Return To supplier',:gs_storeid, :gs_CO_ID,:gs_garden_snm,:GS_USER) into :ll_temp from dual;
			if sqlca.sqlcode = -1 then
	   			messagebox('Error ! During Function Call fn_return_to_supp',sqlca.sqlerrtext)
	   			return 1
			end if	
			
			if(ll_temp=1) then
				dw_1.setitem(ll_ctr,'spr_stockind','Y')	
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
	
dw_1.update( )
commit using sqlca;
dw_1.reset()
dw_2.reset()
DESTROY n_fames
cb_6.enabled = false
end event

type cbx_1 from checkbox within w_gteinf006
integer x = 1111
integer y = 24
integer width = 421
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

type em_1 from editmask within w_gteinf006
integer x = 2011
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
	cb_6.enabled = true
end if;	
end event

type st_1 from statictext within w_gteinf006
integer x = 1531
integer y = 32
integer width = 471
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

type cb_5 from commandbutton within w_gteinf006
integer x = 3648
integer y = 28
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

type cb_7 from commandbutton within w_gteinf006
integer x = 3767
integer y = 28
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

type cb_8 from commandbutton within w_gteinf006
integer x = 3886
integer y = 28
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

type cb_9 from commandbutton within w_gteinf006
integer x = 4005
integer y = 28
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

type dw_2 from datawindow within w_gteinf006
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 14
integer y = 832
integer width = 4434
integer height = 1276
integer taborder = 40
string dataobject = "dw_gteinf006a"
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

event itemchanged;
if dwo.name = 'sp_id' then
	ld_dt = dw_1.getitemdatetime(dw_1.getrow(),'spr_date')
	ls_sp_id = trim(data)
	
	select max(DS_DATE) into :ld_stock_dt from fb_daily_stock where  DS_ITEM_CD = :ls_sp_id;
	
	select sp_name into :ls_spname from fb_storeproduct where sp_id = :ls_sp_id;

	 if date(ld_dt) < date(ld_stock_dt) then
		MESSAGEBOX('Error:','The Return date Should be greater than equal to Last Stock Transaction Date i.e. '+string(ld_stock_dt,'dd/mm/yyyy')+' Of Item '+ls_spname+' ('+ls_sp_id+')')
		return 1;
	end if;
	
	if  wf_check_duplicate_rec(ls_sp_id) = -1 then return 1
	
	ls_invoic_id = dw_1.getitemstring(dw_1.getrow(),'spr_lpi_hpi_id') 
	
	/// find Issue qnty/Unit Price of this item
	select  quantity,unit_price into  :ld_inv_qty,:ld_efunit_price 
	   from (select a.LPI_ID PI_ID,SP_ID,LPI_QUANTITY quantity ,round((decode(nvl(b.LPI_SALETAX,0),0,(lpi_effectiveunitprice* LPI_QUANTITY),(lpi_effectiveunitprice* LPI_QUANTITY)+ ((lpi_effectiveunitprice* LPI_QUANTITY)*(b.LPI_SALETAX/100)))/LPI_QUANTITY),3) unit_price
			    from fb_localpurchaseinvoice a,fb_lpidetails b where a.LPI_ID=b.LPI_ID 
		  	  union  
		  	  select a.HOPI_ID PI_ID,SP_ID,HOPI_QUANTITY,round((decode(nvl(b.HOPI_SALETAX,0),0,(hopi_effectiveunitprice* HOPI_QUANTITY),(hopi_effectiveunitprice* HOPI_QUANTITY)+((hopi_effectiveunitprice* HOPI_QUANTITY)*(b.HOPI_SALETAX/100)))/HOPI_QUANTITY),3)  unit_price
		  		from fb_hopurchaseinvoice	a,fb_hopidetails b  where a.HOPI_ID=b.HOPI_ID)
	  where PI_ID= :ls_invoic_id and SP_ID=:ls_sp_id;
	
	if sqlca.sqlcode = -1 then
	   messagebox('Error During Select Of Invoice Quantity/Unit Price',sqlca.sqlerrtext)
	   return 1
	end if	
	
	dw_2.setitem(row,'spr_invquantity',truncate(double(ld_inv_qty),3))	
	dw_2.setitem(row,'spr_unitprice',truncate(double(ld_efunit_price),2))	
		
	/// find total return qnty of this item
	select nvl(sum(SPR_QUANTITY),0) into :ld_tot_retqnty from fb_supproductreturn a, fb_supproductreturndetails b
	where a.SPR_ID=b.SPR_ID and a.SPR_ID=:ls_invoic_id and b.SP_ID=:ls_sp_id;
  
	 if sqlca.sqlcode = -1 then
	   messagebox('Error During Select Of Total Return Quantity',sqlca.sqlerrtext)
	   return 1
	end if	
	// check total adjusted quantity
	 ls_lpi_hpi_id=dw_1.getitemstring(dw_1.getrow(),'spr_lpi_hpi_id')
	 ld_qnty=dw_2.getitemnumber(row,'spr_quantity')
	 
	select   nvl(DS_ADJ_QTY,0) into :ld_adjqnty from fb_daily_stock where DS_REF_NO= :ls_lpi_hpi_id and  DS_ITEM_CD = :ls_sp_id ;
	
	if sqlca.sqlcode = -1 then 
		messagebox('SQL Error','Error During Select Adjust quantity : '+sqlca.sqlerrtext)
		return 1
	end if;	
//	if (ld_qnty + ld_adjqnty) > ld_inv_qty then
//		messagebox('Error:','Return quantity should be <= (Invoice quantity - Adjusted quantity)')
//		return 1;
//	end if;	// Changed on 03/12/2013 By PKT
	if (ld_qnty ) > ld_inv_qty then
		messagebox('Error:','Return quantity should be <= (Invoice quantity )')
		return 1;
	end if;	
	
	if date(ld_dt) > date('26/06/2017') then
		
//		select SUP_GSTN_STCD into :ls_iss_locn from fb_supplier where sup_id =  :ls_sup_id;
//		if sqlca.sqlcode = -1 then 
//			messagebox('Sql Error','Error During Getting HSN Code : '+sqlca.sqlerrtext)
//			return 1
//		end if;			
//
		ls_rec_locn = dw_1.getitemstring(dw_1.getrow(),'spr_rec_locn')
		
		select SP_HSN_NO into :ls_hsn_cd from fb_storeproduct where sp_id =  :ls_sp_id;
		if sqlca.sqlcode = -1 then 
			messagebox('Sql Error','Error During Getting HSN Code : '+sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 100 then 
			messagebox('Error','Item HSN Code Missing, Please Check !!!')
			return 1
		end if;	
		
		if isnull(ls_rec_locn) or len(ls_rec_locn) = 0 then
			messagebox('Error','Supplier State Code Not Update, Please Update Now !!!')
			return 1
		end if
			
		if isnull(gs_gstn_stcd) or len(gs_gstn_stcd) = 0 then
			messagebox('Error','Garden State Code Not Update, Please Update Now !!!')
			return 1
		end if	
		
		ls_iss_locn = gs_gstn_stcd
		
		select nvl(HM_CGST_RATE,0), nvl(HM_SGST_RATE,0), nvl(HM_IGST_RATE,0) into :ld_cgst_per, :ld_sgst_per, :ld_igst_per
		from fb_hsn_master where HM_HSN_code = :ls_hsn_cd and trunc(:ld_dt) between trunc(HM_FROM_DT) and trunc(nvl(HM_TO_DT,sysdate)) and HM_APPROVED_DT is not null;
		
		if sqlca.sqlcode = -1 then 
			messagebox('Sql Error','Error During Getting HSN Code : '+sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 100 then 
			messagebox('Error','Item HSN Code Missing, Please Check !!!')
			return 1
		end if;	
	end if	

else
	 ls_sp_id=dw_2.getitemstring(row,'sp_id') 
end if;	

if dwo.name = 'spr_quantity' then
	ld_qnty = double(data)
	ls_lpi_hpi_id=dw_1.getitemstring(dw_1.getrow(),'spr_lpi_hpi_id')
	
	ld_inv_qty =dw_2.getitemnumber(row,'spr_invquantity')
		
	if (ld_qnty + ld_tot_retqnty) > ld_inv_qty then
		messagebox('Error:','Return quantity should be <= Invoice quantity')
		return 1;
	end if;	
	
	select   nvl(DS_ADJ_QTY,0) into :ld_adjqnty from fb_daily_stock where DS_REF_NO= :ls_lpi_hpi_id and  DS_ITEM_CD = :ls_sp_id ;
	if sqlca.sqlcode = -1 then 
		messagebox('SQL Error','Error During Select Adjust quantity : '+sqlca.sqlerrtext)
		return 1
	end if;	
	
//	if (ld_qnty + ld_adjqnty) > ld_inv_qty then
//		messagebox('Error:','Return quantity should be <= (Invoice quantity - Adjusted quantity) ~r You can Only Return Upto '+string((ld_inv_qty - ld_adjqnty),'#,##0.00')+' Quantity')
//		return 1;
//	end if;	// Changed on 03/12/2013 By PKT
	if (ld_qnty) > ld_inv_qty then
		messagebox('Error:','Return quantity should be <= (Invoice quantity ) ~r You can Only Return Upto '+string((ld_inv_qty),'#,##0.00')+' Quantity')
		return 1;
	end if;	
	
	
	ld_tot_val =0
	ld_unit_price =dw_2.getitemnumber(row,'spr_unitprice')
	ld_tot_val = truncate((ld_qnty * ld_unit_price),2)
//===========	
	if ls_iss_locn = ls_rec_locn then
		ld_igst_per = 0
	elseif ls_iss_locn <> ls_rec_locn then
		ld_cgst_per = 0; ld_sgst_per = 0;
	end if
	
	if ld_igst_per > 0 then
		ld_cgst_per = 0
		ld_sgst_per = 0
		dw_2.setitem(row,'spr_cgst_per',0)
		dw_2.setitem(row,'spr_sgst_per',0)
		dw_2.setitem(row,'spr_igst_amt',truncate( (ld_tot_val *(ld_igst_per/100)),2)) 
		dw_2.setitem(row,'spr_igst_per',ld_igst_per)
		dw_2.setitem(row,'spr_cgst_amt',0) 
		dw_2.setitem(row,'spr_sgst_amt',0) 								
	elseif ld_cgst_per > 0 or ld_sgst_per > 0 then
		ld_igst_per = 0
		dw_2.setitem(row,'spr_igst_per',0)
		dw_2.setitem(row,'spr_igst_amt',0) 
		dw_2.setitem(row,'spr_cgst_amt',truncate((ld_tot_val *(ld_cgst_per/100)),2)) 
		dw_2.setitem(row,'spr_sgst_amt',truncate((ld_tot_val *(ld_sgst_per/100)),2)) 
		dw_2.setitem(row,'spr_cgst_per',ld_cgst_per)
		dw_2.setitem(row,'spr_sgst_per',ld_sgst_per)				
	end if	
//===========	
	dw_2.setitem(row,'amount',ld_tot_val)
end if;

if row = dw_2.rowcount() and dwo.name <> 'del_flag'  then
	  dw_2.insertrow(0)
end if


cb_3.enabled = true
end event

type cb_4 from commandbutton within w_gteinf006
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

type cb_3 from commandbutton within w_gteinf006
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
	if (isnull(dw_2.getitemstring(dw_2.rowcount(),'spr_id')) or len(dw_2.getitemstring(dw_2.rowcount(),'spr_id')) = 0) then 
		dw_2.deleterow(dw_2.rowcount())
	end if;
end if

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	n_fames luo_fames
	luo_fames = Create n_fames


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

	if (isnull(dw_1.getitemstring(dw_1.getrow(),'spr_desc')) or isnull(dw_1.getitemstring(dw_1.getrow(),'spr_desc')) or &
		isnull(dw_1.getitemstring(dw_1.getrow(),'spr_lpi_hpi_id')) or isnull(dw_1.getitemstring(dw_1.getrow(),'spr_type'))) then
		messagebox('Warning:','One Of The Fields Are Blank : Reason For Return, Invoice Type, Invoice Id !!!')
		dw_1.setfocus()
		dw_1.setcolumn('spr_desc')
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
		ll_last =0
		if ll_last=0 then
			select nvl(MAX(substr(spr_id,4,10)),0) into :ll_last from fb_supproductreturn;
		end if

			ll_last = ll_last + 1
			ls_tmp_id = 'SPR'+string(ll_last,'0000000000') 
			dw_1.setitem(dw_1.getrow(),'spr_id',ls_tmp_id)	
			//dw_1.setitem(dw_1.getrow(),'spr_date',datetime(today()))
	else
		ls_tmp_id =dw_1.getitemstring(dw_1.getrow(),'spr_id')
	end if

	for ll_ctr = 1 to dw_2.rowcount()
		dw_2.setitem(ll_ctr,'spr_id',ls_tmp_id)
	next
          
	 commit using sqlca;
      DESTROY n_fames
         
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

end if 
end event

type cb_2 from commandbutton within w_gteinf006
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
	dw_1.settaborder('spr_desc',10)
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('spr_desc')
	cb_2.text = "&Run"
	cb_3.enabled = false
else
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(ls_appr_ind)
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

type cb_1 from commandbutton within w_gteinf006
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

/////check Issue for previous date A/c posting	
//	select distinct 'x' into :ls_temp from fb_supproductreturn
//	where  trunc(SPR_DATE) < trunc(sysdate) and nvl(SPR_VOU_NO,'N')='N' ;
//	
//	if sqlca.sqlcode = -1 then 
//	      messagebox('Sql Error','Error During check Return To Supplier for previous date A/c posting : '+sqlca.sqlerrtext)
//	      return 1
//	elseif sqlca.sqlcode = 0 then 
//	     messagebox('Error','Previous Date Return To Supplier Already Available for  A/c Posting ....Please check ')
//		return 1
//	end if;		
//
///check Issue for Stock/MES posting	
	select distinct 'x' into :ls_temp from fb_supproductreturn where  nvl(SPR_STOCKIND,'N')='N' ;
	
	if sqlca.sqlcode = -1 then 
	      messagebox('Sql Error','Error During check Return To Supplier for Stock/MES Posting : '+sqlca.sqlerrtext)
	      return 1
	elseif sqlca.sqlcode = 0 then 
	     messagebox('Error',' Return To Supplier  Already Available for Stock/MES Posting...Please Check ')
		return 1
	end if;	

dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'spr_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'spr_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'spr_division',gs_storeid)
	dw_1.setitem(dw_1.getrow(),'spr_iss_locn',gs_gstn_stcd)
	dw_1.setcolumn('spr_date')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'spr_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'spr_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'spr_division',gs_storeid)
	dw_1.setitem(dw_1.getrow(),'spr_iss_locn',gs_gstn_stcd)
	dw_1.setcolumn('spr_date')
end if


end event

type dw_1 from datawindow within w_gteinf006
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 14
integer y = 120
integer width = 4430
integer height = 688
integer taborder = 30
string dataobject = "dw_gteinf006"
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
		dw_1.setitem(newrow,'spr_entry_by',gs_user)
		dw_1.setitem(newrow,'spr_entry_dt',datetime(today()))
		dw_1.setcolumn('spr_date')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;if dwo.name = 'spr_date'  and lb_query = false then
	ld_dt = datetime(data)
	 select max(DS_DATE) into :ld_stock_dt from fb_daily_stock;

	 if date(ld_dt) < date(ld_stock_dt) then
		MESSAGEBOX('Error:','The Posting date Should be greater than equal to Last Stock Transaction Date i.e. '+string(ld_stock_dt,'dd/mm/yyyy'))
		return 1;
	end if;	
	 if date(ld_dt) > date(today()) then
		MESSAGEBOX('Error:','The Issue date Should be Less than equal to Current System Date i.e. '+string(today(),'dd/mm/yyyy'))
		return 1;
	end if;	
	/////check Issue for previous date A/c posting	
	select distinct 'x' into :ls_temp from fb_supproductreturn 	where  trunc(SPR_DATE) < trunc(:ld_dt) and nvl(SPR_VOU_NO,'N')='N' ;
	
	if sqlca.sqlcode = -1 then 
	      messagebox('Sql Error','Error During check Return To Supplier for previous date A/c posting : '+sqlca.sqlerrtext)
	      return 1
	elseif sqlca.sqlcode = 0 then 
	     messagebox('Error','Previous Date Return To Supplier Already Available for  A/c Posting ....Please check ')
		return 1
	end if;

	if lb_neworder = true and dw_2.rowcount() = 0 then
		dw_2.setfocus()
		dw_2.insertrow(0)
		dw_1.setfocus()
		dw_1.setcolumn('spr_date')		
	end if;	
end if

//if dwo.name = 'spr_desc'  and lb_query = false then
//	if lb_neworder = true and dw_2.rowcount() = 0 then
//		dw_2.setfocus()
//		dw_2.insertrow(0)
//		dw_1.setfocus()
//		dw_1.setcolumn('spr_desc')		
//	end if;	
//end if

if dwo.name = 'spr_type' then
	idw_invid.SetFilter ("pi_id = '"+trim(data)+"'") 
	idw_invid.filter( )
end if;

if dwo.name = 'spr_lpi_hpi_id'   then
	ls_lpi_hpi_id = data
				
     select distinct b.SUP_ID ,c.SUP_NAME, c.SUP_ADD, c.SUP_GSTN_STCD
	  into :ls_sup_id,:ls_supname,:ls_temp, :ls_rec_locn
	from (select distinct LPI_ID, LPI_DATE,SUP_ID from fb_localpurchaseinvoice a,fb_localpurchaseorder c where a.LPO_ID=c.LPO_ID 
               union 
               select distinct HOPI_ID, HOPI_DATE, SUP_ID from fb_hopurchaseinvoice)b,fb_supplier c
    	 where b.SUP_ID=c.SUP_ID(+) and  LPI_ID=:ls_lpi_hpi_id;				
	
	dw_1.setitem(row,'sup_id',ls_sup_id)	
	dw_1.setitem(row,'sup_name',ls_supname)	
	dw_1.setitem(row,'sup_add',ls_temp)	
	dw_1.setitem(row,'spr_rec_locn',ls_rec_locn)	
	ls_iss_locn = gs_gstn_stcd
	
	idw_prod.SetFilter ("lpi_hpi_id = '"+trim(data)+"'") 
	idw_prod.filter( )
	
	if sqlca.sqlcode = -1 then 
	      messagebox('Sql Error','Error During Getting Invoice ID  : '+sqlca.sqlerrtext)
	      rollback using sqlca;
	      return 1
	elseif sqlca.sqlcode = 100 then 
	     messagebox('Error','Indent ID Not Available In Invoice Master !!!')
		rollback using sqlca;
		return 1
	end if;	
end if;

dw_1.setitem(row,'spr_entry_by',gs_user)
dw_1.setitem(row,'spr_entry_dt',datetime(today()))

//cb_3.enabled = true

if dwo.name<>'appr_flag' then
		cb_3.enabled = true
	end if
end event

event rowfocuschanged;if lb_query = false then
	if lb_neworder = false  then
		if dw_1.rowcount() > 0 then
			dw_2.reset()
			dw_2.retrieve(dw_1.getitemstring(dw_1.getrow(),'spr_id'))
		end if
	end if
end if
end event

