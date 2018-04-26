class Employee
attr_reader :salary
  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    boss.add_employee(self) unless boss == nil
  end

  def bonus(multiplier)
    @salary * multiplier
  end

end
