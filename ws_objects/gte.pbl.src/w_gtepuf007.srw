$PBExportHeader$w_gtepuf007.srw
forward
global type w_gtepuf007 from window
end type
type st_1 from statictext within w_gtepuf007
end type
type em_1 from editmask within w_gtepuf007
end type
type cb_6 from commandbutton within w_gtepuf007
end type
type cbx_1 from checkbox within w_gtepuf007
end type
type cb_5 from commandbutton within w_gtepuf007
end type
type cb_7 from commandbutton within w_gtepuf007
end type
type cb_8 from commandbutton within w_gtepuf007
end type
type cb_9 from commandbutton within w_gtepuf007
end type
type dw_2 from datawindow within w_gtepuf007
end type
type cb_4 from commandbutton within w_gtepuf007
end type
type cb_3 from commandbutton within w_gtepuf007
end type
type cb_2 from commandbutton within w_gtepuf007
end type
type cb_1 from commandbutton within w_gtepuf007
end type
type dw_1 from datawindow within w_gtepuf007
end type
end forward

global type w_gtepuf007 from window
integer width = 4558
integer height = 2276
boolean titlebar = true
string title = "(W_gtepuf007) Purchase Invoice Local"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_1 st_1
em_1 em_1
cb_6 cb_6
cbx_1 cbx_1
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
global w_gtepuf007 w_gtepuf007

type variables
long ll_user_level,ll_ctr,ll_last,ll_count
string ls_temp,ls_sp_id,ls_last,ls_count,ls_tmp_id,ls_appr_ind,ls_lpo_id,ls_sup_id,ls_supname,ls_ac_dt,ls_spname,ls_iss_locn,ls_rec_locn,ls_hsn_cd, ls_rec_GSTNNO, ls_iss_GSTNNO, ls_rev_cat
boolean lb_neworder, lb_query
double ld_tot_val,ld_freight,ld_insurance,ld_other,ld_net_amt,ld_discount,ld_qnty,ld_unit_price,ld_balqnty,ld_saletax,ld_efunit_price,ld_amount, ld_cgst_per, ld_sgst_per, ld_igst_per,ld_tcs_amt
datetime ld_lpo_dt,ld_date,ld_lpi_date,ld_stock_dt
datawindowchild idw_prod
string ls_po_id


end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_cal_datediff (datetime fd_frdt, datetime fd_todt)
public function integer wf_check_duplicate_rec (string fs_con_id)
public function integer wf_cal_netamt (string fs_field, double fd_val)
public function integer wf_upd_po_recvqnty (string fs_po_id, string fs_sp_id, double fd_recpt_qnty, string fs_rec_old)
public function integer wf_check_special_char (string fs_value)
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
	    isnull(dw_2.getitemstring(fl_row,'lpi_hsn_no')) or  len(dw_2.getitemstring(fl_row,'lpi_hsn_no'))=0 or &
	    isnull(dw_2.getitemnumber(fl_row,'lpi_quantity')) or dw_2.getitemnumber(fl_row,'lpi_quantity') = 0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Product, HSN No, Quantity, Please Check !!!')
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

public function integer wf_cal_netamt (string fs_field, double fd_val);
	ld_tot_val =dw_2.getitemnumber(1,'tot_val')

	if fs_field = 'lpi_freight' then
	    	ld_freight = fd_val
	else
	    	ld_freight =dw_1.getitemnumber(dw_1.getrow(),'lpi_freight')
	end if

	if fs_field = 'lpi_insurance' then
		ld_insurance = fd_val
	else
		ld_insurance =dw_1.getitemnumber(dw_1.getrow(),'lpi_insurance')
	end if

	if fs_field = 'lpi_otheramo' then
		ld_other  = fd_val
	else
		ld_other =dw_1.getitemnumber(dw_1.getrow(),'lpi_otheramo') 
	end if
	
	if fs_field = 'lpi_tcs_amt' then
		ld_tcs_amt  = fd_val
	else
		ld_tcs_amt =dw_1.getitemnumber(dw_1.getrow(),'lpi_tcs_amt') 
	end if
	
	if isnull(ld_tot_val) then ld_tot_val = 0;
	if isnull(ld_freight) then ld_freight = 0;
	if isnull(ld_insurance) then ld_insurance = 0;
	if isnull(ld_other) then ld_other = 0;
	
     ld_net_amt= ld_tot_val + ld_freight + ld_other + ld_insurance + ld_tcs_amt
	  
	if isnull(ld_net_amt) then ld_net_amt = 0;

     ld_net_amt= ld_tot_val + ld_freight + ld_other + ld_insurance + ld_tcs_amt
     dw_1.setitem(dw_1.getrow(),'lpi_netamo',ld_net_amt)
	dw_1.setitem(dw_1.getrow(),'lpi_amocharged',ld_net_amt)
	dw_1.setitem(dw_1.getrow(),'lpi_amodue',ld_net_amt)
	
return 1
end function

public function integer wf_upd_po_recvqnty (string fs_po_id, string fs_sp_id, double fd_recpt_qnty, string fs_rec_old);	select distinct 'x' into :ls_temp from fb_lpodetails b
  	 where LPO_ID= :fs_po_id and SP_ID = :fs_sp_id ; 
 
	if sqlca.sqlcode = -1 then
		messagebox('Sql Error During geting PO receipt detail : ',sqlca.sqlerrtext);
		return -1;
	elseif sqlca.sqlcode = 100 then
		messagebox('Missing PO/Item','The PO Detail Not found in PO Master, Please checck..!');
		return -1;
	end if
	
		if fs_rec_old = 'N' then				
			update fb_lpodetails set LPO_QUANTITYRECEIVED = nvl(LPO_QUANTITYRECEIVED,0) + nvl(:fd_recpt_qnty,0)
			 where LPO_ID= :fs_po_id and SP_ID = :fs_sp_id ;
			 
		else 
			update fb_lpodetails set LPO_QUANTITYRECEIVED = nvl(LPO_QUANTITYRECEIVED,0) - nvl(:fd_recpt_qnty,0) 
			 where LPO_ID= :fs_po_id and SP_ID = :fs_sp_id ;
			
		end if;
		
		if sqlca.sqlcode = -1 then
			messagebox('Sql Error During Received Quantity Update in PO: ',sqlca.sqlerrtext);
			return -1;
		end if;	

  return 1;
	
	
