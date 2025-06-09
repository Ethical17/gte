$PBExportHeader$w_gtelaf029.srw
forward
global type w_gtelaf029 from window
end type
type st_1 from statictext within w_gtelaf029
end type
type em_2 from editmask within w_gtelaf029
end type
type em_1 from editmask within w_gtelaf029
end type
type em_7 from editmask within w_gtelaf029
end type
type st_7 from statictext within w_gtelaf029
end type
type em_6 from editmask within w_gtelaf029
end type
type st_6 from statictext within w_gtelaf029
end type
type cb_2 from commandbutton within w_gtelaf029
end type
type cb_3 from commandbutton within w_gtelaf029
end type
type st_3 from statictext within w_gtelaf029
end type
type cb_4 from commandbutton within w_gtelaf029
end type
type dw_1 from datawindow within w_gtelaf029
end type
end forward

global type w_gtelaf029 from window
integer width = 2446
integer height = 2168
boolean titlebar = true
string title = "(W_gtelaf029) Absentism "
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_1 st_1
em_2 em_2
em_1 em_1
em_7 em_7
st_7 st_7
em_6 em_6
st_6 st_6
cb_2 cb_2
cb_3 cb_3
st_3 st_3
cb_4 cb_4
dw_1 dw_1
end type
global w_gtelaf029 w_gtelaf029

type variables
long ll_ctr, ll_last, ll_paybook
boolean lb_neworder, lb_query
string LS_ID, LS_TYPE,LS_DESC, LS_ENTRY_BY,LS_LABOUR_ID  ,Ls_PERIOD_FR,Ls_PERIOD_TO
date LD_DATE,LD_ENTRY_DT,LD_PRINT_DT
double ld_absent
end variables

forward prototypes
public function integer wf_inquiry (long fl_year)
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
	case "PDF"
			this.dw_1.saveas("C:\reports\Gtebgr001.pdf",pdf!,true)
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

public function integer wf_inquiry (long fl_year);dw_1.settransobject(sqlca)
dw_1.retrieve(gs_user,fl_year)
return 1
end function

on w_gtelaf029.create
this.st_1=create st_1
this.em_2=create em_2
this.em_1=create em_1
this.em_7=create em_7
this.st_7=create st_7
this.em_6=create em_6
this.st_6=create st_6
this.cb_2=create cb_2
this.cb_3=create cb_3
this.st_3=create st_3
this.cb_4=create cb_4
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.em_2,&
this.em_1,&
this.em_7,&
this.st_7,&
this.em_6,&
this.st_6,&
this.cb_2,&
this.cb_3,&
this.st_3,&
this.cb_4,&
this.dw_1}
end on

on w_gtelaf029.destroy
destroy(this.st_1)
destroy(this.em_2)
destroy(this.em_1)
destroy(this.em_7)
destroy(this.st_7)
destroy(this.em_6)
destroy(this.st_6)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.st_3)
destroy(this.cb_4)
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
lb_query = false	
lb_neworder = false

setpointer(hourglass!)

end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if

end event

type st_1 from statictext within w_gtelaf029
integer x = 681
integer y = 4
integer width = 247
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pay Book"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_2 from editmask within w_gtelaf029
integer x = 686
integer y = 80
integer width = 238
integer height = 76
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
string mask = "##"
end type

type em_1 from editmask within w_gtelaf029
integer x = 960
integer y = 80
integer width = 320
integer height = 76
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "########"
end type

type em_7 from editmask within w_gtelaf029
integer x = 357
integer y = 80
integer width = 315
integer height = 76
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type st_7 from statictext within w_gtelaf029
integer x = 402
integer y = 4
integer width = 201
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To Date"
boolean focusrectangle = false
end type

type em_6 from editmask within w_gtelaf029
integer x = 27
integer y = 80
integer width = 315
integer height = 76
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type st_6 from statictext within w_gtelaf029
integer x = 37
integer y = 4
integer width = 274
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From Date"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gtelaf029
integer x = 1591
integer y = 76
integer width = 265
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&New"
end type

event clicked;dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false
//dw_1.reset()

if isnull(em_6.text) or len(em_6.text) <1 then 
	messagebox('Warning','From Date Should be Enter') 
	return  1
end if
if isnull(em_7.text) or len(em_7.text) <1 then 
	messagebox('Warning','To Date Should be Enter') 
	return  1
end if

if isnull(em_2.text) or len(em_2.text) = 0  then 
	messagebox('Warning ','Please Enter Pay Book No ...!') 
	return  1
end if

if isnull(em_1.text) or len(em_1.text) = 0 then 
	messagebox('Warning ','Please Select a Valid Absent Days ...!') 
	return  1
end if


setpointer(hourglass!)

