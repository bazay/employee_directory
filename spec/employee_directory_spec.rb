# frozen_string_literal: true

require_relative "../lib/employee_directory"

RSpec.describe EmployeeDirectory do
  describe ".get_common_group_for_employees" do
    subject { described_class.get_common_group_for_employees(params) }

    let(:company) { EmployeeDirectory::Group.new(name: "Company") }
    let(:engineering) { EmployeeDirectory::Group.new(name: "Engineering", parent_group: company) }
    let(:frontend) { EmployeeDirectory::Group.new(name: "Front End", parent_group: engineering) }
    let(:backend) { EmployeeDirectory::Group.new(name: "Backend End", parent_group: engineering) }
    let(:hr) { EmployeeDirectory::Group.new(name: "HR", parent_group: company) }
    let(:companies) { [company, engineering, hr, frontend, backend] }
    let(:lisa) { EmployeeDirectory::Employee.new(name: "Lisa", group: frontend) }
    let(:marley) { EmployeeDirectory::Employee.new(name: "Marley", group: frontend) }
    let(:alice) { EmployeeDirectory::Employee.new(name: "Alice", group: backend) }
    let(:bob) { EmployeeDirectory::Employee.new(name: "Bob", group: backend) }
    let(:mona) { EmployeeDirectory::Employee.new(name: "Mona", group: hr) }
    let(:springs) { EmployeeDirectory::Employee.new(name: "Springs", group: hr) }
    let(:employees) do
      [lisa, marley, alice, bob, mona, springs]
    end

    context "when employees are Lisa and Marley" do
      let(:params) { [lisa, marley] }

      it "returns the common group" do
        expect(subject).to eq(frontend)
      end
    end

    context "when employees are Alice and Marley" do
      let(:params) { [alice, marley] }

      it "returns the common group" do
        expect(subject).to eq(engineering)
      end
    end

    context "when employees are Mona, Lisa and Bob" do
      let(:params) { [mona, lisa, bob] }

      it "returns the common group" do
        expect(subject).to eq(company)
      end
    end
  end

  describe EmployeeDirectory::Employee do
    describe "#all_parent_groups" do
      subject { employee.all_parent_groups }

      let(:company) { EmployeeDirectory::Group.new(name: "Company") }
      let(:engineering) { EmployeeDirectory::Group.new(name: "Engineering", parent_group: company) }
      let(:frontend) { EmployeeDirectory::Group.new(name: "Front End", parent_group: engineering) }
      let(:backend) { EmployeeDirectory::Group.new(name: "Back End", parent_group: engineering) }
      let(:employee) { EmployeeDirectory::Employee.new(name: "Lisa", group: frontend) }

      it "returns all parent groups" do
        expect(subject).to eq([frontend, engineering, company])
      end
    end

  end
end
