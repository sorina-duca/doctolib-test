# frozen_string_literal: true

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test 'one simple test example' do
    Event.create kind: 'opening', starts_at: DateTime.parse('2014-08-04 09:30'), ends_at: DateTime.parse('2014-08-04 12:30'), weekly_recurring: true
    Event.create kind: 'appointment', starts_at: DateTime.parse('2014-08-11 10:30'), ends_at: DateTime.parse('2014-08-11 11:30')

    availabilities = Event.availabilities DateTime.parse('2014-08-10')
    # puts availabilities
    # assert_equal Date.new(2014, 8, 10), availabilities[0][:date]
    # assert_equal [], availabilities[0][:slots]
    # assert_equal Date.new(2014, 8, 11), availabilities[1][:date]
    assert_equal ['9:30', '10:00', '11:30', '12:00'], availabilities[1][:slots]
    # assert_equal [], availabilities[2][:slots]
    # assert_equal Date.new(2014, 8, 16), availabilities[6][:date]
    # assert_equal 7, availabilities.length
  end

  # test 'another simple test example' do
  #   Event.create kind: 'opening', starts_at: DateTime.parse('2014-08-04 09:30'), ends_at: DateTime.parse('2014-08-04 12:30'), weekly_recurring: true
  #   Event.create kind: 'appointment', starts_at: DateTime.parse('2014-08-04 10:30'), ends_at: DateTime.parse('2014-08-04 11:30')

  #   availabilities = Event.availabilities DateTime.parse('2014-08-04')
  #   assert_equal ['9:30', '10:00', '11:30', '12:00'], availabilities[0][:slots]
  #   assert_equal 7, availabilities.length
  # end
end

# [{"date":"2014/08/04","slots":["12:00","13:30"]},{"date":"2014/08/05","slots":["09:00", "09:30"]},
