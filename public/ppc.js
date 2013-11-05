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
    $(".header").each(function()
    {
        $(this).on("mouseover", function()
        {
            var $details=$($("#" + $(this).data("tsid")).children(".details"));
            $details.show();
            return false;
        });
        $(this).hover(function()
        {
            var $details=$($("#" + $(this).data("tsid")).children(".details"));
            $details.css({ left: $(this).position().left-$details.width()-20, top: $(this).position().top});
            $details.show();
            return false;
        }, function()
        {
            var $details=$($("#" + $(this).data("tsid")).children(".details"));
            $details.hide();
            return false;
        });
    });
});
