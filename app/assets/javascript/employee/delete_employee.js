$(function() {
    $("body")
        .on("click", "#deactivate-employee-button", function(event){
            let employee_id = $(this).attr("data-employee-id");
            $("#delete_employee_form #employee_id").val(employee_id);
        })
        .on("submit", "#delete_employee_form", deleteEmployee)

});


function deleteEmployee(){
    const toastElement = $("#toast");
    const toast = new bootstrap.Toast(toastElement);
    const form = $(this);
    const employeeId = form.find("#employee_id").val();
    const deleteEmployeeModal = form.closest('.modal');
    const employee_table_row = $(`#employee-table button[data-employee-id='${employeeId}']`).closest("tr");
    

    $.post(form.attr("action"), form.serialize(), function(response){
        console.log("Server response:", response);
       
        // Optionally, you can add code here to update the UI after successful deletion
        // location.reload(); // Reload the page to reflect changes
        employee_table_row.remove();
        deleteEmployeeModal.modal("hide");
        toastElement.find(".toast-body").text(response.message);
        toast.show();
    }).fail(function(xhr, status, error){
        console.error("Error deleting employee:", error);
        alert("Failed to deactivate employee. Please try again.");
    });

    console.log("Intercepting form submit")
    return false;

    // return false; // Prevent actual form submission for demonstration purposes
}