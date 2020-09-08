var baseUri = "https://api.armas.id/";
// var baseUri = "https://armas.jiwalu.id/api/";
var register= baseUri + "auth/register";
var login   = baseUri + "auth/login";
var listSlipsByYear = baseUri + 'payroll/slips?year=';
var detailSlipUri = baseUri + 'payroll/slips/detail?id=';
var getAttendance = baseUri + 'time/attendances?';
var checkin = baseUri + 'time/attendances/checkin';
var checkout = baseUri + 'time/attendances/checkout';