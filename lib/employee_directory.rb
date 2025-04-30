# frozen_string_literal: true

require_relative "employee_directory/version"
require "pry"

module EmployeeDirectory
  class Error < StandardError; end

  class Employee
    attr_accessor :name, :group

    def initialize(name:, group:)
      @name = name
      @group = group
    end

    def all_parent_groups
      @all_parent_groups ||= begin
        parent_groups = []
        current_group = @group
        parent_group = current_group.parent_group

        while parent_group != nil
          parent_groups << current_group
          current_group = parent_group
          parent_group = current_group.parent_group
        end
        parent_groups << current_group

        parent_groups
      end
    end
  end

  class Group
    attr_accessor :name, :parent_group

    def initialize(name:, sub_groups: [], parent_group: nil)
      @name = name
      @parent_group = parent_group
    end
  end

  # This method should return the common group for the given employees.
  # If there is no common group, it should return nil.
  # If there are no employees, it should return nil.
  #
  # @param employees [Array<Employee>] The list of employees to check.
  # @return [String, nil] The common group or nil if there is none.

  class << self
    def get_common_group_for_employees(employees)
      return nil if employees.any? { |employee| employee.group.nil? }

      employee1, employee2 = *employees
      common_groups = employee1.all_parent_groups & employee2.all_parent_groups

      common_groups.first
    end
  end
end
