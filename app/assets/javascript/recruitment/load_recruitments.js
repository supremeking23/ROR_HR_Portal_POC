$(function() {
    loadRecruitments();
});

function loadRecruitments() {
    const recruitment_table = $('#recruitment_table tbody');
    $.ajax({
        url: '/recruitments/load_recruitments',
        method: 'GET',
        dataType: 'json',
        success: function(data) {
            recruitment_table.empty();
            console.log('Recruitments loaded:', data);
            let recuitment_data = data.recruitments;
            let rows = '';
            recuitment_data.forEach(function(recruitment) {
                rows += `<tr>
                            <td>${recruitment.job_position}</td>
                            <td>${recruitment.vacancies}</td>
                            <td>
                            ${recruitment.managers.map(manager => {
                                const alias = `${manager.firstname.charAt(0)}${manager.lastname.charAt(0)}`.toUpperCase(); // e.g. "EV"
                                const fullName = `${manager.firstname} ${manager.lastname}`;
                                return `<span class="manager-badge badge text-bg-primary" title="${fullName}">${alias}</span>`;
                            }).join(' ')}
                            </td>
                            <td>From <strong>${new Date(recruitment.start_date).toLocaleDateString()}</strong> To <strong>${new Date(recruitment.end_date).toLocaleDateString()}</strong></td>
                            <td><a href="/recruitment/${recruitment.id}" />View Recruitment Details</a></td>
                         </tr>`;
            });
            recruitment_table.append(rows);
            // You can add code here to update the UI with the loaded recruitments
        },
        error: function(xhr, status, error) {
            console.error('Error loading recruitments:', error);
        }
    });
}