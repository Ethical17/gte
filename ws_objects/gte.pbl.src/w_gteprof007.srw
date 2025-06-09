$PBExportHeader$w_gteprof007.srw
forward
global type w_gteprof007 from window
end type
type cb_5 from commandbutton within w_gteprof007
end type
type cb_4 from commandbutton within w_gteprof007
end type
type cb_3 from commandbutton within w_gteprof007
end type
type cb_2 from commandbutton within w_gteprof007
end type
type cb_1 from commandbutton within w_gteprof007
end type
type dw_1 from datawindow within w_gteprof007
end type
end forward

global type w_gteprof007 from window
integer width = 4869
integer height = 2280
boolean titlebar = true
string title = "(w_gteprof007) Green Leaf Transaction"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gteprof007 w_gteprof007

type variables
long ll_row, ll_cnt,ll_elect,ll_hsd,ll_user_level, ld_gltransfer
string ls_temp,ls_del_ind,ls_tran_ty,ls_sup_id,ls_tmp_id,ls_appr_ind,ls_entry_user, ls_appr_by,ls_last,ls_count,ls_trans_sup
boolean lb_neworder, lb_query
double ld_price, ld_qnty,ld_tax,ld_stax,ld_otchrg,ld_net
datetime ld_appr_dt,ld_plk_dt, ld_dt,ld_rundt
datawindowchild idw_supid
string ls_plk_dt
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function double wf_cal_netval (double fd_uprice, double fd_qnty, double fd_tax, double fd_otchrg)
public function integer wf_check_duplicate_recown (string fs_tran_ty, datetime fs_plk_dt)
public function integer wf_check_duplicate_rec (string fs_tran_ty, string fs_supp, datetime fs_plk_dt, double fd_price)
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
	if (isnull(dw_1.getitemstring(fl_row,'gt_type')) or  len(dw_1.getitemstring(fl_row,'gt_type'))=0 or &
		isnull(dw_1.getitemstring(fl_row,'sup_id')) or  len(dw_1.getitemstring(fl_row,'sup_id'))=0 or &
		 isnull(dw_1.getitemdatetime(fl_row,'pluckingdate')) or &
		 ((dw_1.getitemstring(fl_row,'gt_type') = 'PURCHASE' or dw_1.getitemstring(fl_row,'gt_type') = 'SALE') and (isnull(dw_1.getitemnumber(fl_row,'gt_unitprice')) or dw_1.getitemnumber(fl_row,'gt_unitprice')=0)) or &
		 isnull(dw_1.getitemnumber(fl_row,'gt_quantity')) or dw_1.getitemnumber(fl_row,'gt_quantity')=0 or isnull(dw_1.getitemnumber(fl_row,'gt_season')) or dw_1.getitemnumber(fl_row,'gt_season')=0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Transaction Type, Supplier, Plucking Date, Unit Price, Quantity, Season Please Check !!!')
		 return -1
	end if
end if
return 1

end function

public function double wf_cal_netval (double fd_uprice, double fd_qnty, double fd_tax, double fd_otchrg);double ld_netval

if isnull(fd_uprice) then fd_uprice = 0
if isnull(fd_qnty) then fd_qnty = 0
if isnull(fd_tax) then fd_tax = 0
if isnull(fd_otchrg) then fd_otchrg = 0

ld_netval = (fd_uprice * fd_qnty) - fd_tax + fd_otchrg

return ld_netval
end function

public function integer wf_check_duplicate_recown (string fs_tran_ty, datetime fs_plk_dt);long fl_row
string ls_tran_ty1,ls_supp1
datetime ld_plk_dt1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_tran_ty1 = dw_1.getitemstring(fl_row,'gt_type')
		ld_plk_dt1 = dw_1.getitemdatetime(fl_row,'pluckingdate')
		
		if ls_tran_ty1 = fs_tran_ty and ld_plk_dt1 = fs_plk_dt then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			dw_1.SelectRow(fl_row, FALSE)
			return -1
		end if
	next 
end if 

return 1
end function

public function integer wf_check_duplicate_rec (string fs_tran_ty, string fs_supp, datetime fs_plk_dt, double fd_price);long fl_row
string ls_tran_ty1,ls_supp1
datetime ld_plk_dt1
double ld_price1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_tran_ty1 = dw_1.getitemstring(fl_row,'gt_type')
		ls_supp1 = dw_1.getitemstring(fl_row,'sup_id')
		ld_plk_dt1 = dw_1.getitemdatetime(fl_row,'pluckingdate')
		ld_price1 = dw_1.getitemnumber(fl_row,'gt_unitprice')
		
		if ls_tran_ty1 = fs_tran_ty and ls_supp1 = fs_supp and ld_plk_dt1 = fs_plk_dt and ld_price1 = fd_price then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gteprof007.create
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gteprof007.destroy
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
lb_query = false	
lb_neworder = false
//dw_1.modify("t_co.text = '"+gs_co_name+"'")

if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if
//if date(gd_dt) <> today() then
//	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
//	return 1
//end if

this.tag = Message.StringParm
ll_user_level = long(this.tag)

dw_1.GetChild ("sup_id", idw_supid)
idw_supid.settransobject(sqlca)	


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

type cb_5 from commandbutton within w_gteprof007
integer x = 1093
integer y = 12
integer width = 366
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&For Account"
end type

event clicked;open(w_gteprof007b)
end event

type cb_4 from commandbutton within w_gteprof007
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

type cb_3 from commandbutton within w_gteprof007
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

IF (isnull(dw_1.getitemstring(dw_1.rowcount(),'gt_type')) or len(dw_1.getitemstring(dw_1.rowcount(),'gt_type'))=0) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN

	for ll_row = dw_1.rowcount() to 1 step -1
		if dw_1.getitemstring(ll_row,'del_flag') = 'Y' then
			ld_plk_dt = dw_1.getitemdatetime(ll_row,'pluckingdate')
			
			select distinct 'x' into :ls_temp from fb_glforproduction glfp,fb_gardenwiseteamade gwtm
			where  glfp.glfp_pk=gwtm.glfp_pk and gwtm.gwtm_type='N' and trunc(GLFP_PLUCKINGDATE) = trunc(:ld_plk_dt) ;
			
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Production Details',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode = 0 then
				messagebox('Warning!','Production For This Date is Already Done, Record Cannot Be Deleted  !!!')
				return 1
			elseif sqlca.sqlcode = 100 then
				dw_1.deleterow(ll_row)
			end if				
		end if
	next	
	
	if dw_1.rowcount() > 0 then
		IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
			return 1
		END IF
	end if

	
	if lb_neworder = true then
		select nvl(MAX(GT_ID),0) into :ls_last from fb_gltransaction;
		ls_last = right(ls_last,10)
		ll_cnt = long(ls_last)
	end if
	
	if dw_1.rowcount() > 0 then
		for ll_row = 1 to dw_1.rowcount( ) 
			ld_plk_dt = dw_1.getitemdatetime(ll_row,'pluckingdate')
			if lb_neworder = true then
				ll_cnt = ll_cnt + 1
				select lpad(:ll_cnt,10,'0') into :ls_count from dual;
				ls_tmp_id = 'GT'+ls_count
				dw_1.setitem(ll_row,'gt_id',ls_tmp_id)
				dw_1.setitem(ll_row,'gt_date',ld_plk_dt)
			end if
			if dw_1.getitemstring(ll_row,'gt_type')='BROUGHT' then
				
			
				select distinct 'x' into :ls_temp from fb_leafanalysis where trunc(LA_DATE) = trunc(:ld_plk_dt);
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 100 then
					messagebox('Warning!','Fine Leaf Count For The Selected Date Is Not Entered, Please Enter The Fine Leaf Count First !!!')
					return 1
				end if	
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

type cb_2 from commandbutton within w_gteprof007
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
	lb_neworder = true
	if dw_1.modifiedcount() > 0 then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	dw_1.reset()
	dw_1.settaborder('gt_id',5)
	dw_1.settaborder('gt_date',6)
	lb_query = true
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('gt_id')
	cb_2.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_neworder =false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user)
	dw_1.settaborder('gt_id',0)
	dw_1.settaborder('gt_date',0)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	lb_query = false
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gteprof007
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
end if

dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'gt_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'gt_entry_dt',datetime(today()))
	dw_1.setcolumn('gt_type')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'gt_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'gt_entry_dt',datetime(today()))
	dw_1.setcolumn('gt_type')
end if


end event

type dw_1 from datawindow within w_gteprof007
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 120
integer width = 4814
integer height = 2052
integer taborder = 30
string dataobject = "dw_gteprof007"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'gt_entry_by',gs_user)
		dw_1.setitem(newrow,'gt_entry_dt',datetime(today()))
		dw_1.setitem(newrow,'pluckingdate',dw_1.GetItemDateTime(currentrow,'pluckingdate'))
		dw_1.setitem(newrow,'gt_season',dw_1.GetItemnumber(currentrow,'gt_season'))
		dw_1.setcolumn('gt_type')
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
	if dwo.name = 'gt_type' then
		
		if trim(data) = 'BROUGHT' then
			ls_tran_ty = 'T'
		else
			ls_tran_ty = left(data,1)
		end if
		idw_supid.SetFilter ("trantype = '"+left(trim(ls_tran_ty),1)+"'")
		idw_supid.settransobject(sqlca)	
		idw_supid.retrieve()
		ld_plk_dt = dw_1.getitemdatetime(row,'pluckingdate')
		ls_plk_dt=string(ld_plk_dt,'dd/mm/yyyy')
		if trim(data) = 'PURCHASE' or trim(data) = 'BROUGHT' then
			select distinct 'x' into :ls_temp from fb_glforproduction glfp,fb_gardenwiseteamade gwtm
			where  glfp.glfp_pk=gwtm.glfp_pk and gwtm.gwtm_type='N' and to_char(GLFP_PLUCKINGDATE,'dd/mm/yyyy') =:ls_plk_dt ;
			
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Production Details',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode = 0 then
				messagebox('Warning!','Production For This Date is Already Done, Record Cannot Be Entered  !!!')
				return 1
			end if	
		end if		
		if gs_garden_snm <> 'KG' then
			if trim(data) = 'OWNATTE' then
				messagebox('Warning!','You Cannot Select Own User  !!!')
				return 1
			end if				
		end if
	end if
	
	if dwo.name = 'pluckingdate'  then
		ld_plk_dt = datetime(data)
		ls_tran_ty = dw_1.getitemstring(row,'gt_type')
		ls_sup_id = dw_1.getitemstring(row,'sup_id')
		ld_price = dw_1.getitemnumber(row,'gt_unitprice')
		
		select max(gt_date) into :ld_dt  from fb_gltransaction where gt_type = :ls_tran_ty;
		if sqlca.sqlcode = -1 then 
			messagebox('Sql Error','Error During Check Max Transaction Date : '+sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 0 then

			if ld_dt > ld_plk_dt then
				select distinct 'x' into :ls_temp from fb_glforproduction glfp,fb_gardenwiseteamade gwtm
				where  glfp.glfp_pk=gwtm.glfp_pk and gwtm.gwtm_type='N' and trunc(GLFP_PLUCKINGDATE) = trunc(:ld_plk_dt) ;
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Production Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 0 then
					messagebox('Warning!','Production For This Date is Already Done, Record Cannot Be Entered  !!!')
					return 1
//				messagebox('Warning','Transaction Date Should Be > Laster Transaction Date : '+string(ld_dt,'dd/mm/yyyy'))
//				return 1
				end if
			end if
		end if;		
		
		
		idw_supid.SetFilter ("la_date = date('"+string(ld_plk_dt,'dd/mm/yyyy')+"')") 
		idw_supid.filter( )
		
		select distinct 'x' into :ls_temp from fb_gltransaction where GT_TYPE in ('PURCHASE','SALE') and 
				trunc(pluckingdate) < trunc(:ld_plk_dt) and nvl(GT_VOU_NO,'N')='N' and (:gs_garden_snm <> 'LG' or (:gs_garden_snm = 'LG' and trunc(:ld_plk_dt) > to_date('01/04/2017','dd/mm/yyyy')));
	
		if sqlca.sqlcode = -1 then 
				messagebox('Sql Error','Error During check Green Leaf for previous date A/c posting : '+sqlca.sqlerrtext)
				return 1
		elseif sqlca.sqlcode = 0 then 
			  messagebox('Error','Previous Date Green Leaf Already Available for  A/c Posting : ')
			return 1
		end if;
		if ls_tran_ty = 'PURCHASE' or ls_tran_ty = 'BROUGHT' then
			select distinct 'x' into :ls_temp from fb_glforproduction glfp,fb_gardenwiseteamade gwtm
			where  glfp.glfp_pk=gwtm.glfp_pk and gwtm.gwtm_type='N' and trunc(GLFP_PLUCKINGDATE) = trunc(:ld_plk_dt) ;
			
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Production Details',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode = 0 then
				messagebox('Warning!','Production For This Date is Already Done, Record Cannot Be Entered  !!!')
				return 1
			end if	
		end if
	
		//if ls_tran_ty = 'OWNATTE' then
		if gs_garden_snm <> 'MF' and gs_garden_snm <> 'GF' and (gs_garden_snm <> 'KG' and (ls_tran_ty = 'PURCHASE' or ls_tran_ty = 'BROUGHT')) then
			select distinct 'x' into :ls_temp from fb_sectionpluckinground where trunc(SPR_DATE) = trunc(:ld_plk_dt);
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Pluckinground Details',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode = 100 then
				if messagebox('Warning!','Plucking Round Entry Not Done For This Date, Please Check !!!~r Want to Continue without plucking rounds',question!,yesno!,2) = 2 then 
					return 1
				end if
			end if	
		end if
		//end if
			
			setnull(ls_temp)
			if gs_garden_snm <> 'KG' then	
				select distinct 'x' into :ls_temp from fb_leafanalysis where trunc(LA_DATE) = trunc(:ld_plk_dt);
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Fineleaf Count Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 100 then
					messagebox('Warning!','Fine Leaf Count For The Selected Date Is Not Entered, Please Enter The Fine Leaf Count First !!!')
					return 1
				end if		
			end if	
			
			if  wf_check_duplicate_rec(ls_tran_ty,ls_sup_id,ld_plk_dt,ld_price) = -1 then return 1
			
			setnull(ls_temp)
			select distinct 'x' into :ls_temp from fb_gltransaction
			where upper(sup_id) = upper(:ls_sup_id) and upper(gt_type) = upper(:ls_tran_ty) and trunc(pluckingdate) = :ld_plk_dt;
		
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Transaction Details',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode  = 0 then
				messagebox('Warning!','Transaction Already Exists For This Date, Please Check !!!')
				return 1
			end if	
			
			datawindowchild dwc_glt_transfer
			dw_1.getchild('gt_sup_from',dwc_glt_transfer)
			dwc_glt_transfer.settransobject(sqlca)
			dwc_glt_transfer.retrieve(gs_supid,date(ld_plk_dt))
			
	end if
	
	if dwo.name = 'sup_id'  then
		ls_sup_id = data
		ls_tran_ty = dw_1.getitemstring(row,'gt_type')
		ld_plk_dt = dw_1.getitemdatetime(row,'pluckingdate')
		ld_price = dw_1.getitemnumber(row,'gt_unitprice')
		setnull(ls_temp)
		
			// Check Removed as per discission with Mr. Lahari and Mr. Govind at Fulbari on 02-Mar-2012...
//		if ls_tran_ty = 'BROUGHT' or ls_tran_ty = 'PURCHASE' then
//			select distinct 'x' into :ls_temp from fb_leafanalysis where trim(sup_id) = :ls_sup_id and trunc(LA_DATE) = trunc(:ld_plk_dt);
//			if sqlca.sqlcode = -1 then
//				messagebox('Error : While Getting Fineleaf Count  Details',sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 1
//			elseif sqlca.sqlcode = 100 then
//				messagebox('Warning!','Fine Leaf Count For The Selected Date Is Not Entered, Please Enter The Fine Leaf Count First !!!')
//				return 1
//			end if	
//		end if 
			// Check Removed as per discission with Mr. Lahari and Mr. Govind at Fulbari on 02-Mar-2012...
			
	// Check Removed as per  Issue No C0000451
//		if  wf_check_duplicate_rec(ls_tran_ty,ls_sup_id,ld_plk_dt,ld_price) = -1 then return 1
//	
//		setnull(ls_temp)
//		select distinct 'x' into :ls_temp from fb_gltransaction
//		where upper(sup_id) = upper(:ls_sup_id) and upper(gt_type) = upper(:ls_tran_ty) and trunc(pluckingdate) = :ld_plk_dt;
//	
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Transaction Details',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		elseif sqlca.sqlcode  = 0 then
//			messagebox('Warning!','Transaction Already Exists For This Date, Please Check !!!')
//			return 1
//		end if	
	// Check Removed as per Issue No C0000451
	end if
	
	if dwo.name = 'gt_unitprice' then
		ld_price = double(data)
		ld_qnty = dw_1.getitemnumber(row,'gt_quantity')
		ld_tax = dw_1.getitemnumber(row,'tax_amt')
		ld_otchrg = dw_1.getitemnumber(row,'gt_otheramo')
		ls_tran_ty = dw_1.getitemstring(row,'gt_type')
		ld_plk_dt = dw_1.getitemdatetime(row,'pluckingdate')
		ls_sup_id = dw_1.getitemstring(row,'sup_id')
		
		
		if isnull(ld_price) then ld_price = 0
		if isnull(ld_qnty) then ld_qnty = 0
		if isnull(ld_tax) then ld_tax = 0
		if isnull(ld_otchrg) then ld_otchrg = 0
		
		if  wf_check_duplicate_rec(ls_tran_ty,ls_sup_id,ld_plk_dt,ld_price) = -1 then return 1
		
		setnull(ls_temp)
		select distinct 'x' into :ls_temp from fb_gltransaction
		where upper(sup_id) = upper(:ls_sup_id) and upper(gt_type) = upper(:ls_tran_ty) and trunc(pluckingdate) = :ld_plk_dt and gt_unitprice = :ld_price;
	
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Transaction Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 0 then
			messagebox('Warning!','Transaction Already Exists For This Date, Please Check !!!')
			return 1
		end if	
		
		ld_net = wf_cal_netval(ld_price,ld_qnty,ld_tax,ld_otchrg)
		dw_1.setitem(row,'gt_netamount',ld_net)
	end if
	
	if dwo.name = 'gt_quantity' then
		ld_qnty = double(data)
		ld_price = dw_1.getitemnumber(row,'gt_unitprice')
		ld_tax = dw_1.getitemnumber(row,'tax_amt')
		ld_otchrg = dw_1.getitemnumber(row,'gt_otheramo')
		
		if isnull(ld_price) then ld_price = 0
		if isnull(ld_qnty) then ld_qnty = 0
		if isnull(ld_tax) then ld_tax = 0
		if isnull(ld_otchrg) then ld_otchrg = 0
		
		ld_net = wf_cal_netval(ld_price,ld_qnty,ld_tax,ld_otchrg)
		dw_1.setitem(row,'gt_netamount',ld_net)
		
//		if double(data) > double(dw_1.getitemstring(dw_1.getrow(),'gt_sup_from_1')) then
//			messagebox('Warning','Quantity to be transferred cannot be greater than quantity available in stock for selected supplier.' )
//			return 1
//		end if
		if dw_1.getitemstring(dw_1.getrow(),'gt_type') = 'TRANSFER' then
			
			ld_rundt = dw_1.getitemdatetime(dw_1.getrow(),'pluckingdate')
			ls_trans_sup = dw_1.getitemstring(dw_1.getrow(),'gt_sup_from')
	
			select distinct gltq into :ld_gltransfer
			from (select decode(glt.gt_type,'TRANSFER',nvl(gt_sup_from,unitsupid),glt.sup_id) gtsupid, nvl(sum(decode(glt.gt_type,'TRANSFER',(-1),1) * glt.gt_quantity),0) gltq from fb_gltransaction glt,
			(select UNIT_SUPID unitsupid from fb_gardenmaster where  UNIT_ACTIVE_IND = 'Y') 
			where trunc(GLT.pluckingdate) <= trunc(:ld_rundt) and glt.gt_type in ('PURCHASE','BROUGHT','OWNATTE','TRANSFER') and
			trunc(GLT.pluckingdate) > (select nvl(max(trunc(GLFP_PLUCKINGDATE)),'01-Jan-2000') from fb_glforproduction glfp,fb_gardenwiseteamade gwtm
			where  glfp.glfp_pk=gwtm.glfp_pk and gwtm.gwtm_type='N') 
			group by decode(glt.gt_type,'TRANSFER',nvl(gt_sup_from,unitsupid),glt.sup_id)) where gtsupid = :ls_trans_sup;
			
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Transfer Quantity Details',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode  = 100 then
				messagebox('Warning!','Transfer Quantity Not Found For This Date, Please Check !!!')
				return 1
			end if	
			
			if double(data) > ld_gltransfer then
				messagebox('Warning','Quantity to be transferred cannot be greater than quantity available in stock for selected supplier.' )
				return 1
			end if
		end if 
	end if
	
	if dwo.name = 'gt_saletax' then
		ld_stax = double(data)
		ld_qnty = dw_1.getitemnumber(row,'gt_quantity')
		ld_price = dw_1.getitemnumber(row,'gt_unitprice')
		ld_otchrg = dw_1.getitemnumber(row,'gt_otheramo')
		
		if isnull(ld_price) then ld_price = 0
		if isnull(ld_qnty) then ld_qnty = 0
		if isnull(ld_otchrg) then ld_otchrg = 0
		
		ld_tax = ld_qnty * ld_stax
		dw_1.setitem(row,'tax_amt',ld_tax)
		
		ld_net = wf_cal_netval(ld_price,ld_qnty,ld_tax,ld_otchrg)
		dw_1.setitem(row,'gt_netamount',ld_net)		
	end if
	
//	if dwo.name = 'tax_amt' then
//		ld_tax = double(data)
//		ld_price = dw_1.getitemnumber(row,'gt_unitprice')
//		ld_otchrg = dw_1.getitemnumber(row,'gt_otheramo')
//		ld_qnty = dw_1.getitemnumber(row,'gt_quantity')
//		
//		if isnull(ld_price) then ld_price = 0
//		if isnull(ld_qnty) then ld_qnty = 0
//		if isnull(ld_tax) then ld_tax = 0
//		if isnull(ld_otchrg) then ld_otchrg = 0
//		
//		ld_stax = ld_tax / (ld_qnty)
//		dw_1.setitem(row,'gt_saletax',ld_stax)
//	
//		
//		ld_net = wf_cal_netval(ld_price,ld_qnty,ld_tax,ld_otchrg)
//		dw_1.setitem(row,'gt_netamount',ld_net)
//	end if
	
	if dwo.name = 'gt_otheramo' then
		ld_otchrg = double(data)
		ld_price = dw_1.getitemnumber(row,'gt_unitprice')
		ld_tax = dw_1.getitemnumber(row,'tax_amt')
		ld_qnty = dw_1.getitemnumber(row,'gt_quantity')
		
		if isnull(ld_price) then ld_price = 0
		if isnull(ld_qnty) then ld_qnty = 0
		if isnull(ld_tax) then ld_tax = 0
		if isnull(ld_otchrg) then ld_otchrg = 0
		
		ld_net = wf_cal_netval(ld_price,ld_qnty,ld_tax,ld_otchrg)
		dw_1.setitem(row,'gt_netamount',ld_net)
	end if
	dw_1.setitem(row,'gt_entry_by',gs_user)
	dw_1.setitem(row,'gt_entry_dt',datetime(today()))
	
	cb_3.enabled = true
end if
if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
	dw_1.insertrow(0)
end if

end event

