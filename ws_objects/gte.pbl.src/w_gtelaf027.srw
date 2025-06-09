$PBExportHeader$w_gtelaf027.srw
forward
global type w_gtelaf027 from window
end type
type cb_3 from commandbutton within w_gtelaf027
end type
type st_1 from statictext within w_gtelaf027
end type
type cb_1 from commandbutton within w_gtelaf027
end type
type cb_2 from commandbutton within w_gtelaf027
end type
type dw_1 from datawindow within w_gtelaf027
end type
type ddlb_1 from dropdownlistbox within w_gtelaf027
end type
end forward

global type w_gtelaf027 from window
integer width = 5170
integer height = 2268
boolean titlebar = true
string title = "(w_gtelaf027) - Advance Deduction"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
cb_3 cb_3
st_1 st_1
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
ddlb_1 ddlb_1
end type
global w_gtelaf027 w_gtelaf027

type variables
long ll_ctr,ll_user_level
string ls_temp, ls_dt, ls_lwwid, ls_labour,ls_exempt, ls_name, ls_labour_id
double ld_adv, ld_pf, ld_pfint,ld_elc, ld_net, ld_elec_advded, ld_med_advded,ld_fest_advded, ld_comp_adv_emi, ld_pf_adv_emi, ld_elec_emi,ld_excess_ded
double ld_med_emi, ld_fest_emi, ld_pfadv_int_emi
datetime ld_dt
end variables

forward prototypes
public function integer wf_upd_adv_realized (string fs_labour_id, double fd_ded_amt, string fs_type)
end prototypes

public function integer wf_upd_adv_realized (string fs_labour_id, double fd_ded_amt, string fs_type);string  ls_Advid
datetime ld_Date
double ld_Amount

if fs_type = 'comp_adv' then
	declare c1 cursor for 
		select LA_ADVID, LABOUR_ID, LA_DATE, nvl(LA_AMOUNT, 0) advance from fb_labouradvance where nvl(LA_AMOUNT, 0) - nvl(LA_REALIZED, 0) > 0 and labour_id = :fs_labour_id order by la_date, la_advid;
  
  	open c1;
	if sqlca.sqlcode = -1 then
		messagebox('Error', 'Error occured while opening cursor c1 : '+sqlca.sqlerrtext)
		return 1
	end if
	
	setnull(ls_advid); setnull(ls_labour_id); setnull(ld_date); setnull(ld_amount);
	fetch c1 into :ls_advid, :ls_labour_id, :ld_Date, :ld_Amount;
	
	do while sqlca.sqlcode<> 100
		if sqlca.sqlcode = -1 then
			messagebox('Error', 'Error occured while fetching data : '+sqlca.sqlerrtext)
			return 1
		end if
		if fd_ded_amt <= ld_Amount then
			  update fb_labouradvance set la_realized = :fd_ded_Amt where la_advid = :ls_Advid and labour_id = :ls_labour_id and la_date = :ld_date;
			  exit;
		elseif fd_ded_amt > ld_Amount then
			  update fb_labouradvance set la_realized = :ld_Amount where la_advid = :ls_Advid and labour_id = :ls_labour_id and la_date = :ld_date;
			  fd_ded_Amt = fd_ded_Amt - ld_Amount;
		end if; 
		
		setnull(ls_advid); setnull(ls_labour_id); setnull(ld_date); setnull(ld_amount);
		fetch c1 into :ls_advid, :ls_labour_id, :ld_Date, :ld_Amount;
	loop
	close c1;
end if

