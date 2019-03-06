import json
import os
extra_labels = json.loads(os.environ.get('labels', '{}'))
print(extra_labels)
