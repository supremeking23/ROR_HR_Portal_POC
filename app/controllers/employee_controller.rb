class EmployeeController < ApplicationController
    def index
        # Prepares a blank employee object for the form (used in the view)
        @employee = Employee.new

        # Fetches all employee type options (e.g., HR, IT) from RefCode for the dropdown
        @employee_types = RefCode.where(code_type: "employee_type")

        # Loads all employee records, eager-loading associated user and type to avoid N+1 queries
        # .active is to retrieve all Employee that is currently active
        @employees = Employee.active.includes(:employee_type_ref, :user).all
    end

    def create
        # Step 1: Create the user with email from form, password set manually
        user = User.new(
            email: params[:user][:email],
            password: "Password123456", # You can randomize this later
            # need the password_confirmation because of our setting with the devise package
            password_confirmation: "Password123456"
        )

        if user.save
            # Step 2: Create the employee and link to the new user
            @employee = Employee.new(employee_params)
            @employee.user = user # Establishes the foreign key relationship

            if @employee.save
                # If both user and employee are saved successfully, redirect to index with success message
                redirect_to employees_path, notice: "Employee created successfully."
            else
                # If employee save fails, reload type options and show error messages
                @employee_types = RefCode.where(code_type: "employee_type")
                flash.now[:alert] = "Employee creation failed: #{@employee.errors.full_messages.join(', ')}"
                render :index, status: :unprocessable_entity
            end
        else
            # If user save fails, prepare a blank employee and show user-related errors
            @employee = Employee.new
            @employee_types = RefCode.where(code_type: "employee_type")
            flash.now[:alert] = "User creation failed: #{user.errors.full_messages.join(', ')}"
            render :index, status: :unprocessable_entity
        end
    end

    def soft_delete
        @employee = Employee.find(params[:employee_id])
        if @employee.update(is_active: 0)
            render json: { message: "Employee deactivated successully." }, status: :ok
        else
            render json: { error: "Failed to deactivate employee." }, status: :unprocessable_content
        end
    end

    private
    # Strong parameters: only allow these fields to be mass-assigned
    def employee_params
        params.require(:employee).permit(:firstname, :middlename, :lastname, :address1, :address2, :city, :birthdate, :employee_type_ref_id, :user_id)
    end
end
