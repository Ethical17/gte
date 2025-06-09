$PBExportHeader$w_gtehrf014.srw
forward
global type w_gtehrf014 from window
end type
type cb_1 from commandbutton within w_gtehrf014
end type
type st_1 from statictext within w_gtehrf014
end type
type ddlb_1 from dropdownlistbox within w_gtehrf014
end type
type cb_5 from commandbutton within w_gtehrf014
end type
type cb_4 from commandbutton within w_gtehrf014
end type
type cb_3 from commandbutton within w_gtehrf014
end type
type dw_1 from datawindow within w_gtehrf014
end type
end forward

global type w_gtehrf014 from window
integer width = 4576
integer height = 2392
boolean titlebar = true
string title = "(w_gtehrf014) Bonus process "
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_1 cb_1
st_1 st_1
ddlb_1 ddlb_1
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
dw_1 dw_1
end type
global w_gtehrf014 w_gtehrf014

type variables
long ll_ctr,ll_cnt, ll_year, ll_last, ll_st_year, ll_end_year,ll_user_level,ll_id
string ls_temp,ls_name,ls_last,ls_type,ls_tmp_id,ls_count,ls_bonusid,ls_emp_ty
boolean lb_neworder, lb_query
datetime ld_frdt, ld_todt,ld_otodt,ld_ofrdt
string ls_frdt, ls_todt
double ld_bonus_limit

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (datetime fd_frdt, datetime fd_todt)
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
//	if (isnull(dw_1.getitemdatetime(fl_row,'lbp_startdate')) or isnull(dw_1.getitemdatetime(fl_row,'lbp_enddate')) then
//	    messagebox('Warning: One Of The Following Fields Are Blank', 'Season Start Date, Season End Date,Bonus Per,min Working Days.  Please Check !!!')
//		 return -1
//	end if
end if
return 1
end function

public function integer wf_check_duplicate_rec (datetime fd_frdt, datetime fd_todt);long fl_row
datetime ld_fdt1, ld_todt1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ld_fdt1 = dw_1.getitemdatetime(fl_row,'lbs_startdate')
		ld_todt1 = dw_1.getitemdatetime(fl_row,'lbs_enddate')
		
		if ld_fdt1 = fd_frdt and ld_todt1 = fd_todt then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gtehrf014.create
this.cb_1=create cb_1
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.st_1,&
this.ddlb_1,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.dw_1}
end on

on w_gtehrf014.destroy
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.dw_1)
end on

event open;//dw_1.modify("t_co.text = '"+gs_co_name+"'")
if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if

dw_1.settransobject(sqlca)
lb_query = false	
lb_neworder = false

date ld_dt
declare c1 cursor for
select to_char(lbs_STARTDATE,'dd/mm/yyyy')||'-'||to_char(lbs_ENDDATE,'dd/mm/yyyy')||' ('||lbs_ID||' - '||LBS_EMP_TYPE||') - '||lbs_CONFIRM,lbs_STARTDATE
  from fb_labbonusseason  where LBS_EMP_TYPE not in ('LP','LT','LO')
order by lbs_STARTDATE desc;

open c1;

IF sqlca.sqlcode = 0 THEN 
	fetch c1 into :ls_bonusid,:ld_dt;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_bonusid)
		fetch c1 into:ls_bonusid,:ld_dt;
	loop
	close c1;
end if

this.tag = Message.StringParm
ll_user_level = long(this.tag)
end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if
IF KeyDown(KeyF1!) THEN
	cb_1.triggerevent(clicked!)
end if
IF KeyDown(KeyF3!) THEN
	if dw_1.rowcount() > 0  then
		cb_3.triggerevent(clicked!)
	end if
end if
end event

type cb_1 from commandbutton within w_gtehrf014
integer x = 2642
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
boolean enabled = false
string text = "&Process"
end type

event clicked;if  len(trim(ddlb_1.text)) = 0 or isnull(ddlb_1.text) then
	messagebox ('Warning','Please Select the Bonus Period.')
	return 1
end if;
setpointer(hourglass!)
ls_frdt=left(ddlb_1.text,10)
ls_todt=left(right(ddlb_1.text,30),10)
ls_bonusid=left(right(ddlb_1.text,18),8)


