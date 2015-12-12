// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require materialize-sprockets
//= require_tree .

$(document).ready(function () {
    $('select').material_select();

    $.each(['notice', 'alert'], function (index, the_flash) {
        contents = $('#flash_' + the_flash).val()
        if (contents.length > 0) Materialize.toast(contents, 3000)
    })

    $('.transactions-tab tr').click(transactionLineHandler)
    $('#transactions-form').submit(transactionsBeforeSubmitHandler)
    $('.transactions-tab input').keyup(updateTotals)
})

var transactionLineHandler = function(){
    var selected = $(this).hasClass('selected')

    var input_val = (selected ? '' : $(this).find('.transaction-spent').text());

    $(this).toggleClass('selected')
    $(this).find('.spent-input-container').toggle()
    $(this).find('input').addClass('updated').val(input_val).focus()

    updateTotals()
}

var transactionsBeforeSubmitHandler = function() {
    $('.transactions-tab input').not('.updated').not(':visible').prop('disabled', true);
    $('#active_tab').val($('.tabs a.active').attr('number'))

    return true;
}

var updateTotals = function(amount, selected) {
    var total = 0.0

    $('.transactions-tab input:visible').each(function(){
        value = parseFloat($(this).val())
        if(!isNaN(value)) total += value
    })

    $('#total-selected span').text(total.toFixed(2))
}
