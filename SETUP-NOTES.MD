
# Setup Notes

# devise documentation: https://github.com/heartcombo/devise

# bundle add devise -- will add the gem on gemfile
# bin/rails generate devise: install -- will install the gem

# bin/rails generate devise {Model} - will create a table on the database {Model name could User or something}


# docker-compose down --volumes
# docker-compose build --no-cache
# 


# docker-compose exec web rails db:migrate




# linting
# bundle exec rubocop --format clang

# Creating employee model
# bin/rails generate model Employee user: references firstname:string middlename:string lastname:string address1:text address2:text city:string, mobile_number:string employee_type:string, birthdate:date

## run migration
# docker-compose run web bin/rails db:migrate


## Rollback the migration:
## bin/rails db:rollback STEP=1

### Since we are running everythin in docker, we need to add docker-compose run {service} - bin/rails
## docker-compose run web bin/rails db:migrate

## delete migration
## bin/rails generate migration RemoveEmployeeTypeFromEmployees employee_type:string

## test users

## ivan@test.com/Ivan123456


## Rails customizable path -- Manual approach
<!-- 
    <select name="employee[employee_type_ref_id]">
    <% @employee_types.each do |type| %>
        <option value="<%= type.id %>"><%= type.name %></option>
    <% end %>
    </select> -->


## docker-compose build --no-cache