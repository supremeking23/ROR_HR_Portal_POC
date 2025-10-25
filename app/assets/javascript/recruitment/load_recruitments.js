$(function() {
    loadRecruitments();
    // fetchRecruitments();
});

function loadRecruitments(page = 1) {
    const recruitment_table = $('#recruitment_table tbody');
    $.ajax({
        url: `/recruitments/load_recruitments?page=${page}`,
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
            renderPagination(data.pagy);
        },
        error: function(xhr, status, error) {
            console.error('Error loading recruitments:', error);
        }
    });
}

// function fetchRecruitments(page = 1) {
//   fetch(`/recruitments/load_recruitments?page=${page}`)
//     .then(res => res.json())
//     .then(data => {
//     //   renderRecruitments(data.recruitments);
//       renderPagination(data.pagy);
//     });
// }

function renderPagination(pagy) {
  const container = document.getElementById("pagination-nav");
  container.innerHTML = "";

  const current = pagy.page;
  const total = pagy.pages;
  const range = 2; // how many pages to show around current
  const pages = [];

  /* TODO: Refactor so it may be readable */
  for (let i = 1; i <= total; i++) {
    if (
      i === 1 || i === total || // always show first and last
      Math.abs(i - current) <= range
    ) {
      pages.push(i);
    } else if (pages[pages.length - 1] !== "...") {
      pages.push("...");
    }
  }

  container.innerHTML += `<li class="page-item"><button data-page="${pagy.prev}" class="page-link ${pagy.prev ? '': 'disabled'}">« Prev</button></li>`;

  pages.forEach(p => {
    if (p === "...") {
      container.innerHTML += `<span>...</span>`;
    } else {
      container.innerHTML += `<li class="page-item"><button data-page="${p}" class="page-link ${p === current ? 'active' : ''}" >${p}</button></li>`;
    }
  });

  container.innerHTML += `<li class="page-item"><button data-page="${pagy.next}" class="page-link  ${pagy.next ? '': 'disabled'}">Next »</button></li>`;

  container.querySelectorAll("button[data-page]").forEach(btn => {
    btn.addEventListener("click", () => {
      loadRecruitments(btn.dataset.page);
    });
  });
}