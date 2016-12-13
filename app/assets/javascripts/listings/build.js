$(document).ready(function() {
    // Top level class for the boolean checkbox
    var rootClickClass = '.room-boolean';

    // Apply CSS classes depending on value passed in
    function toggleActiveStyle(elem) {
        elem.toggleClass('selected');
        elem.children('.optional').toggleClass('selectedtext');
    }

    // Event handler for on click action
    $(rootClickClass).click(function () {
        var label = $(this).find('.cellmarker');
        var input = $(this).find('input[type=checkbox]');

        toggleActiveStyle(label);

        // Toggle checkbox value
        var newValue = !(input.prop('checked'));
        input.prop('checked', newValue);
        event.preventDefault();
    });

    // Initially load page with selected objects
    $(rootClickClass).each(function(index, element) {
        var label = $(this).find('.cellmarker');
        var input = $(this).find('input[type=checkbox]');
        if (input.prop('checked')) {
            toggleActiveStyle(label);
        }
    });

    $('form').on('click', '.add_fields', function(event) {
        var time = new Date().getTime();
        var regexp = new RegExp($(this).data('id'), 'g');

        $(this).before($(this).data('fields').replace(regexp, time));
        event.preventDefault();
    });

    $('form').on('click', '.remove_fields', function(event) {
        $(this).parent().find('input[type=hidden]').val(true);
        $(this).closest('.room').hide();
        event.preventDefault();
    });

    $('form').on('click', '.delete-photo', function(event) {
        if(confirm("Are you sure you want to remove this photo? This cannot be undone.")) {
            $(this).parent().prev('.listing_photos__destroy').find('input:hidden').val(true);
            $(this).parent().remove();
            event.preventDefault();
        }
    });
});