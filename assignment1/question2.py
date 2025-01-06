def process(d):
    STATUS_MESSAGES = {
        'active': 'Active',
        'inactive': 'Inactive'
    }
    status = d.get('status', 'unknown')
    print(STATUS_MESSAGES.get(status, 'Unknown'))


process({'status': 'active'})
