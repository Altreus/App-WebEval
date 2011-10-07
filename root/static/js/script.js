$(function(){

    $('button').click(function() {
        $.post('/eval',
            { code: $('#code').val() },
            function(result) {
                $('#result').html(result.output);
            },
            'json'
        );
    });
});
