class RecruitmentController < ApplicationController
    def index
        # @recruitments = Recruitment.all
        @job_positions = RefCode.where(code_type: "job_position")
        @recruitment_managers =  Employee.recruitment_managers
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
