require('dotenv').config({ path: require('path').join(__dirname, '..', '..', '.env') });
const mongoose = require('mongoose');
const User = require('../models/User');
const ChecklistTemplate = require('../models/ChecklistTemplate');
const Job = require('../models/Job');

async function seed() {
  await mongoose.connect(process.env.MONGODB_URI);
  console.log('Connected to MongoDB');

  // Clear existing data
  await User.deleteMany({});
  await ChecklistTemplate.deleteMany({});
  await Job.deleteMany({});
  console.log('Cleared existing data');

  // ── Create Users ──────────────────────────────────────
  const admin = await User.create({
    name: 'Admin User',
    email: 'admin@rededge.com',
    password: 'password123',
    role: 'admin',
    phone: '0400000000',
  });

  const mike = await User.create({
    name: 'Mike Johnson',
    email: 'mike.johnson@rededge.com',
    password: 'password123',
    role: 'installer',
    phone: '0411111111',
  });

  const tom = await User.create({
    name: 'Tom Wilson',
    email: 'tom.wilson@rededge.com',
    password: 'password123',
    role: 'installer',
    phone: '0422222222',
  });

  const lisa = await User.create({
    name: 'Lisa Chen',
    email: 'lisa.chen@rededge.com',
    password: 'password123',
    role: 'installer',
    phone: '0433333333',
  });

  console.log('Created users: admin, mike, tom, lisa');

  // ── Create Checklist Templates ────────────────────────
  await ChecklistTemplate.create({
    systemType: 'hemisphere_vr1000_dozer',
    name: 'Hemisphere VR1000 Dozer',
    createdBy: admin._id,
    steps: [
      { number: 1, title: 'Pre-Installation Safety Check', description: 'Verify site safety, check PPE, confirm machine isolation', requiresPhoto: true },
      { number: 2, title: 'Mount GNSS Antenna on Dozer Blade', description: 'Install antenna mount bracket, attach GNSS antenna, route cables', requiresPhoto: true },
      { number: 3, title: 'Install VR1000 Control Box in Cabin', description: 'Mount control box, connect power supply, verify display', requiresPhoto: true },
      { number: 4, title: 'Connect Blade Sensors', description: 'Install blade slope sensor, connect wiring harness', requiresPhoto: true },
      { number: 5, title: 'Configure Base Station Link', description: 'Set up radio link or NTRIP connection to base station', requiresPhoto: false },
      { number: 6, title: 'Calibrate Machine Geometry', description: 'Input dozer dimensions, calibrate blade position sensors', requiresPhoto: false },
      { number: 7, title: 'Run System Diagnostics', description: 'Run built-in diagnostics, verify GPS fix, test blade control', requiresPhoto: true },
      { number: 8, title: 'Field Test & Operator Training', description: 'Perform field test cuts, train operator on system use', requiresPhoto: true },
      { number: 9, title: 'Final Sign-Off & Documentation', description: 'Complete paperwork, take final photos, get client sign-off', requiresPhoto: true },
    ],
  });

  await ChecklistTemplate.create({
    systemType: 'hemisphere_vr1000_excavator',
    name: 'Hemisphere VR1000 Excavator',
    createdBy: admin._id,
    steps: [
      { number: 1, title: 'Pre-Installation Safety Check', description: 'Verify site safety, check PPE, confirm machine isolation', requiresPhoto: true },
      { number: 2, title: 'Mount GNSS Antenna on Excavator', description: 'Install antenna on cab roof or counterweight, route cables', requiresPhoto: true },
      { number: 3, title: 'Install VR1000 Control Box', description: 'Mount control box inside cab, connect power', requiresPhoto: true },
      { number: 4, title: 'Install Boom & Stick Sensors', description: 'Mount angle sensors on boom, stick, and bucket pins', requiresPhoto: true },
      { number: 5, title: 'Install Bucket Sensor', description: 'Mount tilt sensor on bucket linkage, calibrate', requiresPhoto: true },
      { number: 6, title: 'Configure Base Station Link', description: 'Set up radio link or NTRIP connection', requiresPhoto: false },
      { number: 7, title: 'Calibrate Machine Geometry', description: 'Input boom/stick/bucket dimensions, calibrate sensors', requiresPhoto: false },
      { number: 8, title: 'Run System Diagnostics', description: 'Verify GPS fix, test dig guidance, check sensor accuracy', requiresPhoto: true },
      { number: 9, title: 'Field Test & Operator Training', description: 'Perform test dig, train operator', requiresPhoto: true },
      { number: 10, title: 'Final Sign-Off & Documentation', description: 'Complete paperwork, take final photos, get client sign-off', requiresPhoto: true },
    ],
  });

  await ChecklistTemplate.create({
    systemType: 'stonex_stxdig_dozer',
    name: 'Stonex STX-DIG Dozer',
    createdBy: admin._id,
    steps: [
      { number: 1, title: 'Pre-Installation Safety Check', description: 'PPE check, machine isolation, site inspection', requiresPhoto: true },
      { number: 2, title: 'Install Stonex GNSS Receiver', description: 'Mount GNSS receiver on dozer, connect cables', requiresPhoto: true },
      { number: 3, title: 'Mount STX-DIG Display', description: 'Install display unit in cab, connect power and data', requiresPhoto: true },
      { number: 4, title: 'Install Blade Sensors', description: 'Mount blade rotation and slope sensors', requiresPhoto: true },
      { number: 5, title: 'Connect Hydraulic Control Valves', description: 'Wire automatic blade control valves', requiresPhoto: true },
      { number: 6, title: 'Configure Corrections Source', description: 'Set up NTRIP or local base station', requiresPhoto: false },
      { number: 7, title: 'Calibrate Machine Profile', description: 'Input machine dimensions, calibrate sensors', requiresPhoto: false },
      { number: 8, title: 'System Test & Validation', description: 'Run diagnostics, verify accuracy', requiresPhoto: true },
      { number: 9, title: 'Operator Training & Sign-Off', description: 'Train operator, complete documentation', requiresPhoto: true },
    ],
  });

  await ChecklistTemplate.create({
    systemType: 'stonex_stxdig_excavator',
    name: 'Stonex STX-DIG Excavator',
    createdBy: admin._id,
    steps: [
      { number: 1, title: 'Pre-Installation Safety Check', description: 'PPE check, machine isolation, site inspection', requiresPhoto: true },
      { number: 2, title: 'Install Stonex GNSS Receiver', description: 'Mount GNSS receiver on excavator cab/counterweight', requiresPhoto: true },
      { number: 3, title: 'Mount STX-DIG Display', description: 'Install display unit in cab', requiresPhoto: true },
      { number: 4, title: 'Install Boom Angle Sensor', description: 'Mount sensor on boom pin, route cable', requiresPhoto: true },
      { number: 5, title: 'Install Stick Angle Sensor', description: 'Mount sensor on stick pin, route cable', requiresPhoto: true },
      { number: 6, title: 'Install Bucket Tilt Sensor', description: 'Mount sensor on bucket linkage', requiresPhoto: true },
      { number: 7, title: 'Configure Corrections Source', description: 'Set up NTRIP or local base station', requiresPhoto: false },
      { number: 8, title: 'Calibrate Machine Geometry', description: 'Input boom/stick/bucket dimensions', requiresPhoto: false },
      { number: 9, title: 'System Test & Validation', description: 'Test dig guidance accuracy', requiresPhoto: true },
      { number: 10, title: 'Operator Training & Sign-Off', description: 'Train operator, complete documentation', requiresPhoto: true },
    ],
  });

  console.log('Created 4 checklist templates');

  // ── Create Sample Jobs ────────────────────────────────
  await Job.create({
    title: 'Hemisphere VR1000 Installation - Dozer',
    description: 'Install VR1000 machine guidance system on CAT D6 dozer with blade sensors',
    systemType: 'hemisphere_vr1000_dozer',
    location: 'Denver, CO',
    address: '1234 Construction Way, Denver, CO 80201',
    scheduledDate: new Date('2026-03-20'),
    company: 'Rocky Mountain Earthworks',
    status: 'draft',
    createdBy: admin._id,
    assignedTo: mike._id,
    steps: [
      { number: 1, title: 'Pre-Installation Safety Check', description: 'Verify site safety', requiresPhoto: true, isCompleted: false },
      { number: 2, title: 'Mount GNSS Antenna on Dozer Blade', description: 'Install antenna mount', requiresPhoto: true, isCompleted: false },
      { number: 3, title: 'Install VR1000 Control Box in Cabin', description: 'Mount control box', requiresPhoto: true, isCompleted: false },
      { number: 4, title: 'Connect Blade Sensors', description: 'Install blade slope sensor', requiresPhoto: true, isCompleted: false },
      { number: 5, title: 'Configure Base Station Link', requiresPhoto: false, isCompleted: false },
      { number: 6, title: 'Calibrate Machine Geometry', requiresPhoto: false, isCompleted: false },
      { number: 7, title: 'Run System Diagnostics', requiresPhoto: true, isCompleted: false },
      { number: 8, title: 'Field Test & Operator Training', requiresPhoto: true, isCompleted: false },
      { number: 9, title: 'Final Sign-Off & Documentation', requiresPhoto: true, isCompleted: false },
    ],
  });

  await Job.create({
    title: 'Stonex STX-DIG Excavator Setup',
    description: 'Full Stonex STX-DIG installation on Komatsu PC200 excavator',
    systemType: 'stonex_stxdig_excavator',
    location: 'Phoenix, AZ',
    address: '567 Desert Road, Phoenix, AZ 85001',
    scheduledDate: new Date('2026-03-22'),
    company: 'Southwest Contracting',
    status: 'pending',
    createdBy: admin._id,
    assignedTo: tom._id,
    steps: [
      { number: 1, title: 'Pre-Installation Safety Check', requiresPhoto: true, isCompleted: false },
      { number: 2, title: 'Install Stonex GNSS Receiver', requiresPhoto: true, isCompleted: false },
      { number: 3, title: 'Mount STX-DIG Display', requiresPhoto: true, isCompleted: false },
      { number: 4, title: 'Install Boom Angle Sensor', requiresPhoto: true, isCompleted: false },
      { number: 5, title: 'Install Stick Angle Sensor', requiresPhoto: true, isCompleted: false },
      { number: 6, title: 'Install Bucket Tilt Sensor', requiresPhoto: true, isCompleted: false },
      { number: 7, title: 'Configure Corrections Source', requiresPhoto: false, isCompleted: false },
      { number: 8, title: 'Calibrate Machine Geometry', requiresPhoto: false, isCompleted: false },
      { number: 9, title: 'System Test & Validation', requiresPhoto: true, isCompleted: false },
      { number: 10, title: 'Operator Training & Sign-Off', requiresPhoto: true, isCompleted: false },
    ],
  });

  await Job.create({
    title: 'VR1000 Precision Installation',
    description: 'Full Hemisphere VR1000 Dozer setup including GPS antenna and calibration',
    systemType: 'hemisphere_vr1000_dozer',
    location: 'Salt Lake City, UT',
    address: '890 Mountain View, Salt Lake City, UT 84101',
    scheduledDate: new Date('2026-03-25'),
    company: 'Wasatch Heavy Equipment',
    status: 'needs_approval',
    createdBy: admin._id,
    assignedTo: mike._id,
    steps: [
      { number: 1, title: 'Pre-Installation Safety Check', requiresPhoto: true, isCompleted: true },
      { number: 2, title: 'Mount GNSS Antenna', requiresPhoto: true, isCompleted: true },
      { number: 3, title: 'Install Control Box', requiresPhoto: true, isCompleted: true },
      { number: 4, title: 'Connect Blade Sensors', requiresPhoto: true, isCompleted: true },
      { number: 5, title: 'Configure Base Station', requiresPhoto: false, isCompleted: true },
      { number: 6, title: 'Calibrate Geometry', requiresPhoto: false, isCompleted: true },
      { number: 7, title: 'Run Diagnostics', requiresPhoto: true, isCompleted: true },
      { number: 8, title: 'Field Test', requiresPhoto: true, isCompleted: true },
      { number: 9, title: 'Final Sign-Off', requiresPhoto: true, isCompleted: true },
    ],
  });

  await Job.create({
    title: 'Stonex Dozer GPS Installation',
    description: 'Stonex STX-DIG installation on CAT D8 dozer',
    systemType: 'stonex_stxdig_dozer',
    location: 'Las Vegas, NV',
    address: '321 Strip Road, Las Vegas, NV 89101',
    scheduledDate: new Date('2026-03-28'),
    company: 'Nevada Grading Co',
    status: 'in_progress',
    createdBy: admin._id,
    assignedTo: lisa._id,
    steps: [
      { number: 1, title: 'Pre-Installation Safety Check', requiresPhoto: true, isCompleted: true },
      { number: 2, title: 'Install Stonex GNSS Receiver', requiresPhoto: true, isCompleted: true },
      { number: 3, title: 'Mount STX-DIG Display', requiresPhoto: true, isCompleted: true },
      { number: 4, title: 'Install Blade Sensors', requiresPhoto: true, isCompleted: false },
      { number: 5, title: 'Connect Hydraulic Control Valves', requiresPhoto: true, isCompleted: false },
      { number: 6, title: 'Configure Corrections Source', requiresPhoto: false, isCompleted: false },
      { number: 7, title: 'Calibrate Machine Profile', requiresPhoto: false, isCompleted: false },
      { number: 8, title: 'System Test & Validation', requiresPhoto: true, isCompleted: false },
      { number: 9, title: 'Operator Training & Sign-Off', requiresPhoto: true, isCompleted: false },
    ],
  });

  await Job.create({
    title: 'VR1000 Excavator Full Install',
    description: 'Hemisphere VR1000 excavator guidance on Hitachi ZX350',
    systemType: 'hemisphere_vr1000_excavator',
    location: 'Portland, OR',
    address: '456 River Way, Portland, OR 97201',
    scheduledDate: new Date('2026-04-01'),
    company: 'Pacific Northwest Construction',
    status: 'completed',
    createdBy: admin._id,
    assignedTo: tom._id,
    completedAt: new Date('2026-03-15'),
    steps: [
      { number: 1, title: 'Pre-Installation Safety Check', requiresPhoto: true, isCompleted: true },
      { number: 2, title: 'Mount GNSS Antenna', requiresPhoto: true, isCompleted: true },
      { number: 3, title: 'Install Control Box', requiresPhoto: true, isCompleted: true },
      { number: 4, title: 'Install Boom & Stick Sensors', requiresPhoto: true, isCompleted: true },
      { number: 5, title: 'Install Bucket Sensor', requiresPhoto: true, isCompleted: true },
      { number: 6, title: 'Configure Base Station', requiresPhoto: false, isCompleted: true },
      { number: 7, title: 'Calibrate Machine Geometry', requiresPhoto: false, isCompleted: true },
      { number: 8, title: 'Run Diagnostics', requiresPhoto: true, isCompleted: true },
      { number: 9, title: 'Field Test', requiresPhoto: true, isCompleted: true },
      { number: 10, title: 'Final Sign-Off', requiresPhoto: true, isCompleted: true },
    ],
  });

  console.log('Created 5 sample jobs');
  console.log('\n=== SEED COMPLETE ===');
  console.log('Admin login: admin@rededge.com / password123');
  console.log('Installer logins:');
  console.log('  mike.johnson@rededge.com / password123');
  console.log('  tom.wilson@rededge.com / password123');
  console.log('  lisa.chen@rededge.com / password123');

  process.exit(0);
}

seed().catch((err) => {
  console.error('Seed error:', err);
  process.exit(1);
});
