import logging
FORMAT = "%(asctime)-15s:%(levelname)s %(module)s %(message)s"
logging.basicConfig(format=FORMAT, level=logging.ERROR)
logging.debug('This message should go to the log file')
logging.info('So should this')
logging.warning('And this, too')
logging.critical('And shit this as well')
logging.error('And that so totally')

import logging
logging.basicConfig(level=logging.DEBUG)
