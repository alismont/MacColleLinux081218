import logging

logging.basicConfig(filename='test_log.log',level=logging.DEBUG,\
      format='%(asctime)s -- %(name)s -- %(levelname)s -- %(message)s')
logging.debug('Debug error')
logging.info('INFO ERROR')
logging.warning('Warning Error %s: %s', '01234', 'Erreur Oracle')
logging.error('error message')
logging.critical('critical error')
