# frozen_string_literal: true

require_relative "employee_directory/version"
require "pry"

module EmployeeDirectory
  class Error < StandardError; end

  class Employee
    attr_accessor :name, :groups

    def initialize(name:, groups:)
      @name = name
      @groups = groups
    end

    def all_parent_groups
      @all_parent_groups ||= begin
        parent_groups = []
        @groups.each do |group|
          current_group = group
          parent_group = current_group.parent_group

          while parent_group != nil
            parent_groups << current_group
            current_group = parent_group
            parent_group = current_group.parent_group
          end
          parent_groups << current_group
        end

        parent_groups.uniq.sort_by { |group| group.hierarchy_level }.reverse
      end
    end
  end

  class Group
    attr_accessor :name, :parent_group

    def initialize(name:, parent_group: nil)
      @name = name
      @parent_group = parent_group
    end

    def hierarchy_level
      # We perform this operation once, then cache the result in instance variable
      @hierarchy_level ||= begin
        level = 0
        current_group = self

        while current_group.parent_group != nil
          level += 1
          current_group = current_group.parent_group
        end

        level
      end
    end
  end

  # This method should return the common group for the given employees.
  # If there is no common group, it should return nil.
  # If there are no employees, it should return nil.
  #
  # @param employees [Array<EmployeeDirectory::Employee>] The list of employees to check.
  # @return [EmployeeDirectory::Group, nil] The common group or nil if there is none.

  class << self
    def get_common_group_for_employees(employees:)
      # Validate the input :employees
      validate_employees_arg(employees)

      common_groups = employees.first.all_parent_groups
      employees.each_with_index do |employee, i|
        next if i == 0

        common_groups = common_groups & employee.all_parent_groups
      end

      common_groups.uniq.first
    end

    private

    def validate_employees_arg(employees)
      raise ArgumentError, "Arg :employees must be an Array" unless employees.is_a?(Array)
      raise ArgumentError, "Arg :employees must contain at least two employee" if employees.size < 2
      raise ArgumentError, "Arg :employees must contain only Employee objects" unless employees.all? { |employee| employee.is_a?(Employee) }
      raise ArgumentError, "One or more employees do not belong to a group" if employees.any? { |employee| employee.groups.nil? || employee.groups.empty? }
    end
  end
end
