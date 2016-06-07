package life;

import static java.util.concurrent.TimeUnit.MILLISECONDS;

import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;
import java.util.concurrent.Future;
import java.util.concurrent.FutureTask;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.ThreadPoolExecutor;

import comunicaton.Comunicator;

public class FailureDetector {

	private ConcurrentMap<Integer, Future<?>> scheduledSuspicions = new ConcurrentHashMap<Integer, Future<?>>();
	private ScheduledExecutorService executor;

	long TIME_OUT;

	private Comunicator comunicator;

	public FailureDetector(Comunicator comunicator, long TIME_OUT) {
		this.comunicator = comunicator;
		this.TIME_OUT = TIME_OUT;
		List<Integer> devicesIDs = comunicator.getDevicesIds();
		executor = new ScheduledThreadPoolExecutor(comunicator.getNumberOfDevices(),
				new ThreadPoolExecutor.AbortPolicy());
		for (int i = 0; i < comunicator.getNumberOfDevices(); i++) {
			scheduleNewSuspicion(devicesIDs.get(i));
		}
	}

	public void messageRecived(int nod_id) {
		scheduleNewSuspicion(nod_id);
	}

	private void scheduleNewSuspicion(int nod_id) {
		FutureTask<?> scheduledSuspicion = new FutureTask<Object>(new Callable<Object>() {
			@Override
			public Object call() throws Exception {
				removeInactiveDevice(nod_id);
				return null; // no result expected
			}
		});

		executor.schedule(scheduledSuspicion, TIME_OUT, MILLISECONDS);

		Future<?> previousSuspicion = scheduledSuspicions.put(nod_id, scheduledSuspicion);
		if (previousSuspicion != null) {
			previousSuspicion.cancel(true);
		}
	}

	protected final void removeInactiveDevice(int nod_id) {
		comunicator.remove(nod_id);
	}

}
