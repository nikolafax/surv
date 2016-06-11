package messages;

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.SynchronousQueue;

public class MessageQeue {

	private BlockingQueue<byte[]> buffer;

	public MessageQeue(int BUFFER_SIZE) {
		buffer = new SynchronousQueue<>();
	}

	public byte[] take() {
		try {
			return buffer.take();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		return null;
	}

	public void put(byte[] obj) {
		try {
			buffer.put(obj);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

}
