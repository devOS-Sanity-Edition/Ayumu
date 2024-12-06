// getBuildDate()
// get GM_build_date in YYYYMMDDHRMNSS format
function getBuildDate() {
	var yy, mm, dd, h, mn
	yy = date_get_year(GM_build_date)
	mm = date_get_month(GM_build_date)
	if (mm < 10) mm = "0" + string(mm)
	dd = date_get_day(GM_build_date)
	if (dd < 10) dd = "0" + string(dd)
	hr = date_get_hour(GM_build_date)
	if (hr < 10) hr = "0" + string(hr)
	mn = date_get_minute(GM_build_date)
	if (mn < 10) mn = "0" + string(mn)
	ss = date_get_second(GM_build_date)
	if (ss < 10) ss = "0" + string(mn)
	return (string(mm) + string(dd) + string(yy) + string(hr) + string(mn) + string(ss));
}