end function

public function integer wf_check_special_char (string fs_value);long l_ctr,i,l_ascii
string ls_char

select length(:fs_value) into :l_ctr from dual;
for i = 1 to l_ctr
	select substr(:fs_value,:i,1) into :ls_char from dual;
	select ascii(:ls_char) into :l_ascii from dual;
	//32 33 34 35 36 37 38 39 40 41 43 44 45 46 47 58 59 60 61 62 63 64 91 92 93 94 95 96 123 124 125 126
	if (l_ascii > 32 and l_ascii < 45)  then
 		messagebox("Alert !","Special character ("+ ls_char +") are not allowed !!!")
		return -1
	elseif (l_ascii = 46)  then
		messagebox("Alert !","Special character ("+ ls_char +") are not allowed !!!")
		return -1
	elseif (l_ascii > 57 and l_ascii < 65) then
		messagebox("Alert !","Special character ("+ ls_char +") are not allowed !!!")
		return -1
	elseif	(l_ascii > 90 and l_ascii < 97) then
		messagebox("Alert !","Special character ("+ ls_char +") are not allowed !!!")
		return -1
	elseif	(l_ascii > 122 and l_ascii < 127) then
		messagebox("Alert !","Special character ("+ ls_char +") are not allowed !!!")
		return -1
	end if
next 

return 1
end function

