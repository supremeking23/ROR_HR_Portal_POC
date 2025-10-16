$(function() {
    $("body")
        .on("submit", "#add_recruitment_form", addRecruitment)

});


function addRecruitment(){
    const toastElement = $("#toast");
    const toast = new bootstrap.Toast(toastElement);
    const form = $(this);
    const addRecruitmenteModal = form.closest('.modal');

    $.post(form.attr("action"), form.serialize(), function(response){
        console.log("Server response:", response);
        addRecruitmenteModal.find(".close").click();
        toastElement.find(".toast-body").text(response.message);
        toast.show();
    }).fail(function(xhr, status, error){
        console.error("Error", error);

    });

    return false;
    // return false; // Prevent actual form submission for demonstration purposes
}