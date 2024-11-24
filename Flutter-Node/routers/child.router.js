const router = require('express').Router();
const ChildController = require('../controller/child.contoller');

router.post('/childEntry',ChildController.child_entry);
router.post('/childRetrieve',ChildController.child_retrieve);

module.exports = router;