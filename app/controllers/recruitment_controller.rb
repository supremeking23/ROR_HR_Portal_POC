class RecruitmentController < ApplicationController
    def index
        # @recruitments = Recruitment.all
        @job_positions = RefCode.where(code_type: "job_position")
        @recruitment_managers =  Employee.recruitment_managers
    end

    def load_recruitments
    # Fetch all recruitments, eager-loading associated recruitment_managers, employees, and job_position_ref
    # This avoids N+1 queries by loading everything in one go
    # recruitments are ordered by creation date, most recent first, and limited to 5 records
    @recruitments = Recruitment.includes(:job_position_ref, recruitment_managers: :employee).all.order(created_at: :desc).limit(5)

    # Render JSON response with selected attributes and nested associations
    render json: {
        status: "success",
        recruitments: @recruitments.map do |r|
        {
            id: r.id,
            description: r.description,
            vacancies: r.vacancies,
            start_date: r.start_date,
            end_date: r.end_date,

            # Use existing column (e.g. name or title) from ref_codes, only if code_type is 'job_position'
            job_position: r.job_position_ref&.code_type == "job_position" ? r.job_position_ref.name : nil,

            # Include associated managers (employees) with selected fields
            managers: r.managers.map do |m|
            {
                id: m.id,
                firstname: m.firstname,
                lastname: m.lastname
            }
            end
        }
        end
    }, status: :ok
    end

    # Will load one recruitment detail on a single page view
    def _recruitment
        @recruitment = Recruitment.includes(recruitment_managers: :employee).find(params[:id])
    end


    def create
        recruitment = Recruitment.new(recruitment_params)

        if recruitment.save
            # Insert into recruitment_managers join table
            managers_ids = params[:recruitment_managers] || []
            managers_ids.each do |manager_id|
                RecruitmentManager.create(recruitment_id: recruitment.id, employee_id: manager_id)
            end
            render json: { status: "success", message: "Recruitment created successfully", recruitment_id: recruitment.id }, status: :created
        else
            render json: { status: "error", message: recruitment.errors.full_messages.join(", ") }, status: :unprocessable_entity
        end
    end


    private
    def recruitment_params
        params.permit(:job_position_id, :description, :vacancies, :start_date, :end_date)
    end
end
