$PBExportHeader$w_gtedsf006.srw
forward
global type w_gtedsf006 from window
end type
type cb_6 from commandbutton within w_gtedsf006
end type
type cb_5 from commandbutton within w_gtedsf006
end type
type cb_7 from commandbutton within w_gtedsf006
end type
type cb_8 from commandbutton within w_gtedsf006
end type
type cb_9 from commandbutton within w_gtedsf006
end type
type dw_2 from datawindow within w_gtedsf006
end type
type cb_4 from commandbutton within w_gtedsf006
end type
type cb_3 from commandbutton within w_gtedsf006
end type
type cb_2 from commandbutton within w_gtedsf006
end type
type cb_1 from commandbutton within w_gtedsf006
end type
type dw_1 from datawindow within w_gtedsf006
end type
end forward

global type w_gtedsf006 from window
integer width = 4535
integer height = 2432
boolean titlebar = true
string title = "(w_gtedsf006) Dispatch Advice"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_6 cb_6
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
global w_gtedsf006 w_gtedsf006

type variables
long ll_ctr,ll_cnt,l_ctr,ix,ll_user_level
string ls_temp,ls_del_ind,ls_tmp_id,ls_entry_user,ls_cons,ls_last,ls_count, ls_ref, ls_desc,ls_cus, ls_brok, ls_type,ls_satype
string ls_bname, ls_badd, ls_cname, ls_cadd
boolean lb_neworder, lb_query
double ld_hrs, ld_gross, ld_tear, ld_net
datetime ld_rundt

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_prod)
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
	if (isnull(dw_2.getitemstring(fl_row,'tmp_id')) or  len(dw_2.getitemstring(fl_row,'tmp_id'))=0 or &
		 isnull(dw_2.getitemnumber(fl_row,'advice_ordquantity')) or dw_2.getitemnumber(fl_row,'advice_ordquantity') = 0 ) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Product, Order Quantity, Please Check !!!')
		 return -1
	end if
end if
return 1

end function

public function integer wf_check_duplicate_rec (string fs_prod);long fl_row
string ls_prod1

dw_2.SelectRow(0, FALSE)
if dw_2.rowcount() > 1 then
	for fl_row = 1 to (dw_2.rowcount() - 1)
		ls_prod1 = dw_2.getitemstring(fl_row,'tmp_id')
		
		if trim(ls_prod1) = trim(fs_prod) then
			dw_2.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gtedsf006.create