for ll_cnt = 1 to dw_1.rowcount( ) 
	if isnull(dw_1.getitemstring(ll_cnt,'ebp_id')) or len(dw_1.getitemstring(ll_cnt,'ebp_id')) = 0 then
		messagebox('Warning!','First Save The Record Then Click On Process Button !!!')
		return 1
	end if
next

//if right(ddlb_1.text,1) = '1' then
//	MessageBox('Bonus Calculation Error','Bonus Already calculateed for the period : '+ ls_frdt+' to '+ls_todt+',  Please Check..!',information!)
//	return 1
//end if
//
//if MessageBox('Confirmation: Bonus Calculation','Do you want to calculate Bonus for the period : '+ ls_frdt+' to '+ls_todt,Question!,yesno!,1 )=2 then
//	return 1
//end if
string ls_LBP_ID ,ls_start_dt,ls_end_dt,ls_ID,Ls_PERORNOT,ls_LTYPE,ls_OTYPE,ls_lwwpaidflag
double ld_BONUSPER,Ld_PUJAPER,Ld_PAUSPER,Ld_FAGUAPER,Ld_MINWDAYS

select distinct LBS_CONFIRM into :ls_lwwpaidflag from fb_labbonusseason where LBS_ID = :ls_bonusid;

if sqlca.sqlcode =100 then
	messagebox('Bonus Week Select ','No bonus period found, Please Check...!')
	return 1
elseif sqlca.sqlcode = -1 then
	messagebox('SQL ERROR: During Bonus Week Select ',sqlca.sqlerrtext)
	return 1
end if;	

if ls_lwwpaidflag = '1' then
	if ll_user_level = 1 then	
		if messagebox('Bonus Select ','The Bonus against this Period has been already calculated, Would You Like to Recalculate the Bonus',question!,yesno!,1) = 1 then
			update fb_labbonusseason set LBS_CONFIRM='0' where LBS_ID = :ls_bonusid;
			if sqlca.sqlcode = -1 then
				messagebox('Sql Error : During Labour Bonus Week (Update) ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return 1; 
			end if
			
			delete from fb_empbonus where LBP_ID in (select EBP_ID from fb_empbonusperiod where  LBS_ID = :ls_bonusid);
			
			if sqlca.sqlcode = -1 then
				messagebox('Sql Err: During Delete Of Labour Bonus', sqlca.sqlerrtext)
				return 1
			end if
		else
			return 1
		end if
	else
		messagebox('Bonus Select ','The Bonus against this Period has been already Calculated, You can not Recalculate the Bonus, Please Contact "Admin User"',information!)
		return 1
	end if
end if	

select distinct 'x' into :ls_temp from fb_empbonus where LBP_ID in (select EBP_ID from fb_empbonusperiod where  LBS_ID = :ls_bonusid);
if sqlca.sqlcode = 0 then
	delete from fb_empbonus where LBP_ID in (select EBP_ID from fb_empbonusperiod where  LBS_ID = :ls_bonusid);
elseif sqlca.sqlcode = -1 then
	messagebox('Sql Err: During Delete Of Labour Bonus', sqlca.sqlerrtext)
	return 1
end if


//	 		select :ls_LBP_ID,emp_id labid,
//	 		 		0 workdays,sum(nvl(totearn,0)) grearn,
//	 		 		decode(:ls_PERORNOT,'1',(round((sum(nvl(totearn,0)))*0.01*nvl(:ld_PUJAPER,0),2) + round((sum(nvl(totearn,0)))*0.01*nvl(:Ld_PAUSPER,0),2)+round((sum(nvl(totearn,0)))*0.01*nvl(:ld_FAGUAPER,0),2)),
//													 ((sum(nvl(totearn,0))+1) * nvl(:ld_BONUSPER,0))  ) bonusamo,
//	 		 		decode(:ls_PERORNOT,'1',round((sum(nvl(totearn,0)))*0.01*nvl(:ld_PUJAPER,0),2), 
//			  										 ((sum(nvl(totearn,0))+1)*nvl(:ld_PUJAPER,0))) pujaamo, 
//			 		decode(:ls_PERORNOT,'1',round((sum(nvl(totearn,0)))*0.01*nvl(:Ld_PAUSPER,0),2),
//			 										 ((sum(nvl(totearn,0))+1)*nvl(:Ld_PAUSPER,0))) pausamo, 
//			 	   	decode(:ls_PERORNOT,'1',round((sum(nvl(totearn,0)))*0.01*nvl(:ld_FAGUAPER,0),2),
//			 										 ((sum(nvl(totearn,0))+1)*nvl(:ld_FAGUAPER,0))) faguaamo
//			from  (select emp.emp_id,emp_name,
//							(emp.ebs_basicamount +
//							(nvl(emp.ebs_basicamount,0) * nvl(ead.ead_da,0) / 100) +
//							(nvl(emp.ebs_basicamount,0) * nvl(ead.ead_vda,0) / 100) +
//							(nvl(emp.ebs_basicamount,0) * nvl(ead.ead_hr,0) / 100) + nvl(emp.emp_adhoc,0)) totearn
//					  from fb_employee emp,
//							(select * from fb_empallowancededuction where (EAD_GRADE,(nvl(EAD_YEAR,0) * 100 + nvl(EAD_MONTH,0))) in
//										(select EAD_GRADE,max(nvl(EAD_YEAR,0) * 100 + nvl(EAD_MONTH,0)) from fb_empallowancededuction group by EAD_GRADE)) ead
//		  where emp.emp_grade=ead.ead_grade and ead.ead_validityflag='1' and emp.emp_active='1' and emp.emp_type = :ls_emp_ty)
//		  group by :ls_bonusid,emp_id;

//42000
select sum(nvl(pd_value,0)) into :ld_bonus_limit
from fb_param_detail 
where pd_doc_type in ('BONUS') and to_date(:ls_frdt,'dd/mm/yyyy') between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));

