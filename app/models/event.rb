# frozen_string_literal: true

class Event < ApplicationRecord
  def self.availabilities(start_date)
    weekdays = get_week(start_date)
    weekdays.each do |day|
      day[:slots] = Event.available_slots(day[:date])
    end
    weekdays
  end

  def self.get_week(start_date)
    week = []
    (0..6).each do |n|
      day = {}
      day[:date] = (start_date + n.days).to_date
      week << day
    end
    week
  end

  def self.openings(day)
    open = Event.where(kind: 'opening').select do |ev|
      ev.starts_at.to_date == day.to_date ||
        ev.weekly_recurring == true && ev.starts_at.wday == day.wday
    end
    open.map do |ev|
      Event.new(starts_at: DateTime.parse((ev.starts_at + (day - ev.starts_at.to_date).days).to_s), ends_at: DateTime.parse((ev.ends_at + (day - ev.ends_at.to_date).days).to_s))
    end
  end

  def self.appointments(day)
    Event.where(kind: 'appointment').select do |ev|
      ev.starts_at.to_date == day.to_date
    end
  end

  def self.available_slots(day)
    slots = []
    if Event.appointments(day) == []
      Event.openings(day).each do |op|
        slots << Event.slot_to_string(op.starts_at)
        for n in 1..(Event.minutes(op) / 30 - 1) do
          slots << Event.slot_to_string(op.starts_at + n * 30.minutes)
        end
      end
    else
      Event.openings(day).each do |op|
        slot_start = op.starts_at
        slot_end = op.starts_at + 30.minutes
        slots << Event.slot_to_string(op.starts_at) if Event.slot_available?(slot_start, slot_end, day) == true
        for n in 1..((Event.minutes(op) / 30) - 1) do
          slot_start = op.starts_at + n * 30.minutes
          slot_end = slot_start + 30.minutes
          slots << Event.slot_to_string(slot_start) if Event.slot_available?(slot_start, slot_end, day) == true
        end
      end
    end
    slots
  end

  def self.minutes(event)
    (event.ends_at - event.starts_at) / 60
  end

  def self.slot_available?(slot_start, slot_end, day)
    Event.appointments(day).none? do |app|
      slot_start < app.ends_at && slot_end > app.starts_at
    end
  end

  def self.slot_to_string(datetime)
    datetime.strftime("%-l:%M")
  end
end