this.cb_6=create cb_6
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
this.Control[]={this.cb_6,&
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

on w_gtedsf006.destroy
destroy(this.cb_6)
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

//dw_2.GetChild ("tmp_id", idw_grade)
//idw_grade.settransobject(sqlca)	

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

type cb_6 from commandbutton within w_gtedsf006
integer x = 1074
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
string text = "&Import"
end type

event clicked;integer l_fnum
long l_flen,l_bytes_read,l_rec_len,l_count,l_fexit, l_ctr1
string l_byte,l_rec_val,ls_filename,lf_fnamed,ls_id,ls_sn,ls_dt,ls_sid,ls_sild, ls_oldmail
string l_field0,l_field1,l_field2,l_field3,l_field4,l_field5,l_field6,l_field7,l_field8,l_field9,l_field10
string l_field11,l_field12,l_field13,l_field14,l_field15,l_field16,ls_srep_id,ls_stax_flag,l_field17,l_field18,l_field19,l_field20,l_field21
string ls_third_party,ls_cust_id,ls_inven_id
double ld_stax_per,ld_fob,ld_ldp

l_count = 0
l_fexit = GetFileOpenName("Select Web Order File", &
		+ ls_filename, lf_fnamed, "CSV", &
		+ "CSV Files (*.CSV),*.CSV")

lf_fnamed = upper(left(lf_fnamed,len(lf_fnamed) - 4))

setpointer(HourGlass!)

IF l_fexit = 1 THEN 	
	open(w_import_rows_information)
	l_flen = filelength(ls_filename)
	l_fnum = fileopen(ls_filename)
	l_bytes_read = fileread(l_fnum,l_byte)
	do while l_bytes_read <> -100
			l_rec_val = l_byte
			l_rec_len = len(l_rec_val)
			l_rec_val = right(l_rec_val,l_rec_len)
			l_field0  = f_get_string_position(l_rec_val,',')
//			messagebox('recval',l_field0)
		if l_field0 = 'SH' then
//			messagebox('12','12')
			l_field1   = f_get_string_position(l_rec_val,',')
			l_field2   = f_get_string_position(l_rec_val,',')
			l_field3   = f_get_string_position(l_rec_val,',')
			l_field14  = f_get_string_position(l_rec_val,',')
			l_field4   = f_get_string_position(l_rec_val,',')
			l_field5   = f_get_string_position(l_rec_val,',')
			l_field6   = f_get_string_position(l_rec_val,',')
			l_field7   = f_get_string_position(l_rec_val,',')
			l_field8   = f_get_string_position(l_rec_val,',')
			l_field9   = f_get_string_position(l_rec_val,',')
			l_field10  = f_get_string_position(l_rec_val,',')
			l_field11  = f_get_string_position(l_rec_val,',')
			l_field12  = f_get_string_position(l_rec_val,',')
			l_field13  = f_get_string_position(l_rec_val,',')
//			l_field14  = f_get_string_position(l_rec_val,',')
//			l_field15  = f_get_string_position(l_rec_val,',')
//			l_field16  = f_get_string_position(l_rec_val,',')
//			l_field17  = f_get_string_position(l_rec_val,',')
//			l_field18  = f_get_string_position(l_rec_val,',')
//			l_field19  = f_get_string_position(l_rec_val,',')
//			l_field20  = f_get_string_position(l_rec_val,',')
//			l_field21  = f_get_string_position(l_rec_val,',')

//			ls_rec = ls_rec_ty +"," + ls_said +","
//			if ls_sadate="" then  ls_rec = ls_rec + "," else	ls_rec = ls_rec+ls_sadate + ","
//			if ls_deadlinedate = "" then ls_rec = ls_rec + "," else	ls_rec = ls_rec+ls_deadlinedate + ","
//			ls_rec = ls_rec + trim(ls_sa_type) + "," + trim(ls_sadesc) +","
//			ls_rec = ls_rec + string(ld_insval)+","+ls_active + ","+ls_advth + ","+ls_confirm + ","+ls_type + ","+ ls_custid + "," + ls_brokid +"," + ls_entryby + "," + ls_entrydt


			if len(l_field1) > 0 then

				select nvl(MAX(advice_id),0) into :ls_last from fb_advice;
				ls_last = right(ls_last,10)
				ll_cnt = long(ls_last) + 1
	
				select lpad(:ll_cnt,10,'0') into :ls_count from dual;
				ls_tmp_id = 'ADVICE'+ls_count

//				select distinct 'x' into :ls_temp from fb_saleadvice where advice_id = :l_field1;
//				
//				if sqlca.sqlcode = 0 then
//				   messagebox("Warning",'Record Already Present, Please Check : '+l_field1)
//					rollback using sqlca;
//					close(w_import_rows_information)
//				   fileclose(l_fnum)
//					return 1	
//				end if
//
				insert into fb_advice (ADVICE_ID, ADVICE_DATE, ADVICE_DEADLINEDATE, sa_type, ADVICE_DESC, ADVICE_INSURANCEVALUE, 
												ADVICE_ACTIVE, ADVICE_MEDIUM, ADVICE_COMPFLAG, ADVICE_TYPE,CUST_ID, BROKER_ID, 
												ADVICE_ENTRY_BY, ADVICE_ENTRY_DT)
				values (:ls_tmp_id,to_date(:l_field2,'dd/mm/yyyy'),to_date(:l_field3,'dd/mm/yyyy'), decode(ltrim(rtrim(:l_field14)),'AUX','FWD','PKT'), ltrim(rtrim(:l_field4)),to_number(:l_field5),ltrim(rtrim(:l_field6)),ltrim(rtrim(:l_field7)),
						  trim(:l_field8),decode(ltrim(rtrim(:l_field9)),'AUC','AUCTION','CON','PRICONS','PRI','PRILOCAL','TFR','TRANSFREE','TPR','TRANSPRI',null),
						  ltrim(rtrim(:l_field10)),ltrim(rtrim(:l_field11)),ltrim(rtrim(:l_field12)),to_date(:l_field13,'dd/mm/yyyy'));

				if sqlca.sqlcode = -1 then
					messagebox("SQL Error : At Sales Advice Header Insert ",SQLCA.SQLErrtext,Information!)
					rollback using sqlca;
					close(w_import_rows_information)
				   fileclose(l_fnum)
					return 1
				end if
			end if		
			
		 elseif l_field0 = 'SD' then
//			messagebox('14','14')
			l_field1   = f_get_string_position(l_rec_val,',')
			l_field2   = f_get_string_position(l_rec_val,',')
			l_field3   = f_get_string_position(l_rec_val,',')
			l_field4   = f_get_string_position(l_rec_val,',')
//			l_field5   = f_get_string_position(l_rec_val,',')
//			l_field6   = f_get_string_position(l_rec_val,',')
//			l_field7   = f_get_string_position(l_rec_val,',')

			if len(l_field1) > 0 then
				
//				messagebox('15','15')

				insert into fb_advicedetails (ADVICE_ID, TMP_ID, ADVICE_ORDQUANTITY, ADVICE_DELIQUANTITY,ADVICE_UNITPRICE,ADVICE_COMPFLAG, ADVICE_EXTRADELI)
				values (:ls_tmp_id,ltrim(rtrim(:l_field2)),to_number(:l_field3),to_number(:l_field4),0,'0',0);

				if sqlca.sqlcode = -1 then
					messagebox("SQL Error: At SI Details Insert ",SQLCA.SQLErrtext,Information!)
					close(w_import_rows_information)
					rollback using sqlca;
					fileclose(l_fnum)
					return 1
				end if			
			end if

	end if
		
			l_bytes_read = fileread(l_fnum,l_byte)
			l_count = l_count + 1
			w_import_rows_information.sle_1.text= string(l_count) 
			//messagebox('Count',l_count)
	loop
	commit using sqlca;
	fileclose(l_fnum)
	close(w_import_rows_information)
	setpointer(arrow!) 
	messagebox("Import File Information",'Total ' + string(l_count) + ' Rows Imported.....')
else
	setpointer(arrow!) 
	messagebox("file","File Does Not Exists -> " + ls_filename)
end if

return 1
end event

type cb_5 from commandbutton within w_gtedsf006
integer x = 3995
integer y = 24
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

type cb_7 from commandbutton within w_gtedsf006
integer x = 4114
integer y = 24
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

type cb_8 from commandbutton within w_gtedsf006
integer x = 4233
integer y = 24
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

type cb_9 from commandbutton within w_gtedsf006
integer x = 4352
integer y = 24
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

type dw_2 from datawindow within w_gtedsf006
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 183
integer y = 984
integer width = 4137
integer height = 1324
integer taborder = 40
string dataobject = "dw_gtedsf006a"
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
//	messagebox('1','1')
//	if dw_2.rowcount() > 1 then
//		messagebox('1','2')
//		messagebox('advno',dw_2.getitemstring(currentrow - 1,'advice_id'))
//		dw_2.setitem(currentrow,'advice_id',dw_2.getitemstring(currentrow - 1,'advice_id'))
////		if (dw_2.getitemnumber(currentrow,'dtpd_srnostart') > dw_2.getitemnumber(currentrow,'dtpd_srnoend')) then
////			messagebox('Warning!','Mark on Package From Should Be <= Mark on Package To, Please Check !!!')
////			return 1
////		end if
////		ll_from = dw_2.getitemnumber(currentrow,'dtpd_srnostart')
////		ll_to = dw_2.getitemnumber(currentrow,'dtpd_srnoend')
////		dw_2.setitem(currentrow,'nop',((ll_to - ll_from) +1))
//	end if
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
if dwo.name = 'tmp_id' then
	ls_tmp_id = data
//	if  wf_check_duplicate_rec(ls_tmp_id) = -1 then return 1
end if

if lb_neworder = true then
	if row = dw_2.rowcount() and dwo.name <> 'del_flag'  then
			dw_2.insertrow(0)
			if row > 1 then
				dw_2.setitem(row,'advice_id',dw_2.getitemstring(row - 1,'advice_id'))
			end if
	end if
end if
cb_3.enabled = true
end event

type cb_4 from commandbutton within w_gtedsf006
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

type cb_3 from commandbutton within w_gtedsf006
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
	if (isnull(dw_2.getitemstring(dw_2.rowcount(),'tmp_id')) or len(dw_2.getitemstring(dw_2.rowcount(),'tmp_id')) = 0) then 
		dw_2.deleterow(dw_2.rowcount())
	end if;
end if

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN

	for ix = dw_2.rowcount() to 1 step -1
		if dw_2.getitemstring(ix,'del_flag') = 'Y' and dw_2.rowcount() = dw_2.getitemnumber(ix,'sel_row') then
			messagebox('Warning!','You Cannot Delete All Records From Detail Section !!!')
			return 1
		elseif dw_2.getitemstring(ix,'del_flag') = 'Y' and dw_2.rowcount() <> dw_2.getitemnumber(ix,'sel_row') then
			dw_2.deleterow(ix)
		end if
	next	
	
	if dw_2.rowcount() = 0 then
		messagebox('Error','Records Should Be Available In Detail Block')
		return
	end if

	if (isnull(dw_1.getitemstring(dw_1.getrow(),'advice_type')) or len(dw_1.getitemstring(dw_1.getrow(),'advice_type')) = 0 or &
		isnull(dw_1.getitemstring(dw_1.getrow(),'advice_medium')) or len(dw_1.getitemstring(dw_1.getrow(),'advice_medium')) = 0 or &
		((isnull(dw_1.getitemstring(dw_1.getrow(),'cust_id')) or len(dw_1.getitemstring(dw_1.getrow(),'cust_id')) = 0) and &
		 (isnull(dw_1.getitemstring(dw_1.getrow(),'broker_id')) or len(dw_1.getitemstring(dw_1.getrow(),'broker_id')) = 0)) or &
		isnull(dw_1.getitemdatetime(dw_1.getrow(),'advice_deadlinedate'))) then
		messagebox('Warning:','One Of The Fields Are Blank : Advice Type, Customer/ Broker ID, Advice Through, Deadline Date !!!')
		dw_1.setfocus()
		dw_1.setcolumn('advice_type')
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
		select nvl(MAX(advice_id),0) into :ls_last from fb_advice;
		ls_last = right(ls_last,10)
		ll_cnt = long(ls_last)
		ll_cnt = ll_cnt + 1
		select lpad(:ll_cnt,10,'0') into :ls_count from dual;
		ls_tmp_id = 'ADVICE'+ls_count
		dw_1.setitem(dw_1.getrow(),'advice_id',ls_tmp_id)
		dw_1.setitem(dw_1.getrow(),'advice_date',today())
		for ix = 1 to dw_2.rowcount()
			dw_2.setitem(ix,'advice_id',ls_tmp_id)
		next
	end if		
	
	if dw_1.update(true,false) = 1 and dw_2.update(true,false) = 1 then
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

type cb_2 from commandbutton within w_gtedsf006
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
	dw_1.settaborder('advice_id',5)
	dw_1.settaborder('advice_date',6)
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('advice_id')
	cb_2.text = "&Run"
	cb_3.enabled = false
else
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user)
 	dw_1.TriggerEvent(rowfocuschanged!)
	dw_1.SetRedraw (TRUE)
	dw_1.settaborder('advice_id',0)
	dw_1.settaborder('advice_date',0)
	cb_2.text = "&Query"
	cb_1.enabled = true
   	cb_5.enabled = true
   	cb_7.enabled = true
   	cb_8.enabled = true
   	cb_9.enabled = true
