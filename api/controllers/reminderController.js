const Reminder = require('../models/reminder');

// Get all reminders
exports.getAllReminders = async (req, res) => {
  try {
    const reminders = await Reminder.find({});
    res.json(reminders);
  } catch (error) {
    console.error('Error getting reminders:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

// Get a single reminder
exports.getReminderById = async (req, res) => {
  try {
    const reminder = await Reminder.findById(req.params.id);
    if (!reminder) {
      return res.status(404).json({ error: 'Reminder not found' });
    }
    res.json(reminder);
  } catch (error) {
    console.error('Error getting reminder:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

// Create a new reminder
exports.createReminder = async (req, res) => {
  try {
      const reminder = new Reminder(req.body);
      await Reminder.save();
      res.json(reminder);
  } catch (error) {
    console.error('Error creating reminder:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

// Update a reminder
exports.updateReminder = async (req, res) => {
  try {
    let reminder = await Reminder.findById(req.params.id);
    if (!reminder) {
      return res.status(404).json({ error: 'reminder not found' });
    }

    updated_reminder = await Reminder.findByIdAndUpdate(reminder._id, req.body, {
      new: true,
      runValidators: true,
    });

    res.json(updated_reminder);
  } catch (error) {
    console.error('Error updating reminder:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

// Delete a reminder
exports.deleteReminder = async (req, res) => {
  try {
    const reminder = await Reminder.findById(req.params.id);

    if (!reminder) {
      return res.status(404).json({ error: 'reminder not found' });
    }
    await Reminder.deleteOne({ _id: req.params.id });

    res.json({ message: 'reminder deleted successfully' });
  } catch (error) {
    console.error('Error deleting reminder:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};