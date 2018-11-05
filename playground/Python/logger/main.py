import logging
FORMAT = "%(asctime)-15s:%(levelname)s %(module)s %(message)s"
logging.basicConfig(format=FORMAT, level=logging.INFO)
logging.debug('This message should go to the log file')
logging.info('So should this')
logging.warning('And this, too')
