def log(*args):
    print("logging..")

def dupa():
    raise OSError()

def main():
    pids = ["123","345"]
    tasks_filepath = "/home/felidadae/tmp/my_shit_file"

    if not pids:
        return

    try:
        ftasks = dupa()
        for pid in pids:
            ftasks.write(pid)
            ftasks.flush()

    except ProcessLookupError:
        log.warning('Could not write pid to resctrl (%r): '
                    'Process probably does not exist. ', tasks_filepath)
    except FileNotFoundError:
        log.error('Could not write pid to resctrl (%r): '
                  'rdt group was not found (moved/deleted - race detected).', tasks_filepath)
    except OSError as e:
        if e.errno == errno.EINVAL:
            # (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
            log.error(
                'Could not write pid to resctrl (%r): '
                'Invalid argument %r.', tasks_filepath)
        else:
            log.error(
                'Could not write pid to resctrl (%r): '
                'Unexpected errno %r.', tasks_filepath, e.errno)
    finally:
        try:
            # Try what we can to close the file but it is expected
            # to fails because the wrong # data is waiting to be flushed
            ftasks.close()
        except (ProcessLookupError, FileNotFoundError, OSError):
            log.warning('Could not close resctrl/tasks file - ignored!'
                        '(side-effect of previous warning!)')

if __name__ == "__main__":
    main()

