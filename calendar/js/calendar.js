var calendar = {
  renderData : function(jsonData) {
    jsonData.events.sort(function(a, b) {
      date1 = new Date(a["month"], a["day"], a["year"]);
      date2 = new Date(b["month"], b["day"], b["year"]);

      return date1.valueOf() > date2.valueOf();
    });

    var templateEl = $("#calendar-template").html();
    var template = Handlebars.compile(templateEl);
    var calendarHtml = template(jsonData);

    $('.m-container').html(calendarHtml);
  },
  loadData : function() {
    var jsonText =
    '{"events": [{"occasion": "Birthday party","invited_count": 120,"year": 2016,"month": 2,"day": 14},{"occasion": "Technical discussion","invited_count": 23,"year": 2016,"month": 11,"day": 24},{"occasion": "Press release","invited_count": 64,"year": 2015,"month": 12,"day": 17,"cancelled": true},{"occasion": "New year party","invited_count": 55,"year": 2016,"month": 1,"day": 1}]}';

    var jsonData = JSON.parse(jsonText);
    this.renderData(jsonData);
  }
}

$(document).ready(function() {
  calendar.loadData();
});

Handlebars.registerHelper("formatDate", function(year, month, day, format) {
  var date = new Date(month, day, year),
      weekday = date.toLocaleString("en-us", {weekday: "long"}),
      month = date.toLocaleString("en-us", {month: "long"});


  return weekday + " " + date.getDay() + ", " + month + " " + date.getFullYear();
});
