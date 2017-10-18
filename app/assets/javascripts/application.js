// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require selectize/standalone/selectize
//= require handlebars.runtime
//= require_tree ./templates
//= require_tree .


var itemTemplate = HandlebarsTemplates['item'];
var curlTemplate = HandlebarsTemplates['curl'];
var skuOptionTemplate = HandlebarsTemplates['sku-option'];

$(document).on("turbolinks:load", function(){

  var apiRequest = function(url, method, data){
    var requestEl = $(curlTemplate({
      url: location.origin + url,
      method: method,
      data: JSON.stringify(data, true, 4)
    }));

    $('.request-log').append(requestEl);

    return $.ajax(url, {
      method: method,
      data: data
    });
  };

  var renderItemElement = function(itemData){
    var item = itemData;
    var itemEl = $(itemTemplate({item: item}));

    itemEl.find('.check-out.btn').click(function(e){
      e.preventDefault();
      console.log("checkout", item);

      apiRequest("/items/" + item.code + "/sessions", "POST", {
        checked_out_at: (new Date()).toISOString()
      }).then(function(sessionData, status){
        if(status !== "success") throw status;

        var session = sessionData.session;

        item.checkedOut = true;
        item.session = session.id;

        itemEl.replaceWith(renderItemElement(item));
      });
    });

    itemEl.find('.check-in.btn').click(function(e){
      e.preventDefault();

      var checkInData = {
        checked_in_at: (new Date()).toISOString(),
        usage: itemEl.find(".usage")[0].value,
        unit: item.unit
      };

      console.log("check in", item, checkInData);

      apiRequest("/items/" + item.code + "/sessions/" + item.session, "PUT", checkInData).then(function(sessionData, status){
        if(status !== "success") throw status;

        var session = sessionData.session;

        item = session.item;

        itemEl.replaceWith(renderItemElement(item));
      });
    });

    return itemEl;
  };

  $('#select-sku').selectize({
    valueField: 'id',
    labelField: 'name',
    searchField: 'name',
    create: false,
    preload: true,
    render: { option: skuOptionTemplate },
    load: function(query, callback) {
      $.ajax({
        url: '/search?q=' + encodeURIComponent(query),
        type: 'GET',
        error: function() {
          callback();
        },
        success: function(res) {
          callback(res.skus.slice(0, 10));
        }
      });
    }
  }).change(function(){
    var value = this.value;

    if(!value) {
      $("#sku").hide("fast");
      return;
    }

    apiRequest("/skus/" + value, "GET").then(function(data){
      console.log(data);

      var sku = data.sku;

      console.log(sku, sku.name);

      $("#sku-name").text(sku.name);

      $("#items-grid").html(sku.items.map(function(itemData){
        return renderItemElement(itemData);
      }));

      $("#sku").show("fast");
    }).catch(function(){
      $("#sku").hide("fast");
    });
  });
});