// if ( document.querySelector("#find_form") ) {
//
//   var now = new Date();
//   var date = now.toISOString().slice(0,10);
//   var hours = now.getHours();
//   var time = ( hours < 10 ? '0' + hours : hours ) + ':' + now.getMinutes();
//   var hoursOffset = now.getTimezoneOffset() / -60;
//   var offset = (hoursOffset > 0 ? '+' : '' ) + hoursOffset + ':00'
//   // TODO: Handle minutes in offset ( currently works with whole hours )
//   // debugger
//   var timeInput = document.querySelector("#find_form input[name='find[time]']");
//   timeInput.value = timeInput.value || time;
//   var dateInput = document.querySelector("#find_form input[name='find[date]']")
//   dateInput.value = dateInput.value || date;
//   document.querySelector("#find_form input[name='find[offset]']").value = offset;
//
// };