delete from temp_attn;
if sqlca.sqlcode = -1 then
	messagebox('SQL Error : During Delete',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if;	

long  count1,ll_abdays
double abs_days
string old_labid,ls_firstread ,ls_labid,ls_name,ls_kamid,old_name
date ld_frdt,ld_todt ,old_dt 

ll_abdays = long(em_1.text);
ll_paybook = long(em_2.text);
ld_frdt=date(em_6.text);
ld_todt=date(em_7.text);
count1 = 0 ;abs_days= 0;
ls_firstread = 'Y';	

declare c1 cursor for 
select LDA_DATE,LABOUR_ID,EMP_NAME,KAMSUB_NAME
  from FB_LABOURDAILYATTENDANCE a,FB_KAMSUBHEAD b,fb_employee c
where a.KAMSUB_ID=b.KAMSUB_ID and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and a.LABOUR_ID = c.EMP_ID and c.ls_id = :ll_paybook and
		 a.LDA_DATE between :ld_frdt AND :ld_todt
order by 2,1;

open c1;   

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return 1; 
else 
	setnull(ls_labid);setnull(ls_name);setnull(ls_kamid);setnull(ld_date);

	fetch c1 into :ld_date,:ls_labid,:ls_name,:ls_kamid;
	if sqlca.sqlcode = -1 then 
		messagebox('Error','Error During Fetching Data'+sqlca.sqlerrtext);
		return 1
	end if;
	do while sqlca.sqlcode <> 100     
		    if ls_firstread = 'Y' then
				old_labid = ls_labid; 
				old_name = ls_name;				
				old_dt = ld_date ;		 
		         ls_firstread = 'N';
			end if;
			
		if  (ls_labid = old_labid) and (ld_date = ld_frdt or RelativeDate(old_dt,1) = ld_date)  then 
			  if ls_kamid='AB' then
				 count1 = count1 + 1;
			  else
				  abs_days = count1;
				// count1 = 0;	 
			  end if;		
			 // messagebox('ab=',ls_labid+'  '+ls_kamid+' '+string(count1))
			  old_dt = ld_date ;		
		elseif (ls_labid <> old_labid) then
				//messagebox('a=',old_labid+'  '+string(abs_days))
				if abs_days>=ll_abdays then
					insert into temp_attn(LAB_ID,lab_name,absent_days,FROM_DT, TO_DT) values(:old_labid,:old_name,:abs_days,:ld_frdt,:ld_todt);
						if sqlca.sqlcode = -1 then
						messagebox('SQL Error : During insert',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					end if;	  
				end if;	
				old_labid = ls_labid; 
				old_name = ls_name;
				old_dt = ld_date ;
		         count1 = 0;	 
		 end if;
		  //end if;
     setnull(ls_labid);setnull(ls_name);setnull(ls_kamid);setnull(ld_date);
	fetch c1 into :ld_date,:ls_labid,:ls_name,:ls_kamid;
		  
  loop;
  if abs_days>=ll_abdays then
	 insert into temp_attn(LAB_ID,lab_name,absent_days,FROM_DT, TO_DT) values(:old_labid,:old_name,:abs_days,:ld_frdt,:ld_todt);
    		if sqlca.sqlcode = -1 then
			messagebox('SQL Error : During insert',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if;	
   end if;				
close c1;
commit using sqlca;	  
end if;	

dw_1.retrieve(gs_user)
setpointer(arrow!)
end event

type cb_3 from commandbutton within w_gtelaf029
integer x = 1861
integer y = 76
integer width = 265
integer height = 100
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Save"
end type

event clicked;if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	if lb_neworder = true and dw_1.rowcount() > 0 then

	//New/Update  received qnty  update in indent
		ll_last=0
		if ll_last=0 then
			select nvl(MAX(substr(FD_ID,5,10)),0) into :ll_last from fb_disciplinary;
		end if

		for ll_ctr = 1 to dw_1.rowcount()
				ll_last = ll_last + 1
						
				LS_ID = 'LDID'+string(ll_last,'0000000000')
				LS_TYPE = 'A'
				LS_DESC='Absenteeism Reason' 
				LS_ENTRY_BY=gs_user
				LS_LABOUR_ID= dw_1.getitemstring(ll_ctr,'lab_id') 
				LD_DATE=date(today())
				Ls_PERIOD_FR=string(dw_1.getitemdatetime(ll_ctr,'FROM_DT'),'dd/mm/yyyy') 
				Ls_PERIOD_TO=string(dw_1.getitemdatetime(ll_ctr,'TO_DT'),'dd/mm/yyyy') 
				ld_absent = dw_1.getitemnumber(ll_ctr,'absent_days')
				LD_ENTRY_DT=date(today())
						
				//ls_cnclty = dw_1.getitemstring(ll_ctr,'cncl_type')
				insert into fb_disciplinary( FD_ID, FD_DATE, FD_TYPE, FD_PERIOD_FR, FD_PERIOD_TO, FD_DESC, FD_ENTRY_BY, FD_ENTRY_DT, FD_LABOUR_ID,fd_absdays)
					values(:LS_ID,to_date(:LD_DATE,'dd/mm/yyyy'),:LS_TYPE,to_date(:Ls_PERIOD_FR,'dd/mm/yyyy'),to_date(:Ls_PERIOD_TO,'dd/mm/yyyy'),:LS_DESC,:LS_ENTRY_BY ,to_date(:LD_ENTRY_DT,'dd/mm/yyyy'),:LS_LABOUR_ID,:ld_absent);
						
					if sqlca.sqlcode = -1 then
						messagebox('Sql Error During insert in master : ',sqlca.sqlerrtext);
						return 1;
					end if;						
		next
	end if		
	
	commit using sqlca;
	cb_3.enabled = false
	cb_2.enabled = true
	dw_1.reset()
		
else
	return
end if 
end event

type st_3 from statictext within w_gtelaf029
integer x = 946
integer y = 4
integer width = 448
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "No of Days Absent"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_gtelaf029
integer x = 2130
integer y = 76
integer width = 265
integer height = 100
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_gtelaf029
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 27
integer y = 184
integer width = 2368
integer height = 1864
string dataobject = "dw_gtelaf029"
boolean vscrollbar = true
end type