end if
lb_neworder = false

end event

type cb_1 from commandbutton within w_gtedsf006
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
	dw_1.setitem(dw_1.getrow(),'advice_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'unit_id',gs_unit)
	dw_1.setitem(dw_1.getrow(),'advice_entry_dt',datetime(today()))
	dw_1.setcolumn('sa_type')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'advice_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'unit_id',gs_unit)
	dw_1.setitem(dw_1.getrow(),'advice_entry_dt',datetime(today()))
	dw_1.setcolumn('sa_type')
end if

cb_1.enabled = false
end event

type dw_1 from datawindow within w_gtedsf006
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 9
integer y = 116
integer width = 4471
integer height = 864
integer taborder = 30
string dataobject = "dw_gtedsf006"
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
		dw_1.setitem(newrow,'advice_entry_by',gs_user)
		dw_1.setitem(newrow,'advice_entry_dt',datetime(today()))
		dw_1.setcolumn('advice_type')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;if lb_neworder = true and dw_2.rowcount() = 0 then
	dw_2.setfocus()
	dw_2.insertrow(0)
	dw_1.setfocus()
	dw_1.setcolumn('sa_type')
	ls_satype = dw_1.getitemstring(dw_1.getrow(),'sa_type')
	
	if ls_satype = 'FWD' then
		setnull(ls_temp)
		dw_2.setfocus()
		dw_2.setitem(dw_2.getrow(),'sad_invno','FORWARD')
	else
		setnull(ls_temp)
		dw_2.setitem(dw_2.getrow(),'sad_invno',ls_temp)
	end if	
end if;	
if lb_query = false then
	if dwo.name = 'sa_type'  then
		ls_satype = data
		if f_check_initial_space(ls_satype) = -1 then return 1
		dw_2.setitem(dw_2.getrow(),'sad_invno','FORWARD')
//		dw_2.scrolltorow(dw_2.insertrow(0))
		if ls_satype = 'FWD' then
			setnull(ls_temp)
			dw_2.setfocus()
			dw_2.setitem(dw_2.getrow(),'sad_invno','FORWARD')
		else
			setnull(ls_temp)
			dw_2.setitem(dw_2.getrow(),'sad_invno',ls_temp)
		end if
	end if

	if dwo.name = 'advice_type'  then
		ls_type = data
		if f_check_initial_space(ls_type) = -1 then return 1
		if ls_type = 'PRILOCAL' then
			setnull(ls_temp)
			dw_1.setitem(row,'broker_id',ls_temp)
			dw_1.setitem(row,'brok_name',ls_temp)
			dw_1.setitem(row,'brok_add',ls_temp)
		end if
	end if
	
	if dwo.name = 'cust_id'  then
		ls_cus = data
		if f_check_initial_space(ls_cus) = -1 then return 1
		select  CUS_NAME, CUS_ADD into :ls_cname, :ls_cadd from fb_customer where nvl(CUS_ACTIVE,'1') = '1' and CUS_ID = :ls_cus;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Customer Detail',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 0 then	
			dw_1.setitem(row,'cus_name',ls_cname)
			dw_1.setitem(row,'cus_add',ls_cadd)
		end if		
	end if
	
	if dwo.name = 'broker_id'  then
		ls_brok = data
		if f_check_initial_space(ls_brok) = -1 then return 1
		select  BROK_NAME, BROK_ADD into :ls_bname, :ls_badd from fb_broker where nvl(BROK_ACTIVE,'1') = '1' and BROK_ID = :ls_brok;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Broker Detail',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 0 then	
			dw_1.setitem(row,'brok_name',ls_bname)
			dw_1.setitem(row,'brok_add',ls_badd)
		end if		
	
	end if
	
	if dwo.name = 'advice_desc'  then
		ls_desc = data
		if f_check_initial_space(ls_desc) = -1 then return 1
		
		if lb_neworder = true and dw_2.rowcount() = 0 then
			dw_2.setfocus()
			dw_2.insertrow(0)
			dw_1.setfocus()
			dw_1.setcolumn('advice_season')		
		end if;	
	end if
	
	dw_1.setitem(row,'advice_entry_by',gs_user)
	dw_1.setitem(row,'advice_entry_dt',datetime(today()))

	cb_3.enabled = true
end if


end event

event rowfocuschanged;if lb_query = false then
	if lb_neworder = false  then
		if dw_1.rowcount() > 0 then
			dw_2.reset()
			dw_2.retrieve(dw_1.getitemstring(dw_1.getrow(),'advice_id'))
		end if
	end if
end if
end event

