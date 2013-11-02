$(function()
{
    $(".commentbutton").each(function()
    {
        $(this).on("click", function()
        {
            var $comments=$($("#" + $(this).data("tsid")).children(".comments"));
            $comments.toggle();
            return false;
        });
    });
});