if sqlca.sqlcode = -1 then
	messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
	return -1
end if;

if isnull(ld_bonus_limit) or ld_bonus_limit = 0 then ld_bonus_limit = 84000;

declare c1 cursor for
select EBP_ID ,to_char(EBP_STARTDATE,'dd/mm/yyyy'),to_char(EBP_ENDDATE,'dd/mm/yyyy'),
		LBS_EMP_TYPE,EBP_BONUSPER,EBP_PUJAPER,EBP_PAUSPER,EBP_FAGUAPER,EBP_MINWDAYS,EBP_PERORNOT
  from fb_empbonusperiod
where LBS_ID = :ls_bonusid;

open c1;
if sqlca.sqlcode = -1 then
	messagebox('SQL Error: During C1 Cursor',sqlca.sqlerrtext)
	return 1
end if
		setnull(ls_LBP_ID);setnull(ls_start_dt);setnull(ls_end_dt);setnull(ls_emp_ty);setnull(Ls_PERORNOT)
		ld_BONUSPER=0;Ld_PUJAPER=0;Ld_PAUSPER=0;Ld_FAGUAPER=0;Ld_MINWDAYS=0;

	fetch c1 into :ls_LBP_ID ,:ls_start_dt,:ls_end_dt,:ls_emp_ty,:ld_BONUSPER,:Ld_PUJAPER,:Ld_PAUSPER,:Ld_FAGUAPER,:Ld_MINWDAYS,:Ls_PERORNOT;
	do while sqlca.sqlcode <> 100