if fs_type = 'pf_adv' then
	declare c2 cursor for 
	select LA_ADVID, LABOUR_ID, LA_DATE, nvl(LA_PFADVANCE, 0) advance from fb_labouradvance where nvl(LA_PFADVANCE, 0) - nvl(LA_REALIZED, 0) > 0 and labour_id = :fs_labour_id order by la_date, la_advid;
  
  	open c2;
	if sqlca.sqlcode = -1 then
		messagebox('Error', 'Error occured while opening cursor c2 : '+sqlca.sqlerrtext)
		return 1
	end if
	
	setnull(ls_advid); setnull(ls_labour_id); setnull(ld_date); setnull(ld_amount);
	fetch c2 into :ls_advid, :ls_labour_id, :ld_Date, :ld_Amount;
	
	do while sqlca.sqlcode<> 100
		if sqlca.sqlcode = -1 then
			messagebox('Error', 'Error occured while fetching data from c2 : '+sqlca.sqlerrtext)
			return 1
		end if
		if fd_ded_amt <= ld_Amount then
			  update fb_labouradvance set la_realized = :fd_ded_Amt where la_advid = :ls_Advid and labour_id = :ls_labour_id and la_date = :ld_date;
			  exit;
		elseif fd_ded_amt > ld_Amount then
			  update fb_labouradvance set la_realized = :ld_Amount where la_advid = :ls_Advid and labour_id = :ls_labour_id and la_date = :ld_date;
			  fd_ded_Amt = fd_ded_Amt - ld_Amount;
		end if; 
		
		setnull(ls_advid); setnull(ls_labour_id); setnull(ld_date); setnull(ld_amount);
		fetch c2 into :ls_advid, :ls_labour_id, :ld_Date, :ld_Amount;
	loop
	close c2;
end if

if fs_type = 'pf_adv_int' then
	declare c3 cursor for 
	select LA_ADVID, LABOUR_ID, LA_DATE, nvl(LA_PFINTEREST, 0) advance from fb_labouradvance where nvl(LA_PFINTEREST, 0) - nvl(LA_INTREALIZED, 0) > 0 and labour_id = :fs_labour_id order by la_date, la_advid;
  
  	open c3;
	if sqlca.sqlcode = -1 then
		messagebox('Error', 'Error occured while opening cursor c3 : '+sqlca.sqlerrtext)
		return 1
	end if
	
	setnull(ls_advid); setnull(ls_labour_id); setnull(ld_date); setnull(ld_amount);
	fetch c3 into :ls_advid, :ls_labour_id, :ld_Date, :ld_Amount;
	
	do while sqlca.sqlcode<> 100
		if sqlca.sqlcode = -1 then
			messagebox('Error', 'Error occured while fetching data from c3 : '+sqlca.sqlerrtext)
			return 1
		end if
		if fd_ded_amt <= ld_Amount then
			  update fb_labouradvance set LA_INTREALIZED = :fd_ded_Amt where la_advid = :ls_Advid and labour_id = :ls_labour_id and la_date = :ld_date;
			  exit;
		elseif fd_ded_amt > ld_Amount then
			  update fb_labouradvance set LA_INTREALIZED = :ld_Amount where la_advid = :ls_Advid and labour_id = :ls_labour_id and la_date = :ld_date;
			  fd_ded_Amt = fd_ded_Amt - ld_Amount;
		end if; 
		
		setnull(ls_advid); setnull(ls_labour_id); setnull(ld_date); setnull(ld_amount);
		fetch c3 into :ls_advid, :ls_labour_id, :ld_Date, :ld_Amount;
	loop
	close c3;
end if

if fs_type = 'elec_adv' then
	declare c4 cursor for 
	select LA_ADVID, LABOUR_ID, LA_DATE, nvl(LA_ELECTADV, 0) advance from fb_labouradvance where nvl(LA_ELECTADV, 0) - nvl(LA_REALIZED, 0) > 0 and labour_id = :fs_labour_id order by la_date, la_advid;
  
  	open c4;
	if sqlca.sqlcode = -1 then
		messagebox('Error', 'Error occured while opening cursor c4 : '+sqlca.sqlerrtext)
		return 1
	end if
	
	setnull(ls_advid); setnull(ls_labour_id); setnull(ld_date); setnull(ld_amount);
	fetch c4 into :ls_advid, :ls_labour_id, :ld_Date, :ld_Amount;
	
	do while sqlca.sqlcode<> 100
		if sqlca.sqlcode = -1 then
			messagebox('Error', 'Error occured while fetching data from c4 : '+sqlca.sqlerrtext)
			return 1
		end if
		if fd_ded_amt <= ld_Amount then
			  update fb_labouradvance set la_realized = :fd_ded_Amt where la_advid = :ls_Advid and labour_id = :ls_labour_id and la_date = :ld_date;
			  exit;
		elseif fd_ded_amt > ld_Amount then
			  update fb_labouradvance set la_realized = :ld_Amount where la_advid = :ls_Advid and labour_id = :ls_labour_id and la_date = :ld_date;
			  fd_ded_Amt = fd_ded_Amt - ld_Amount;
		end if; 
		
		setnull(ls_advid); setnull(ls_labour_id); setnull(ld_date); setnull(ld_amount);
		fetch c4 into :ls_advid, :ls_labour_id, :ld_Date, :ld_Amount;
	loop
	close c4;
