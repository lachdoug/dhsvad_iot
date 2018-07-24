if ( document.querySelector("#reading_datetime") ) {
  var readingDate = new Date( document.querySelector("#reading_datetime").textContent )
  document.querySelector("#reading_datetime_local").textContent = readingDate.toString();
  var hoursOffset = readingDate.getTimezoneOffset() / -60;

  var time = '' + readingDate.getHours() + ':' + ( readingDate.getMinutes() > 9 ? readingDate.getMinutes() : '0' + readingDate.getMinutes() );
  var date = '' + readingDate.getFullYear() + '-' + ( readingDate.getMonth() < 9 ? '0' : '' ) + ( readingDate.getMonth() + 1 ) + '-' + ( readingDate.getDate() < 10 ? '0' : '' ) + readingDate.getDate();
  var offset = (hoursOffset > 0 ? '+' : '' ) + hoursOffset + ':00'
  // // TODO: Handle minutes in offset ( currently works with whole hours )
// debugger
  document.querySelector("#find_form input[name='find[time]']").value = time;
  document.querySelector("#find_form input[name='find[date]']").value = date;
  document.querySelector("#find_form input[name='find[offset]']").value = offset;

};
