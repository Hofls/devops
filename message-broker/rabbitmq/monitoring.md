### List queues with at least 10 stuck messages (useful for monitoring)
```
async function listQueues() {
  const vhost = 'smonation';
  const url = `http://rabbit.someit.com/api/queues/${encodeURIComponent(vhost)}`;
  const username = 'hofls';
  const password = 'qwerty';

  const credentials = btoa(`${username}:${password}`); // base64

  try {
    const response = await fetch(url, {
      method: 'GET',
      headers: {
        'Authorization': `Basic ${credentials}`,
        'Content-Type': 'application/json'
      }
    });

    if (!response.ok) {
      throw new Error(`Error: ${response.status} ${response.statusText}`);
    }

    const queues = await response.json();
    const filteredQueues = queues.filter(queue => queue.messages > 10);
    console.log(filteredQueues);
  } catch (error) {
    console.error('Error fetching queues:', error);
  }
}

listQueues();
```