end if

if fs_type = 'med_adv' then
	declare c5 cursor for 
	select LA_ADVID, LABOUR_ID, LA_DATE, nvl(LA_MEDADV, 0) advance from fb_labouradvance where nvl(LA_MEDADV, 0) - nvl(LA_REALIZED, 0) > 0 and labour_id = :fs_labour_id order by la_date, la_advid;
  
  	open c5;
	if sqlca.sqlcode = -1 then
		messagebox('Error', 'Error occured while opening cursor c5 : '+sqlca.sqlerrtext)
		return 1
	end if
	
	setnull(ls_advid); setnull(ls_labour_id); setnull(ld_date); setnull(ld_amount);
	fetch c5 into :ls_advid, :ls_labour_id, :ld_Date, :ld_Amount;
	
	do while sqlca.sqlcode<> 100
		if sqlca.sqlcode = -1 then
			messagebox('Error', 'Error occured while fetching data from c5 : '+sqlca.sqlerrtext)
			return 1
		end if
		if fd_ded_amt <= ld_Amount then
			  update fb_labouradvance set la_realized = :fd_ded_Amt where la_advid = :ls_Advid and labour_id = :ls_labour_id and la_date = :ld_date;
			  exit;
		elseif fd_ded_amt > ld_Amount then
			  update fb_labouradvance set la_realized = :ld_Amount where la_advid = :ls_Advid and labour_id = :ls_labour_id and la_date = :ld_date;
			  fd_ded_Amt = fd_ded_Amt - ld_Amount;
		end if; 
		
		setnull(ls_advid); setnull(ls_labour_id); setnull(ld_date); setnull(ld_amount);
		fetch c5 into :ls_advid, :ls_labour_id, :ld_Date, :ld_Amount;
	loop
	close c5;
end if

if fs_type = 'fest_adv' then
	declare c6 cursor for 
	select LA_ADVID, LABOUR_ID, LA_DATE, nvl(LA_FESTADV, 0) advance from fb_labouradvance where nvl(LA_FESTADV, 0) - nvl(LA_REALIZED, 0) > 0 and labour_id = :fs_labour_id order by la_date, la_advid;
  
  	open c6;
	if sqlca.sqlcode = -1 then
		messagebox('Error', 'Error occured while opening cursor c6 : '+sqlca.sqlerrtext)
		return 1
	end if
	
	setnull(ls_advid); setnull(ls_labour_id); setnull(ld_date); setnull(ld_amount);
	fetch c6 into :ls_advid, :ls_labour_id, :ld_Date, :ld_Amount;
	
	do while sqlca.sqlcode<> 100
		if sqlca.sqlcode = -1 then
			messagebox('Error', 'Error occured while fetching data from c6 : '+sqlca.sqlerrtext)
			return 1
		end if
		if fd_ded_amt <= ld_Amount then
			  update fb_labouradvance set la_realized = :fd_ded_Amt where la_advid = :ls_Advid and labour_id = :ls_labour_id and la_date = :ld_date;
			  exit;
		elseif fd_ded_amt > ld_Amount then
			  update fb_labouradvance set la_realized = :ld_Amount where la_advid = :ls_Advid and labour_id = :ls_labour_id and la_date = :ld_date;
			  fd_ded_Amt = fd_ded_Amt - ld_Amount;
		end if; 
		
		setnull(ls_advid); setnull(ls_labour_id); setnull(ld_date); setnull(ld_amount);
		fetch c6 into :ls_advid, :ls_labour_id, :ld_Date, :ld_Amount;
	loop
	close c6;