// Arrear Amount Added in bonus in case of matellie as earlier there was no provision in old system a new table create  FB_EMPARREAR and data provided in excell by garden inserted
// and script modified for matellie.
	if 	gs_garden_snm <> 'MT' then
			insert into fb_empbonus(lbp_id,labour_id,lb_workdays,lb_grearn,lb_bonusamo,lb_pujaamo,lb_pausamo,lb_faguaamo)
			select :ls_LBP_ID,emp_id labid,
									sum(nvl(workdays,0)) workdays, round(sum(nvl(totearn,0)), 2) grearn,
									decode(:ls_PERORNOT,'1',(round((sum(nvl(totearn,0)))*0.01*nvl(:ld_PUJAPER,0),2) + round((sum(nvl(totearn,0)))*0.01*nvl(:Ld_PAUSPER,0),2)+round((sum(nvl(totearn,0)))*0.01*nvl(:ld_FAGUAPER,0),2)),
																												  round(((sum(nvl(totearn,0))) * 0.01 * nvl(:ld_BONUSPER,0)),2)  ) bonusamo,
									decode(:ls_PERORNOT,'1',round((sum(nvl(totearn,0))) * 0.01 * nvl(:ld_PUJAPER,0),2), 
																												 ((sum(nvl(totearn,0))) * 0.01 * nvl(:ld_PUJAPER,0))) pujaamo, 
									decode(:ls_PERORNOT,'1',round((sum(nvl(totearn,0))) * 0.01 * nvl(:Ld_PAUSPER,0),2),
																												  ((sum(nvl(totearn,0))) * 0.01 * nvl(:Ld_PAUSPER,0))) pausamo, 
									decode(:ls_PERORNOT,'1',round((sum(nvl(totearn,0))) * 0.01 * nvl(:ld_FAGUAPER,0),2),
																												  ((sum(nvl(totearn,0))) * 0.01 * nvl(:ld_FAGUAPER,0))) faguaamo
							from  (select EMP_ID, decode(sign(sum(earn) - :ld_bonus_limit),-1,sum(earn),:ld_bonus_limit) totearn, sum(workdays) workdays from (
									select ead.emp_id, sum(nvl(EP_BASICAMOUNT,0) + nvl(EP_DAAMOUNT,0) + nvl( EP_VDAAMOUNT,0)) earn, workdays
												from fb_employee emp, fb_emppayment ead, (select emp_id, sum(1) workdays from fb_empattendance where EATTEN_DATE between to_date(:ls_frdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy') and EATTEN_STATUS  = 'WK' group by emp_id) atten
												where emp.emp_id = ead.emp_id and atten.emp_id = emp.emp_id and emp.emp_type = :ls_emp_ty and  ((nvl(EP_YEAR,0) * 100) + nvl(EP_MONTH,0)) between substr(:ls_frdt,7,4)||substr(:ls_frdt,4,2) and substr(:ls_todt,7,4)||substr(:ls_todt,4,2)
									group by ead.EMP_ID,workdays
									union all
									select a.EMP_ID, sum(EA_AMOUNT) earn, 0
									 from fb_emparrear a, fb_emp_arrearperiod b, fb_employee c where a.AP_ID = b.ap_id and a.emp_id = c.emp_id and c.emp_type = :ls_Emp_ty and AP_PAYDATE between to_date(:ls_frdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy')
									 group by a.emp_id )
									 group by EMP_ID)
			  group by :ls_bonusid,emp_id
			  order by 2;
			  

//	elseif 	gs_garden_snm = 'MT' then
//		
//			insert into fb_empbonus(lbp_id,labour_id,lb_workdays,lb_grearn,lb_bonusamo,lb_pujaamo,lb_pausamo,lb_faguaamo)
//			select :ls_LBP_ID,emp_id labid,
//											0 workdays,sum(nvl(totearn,0)) grearn,
//											decode(:ls_PERORNOT,'1',(round((sum(nvl(totearn,0)))*0.01*nvl(:ld_PUJAPER,0),2) + round((sum(nvl(totearn,0)))*0.01*nvl(:Ld_PAUSPER,0),2)+round((sum(nvl(totearn,0)))*0.01*nvl(:ld_FAGUAPER,0),2)),
//																																					round(((sum(nvl(totearn,0))+1) * 0.01 * nvl(:ld_BONUSPER,0)),2)  ) bonusamo,
//											decode(:ls_PERORNOT,'1',round((sum(nvl(totearn,0))) * 0.01 * nvl(:ld_PUJAPER,0),2), 
//																																				  ((sum(nvl(totearn,0))+1) * 0.01 * nvl(:ld_PUJAPER,0))) pujaamo, 
//											decode(:ls_PERORNOT,'1',round((sum(nvl(totearn,0))) * 0.01 * nvl(:Ld_PAUSPER,0),2),
//																																					((sum(nvl(totearn,0))+1) * 0.01 * nvl(:Ld_PAUSPER,0))) pausamo, 
//											decode(:ls_PERORNOT,'1',round((sum(nvl(totearn,0))) * 0.01 * nvl(:ld_FAGUAPER,0),2),
//																																					((sum(nvl(totearn,0))+1) * 0.01 * nvl(:ld_FAGUAPER,0))) faguaamo
//								 from  (select ead.EMP_ID,emp_name, decode(sign(sum(nvl(EP_BASICAMOUNT,0) + nvl(EP_DAAMOUNT,0) + nvl( EP_VDAAMOUNT,0)) - :ld_bonus_limit),-1,sum(nvl(EP_BASICAMOUNT,0) + nvl(EP_DAAMOUNT,0) + nvl( EP_VDAAMOUNT,0)),:ld_bonus_limit) totearn
//																			 from fb_employee emp, fb_emppayment ead 
//																			 where emp.emp_id = ead.emp_id and emp.emp_type = :ls_emp_ty and  ((nvl(EP_YEAR,0) * 100) + nvl(EP_MONTH,0)) between substr(:ls_frdt,7,4)||substr(:ls_frdt,4,2) and substr(:ls_todt,7,4)||substr(:ls_todt,4,2)
//													  group by ead.EMP_ID,emp_name
//										  union all
//										  select labour_id,emp_name, round((nvl(LA_AMOUNT,0) / 2),2) amt 
//										  from FB_EMPARREAR a, fb_employee b 
//										  where a.labour_id = b.emp_id and b.emp_type = :ls_emp_ty and AFS_ID = 'AFS0000000002')
//			  group by :ls_bonusid,emp_id
//			  order by 2;		
	end if
		  
		if sqlca.sqlcode = -1 then
			messagebox('Error', 'Error occured while inserting records : '+sqlca.sqlerrtext);
			rollback using sqlca;
			 close c1 ;
			 return 1 ;
		end if
			
		setnull(ls_LBP_ID);setnull(ls_start_dt);setnull(ls_end_dt);setnull(ls_emp_ty);setnull(Ls_PERORNOT)
		ld_BONUSPER=0;Ld_PUJAPER=0;Ld_PAUSPER=0;Ld_FAGUAPER=0;Ld_MINWDAYS=0;

	fetch c1 into :ls_LBP_ID ,:ls_start_dt,:ls_end_dt,:ls_emp_ty,:ld_BONUSPER,:Ld_PUJAPER,:Ld_PAUSPER,:Ld_FAGUAPER,:Ld_MINWDAYS,:Ls_PERORNOT;
loop

close c1;
setpointer(arrow!)

if ls_lwwpaidflag = '0' then
	if messagebox('Bonus Processing ','Is this final processing?',question!,yesno!,1) = 1 then
		update fb_labbonusseason set LBS_CONFIRM = 1 where LBS_ID = :ls_bonusid;
		if sqlca.sqlcode = -1 then
			messagebox('Sql Err: During Updating labbonusseason', sqlca.sqlerrtext)
			return 1
		end if
	end if
else
	update fb_labbonusseason set LBS_CONFIRM = 1 where LBS_ID = :ls_bonusid;
	if sqlca.sqlcode = -1 then
		messagebox('Sql Err: During Updating labbonusseason', sqlca.sqlerrtext)
		return 1
	end if
end if 


commit using sqlca;
MessageBox("Bonus Calculation",'Bonus during the period : '+ ls_frdt+' to '+ls_todt+' has been calculated successfully...!')
cb_1.enabled = false
end event

type st_1 from statictext within w_gtehrf014
integer x = 18
integer y = 36
integer width = 366
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Bonus Period Id"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gtehrf014
integer x = 398
integer y = 20
integer width = 1431
integer height = 720
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

type cb_5 from commandbutton within w_gtehrf014
integer x = 1851
integer y = 16
integer width = 265
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "OK"
boolean default = true
end type

event clicked;dw_1.settransobject(sqlca)

if  len(trim(ddlb_1.text)) = 0 or isnull(ddlb_1.text) then
	messagebox ('Error:','Please Select the Bonus Id.')
	return 1
end if;
dw_1.reset()
ls_frdt=left(ddlb_1.text,10)
ls_todt=left(right(ddlb_1.text,30),10)
ls_bonusid=left(right(ddlb_1.text,18),8)
ls_emp_ty = left(right(ddlb_1.text,7),2)

cb_1.enabled = false

dw_1.settransobject(sqlca);
dw_1.retrieve(ls_bonusid,long(right(ddlb_1.text,1))) 

//if right(ddlb_1.text,1) = '0' then
	cb_1.enabled = true
//else
//	cb_1.enabled = false
//end if

if dw_1.rowcount() = 0 then

//	DECLARE c1 CURSOR FOR  
//	select distinct emp_type from fb_employee where nvl(EMP_ACTIVE,'0')='1' and emp_type not in ('LP','LT','LO') order by 1;		
//
//	open c1;
//	
//	IF sqlca.sqlcode = 0 THEN
//		fetch c1 into :ls_emp_ty;
//		
//		do while sqlca.sqlcode <> 100
			dw_1.scrolltorow(dw_1.insertrow(0))
			dw_1.setitem(dw_1.getrow(),'lbs_id',ls_bonusid)
			dw_1.setitem(dw_1.getrow(),'ebp_startdate',datetime(ls_frdt))
			dw_1.setitem(dw_1.getrow(),'ebp_enddate',datetime(ls_todt))
			dw_1.setitem(dw_1.getrow(),'lbs_emp_type',ls_emp_ty)
			dw_1.setitem(dw_1.getrow(),'ebp_entry_by',gs_user)
			dw_1.setitem(dw_1.getrow(),'ebp_entry_dt',datetime(today()))
			dw_1.setitem(dw_1.getrow(),'ebp_paidflag','0')
//			fetch c1 into :ls_emp_ty;
//		loop
//	END IF
//	close c1;
	dw_1.setfocus()
	dw_1.scrolltorow(1)
	dw_1.setcolumn('ebp_bonusper')
	lb_neworder = true
	lb_query = false
//	dw_1.settransobject(sqlca);
//	dw_1.retrieve(ls_bonusid);
//	cb_1.enabled = true
end if

end event

type cb_4 from commandbutton within w_gtehrf014
integer x = 2373
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

event clicked;if dw_1.modifiedcount( ) > 0 or dw_1.deletedcount( ) > 0 then
	IF MessageBox("Exit Alert", 'Do You Want To Exit....?' ,Exclamation!, YesNo!, 1) = 1 THEN
		close(parent)
	else
		return
	end if
else
	close(parent)
end if
end event

type cb_3 from commandbutton within w_gtehrf014
integer x = 2112
integer y = 16
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

event clicked;if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

IF (isnull(dw_1.getitemdatetime(dw_1.rowcount(),'ebp_startdate')) ) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
	if lb_neworder = true then
		select nvl(MAX(EBP_ID),0) into :ls_last from fb_empbonusperiod;
		ls_last = right(ls_last,5)
		ll_cnt = long(ls_last)
	end if

	if dw_1.rowcount() > 0 then
		for ll_ctr = 1 to dw_1.rowcount( ) 
			
			if lb_neworder = true then
				ll_cnt = ll_cnt + 1
				select lpad(:ll_cnt,5,'0') into :ls_count from dual;
				ls_tmp_id = 'EBP'+ls_count
				dw_1.setitem(ll_ctr,'ebp_id',ls_tmp_id)
			end if

		next	
	end if

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

type dw_1 from datawindow within w_gtehrf014
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 120
integer width = 4480
integer height = 2052
integer taborder = 40
string dataobject = "dw_gtehrf014"
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
		dw_1.setitem(newrow,'ebp_entry_by',gs_user)
		dw_1.setitem(newrow,'ebp_entry_dt',datetime(today()))
		dw_1.setcolumn('ebp_bonusper')
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
		
	dw_1.setitem(row,'ebp_entry_by',gs_user)
	dw_1.setitem(row,'ebp_entry_dt',datetime(today()))

cb_3.enabled = true
end if

end event

