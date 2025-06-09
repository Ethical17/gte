$PBExportHeader$w_gtelaf023.srw
forward
global type w_gtelaf023 from window
end type
type ddlb_1 from dropdownlistbox within w_gtelaf023
end type
type cbx_2 from checkbox within w_gtelaf023
end type
type em_2 from editmask within w_gtelaf023
end type
type em_1 from editmask within w_gtelaf023
end type
type cbx_1 from checkbox within w_gtelaf023
end type
type cb_2 from commandbutton within w_gtelaf023
end type
type cb_1 from commandbutton within w_gtelaf023
end type
type st_1 from statictext within w_gtelaf023
end type
end forward

global type w_gtelaf023 from window
integer width = 1810
integer height = 1272
boolean titlebar = true
string title = "(w_gtelaf023) Process-Wages"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
boolean center = true
ddlb_1 ddlb_1
cbx_2 cbx_2
em_2 em_2
em_1 em_1
cbx_1 cbx_1
cb_2 cb_2
cb_1 cb_1
st_1 st_1
end type
global w_gtelaf023 w_gtelaf023

type variables
string ls_temp,ls_frdt,ls_todt,ls_chklwf, ls_lwwid,ls_lwwpaidflag, ls_ym, ls_labour_id
double ld_lwf, ld_subs, ld_lpg_subs_Ded
long ll_user_level
end variables

on w_gtelaf023.create
this.ddlb_1=create ddlb_1
this.cbx_2=create cbx_2
this.em_2=create em_2
this.em_1=create em_1
this.cbx_1=create cbx_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.Control[]={this.ddlb_1,&
this.cbx_2,&
this.em_2,&
this.em_1,&
this.cbx_1,&
this.cb_2,&
this.cb_1,&
this.st_1}
end on