end if
end function

on w_gtelaf027.create
this.cb_3=create cb_3
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.ddlb_1=create ddlb_1
this.Control[]={this.cb_3,&
this.st_1,&
this.cb_1,&
this.cb_2,&
this.dw_1,&
this.ddlb_1}
end on

on w_gtelaf027.destroy
destroy(this.cb_3)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.ddlb_1)
end on

event open;//em_1.text = '01'+right(string(today(),'dd/mm/yyyy'),8)

if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if
//if date(gd_dt) <> today() then
//	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
//	return 1
//end if

setpointer(hourglass!)
declare c1 cursor for
select distinct LWW_ID||' ('||to_char(LWW_STARTDATE,'dd/mm/yyyy')||'-'||to_char(LWW_ENDDATE,'dd/mm/yyyy')||')',LWW_STARTDATE
  from fb_LABOURWAGESWEEK
  where lww_paidflag='0'
order by LWW_STARTDATE desc;

open c1;

IF sqlca.sqlcode = 0 THEN 
	fetch c1 into :ls_dt,:ld_dt;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_dt)
		fetch c1 into:ls_dt,:ld_dt;
	loop
	close c1;
end if

//ddlb_2.additem('ALL')
//
//declare c2 cursor for
//select distinct LS_ID from FB_LABOURWEEKLYWAGES a,FB_LABOURWAGESWEEK b where a.LWW_ID = b.LWW_ID order by 1;
//
//open c2;
//
//IF sqlca.sqlcode = 0 THEN 
//	fetch c2 into :ll_pbno;
//	
//	do while sqlca.sqlcode <> 100
//		ddlb_2.additem(string(ll_pbno))
//		fetch c2 into:ll_pbno;
//	loop
//	close c2;
//end if
//
//ddlb_2.text = 'ALL'
//
setpointer(Arrow!)

this.tag = Message.StringParm
ll_user_level = long(this.tag)

end event

