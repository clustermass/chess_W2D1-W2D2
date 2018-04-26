require_relative 'employee'
class Manager < Employee

  def initialize(name, title, salary, boss)
    super(name, title, salary, boss)
    @employees = []
  end

  def bonus(multiplier)

    (all_employees_salary) * multiplier
  end

  def all_employees_salary
    return 0 if @employees.empty?
    total_salary = 0

    @employees.each do |employee|
  
      if employee.class == Employee
        total_salary += employee.salary
      else
        total_salary += employee.salary
        total_salary += employee.all_employees_salary
      end
    end
    total_salary
  end

  def add_employee(employee)
    @employees.push(employee)
  end

end




if __FILE__ == $PROGRAM_NAME
  founder = Manager.new("Ned","founder",1000000,nil)
  ta_manager = Manager.new("Daren","TA manager", 78000, founder)
  ta_1 = Employee.new("Shawna", "TA",12000, ta_manager)
  ta_2 = Employee.new("David", "TA",10000, ta_manager)
  p founder.bonus(5)
  p ta_manager.bonus(4)
  p ta_2.bonus(3)
  p founder.bonus(1)
end
