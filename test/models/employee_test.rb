require "test_helper"

class EmployeeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "valid employee" do
    user = users(:ivan)
    ref_code = ref_codes(:hr) # assuming you have this fixture
    employee = Employee.new(
      user: user,
      firstname: "John",
      lastname: "Doe",
      employee_type_ref: ref_code
    )
    assert employee.valid?
  end

  test "invalid without first_name" do
    employee = Employee.new(firstname: nil)
    assert_not employee.valid?
  end
end