type cb_3 from commandbutton within w_gtelaf027
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 2240
integer y = 12
integer width = 265
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "&Save"
end type

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event clicked;
IF MessageBox("Save  Alert", 'If you confirm advance deduction then it will be saved permanently and you can not deduct advance for any labour further for this week ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	ls_lwwid = left(ddlb_1.text,13)

	for ll_ctr = 1 to DW_1.ROWCOUNT()
		if dw_1.getitemnumber(ll_ctr,'natpayafterded') < 0 then
			ls_labour = dw_1.getitemstring(ll_ctr,'labourid')
			ls_name = dw_1.getitemstring(ll_ctr,'emp_name')
			messagebox('Warning!','Advance Cannot Be Deducted More Than Advance Net Pay Available For Labour ('+ls_name + ' - '+ls_labour+',) Please Check !!!')
			return 1
		end if
	next
	
//	if dw_1.rowcount() > 0 then
//		IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
//			return 1
//		END IF
//	end if	

	for ll_ctr = 1 to DW_1.ROWCOUNT()
		if dw_1.getitemstring(ll_ctr,'exempt_ind') ='Y' then
			ls_labour = dw_1.getitemstring(ll_ctr,'labourid')
			ls_exempt = dw_1.getitemstring(ll_ctr,'exempt_ind')
			ld_adv = dw_1.getitemnumber(ll_ctr,'adv_ded')
			ld_pf = dw_1.getitemnumber(ll_ctr,'pf_ded')
			ld_pfint = dw_1.getitemnumber(ll_ctr,'pfint_ded')
			ld_elc	 = dw_1.getitemnumber(ll_ctr,'elec_ded')
			ld_elec_advded	 = dw_1.getitemnumber(ll_ctr,'elec_advded')
			ld_med_advded = dw_1.getitemnumber(ll_ctr,'med_advded')
			ld_fest_advded	 = dw_1.getitemnumber(ll_ctr,'fest_advded')
			ld_excess_ded = dw_1.getitemnumber(ll_ctr,'dedexcess')
			
			if isnull(ld_adv) then ld_adv=0
			if isnull(ld_pf) then ld_pf=0
			if isnull(ld_pfint) then ld_pfint=0
			if isnull(ld_elc) then ld_elc=0
			if isnull(ld_elec_advded) then ld_elec_advded=0
			if isnull(ld_med_advded) then ld_med_advded=0
			if isnull(ld_fest_advded) then ld_fest_advded=0
			if isnull(ld_excess_ded) then ld_excess_ded=0
			
			
			select distinct 'x' into :ls_temp from fb_labadvancededuction where LABOUR_ID = :ls_labour and LWW_ID = :ls_lwwid;
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Labour Details',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode  = 100 then
				insert into fb_labadvancededuction (LABOUR_ID, ADVANCEDED,pfadvanceded,pfinterestded,electricded, LWW_ID, LAD_DATE, LAD_ENTRY_BY,ELECADVDED, MEDADVDED, FESTADVDED,excess_wages)
				values(:ls_labour,:ld_adv,:ld_pf,:ld_pfint,:ld_elc,:ls_lwwid,trunc(sysdate),:gs_user,:ld_elec_advded,:ld_med_advded,:ld_fest_advded,:ld_excess_ded);
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Inserting Record',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
			elseif sqlca.sqlcode  = 0 then
				update fb_labadvancededuction set ADVANCEDED = :ld_adv,pfadvanceded = :ld_pf,pfinterestded = :ld_pfint, electricded = :ld_elc, LAD_DATE = trunc(sysdate), LAD_ENTRY_BY = :gs_user,
				ELECADVDED = :ld_elec_advded, MEDADVDED = :ld_med_advded, FESTADVDED = :ld_fest_advded,excess_wages=:ld_excess_ded
				where LABOUR_ID = :ls_labour and LWW_ID = :ls_lwwid;
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Updating labadvancededuction table',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
			end if	
			
			if ld_adv > 0 then
				wf_upd_adv_realized(ls_labour, ld_adv, 'comp_adv')
			elseif ld_pf > 0 then
				wf_upd_adv_realized(ls_labour, ld_pf, 'pf_adv')
			elseif ld_pfint > 0 then
				wf_upd_adv_realized(ls_labour, ld_pfint, 'pf_adv_int')
			elseif ld_elec_advded > 0 then
				wf_upd_adv_realized(ls_labour, ld_elec_advded, 'elec_adv')
			elseif ld_med_advded > 0 then
				wf_upd_adv_realized(ls_labour, ld_med_advded, 'med_adv')
			elseif ld_fest_advded > 0 then
				wf_upd_adv_realized(ls_labour, ld_fest_advded, 'fest_adv')
			end if
			
//			select distinct 'x' into :ls_temp from fb_labouradvance where LABOUR_ID = :ls_labour;
//			if sqlca.sqlcode = -1 then
//				messagebox('Error : While Getting Labour Details',sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 1
//			elseif sqlca.sqlcode  = 0 then
//				update fb_labouradvance set la_amounttopaytodate= la_amounttopaytodate - nvl(:ld_adv,0)
//				where LABOUR_ID = :ls_labour and la_date=(select max(la_date) from fb_labouradvance where labour_id= :ls_labour);
//				
//				if sqlca.sqlcode = -1 then
//					messagebox('Error : While Updating labouradvance table',sqlca.sqlerrtext)
//					rollback using sqlca;
//					return 1
//				end if
//			end if		
		end if
	next
	
	update fb_labourwagesweek set lww_advanceflag='1' where lww_id = :ls_lwwid;
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Updating labourwagesweek table',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if

	commit using sqlca;
	cb_3.enabled = false
	dw_1.reset()		
else
	return
end if 
end event

type st_1 from statictext within w_gtelaf027
integer x = 9
integer y = 32
integer width = 754
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "LWW ID (Start && End Date) : "
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_gtelaf027
integer x = 1975
integer y = 12
integer width = 265
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
end type

event clicked;dw_1.settransobject(sqlca)

setpointer(hourglass!)

if isnull(ddlb_1.text)  then
	messagebox('Warning','Please Enter Week Start Date !!!')
	return 
end if

string ls_lww_id,ls_newind
long ll_cnt 

ll_cnt =0
ls_lww_id = left(ddlb_1.text,13)

select count(1) into :ll_cnt from fb_labadvancededuction where LWW_ID = :ls_lww_id;

if isnull(ll_cnt) then ll_cnt = 0;

if ll_cnt > 0 then
	ls_newind='N'
else
	ls_newind='Y'
end if

dw_1.settransobject(sqlca)
dw_1.retrieve(ls_lww_id,ls_newind)

if dw_1.rowcount() > 0 then
	if gs_garden_snm = 'KG' then	
		for ll_ctr = 1 to dw_1.rowcount( ) 
			if ls_newind = 'Y' then
				ld_adv = dw_1.getitemnumber(ll_ctr,'advbal')
				ld_pf = dw_1.getitemnumber(ll_ctr,'pfadvbal')
				ld_pfint = dw_1.getitemnumber(ll_ctr,'pfintbal')
				ld_net = dw_1.getitemnumber(ll_ctr,'natpayafterded')

				if ld_adv > 200 then
					dw_1.setitem(ll_ctr,'adv_ded',200)
				elseif ld_adv < 200 and ld_adv > 0 and ld_net >= ld_adv then
					dw_1.setitem(ll_ctr,'adv_ded',ld_adv)
				else
					dw_1.setitem(ll_ctr,'adv_ded',0)
				end if
				
				if ld_pf > 100 then
					dw_1.setitem(ll_ctr,'pf_ded',100)
				elseif ld_pf < 100 and ld_pf > 0 and ld_net >= ld_pf then
					dw_1.setitem(ll_ctr,'pf_ded',ld_pf)
				else
					dw_1.setitem(ll_ctr,'pf_ded',0)
				end if	
				     dw_1.setitem(ll_ctr,'pfint_ded',0)
					dw_1.setitem(ll_ctr,'elec_ded',0)
			end if	
		next
	elseif gs_garden_snm = 'DL' then	
		for ll_ctr = 1 to dw_1.rowcount( ) 
			if ls_newind = 'Y' then
				ld_adv = dw_1.getitemnumber(ll_ctr,'advbal')
				ld_pf = dw_1.getitemnumber(ll_ctr,'pfadvbal')
				ld_pfint = dw_1.getitemnumber(ll_ctr,'pfintbal')
				ld_net = dw_1.getitemnumber(ll_ctr,'natpayafterded')

				
				if ld_pf > 100 then
					dw_1.setitem(ll_ctr,'pf_ded',100)
				elseif ld_pf < 100 and ld_pf > 0 and ld_net >= ld_pf then
					dw_1.setitem(ll_ctr,'pf_ded',ld_pf)
				else
					dw_1.setitem(ll_ctr,'pf_ded',0)
				end if	
				     dw_1.setitem(ll_ctr,'pfint_ded',0)
					dw_1.setitem(ll_ctr,'elec_ded',0)
			end if	
		next
	elseif ls_newind = 'Y' then
		for ll_ctr = 1 to dw_1.rowcount()
			setnull(ls_labour_id)
			ls_labour_id = dw_1.getitemstring(ll_ctr, 'labourid')
			if(dw_1.getitemnumber(ll_ctr, 'advbal') > 0) then
				select sum(nvl(LA_DEDN_EMI, 0)) into :ld_comp_adv_emi from fb_labouradvance where labour_id = :ls_labour_id and nvl(LA_AMOUNT, 0) - nvl(LA_REALIZED, 0) > 0;
				if sqlca.sqlcode = -1 then
					messagebox('Error', 'Error occured while calculating EMI for Company Advance : '+sqlca.sqlerrtext)
					return 1
				end if
				if isnull(ld_comp_adv_Emi) then ld_comp_adv_Emi = 0;
				if(dw_1.getitemnumber(ll_ctr, 'advbal') > ld_comp_adv_emi) then
					dw_1.setitem(ll_ctr, 'adv_ded', ld_comp_adv_emi)
				else
					dw_1.setitem(ll_ctr, 'adv_ded', dw_1.getitemnumber(ll_ctr, 'advbal'))
				end if		
			end if
			
			if(dw_1.getitemnumber(ll_ctr, 'pfadvbal') > 0) then
				select sum(nvl(LA_DEDN_EMI, 0)) into :ld_pf_adv_emi from fb_labouradvance where labour_id = :ls_labour_id and nvl(LA_PFADVANCE, 0) - nvl(LA_REALIZED, 0) > 0;
				if sqlca.sqlcode = -1 then
					messagebox('Error', 'Error occured while calculating EMI for PF Advance : '+sqlca.sqlerrtext)
					return 1
				end if
				if isnull(ld_pf_adv_emi) then ld_pf_adv_emi = 0;
				
				if(dw_1.getitemnumber(ll_ctr, 'pfadvbal') > ld_pf_adv_emi) then
					dw_1.setitem(ll_ctr, 'pf_ded', ld_pf_adv_emi)
				else
					dw_1.setitem(ll_ctr, 'pf_ded', dw_1.getitemnumber(ll_ctr, 'pfadvbal'))
				end if		
				
			end if	
			
			if(dw_1.getitemnumber(ll_ctr, 'pfintbal') > 0) then
				select sum(decode(nvl(LA_PFADVANCE, 0), 0, 0, (nvl(LA_DEDN_EMI, 0)/nvl(LA_PFADVANCE, 0))*nvl(LA_PFINTEREST, 0))) into :ld_pfadv_int_emi from fb_labouradvance where labour_id = :ls_labour_id and nvl(LA_PFINTEREST, 0) - nvl(LA_INTREALIZED, 0) > 0;
				if sqlca.sqlcode = -1 then
					messagebox('Error', 'Error occured while calculating EMI for PF Advance Interest: '+sqlca.sqlerrtext)
					return 1
				end if
				if isnull(ld_pfadv_int_emi) then ld_pfadv_int_emi = 0;
				
				if(dw_1.getitemnumber(ll_ctr, 'pfintbal') > ld_pfadv_int_emi) then
					dw_1.setitem(ll_ctr, 'pfint_ded', ld_pfadv_int_emi)
				else
					dw_1.setitem(ll_ctr, 'pfint_ded', dw_1.getitemnumber(ll_ctr, 'pfintbal'))
				end if	
				
			end if	
			
			if(dw_1.getitemnumber(ll_ctr, 'elecbal') > 0) then
				select sum(nvl(LA_DEDN_EMI, 0)) into :ld_elec_emi from fb_labouradvance where labour_id = :ls_labour_id and nvl(LA_ELECTADV, 0) - nvl(LA_REALIZED, 0) > 0;
				if sqlca.sqlcode = -1 then
					messagebox('Error', 'Error occured while calculating EMI for Electric Advance : '+sqlca.sqlerrtext)
					return 1
				end if
				if isnull(ld_elec_emi) then ld_elec_emi = 0;
				
				if(dw_1.getitemnumber(ll_ctr, 'elecbal') > ld_elec_emi) then
					dw_1.setitem(ll_ctr, 'elec_advded', ld_elec_emi)
				else
					dw_1.setitem(ll_ctr, 'elec_advded', dw_1.getitemnumber(ll_ctr, 'elecbal'))
				end if			
				
			end if	
			
			if(dw_1.getitemnumber(ll_ctr, 'medbal') > 0) then
				select sum(nvl(LA_DEDN_EMI, 0)) into :ld_med_emi from fb_labouradvance where labour_id = :ls_labour_id and nvl(LA_MEDADV, 0) - nvl(LA_REALIZED, 0) > 0;
				if sqlca.sqlcode = -1 then
					messagebox('Error', 'Error occured while calculating EMI for Medical Advance : '+sqlca.sqlerrtext)
					return 1
				end if
				if isnull(ld_med_emi) then ld_med_emi = 0;
				
				if(dw_1.getitemnumber(ll_ctr, 'medbal') > ld_med_emi) then
					dw_1.setitem(ll_ctr, 'med_advded', ld_med_emi)
				else
					dw_1.setitem(ll_ctr, 'med_advded', dw_1.getitemnumber(ll_ctr, 'medbal'))
				end if
								
			end if	
			
			if(dw_1.getitemnumber(ll_ctr, 'festbal') > 0) then
				select sum(nvl(LA_DEDN_EMI, 0)) into :ld_fest_emi from fb_labouradvance where labour_id = :ls_labour_id and nvl(LA_FESTADV, 0) - nvl(LA_REALIZED, 0) > 0;
				if sqlca.sqlcode = -1 then
					messagebox('Error', 'Error occured while calculating EMI for Festival Advance : '+sqlca.sqlerrtext)
					return 1
				end if
				if isnull(ld_fest_emi) then ld_fest_emi = 0;
				
				if(dw_1.getitemnumber(ll_ctr, 'festbal') > ld_fest_emi) then
					dw_1.setitem(ll_ctr, 'fest_advded', ld_fest_emi)
				else
					dw_1.setitem(ll_ctr, 'fest_advded', dw_1.getitemnumber(ll_ctr, 'festbal'))
				end if
				
			end if	
		next
	end if
end if

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found !!!')
	return 1
end if
setpointer(Arrow!)
cb_3.enabled = true
end event

type cb_2 from commandbutton within w_gtelaf027
integer x = 2505
integer y = 12
integer width = 265
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
boolean cancel = true
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_gtelaf027
event key_down pbm_dwnrowchanging
event ue_tab_to_enter pbm_dwnprocessenter
integer y = 124
integer width = 5106
integer height = 2036
string dataobject = "dw_gtelaf027"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event key_down;if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
	 //netpay - ( adv_ded + pf_ded + pfint_ded )
	 //messagebox('11',(dw_1.getitemnumber(currentrow,'netpay') - (dw_1.getitemnumber(currentrow,'adv_ded') + dw_1.getitemnumber(currentrow,'pf_ded') + dw_1.getitemnumber(currentrow,'pfint_ded'))))
	if (dw_1.getitemnumber(currentrow,'netpay') - (dw_1.getitemnumber(currentrow,'adv_ded') + dw_1.getitemnumber(currentrow,'pf_ded') + dw_1.getitemnumber(currentrow,'pfint_ded'))) < 0 then
		messagebox('Warning!','Advance Cannot Be Deducted More Than Advance Net Pay Available, Please Check !!!')
		return 1
	end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;cb_3.enabled = true

end event

type ddlb_1 from dropdownlistbox within w_gtelaf027
integer x = 773
integer y = 20
integer width = 1152
integer height = 608
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
end type

event selectionchanged;//ls_dt = left(ddlb_1.text,10)
//ddlb_2.reset()
//ddlb_2.additem('ALL')
//
//declare c2 cursor for
//select distinct LS_ID from FB_LABOURWEEKLYWAGES a,FB_LABOURWAGESWEEK b 
//where a.LWW_ID = b.LWW_ID and trunc(b.LWW_STARTDATE) = to_date(:ls_dt,'dd/mm/yyyy') order by 1;
//
//open c2;
//
//IF sqlca.sqlcode = 0 THEN 
//	fetch c2 into :ll_pbno;
//	
//	do while sqlca.sqlcode <> 100
//		ddlb_2.additem(string(ll_pbno))
//		fetch c2 into:ll_pbno;
//	loop
//	close c2;
//end if
//
//ddlb_2.text = 'ALL'
end event