on w_gtepuf007.create
this.st_1=create st_1
this.em_1=create em_1
this.cb_6=create cb_6
this.cbx_1=create cbx_1
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
this.Control[]={this.st_1,&
this.em_1,&
this.cb_6,&
this.cbx_1,&
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

on w_gtepuf007.destroy
destroy(this.st_1)
destroy(this.em_1)
destroy(this.cb_6)
destroy(this.cbx_1)
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

type st_1 from statictext within w_gtepuf007
integer x = 1536
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

type em_1 from editmask within w_gtepuf007
integer x = 2048
integer y = 20
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
	if cb_3.enabled = true then
		messagebox('Warning!','You Have Made Some Changes, Please Save First !!!');
		return 1
	end if
	if dw_1.getitemstring(dw_1.getrow(),'appr_flag') = 'Y' then
		cb_6.enabled = true
	end if
end if;	
end event

type cb_6 from commandbutton within w_gtepuf007
integer x = 2469
integer y = 4
integer width = 343
integer height = 104
integer taborder = 80
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
 setpointer(hourglass!)
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
	where SN_DOC_TYPE in ('JV','CV','BV','RCIN') and SN_ACCT_YEAR=to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm');
	
	if sqlca.sqlcode = 100 then
		INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
		INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
		INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
		INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'RCIN', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
		commit using sqlca;
	end if

string ls_lpi
double ld_qty,ld_rate,ld_amt,ld_oth_amt,ld_tot_amt
 
if f_check_fin_yr(datetime(ls_ac_dt)) = -1 then;	return 1;end if;

	for ll_ctr = 1 to dw_1.rowcount() 
		if dw_1.getitemstring(ll_ctr,'appr_flag') = 'Y'  and isnull(dw_1.getitemstring(ll_ctr,'lpi_vou_no'))=true then
			ls_lpi = dw_1.getitemstring(ll_ctr,'lpi_id')
			ls_rev_cat = dw_1.getitemstring(ll_ctr,'lpi_rev_cat')
			
			if date(ls_ac_dt) < date('01/07/2017') then 
				declare c1 cursor  for 
				 select  b.SP_ID SP_ID, lPI_QUANTITY, lPI_EFFECTIVEUNITPRICE,
				 		  decode(nvl(b.lpi_SALETAX,0),0,(lpi_effectiveunitprice* lpi_QUANTITY),(lpi_effectiveunitprice* lpi_QUANTITY)+((lpi_effectiveunitprice* lpi_QUANTITY)*(b.lpi_SALETAX/100))) Amount,
						 (decode(nvl(b.LPI_SALETAX,0),0,(lpi_effectiveunitprice* LPI_QUANTITY),(lpi_effectiveunitprice* LPI_QUANTITY)+((lpi_effectiveunitprice* LPI_QUANTITY)*(b.LPI_SALETAX/100))))*((nvl(LPI_FREIGHT,0)+nvl(LPI_INSURANCE,0)+nvl(LPI_OTHERAMO,0))/totamt) other_val
				  FROM fb_localpurchaseinvoice a,fb_lpidetails b,
						  (select lpi_id,  round(SUM(decode(nvl(LPI_SALETAX,0),0,(LPI_EFFECTIVEUNITPRICE* LPI_QUANTITY),(LPI_EFFECTIVEUNITPRICE* LPI_QUANTITY)+((LPI_EFFECTIVEUNITPRICE* LPI_QUANTITY)*(LPI_SALETAX/100)))),2) totamt from fb_lpidetails group by lpi_id) x
				 WHERE a.lpi_id = b.lpi_id and a.LPI_ID = x.LPI_ID and b.lPI_ID = :ls_lpi;
					
				open c1; 
					
				if sqlca.sqlcode = -1 then 
						messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
						rollback using sqlca; 
						return 1; 
				else 
					
					setnull(ls_sp_id); ld_qty=0;ld_rate=0;ld_amt=0;ld_oth_amt=0;ld_tot_amt=0
		
					fetch c1 into :ls_sp_id,:ld_qty,:ld_rate,:ld_amt,:ld_oth_amt;
					do while sqlca.sqlcode <> 100 		
						
						if isnull(ld_oth_amt) then ld_oth_amt=0
						if isnull(ld_amt) then ld_amt=0
						
						ld_tot_amt = (ld_amt + ld_oth_amt)
						ld_rate =  (ld_tot_amt / ld_qty)
						
					// received qnty  update in PO
						if wf_upd_po_recvqnty(dw_1.getitemstring(ll_ctr,'lpo_id'),ls_sp_id,ld_qty,'N') = -1 then 
							rollback using sqlca;
							return 1
						end if;

					// update Stock Quantity

						if luo_fames.wf_upd_dailystock(ls_lpi,string(dw_1.getitemdatetime(ll_ctr,'lpi_date'),'dd/mm/yyyy'),ls_sp_id,ld_qty,ld_rate,ld_tot_amt,'Local Purchase Invoice','R','N',gs_storeid) = -1 then 
							rollback using sqlca;
							return 1;
						end if;			

						setnull(ls_sp_id); ld_qty=0;ld_rate=0;ld_amt=0;ld_oth_amt=0;ld_tot_amt=0

						fetch c1 into :ls_sp_id,:ld_qty,:ld_rate,:ld_amt,:ld_oth_amt;
					loop;
				end if
					// JV Creation
				if luo_fames.wf_purchase_tostore_ac(dw_1.getitemstring(ll_ctr,'lpi_id'),ls_ac_dt) = -1 then 
					rollback using sqlca;
					return 1;
				end if;			
			else //if date(ls_ac_dt) < date('01/07/2017') then 
//				change on 300518
				if ls_rev_cat = 'N' then
					declare c3 cursor for
					 select  b.SP_ID SP_ID, lPI_QUANTITY, lPI_EFFECTIVEUNITPRICE,
							  ((lpi_effectiveunitprice* lpi_QUANTITY)+(nvl(LPI_CGST_AMT,0) + nvl(LPI_SGST_AMT,0) + nvl(LPI_IGST_AMT,0))) Amount,
							 ((lpi_effectiveunitprice* lpi_QUANTITY)+(nvl(LPI_CGST_AMT,0) + nvl(LPI_SGST_AMT,0) + nvl(LPI_IGST_AMT,0)))*((nvl(LPI_FREIGHT,0)+nvl(LPI_INSURANCE,0)+nvl(LPI_OTHERAMO,0))/totamt) other_val
					  FROM fb_localpurchaseinvoice a,fb_lpidetails b,
							  (select lpi_id,  round(SUM(((lpi_effectiveunitprice* lpi_QUANTITY)+(nvl(LPI_CGST_AMT,0) + nvl(LPI_SGST_AMT,0) + nvl(LPI_IGST_AMT,0)))),2) totamt from fb_lpidetails group by lpi_id) x
					 WHERE a.lpi_id = b.lpi_id and a.LPI_ID = x.LPI_ID and b.lPI_ID = :ls_lpi; 	
				else  
					declare c2 cursor for 
					 select  b.SP_ID SP_ID, lPI_QUANTITY, lPI_EFFECTIVEUNITPRICE,
							  ((lpi_effectiveunitprice* lpi_QUANTITY)) Amount,
							 ((lpi_effectiveunitprice* lpi_QUANTITY))*((nvl(LPI_FREIGHT,0)+nvl(LPI_INSURANCE,0)+nvl(LPI_OTHERAMO,0))/totamt) other_val
					  FROM fb_localpurchaseinvoice a,fb_lpidetails b,
							  (select lpi_id,  round(SUM(((lpi_effectiveunitprice* lpi_QUANTITY))),2) totamt from fb_lpidetails group by lpi_id) x
					 WHERE a.lpi_id = b.lpi_id and a.LPI_ID = x.LPI_ID and b.lPI_ID = :ls_lpi ;
				end if	
					
				if ls_rev_cat = 'N' then
					open c3;
				else
					open c2;
				end if
					
				if sqlca.sqlcode = -1 then 
						messagebox('Sql Error : During Opening Cursor C2/C3 : ',sqlca.sqlerrtext); 
						rollback using sqlca; 
						return 1; 
				else 
					
					setnull(ls_sp_id); ld_qty=0;ld_rate=0;ld_amt=0;ld_oth_amt=0;ld_tot_amt=0
					
					if ls_rev_cat = 'N' then
						fetch c3 into :ls_sp_id,:ld_qty,:ld_rate,:ld_amt,:ld_oth_amt;
					else
						fetch c2 into :ls_sp_id,:ld_qty,:ld_rate,:ld_amt,:ld_oth_amt;
					end if
				
					
					do while sqlca.sqlcode <> 100 		
						
						if isnull(ld_oth_amt) then ld_oth_amt=0
						if isnull(ld_amt) then ld_amt=0
//						ld_tot_amt = (ld_amt + ld_oth_amt)
//						ld_rate =  (ld_tot_amt / ld_qty)
						ld_tot_amt = Truncate ((ld_amt + ld_oth_amt),2)
						ld_rate =  Truncate ((ld_tot_amt / ld_qty),2)
						
						// Commented 12-09-2024 As Oracle Tranfer Piyush
							//received qnty  update in PO
//							if wf_upd_po_recvqnty(dw_1.getitemstring(ll_ctr,'lpo_id'),ls_sp_id,ld_qty,'N') = -1 then 
//								rollback using sqlca;
//								return 1
//							end if;
//							///update Stock Quantity
//							if luo_fames.wf_upd_dailystock(ls_lpi,string(dw_1.getitemdatetime(ll_ctr,'lpi_date'),'dd/mm/yyyy'),ls_sp_id,ld_qty,ld_rate,ld_tot_amt,'Local Purchase Invoice','R','N',gs_storeid) = -1 then 
//								rollback using sqlca;
//								return 1;
//							end if;

						
						setnull(ls_po_id);
						ls_po_id=dw_1.getitemstring(ll_ctr,'lpo_id')
						declare p2 procedure for up_lopo_stock (:ls_lpi,:ls_ac_dt,:ls_po_id,:ls_sp_id,:ld_qty,:ld_rate,:ld_tot_amt,'Local Purchase Invoice','R',:gs_storeid);
						
						//execute up_hopo_stock ('HOPI0000001922','11/09/2024','AD/HO/000054-24','CSP09377',700,2.25,1575,'HO Purchase Invoice','R','FD001',:ls_msg)
			
						if sqlca.sqlcode = -1 then
							 messagebox('SQL Error: During Procedure Declare of up_hopo_stock',sqlca.sqlerrtext)
							 return 1
						end if
						
						execute p2;
						//messagebox('Check',ls_msg)
						if sqlca.sqlcode = -1 then
							 messagebox('SQL Error: During Procedure Execute of up_hopo_stock',sqlca.sqlerrtext)
							 return 1
						end if

							
							
						setnull(ls_sp_id); ld_qty=0;ld_rate=0;ld_amt=0;ld_oth_amt=0;ld_tot_amt=0
					
						if ls_rev_cat = 'N' then
							fetch c3 into :ls_sp_id,:ld_qty,:ld_rate,:ld_amt,:ld_oth_amt;
						else
							fetch c2 into :ls_sp_id,:ld_qty,:ld_rate,:ld_amt,:ld_oth_amt;
						end if
					loop;
				end if
				// JV Creation
				if luo_fames.wf_purchase_tostore_ac_gst(dw_1.getitemstring(ll_ctr,'lpi_id'),ls_ac_dt) = -1 then 
					rollback using sqlca;
					return 1;
				end if;
			end if //if date(ls_ac_dt) < date('01/07/2017') then 
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

type cbx_1 from checkbox within w_gtepuf007
integer x = 1102
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

type cb_5 from commandbutton within w_gtepuf007
integer x = 3648
integer y = 28
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
	dw_1.ScrolltoRow(1)
	dw_1.setcolumn('ind')
end if
end event

type cb_7 from commandbutton within w_gtepuf007
integer x = 3767
integer y = 28
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
	dw_1.ScrollPriorRow()
	dw_1.setcolumn('ind')
end if
end event

type cb_8 from commandbutton within w_gtepuf007
integer x = 3886
integer y = 28
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
	dw_1.ScrollnextRow()
	dw_1.setcolumn('ind')
end if
end event

type cb_9 from commandbutton within w_gtepuf007
integer x = 4005
integer y = 28
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
	dw_1.ScrolltoRow(dw_1.rowcount())
	dw_1.setcolumn('ind')
end if
end event

type dw_2 from datawindow within w_gtepuf007
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 14
integer y = 892
integer width = 4485
integer height = 1272
integer taborder = 40
string dataobject = "dw_gtepuf007a"
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

event itemchanged;if lb_query = false then
	if dwo.name = 'sp_id' then
		ld_lpi_date = dw_1.getitemdatetime(dw_1.getrow(),'lpi_date')
		ls_sp_id = trim(data)
		ls_iss_locn = dw_1.getitemstring(dw_1.getrow(),'lpi_iss_locn')
		
		select max(DS_DATE) into :ld_stock_dt from fb_daily_stock where  DS_ITEM_CD = :ls_sp_id;
		
		select sp_name into :ls_spname from fb_storeproduct where sp_id = :ls_sp_id;
	
		 if date(ld_lpi_date) < date(ld_stock_dt) then
			MESSAGEBOX('Error:','The Purchase invoice date Should be greater than equal to Last Stock Transaction Date i.e. '+string(ld_stock_dt,'dd/mm/yyyy')+' Of Item '+ls_spname+' ('+ls_sp_id+')')
			return 1;
		end if;
		
		if  wf_check_duplicate_rec(ls_sp_id) = -1 then return 1
		
		if isnull(ls_iss_locn) or len(ls_iss_locn) = 0 then
			messagebox('Warning!','Supplier State / From State Is Blank, Please Check !!!')
		end if
		
		select SP_HSN_NO into :ls_hsn_cd from fb_storeproduct where sp_id =  :ls_sp_id;
		if sqlca.sqlcode = -1 then 
			messagebox('Sql Error','Error During Getting HSN Code : '+sqlca.sqlerrtext)
			return 1
//			elseif sqlca.sqlcode = 100 then 
//				messagebox('Error','Item HSN Code Missing, Please Check !!!')
//				return 1
		end if;	
		dw_2.setitem(row,'lpi_hsn_no',ls_hsn_cd)
		
	end if
     	
	if row = dw_2.rowcount() and dwo.name <> 'del_flag'  then
		  ls_temp =dw_1.getitemstring(dw_1.getrow(),'lpo_id')
	  
		 select count(SP_ID) into :ll_count
		 from (select b.SP_ID,LPO_DATE,a.INDENT_ID, sum(nvl(LPO_QUANTITY,0)-(nvl(LPO_QUANTITYRECEIVED,0)+nvl(LPO_CANCELQUANTITY,0)))po_qnty,a.LPO_ID LPO_ID,LPO_UNITPRICE
							  from fb_localpurchaseorder a,fb_lpodetails b
							where a.LPO_ID=b.LPO_ID and nvl(LPO_QUANTITY,0)>(nvl(LPO_QUANTITYRECEIVED,0)+nvl(LPO_CANCELQUANTITY,0))
							group by b.SP_ID,a.LPO_ID,LPO_DATE,INDENT_ID,LPO_UNITPRICE) x
					 where x.LPO_ID=:ls_temp ;
					 
		if  dw_2.rowcount() < ll_count then
			dw_2.insertrow(0)
		end if
	end if
	
	 if dwo.name = 'lpi_quantity' then 
		ld_qnty = double(data)
		
		ls_temp =dw_1.getitemstring(dw_1.getrow(),'lpo_id')
			ls_sp_id =dw_2.getitemstring(row,'SP_ID')
		
		select nvl(x.po_qnty,0)+ round((nvl(x.po_qnty,0)*0.1))balance,LPO_UNITPRICE into :ld_balqnty,:ld_unit_price  
 		from (select b.SP_ID,LPO_DATE,a.INDENT_ID, sum(nvl(LPO_QUANTITY,0)-(nvl(LPO_QUANTITYRECEIVED,0)+nvl(LPO_CANCELQUANTITY,0)))po_qnty,a.LPO_ID LPO_ID,LPO_UNITPRICE
 	   			  from fb_localpurchaseorder a,fb_lpodetails b
       			where a.LPO_ID=b.LPO_ID and nvl(LPO_QUANTITY,0)>(nvl(LPO_QUANTITYRECEIVED,0)+nvl(LPO_CANCELQUANTITY,0))
       			group by b.SP_ID,a.LPO_ID,LPO_DATE,INDENT_ID,LPO_UNITPRICE) x
       	 where x.LPO_ID=:ls_temp and x.SP_ID=:ls_sp_id ;
						
			
					 
		if ld_qnty > ld_balqnty	then
			messagebox('Error:','Purchase invoice quantity should be <= '+string(ld_balqnty)+ ' (PO balance Quantity + 10% of PO quantity)')
			return 1
		end if
		//dw_2.setitem(row,'lpi_unitprice',ld_unit_price)
	else
		ld_qnty =dw_2.getitemnumber(row,'lpi_quantity')		
	end if
	
	if dwo.name = 'lpi_unitprice' then
		ld_unit_price = double(data)
		
			select nvl(HM_CGST_RATE,0), nvl(HM_SGST_RATE,0), nvl(HM_IGST_RATE,0) into :ld_cgst_per, :ld_sgst_per, :ld_igst_per
			from fb_hsn_master where HM_HSN_code = :ls_hsn_cd and trunc(:ld_lpi_date) between trunc(HM_FROM_DT) and trunc(nvl(HM_TO_DT,sysdate)) and HM_APPROVED_DT is not null;
			if sqlca.sqlcode = -1 then 
				messagebox('Sql Error','Error During Getting HSN Code : '+sqlca.sqlerrtext)
				return 1
			elseif sqlca.sqlcode = 100 then 
				messagebox('Error','Item HSN Code Missing, Please Check !!!')
				return 1
			end if;	

			select SUP_GSTN_STCD into :ls_iss_locn from fb_supplier where sup_id =  :ls_sup_id;
			if sqlca.sqlcode = -1 then 
				messagebox('Sql Error','Error During Getting HSN Code : '+sqlca.sqlerrtext)
				return 1
			end if;			


//			select SP_HSN_NO into :ls_hsn_cd from fb_storeproduct where sp_id =  :ls_sp_id;
//			if sqlca.sqlcode = -1 then 
//				messagebox('Sql Error','Error During Getting HSN Code : '+sqlca.sqlerrtext)
//				return 1
////			elseif sqlca.sqlcode = 100 then 
////				messagebox('Error','Item HSN Code Missing, Please Check !!!')
////				return 1
//			end if;	
			
			if isnull(ls_iss_locn) or len(ls_iss_locn) = 0 then
				messagebox('Error','Supplier Sate Code No Update, Please Update Now !!!')
				return 1
			end if
				
			if isnull(gs_gstn_stcd) or len(gs_gstn_stcd) = 0 then
				messagebox('Error','Garden Sate Code No Update, Please Update Now !!!')
				return 1
			end if			
			

			if ls_iss_locn = gs_gstn_stcd then
				ld_igst_per = 0
			elseif ls_iss_locn <> gs_gstn_stcd then
				ld_cgst_per = 0; ld_sgst_per = 0;
			end if
			
			if dw_1.getitemstring(dw_1.getrow(),'lpi_rev_cat') = 'E' then
				ld_igst_per = 0
				ld_cgst_per = 0; ld_sgst_per = 0;
			end if			
			
			if ld_igst_per > 0 then
				ld_cgst_per = 0
				ld_sgst_per = 0
				dw_2.setitem(row,'lpi_cgst_per',0)
				dw_2.setitem(row,'lpi_sgst_per',0)
				dw_2.setitem(row,'lpi_igst_amt',(ld_amount *(ld_igst_per/100))) 
				dw_2.setitem(row,'lpi_igst_per',ld_igst_per)
				dw_2.setitem(row,'lpi_cgst_amt',0) 
				dw_2.setitem(row,'lpi_sgst_amt',0) 								
				ld_amount=ld_amount+(ld_amount *(ld_igst_per/100))
			elseif ld_cgst_per > 0 or ld_sgst_per > 0 then
				ld_igst_per = 0
				dw_2.setitem(row,'lpi_igst_per',0)
				dw_2.setitem(row,'lpi_igst_amt',0) 
				dw_2.setitem(row,'lpi_cgst_amt',(ld_amount *(ld_cgst_per/100))) 
				dw_2.setitem(row,'lpi_sgst_amt',(ld_amount *(ld_sgst_per/100))) 
				dw_2.setitem(row,'lpi_cgst_per',ld_cgst_per)
				dw_2.setitem(row,'lpi_sgst_per',ld_sgst_per)				
				ld_amount=ld_amount+(ld_amount *(ld_cgst_per/100))+(ld_amount *(ld_sgst_per/100))
			else
				ld_cgst_per = 0
				ld_sgst_per = 0
				ld_igst_per = 0
				dw_2.setitem(row,'lpi_cgst_per',0)
				dw_2.setitem(row,'lpi_sgst_per',0)
				dw_2.setitem(row,'lpi_igst_amt',0) 
				dw_2.setitem(row,'lpi_igst_per',0)
				dw_2.setitem(row,'lpi_cgst_amt',0) 
				dw_2.setitem(row,'lpi_sgst_amt',0) 								
				ld_amount=ld_amount
			end if			
	else
		ld_unit_price =dw_2.getitemnumber(row,'lpi_unitprice')
	end if
	
	if dwo.name = 'lpi_discount' then
		ld_discount = double(data)
	else
		ld_discount =dw_2.getitemnumber(row,'lpi_discount')
	end if
	
	if dwo.name = 'lpi_saletax' then
		ld_saletax = double(data)
	else
		ld_saletax =dw_2.getitemnumber(row,'lpi_saletax')
	end if
	
	if dwo.name = 'lpi_cgst_per' then
		ld_cgst_per = double(data)
	else
		ld_cgst_per =dw_2.getitemnumber(row,'lpi_cgst_per')
	end if

	if dwo.name = 'lpi_sgst_per' then
		ld_sgst_per = double(data)
	else
		ld_sgst_per =dw_2.getitemnumber(row,'lpi_sgst_per')
	end if

	if dwo.name = 'lpi_igst_per' then
		ld_igst_per = double(data)
	else
		ld_igst_per =dw_2.getitemnumber(row,'lpi_igst_per')
	end if

	
	if dwo.name = 'lpi_unitprice' or dwo.name = 'lpi_discount' or  dwo.name = 'lpi_quantity' or dwo.name = 'lpi_saletax' or dwo.name = 'lpi_cgst_per' or dwo.name = 'lpi_sgst_per' or dwo.name = 'lpi_igst_per' then
		if isnull(ld_discount) then ld_discount=0
		if isnull(ld_unit_price) then ld_unit_price=0
		if isnull(ld_qnty) then  ld_qnty=0
		dw_2.setitem(row,'lpi_effectiveunitprice',(ld_unit_price -(ld_unit_price*(ld_discount/100))))
		ld_efunit_price = dw_2.getitemnumber(row,'lpi_effectiveunitprice')
		
		ld_amount=ld_qnty * ld_efunit_price 
		if isnull(ld_saletax) then  ld_saletax=0
		if isnull(ld_cgst_per) then  ld_cgst_per=0
		if isnull(ld_sgst_per) then  ld_sgst_per=0
		if isnull(ld_igst_per) then  ld_igst_per=0
		
		ld_lpi_date = dw_1.getitemdatetime(1,'lpi_date')
		ls_iss_locn = dw_1.getitemstring(1,'lpi_iss_locn')
		ls_rec_locn = dw_1.getitemstring(1,'lpi_rec_locn')
		ls_sup_id = dw_1.getitemstring(1,'sup_id')
		
		if date(ld_lpi_date) > date('30/06/2017') then
			ld_saletax = 0
			dw_2.setitem(row,'lpi_saletax',0)
			
			
			select SUP_GSTN_STCD into :ls_iss_locn from fb_supplier where sup_id =  :ls_sup_id;
			if sqlca.sqlcode = -1 then 
				messagebox('Sql Error','Error During Getting HSN Code : '+sqlca.sqlerrtext)
				return 1
			end if;			


//			select SP_HSN_NO into :ls_hsn_cd from fb_storeproduct where sp_id =  :ls_sp_id;
//			if sqlca.sqlcode = -1 then 
//				messagebox('Sql Error','Error During Getting HSN Code : '+sqlca.sqlerrtext)
//				return 1
////			elseif sqlca.sqlcode = 100 then 
////				messagebox('Error','Item HSN Code Missing, Please Check !!!')
////				return 1
//			end if;	
			
			if isnull(ls_iss_locn) or len(ls_iss_locn) = 0 then
				messagebox('Error','Supplier Sate Code No Update, Please Update Now !!!')
				return 1
			end if
				
			if isnull(gs_gstn_stcd) or len(gs_gstn_stcd) = 0 then
				messagebox('Error','Garden Sate Code No Update, Please Update Now !!!')
				return 1
			end if			
			

			if ls_iss_locn = gs_gstn_stcd then
				ld_igst_per = 0
			elseif ls_iss_locn <> gs_gstn_stcd then
				ld_cgst_per = 0; ld_sgst_per = 0;
			end if
			
			if dw_1.getitemstring(dw_1.getrow(),'lpi_rev_cat') = 'E' then
				ld_igst_per = 0
				ld_cgst_per = 0; ld_sgst_per = 0;
			end if
			
			if ld_igst_per > 0 then
				ld_cgst_per = 0
				ld_sgst_per = 0
				dw_2.setitem(row,'lpi_cgst_per',0)
				dw_2.setitem(row,'lpi_sgst_per',0)
				dw_2.setitem(row,'lpi_igst_amt',(ld_amount *(ld_igst_per/100))) 
				dw_2.setitem(row,'lpi_igst_per',ld_igst_per)
				dw_2.setitem(row,'lpi_cgst_amt',0) 
				dw_2.setitem(row,'lpi_sgst_amt',0) 								
				ld_amount=ld_amount+(ld_amount *(ld_igst_per/100))
			elseif ld_cgst_per > 0 or ld_sgst_per > 0 then
				ld_igst_per = 0
				dw_2.setitem(row,'lpi_igst_per',0)
				dw_2.setitem(row,'lpi_igst_amt',0) 
				dw_2.setitem(row,'lpi_cgst_amt',(ld_amount *(ld_cgst_per/100))) 
				dw_2.setitem(row,'lpi_sgst_amt',(ld_amount *(ld_sgst_per/100))) 
				dw_2.setitem(row,'lpi_cgst_per',ld_cgst_per)
				dw_2.setitem(row,'lpi_sgst_per',ld_sgst_per)				
				ld_amount=ld_amount+(ld_amount *(ld_cgst_per/100))+(ld_amount *(ld_sgst_per/100))
			else
				ld_cgst_per = 0
				ld_sgst_per = 0
				ld_igst_per = 0
				dw_2.setitem(row,'lpi_cgst_per',0)
				dw_2.setitem(row,'lpi_sgst_per',0)
				dw_2.setitem(row,'lpi_igst_amt',0) 
				dw_2.setitem(row,'lpi_igst_per',0)
				dw_2.setitem(row,'lpi_cgst_amt',0) 
				dw_2.setitem(row,'lpi_sgst_amt',0) 								
				ld_amount=ld_amount
			end if
		else
			ld_amount=ld_amount+(ld_amount *(ld_saletax/100))
		end if
	     dw_2.setitem(row,'amount',ld_amount)
		wf_cal_netamt('det',0)
	end if
	cb_3.enabled = true
end if
end event

type cb_4 from commandbutton within w_gtepuf007
integer x = 809
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

type cb_3 from commandbutton within w_gtepuf007
integer x = 544
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
boolean enabled = false
string text = "&Save"
end type

event clicked;if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

if dw_2.rowcount() > 1 then
	if (isnull(dw_2.getitemstring(dw_2.rowcount(),'sp_id')) or len(dw_2.getitemstring(dw_2.rowcount(),'sp_id')) = 0) then 
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



	if (isnull(dw_1.getitemstring(dw_1.getrow(),'lpi_desc')) or isnull(dw_1.getitemstring(dw_1.getrow(),'lpi_desc')) or &
		isnull(dw_1.getitemstring(dw_1.getrow(),'lpo_id')) or &
		isnull(dw_1.getitemstring(dw_1.getrow(),'lpi_billno')) or isnull(dw_1.getitemdatetime(dw_1.getrow(),'lpi_billdate')) or &
		isnull(dw_1.getitemstring(dw_1.getrow(),'sup_id')) or (dw_1.getitemnumber(dw_1.getrow(), 'lpi_netamo') = 0)) then
		messagebox('Warning:','One Of The Fields Are Blank : Description, Indent Id, Supplier Id, Bill no., Bill date,Item Net Amount!!!')
		dw_1.setfocus()
		dw_1.setcolumn('lpi_desc')
		return
	end if
	
	if (dw_1.getitemnumber(dw_1.getrow(), 'lpi_tcs_per') > 0 or dw_1.getitemnumber(dw_1.getrow(), 'lpi_tcs_amt') > 0) then
			if (dw_1.getitemnumber(dw_1.getrow(), 'lpi_tcs_per') = 0 or dw_1.getitemnumber(dw_1.getrow(), 'lpi_tcs_amt') = 0) then
				messagebox('Warning:','One Of The Fields Are Blank : TCS % or TCS Amount!!!')
				return 1
			end if
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
			select nvl(MAX(substr(lpi_id,4,10)),0) into :ll_last from fb_localpurchaseinvoice;
		end if

			ll_last = ll_last + 1
			ls_tmp_id = 'LPI'+string(ll_last,'0000000000') 
			dw_1.setitem(dw_1.getrow(),'lpi_id',ls_tmp_id)	
		//	dw_1.setitem(dw_1.getrow(),'lpi_date',datetime(today()))
		else
			ls_tmp_id =dw_1.getitemstring(dw_1.getrow(),'lpi_id')
		end if	
	
	for ll_ctr = 1 to dw_2.rowcount()
		dw_2.setitem(ll_ctr,'lpi_id',ls_tmp_id)
	next
	if lb_neworder = true then
		Messagebox('Information!','Local Purchase Invoice No Generated Is ('+ls_tmp_id+')')
	end if
	
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
end if

end event

type cb_2 from commandbutton within w_gtepuf007
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
	cb_1.enabled = false
	dw_1.settaborder('lpi_id',5)
	dw_1.settaborder('lpi_date',7)
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('lpi_id')
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
	dw_1.settaborder('lpi_id',0)
	dw_1.settaborder('lpi_date',0)
   	cb_5.enabled = true
   	cb_7.enabled = true
   	cb_8.enabled = true
   	cb_9.enabled = true
	cb_1.enabled = true	
end if
lb_neworder = false

end event

type cb_1 from commandbutton within w_gtepuf007
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
//select max(lpi_date) into :ld_date from fb_localpurchaseinvoice;
///check Purchase invoice for previous date A/c posting	
//	select distinct 'x' into :ls_temp from fb_localpurchaseinvoice
//	where  trunc(LPI_DATE) < trunc(sysdate) and nvl(LPI_VOU_NO,'N')='N' ;
//	
//	if sqlca.sqlcode = -1 then 
//	      messagebox('Sql Error','Error During check Purchase invoice for previous date A/c posting : '+sqlca.sqlerrtext)
//	      return 1
//	elseif sqlca.sqlcode = 0 then 
//	     messagebox('Error','Previous Date Purchase invoice Already Available for  A/c Posting : ')
//		return 1
//	end if;	

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'lpi_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'LPI_REC_LOCN',gs_gstn_stcd)
	dw_1.setitem(dw_1.getrow(),'LPI_REC_GSTNNO',gs_gstnno)
	dw_1.setitem(dw_1.getrow(),'lpi_entry_dt',datetime(today()))
	dw_1.setcolumn('lpi_date')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'lpi_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'LPI_REC_LOCN',gs_gstn_stcd)
	dw_1.setitem(dw_1.getrow(),'LPI_REC_GSTNNO',gs_gstnno)
	dw_1.setitem(dw_1.getrow(),'lpi_entry_dt',datetime(today()))
	dw_1.setcolumn('lpi_date')
end if

cb_1.enabled = false
end event

type dw_1 from datawindow within w_gtepuf007
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 9
integer y = 116
integer width = 4485
integer height = 768
integer taborder = 30
string dataobject = "dw_gtepuf007"
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
		dw_1.setitem(newrow,'lpi_entry_by',gs_user)
		dw_1.setitem(newrow,'lpi_entry_dt',datetime(today()))
		dw_1.setcolumn('lpi_desc')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;if dwo.name = 'lpi_desc'  and lb_query = false then
	ld_lpi_date = dw_1.getitemdatetime(row,'lpi_date')
	
	select distinct 'x' into :ls_temp from fb_localpurchaseinvoice where  trunc(LPI_DATE) < trunc(:ld_lpi_date) and nvl(LPI_VOU_NO,'N')='N' ;
	
	if sqlca.sqlcode = -1 then 
	      messagebox('Sql Error','Error During check Purchase invoice for previous date A/c posting : '+sqlca.sqlerrtext)
	      return 1
	elseif sqlca.sqlcode = 0 then 
	     messagebox('Error','Previous Date Purchase invoice Already Available for  A/c Posting : ')
		return 1
	end if;
	
	if wf_check_special_char(trim(data)) = -1 then return 1
	
	if lb_neworder = true and dw_2.rowcount() = 0 then
		dw_2.setfocus()
		dw_2.insertrow(0)
		dw_1.setfocus()
		dw_1.setcolumn('lpi_desc')		
	end if;	
end if 

if dwo.name = 'lpi_billno' then
	if wf_check_special_char(trim(data)) = -1 then return 1
end if

if dwo.name = 'lpi_date'   then
	ld_lpi_date = datetime(data)
	
	select distinct 'x' into :ls_temp from fb_localpurchaseinvoice where  trunc(LPI_DATE) < trunc(:ld_lpi_date) and nvl(LPI_VOU_NO,'N')='N' ;
	
	if sqlca.sqlcode = -1 then 
	      messagebox('Sql Error','Error During check Purchase invoice for previous date A/c posting : '+sqlca.sqlerrtext)
	      return 1
	elseif sqlca.sqlcode = 0 then 
	     messagebox('Error','Previous Date Purchase invoice Already Available for  A/c Posting : ')
		return 1
	end if;	
	
	select max(DS_DATE) into :ld_stock_dt from fb_daily_stock;
	
	 if date(ld_lpi_date) < date(ld_stock_dt) then
		MESSAGEBOX('Error:','The Purchase invoice date Should be greater than equal to Last Stock Transaction Date i.e. '+string(ld_stock_dt,'dd/mm/yyyy'))
		return 1;
	end if;	
	 if date(ld_lpi_date) > date(today()) then
		MESSAGEBOX('Error:','The Purchase invoice date Should be Less than equal to Current System Date i.e. '+string(today(),'dd/mm/yyyy'))
		return 1;
	end if;
	
	select max(lpi_date) into :ld_date from fb_localpurchaseinvoice;  		
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Maximum Purchase Invoice Date',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
	
	if ld_date > datetime(data) then
		messagebox('Warning!','Purchase Invoice Date Should Be >= '+string(ld_date,'dd/mm/yyyy')+', Please Check !!!')
		return 1
	end if
end if;	


if dwo.name = 'lpo_id'  then
	ls_lpo_id = data	 
	dw_2.reset()
	if lb_neworder = true and dw_2.rowcount() = 0 then
		dw_2.setfocus()
		dw_2.insertrow(0)
		dw_1.setfocus()
	end if

	select distinct LPO_DATE,b.SUP_ID,c.SUP_NAME, c.SUP_ADD, sup_gstn_stcd, SUP_GSTNNO  
	    into :ld_lpo_dt,:ls_sup_id,:ls_supname,:ls_temp,:ls_iss_locn,:ls_iss_GSTNNO
	   from fb_indent a,fb_localpurchaseorder b,fb_supplier c
      where a.indent_id=b.indent_id and b.SUP_ID=c.SUP_ID(+) and indent_active='1' and indent_holocalflag='0'  and  LPO_ID=:ls_lpo_id;
			
		if sqlca.sqlcode = -1 then 
				messagebox('Sql Error','Error During Getting LPO ID  : '+sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
		elseif sqlca.sqlcode = 100 then 
			  messagebox('Error','LPO ID Not Available In Local Purchase Order Master  : '+sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		
		if isnull(ls_iss_locn) or len(ls_iss_locn) = 0 then
			messagebox('Warning!','GSTIN State Of The Supplier Is Blank, Please Update First !!!')
			rollback using sqlca;
			return 1
		end if
		if isnull(ls_iss_gstnno) or len(ls_iss_gstnno) = 0 then
			messagebox('Warning!','GSTIN No Of The Supplier Is Blank, Please Update First !!!')
			//dw_1.setitem(row,'lpi_rev_chrg','Y')	
		end if		

		
		dw_1.setitem(row,'lpo_date',ld_lpo_dt)	
		dw_1.setitem(row,'sup_id',ls_sup_id)	
		dw_1.setitem(row,'sup_name',ls_supname)	
		dw_1.setitem(row,'sup_add',ls_temp)	
		dw_1.setitem(row,'lpi_iss_locn',ls_iss_locn)
		dw_1.setitem(row,'lpi_iss_locn',gs_gstn_stcd)	
		dw_1.setitem(row,'lpi_iss_gstnno',ls_iss_gstnno)	
		
		idw_prod.SetFilter ("lpo_id = '"+trim(data)+"'") 
		idw_prod.filter( )

		ls_iss_locn = dw_1.getitemstring(row,'lpi_iss_locn')
		ls_rec_locn = dw_1.getitemstring(row,'lpi_rec_locn')
//		
		if isnull(ls_iss_locn) or len(ls_iss_locn) = 0 or isnull(ls_rec_locn) or len(ls_rec_locn) = 0 then
			messagebox('Warning !!!','Please Check Issue And Receiving Location !!!')
			return 1
		end if	
 end if
 
  if dwo.name = 'lpi_rev_cat'  then
	dw_2.reset()
	if lb_neworder = true and dw_2.rowcount() = 0 then
		dw_2.setfocus()
		dw_2.insertrow(0)
		dw_1.setfocus()
	end if
end if

 if (dwo.name = 'lpi_freight' or dwo.name = 'lpi_insurance' or dwo.name = 'lpi_otheramo' or dwo.name = 'lpi_tcs_amt') then
     wf_cal_netamt(dwo.name,double(data))
 end if
if dwo.name = 'appr_flag' then
	if data = 'N' or isnull(data) then
		cb_6.enabled = false
	end if
end if
if dwo.name <> 'appr_flag' then
	cb_3.enabled = true
end if
end event

event rowfocuschanged;if lb_query = false then
	if lb_neworder = false  then
		if dw_1.rowcount() > 0 then
			dw_2.reset()
			dw_2.retrieve(dw_1.getitemstring(dw_1.getrow(),'lpi_id'))
			idw_prod.SetFilter ("lpo_id = '"+dw_1.getitemstring(dw_1.getrow(),'lpo_id')+"'") 
	           idw_prod.filter( )
		end if
	end if
end if
end event