on w_gtelaf023.destroy
destroy(this.ddlb_1)
destroy(this.cbx_2)
destroy(this.em_2)
destroy(this.em_1)
destroy(this.cbx_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
end on

event open;
if date(gd_dt) <> today() then
	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
	return 1
end if

declare c1 cursor for
select to_char(lww_startdate,'dd/mm/yyyy')||' - '|| to_char(LWW_ENDDATE,'dd/mm/yyyy') 
from fb_labourwagesweek 
where lww_paidflag='0'
order by  lww_startdate desc;

open c1;

if sqlca.sqlcode = -1 then 
	messagebox('Error At Cursor','Error During Opening Cursor');
	return 1;
else
	setnull(ls_frdt);
	fetch c1 into :ls_frdt;	
	do while sqlca.sqlcode <> 100 
	
		ddlb_1.additem(ls_frdt);
	
		setnull(ls_frdt);
		fetch c1 into :ls_frdt;	
	loop
	close c1;
end if;

this.tag = Message.StringParm
ll_user_level = long(this.tag)

if ll_user_level = 3 then
	cb_1.enabled = false
end if

end event

type ddlb_1 from dropdownlistbox within w_gtelaf023
integer x = 864
integer y = 236
integer width = 736
integer height = 368
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
borderstyle borderstyle = stylelowered!
end type

type cbx_2 from checkbox within w_gtelaf023
integer x = 233
integer y = 484
integer width = 590
integer height = 80
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "Deduction Subscription"
boolean lefttext = true
end type

type em_2 from editmask within w_gtelaf023
integer x = 864
integer y = 476
integer width = 338
integer height = 88
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###.00"
end type

type em_1 from editmask within w_gtelaf023
integer x = 864
integer y = 372
integer width = 338
integer height = 88
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###.00"
end type

type cbx_1 from checkbox within w_gtelaf023
integer x = 398
integer y = 380
integer width = 425
integer height = 80
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "Deduction LWF"
boolean lefttext = true
end type

type cb_2 from commandbutton within w_gtelaf023
integer x = 914
integer y = 612
integer width = 311
integer height = 112
integer taborder = 40
integer textsize = -9
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

type cb_1 from commandbutton within w_gtelaf023
integer x = 398
integer y = 612
integer width = 485
integer height = 112
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Calculation Wages"
boolean default = true
end type

event clicked;ls_frdt = left(ddlb_1.text,10)
ls_todt = right(ddlb_1.text,10) 

if isnull(ls_frdt) then 
	messagebox('Error At Date','Wages Start Date Should Be Entered, Please Check !!!')
	return 1
end if;
 
if cbx_1.checked = true and (isnull(em_1.text) or double(em_1.text) = 0) then
	messagebox('Warning!','Please Enter Deduction LWF Value !!!')
	ld_lwf = 0
	return 1
elseif cbx_1.checked = true and double(em_1.text) > 0 then
	ld_lwf = double(em_1.text)
else
	ld_lwf = 0
end if

select distinct 'x' into :ls_temp from 
(select Emp_name, LABOUR_ID,  attn_pd.LWW_ID actualweekid ,to_char(LWW_STARTDATE,'dd/mm/yyyy') Startdate,to_char(LWW_ENDDATE,'dd/mm/yyyy') enddate,to_char(LDA_DATE,'dd/mm/yyyy') attendancedate, attn.LWW_ID weekid
 from (select LDA_DATE, LABOUR_ID, KAMSUB_ID,LWW_ID
        from fb_labourdailyattendance
       where LDA_DATE between to_date(:ls_frdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy'))attn,
      (select LWW_ID,LWW_STARTDATE, LWW_ENDDATE from fb_labourwagesweek
        where lww_startdate between to_date(:ls_frdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy') or
              LWW_ENDDATE between to_date(:ls_frdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy'))attn_pd, fb_employee
where LDA_DATE between LWW_STARTDATE and LWW_ENDDATE and attn.labour_id = emp_id and attn.LWW_ID <> attn_pd.LWW_ID    
union all
select Emp_name, LABOUR_ID,  attn_pd.LWW_ID actualweekid ,to_char(LWW_STARTDATE,'dd/mm/yyyy') Startdate,to_char(LWW_ENDDATE,'dd/mm/yyyy') enddate,to_char(LDA_DATE,'dd/mm/yyyy') attendancedate, attn.LWW_ID weekid
 from  (select LWW_ID,LWW_STARTDATE, LWW_ENDDATE from fb_labourwagesweek
        where lww_startdate between to_date(:ls_frdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy') or
              LWW_ENDDATE between to_date(:ls_frdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy'))attn_pd, 
              fb_employee, fb_labourdailyattendance attn
where LDA_DATE not between LWW_STARTDATE and LWW_ENDDATE and attn.labour_id = emp_id and attn.LWW_ID = attn_pd.LWW_ID);

if sqlca.sqlcode = 0 then
	messagebox('Warning!','There is descripancy in Attendance, Please Check !!!')
//	openwithparm(w_gtelar043,ls_frdt+ls_todt)
	opensheetwithparm(w_gtelar043,ls_frdt+ls_todt,w_mdi,0,layered!)
	return 1
	
elseif sqlca.sqlcode = -1 then
	messagebox('SQL ERROR: During Checking Descripancy !',sqlca.sqlerrtext)
	return 1
end if;	
ls_ym = mid(ls_frdt,7,10)+mid(ls_frdt,4,2)
//if gs_garden_snm <> 'KG' and gs_garden_snm <> 'DL' then
if gs_garden_snm <> 'DL'  and ((gs_garden_snm = 'MT' and ls_ym <> '201809') or gs_garden_snm <> 'MT' ) then
	select distinct 'x' into :ls_temp 
	from fb_labourdailyattendance a, 
		  (select emp_id, ls_id, round(((to_date(:ls_frdt,'dd/mm/yyyy') - emp_dob) /365)) age  from fb_employee where round(((to_date(:ls_frdt,'dd/mm/yyyy') - emp_dob) /365)) > 18) b,
		  (select trim(kamsub_id) kamsub_id, kamsub_afrate afrate, kamsub_ahrate ahrate, kamsub_adfrate adfrate, 
						 kamsub_adhrate adhrate, kamsub_cfrate cfrate,kamsub_chrate chrate 
			  from fb_kamsubhead
			  where to_date(:ls_frdt,'dd/mm/yyyy') between trunc(KAMSUB_FRDT) and trunc(nvl(KAMSUB_TODT,sysdate))) c  
	where labour_id = emp_id and a.kamsub_id = c.kamsub_id and nvl(LDA_PRORATAIND,'x') = 'x' and lda_date between to_date(:ls_frdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy') and ((age < 18 and (LDA_WAGES - LDA_ELP) < adfrate) or (age > 18 and (LDA_WAGES - LDA_ELP) < afrate)) and lda_status = '1' ; 
	
	if sqlca.sqlcode = 0 then
		messagebox('Warning!','There is descripancy in Attendance, Please Check !!!')
	//	openwithparm(w_gtelar044,ls_frdt+ls_todt)
		opensheetwithparm(w_gtelar044,ls_frdt+ls_todt,w_mdi,0,layered!)
		return 1
		
	elseif sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During Checking Descripancy !',sqlca.sqlerrtext)
		return 1
	end if;	
end if

if cbx_2.checked = true and (isnull(em_2.text) or double(em_2.text) = 0) then
	messagebox('Warning!','Please Enter Deduction Subscription Value !!!')
	ld_subs = 0
	return 1
elseif cbx_2.checked = true and double(em_2.text) > 0 then
	ld_subs = double(em_2.text)
else
	ld_subs = 0
end if

select distinct lww_id,LWW_PAYCALFLAG into :ls_lwwid,:ls_lwwpaidflag  from fb_labourwagesweek where lww_startdate= to_date(:ls_frdt,'dd/mm/yyyy');

if sqlca.sqlcode =100 then
	messagebox('Wages Week Select ','Either the there is no such week or the wages against this week has been paid, Please Check...!')
	return 1
elseif sqlca.sqlcode = -1 then
	messagebox('SQL ERROR: During Wages Week Select ',sqlca.sqlerrtext)
	return 1
end if;	

select distinct 'x' into :ls_temp from fb_holiday  where trunc(FH_DATE) between to_date(:ls_frdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy') and nvl(FH_ACTIVE_IND,'N') = 'Y';
if sqlca.sqlcode = -1 then
	messagebox('SQL ERROR: During Checking Holiday In Wage Period !!!',sqlca.sqlerrtext)
	return 1
elseif sqlca.sqlcode = 0 then
	messagebox('Warning !','Holiday Process Is Not Run For This Wage Period, Please Check...!')
	return 1
end if;	

select distinct 'x' into :ls_temp from fb_rationperiodforweek where RPFW_LWW_ID =  :ls_lwwid and nvl(RPFW_CALFLAG,'0') = '0';

if sqlca.sqlcode =0 then
	messagebox('Ration Chart checking','The Ration Against this Period has not been paid. First pay the ration for this period, Please Check...!')
	return 1
elseif sqlca.sqlcode = -1 then
	messagebox('SQL ERROR: During Ration Payment checking ',sqlca.sqlerrtext)
	return 1
end if;
	
if ls_lwwpaidflag = '1' then
	if ll_user_level = 1 then	
		if messagebox('Wages Week Select ','The wages against this week has been already paid, Would You Like to Recalculate the Wages',question!,yesno!,1) = 1 then
			update fb_labourwagesweek set lww_paycalflag='0',lww_lwfflag='0' where lww_id = :ls_lwwid;
			if sqlca.sqlcode = -1 then
				messagebox('Sql Error : During Labour Wage Week (Update) ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return 1; 
			end if
			
			/// lpg recovery amt update start
			declare c1 cursor for 
			select LABOUR_ID, labour_lpg_subs_ded from fb_labourweeklywages where lww_id = :ls_lwwid and nvl(labour_lpg_subs_ded, 0) <> 0 ;
			
			open c1 ;
			if sqlca.sqlcode = -1 then
				messagebox('Error', 'Error occured while opening cursor c1 : '+sqlca.sqlerrtext)
				rollback using sqlca;
				return 1;
			end if
			
			setnull(ls_labour_id); ld_lpg_subs_Ded = 0;
			fetch c1 into :ls_labour_id, :ld_lpg_subs_Ded;
			
			do while sqlca.sqlcode <> 100 
				update fb_lpg_subsidy_mast set lsm_recovered_amt = lsm_recovered_amt - :ld_lpg_subs_Ded where emp_id = :ls_labour_id and 
				lsm_issue_date = (select max(lsm_issue_Date) from fb_lpg_Subsidy_mast where emp_id = :ls_labour_id and nvl(lsm_recovered_amt, 0) = :ld_lpg_subs_Ded);
				
				if sqlca.sqlcode = -1 then
					messagebox('Error', 'Error occured while update LPG Subsidy Master : '+sqlca.sqlerrtext)
					rollback using sqlca;
					return 1;
				end if
				
				setnull(ls_labour_id); ld_lpg_subs_Ded = 0;
				fetch c1 into :ls_labour_id, :ld_lpg_subs_Ded;
								
			loop
			/// lpg recovery amt update end
			
			
			delete from fb_labourweeklywages where lww_id=:ls_lwwid;
			
			if sqlca.sqlcode = -1 then
				messagebox('SQL ERROR: During Labour Wages Delete',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			end if;	
		else
			return 1
		end if
	else
		messagebox('Wages Week Select ','The wages against this week has been already paid, You can not Recalculate the Wages, Please Contact "Admin User"',information!)
		return 1
	end if
end if	

SetPointer(HourGlass!);
	 n_wagept luo_wagept
	 luo_wagept = Create n_wagept
	  
	if gs_garden_snm='BE' or gs_garden_snm='MR' or gs_garden_snm='AB' or gs_garden_snm='LP' or gs_garden_snm='SP'  or gs_garden_snm = 'AD' or gs_garden_snm = 'MH' or gs_garden_snm = 'DR' then
//		if luo_wagept.wf_wagecal_2w(ls_frdt,ld_lwf,ld_subs) = -1 then 
//			rollback using sqlca;
//			return 1;  
//		end if;

		if luo_wagept.wf_wagecal_2wdb(ls_frdt,ld_lwf,ld_subs) = -1 then 
			rollback using sqlca;
			return 1; 
		end if;

	else
		if luo_wagept.wf_wagecal_db(ls_frdt,ld_lwf,ld_subs) = -1 then 
			rollback using sqlca;
			return 1;
		end if;
	end if
	
messagebox('Confirmation','The wages Has Been Sucessfully Calculate, Please Check....!',information!)

SetPointer(Arrow!);
end event

type st_1 from statictext within w_gtelaf023
integer x = 279
integer y = 252
integer width = 544
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "Wages Start Date :"
alignment alignment = right!
boolean focusrectangle = false
end type

