#include <stdio.h>
#include <math.h>
#include <errno.h>
#include <time.h>
#include <ao/ao.h>
//RcB: LINK "-lao"

struct AoWriter {
	ao_device *device;
	ao_sample_format format;
	int aodriver;
};

int AoWriter_init(struct AoWriter *self) {
	ao_initialize();
	memset(self, 0, sizeof(*self));
	self->format.bits = 8;
	self->format.channels = 1;
	self->format.rate = 11025;
	self->format.byte_format = AO_FMT_LITTLE;
	self->aodriver = ao_default_driver_id();
	self->device = ao_open_live(self->aodriver, &self->format, NULL);
	return self->device != NULL;
}

int AoWriter_write(struct AoWriter *self, void* buffer, size_t bufsize) {
	return ao_play(self->device, buffer, bufsize);
}

int AoWriter_close(struct AoWriter *self) {
	return ao_close(self->device);
}


int msleep(long millisecs) {
	struct timespec req, rem;
	req.tv_sec = millisecs / 1000;
	req.tv_nsec = (millisecs % 1000) * 1000 * 1000;
	int ret;
	while((ret = nanosleep(&req, &rem)) == -1 && errno == EINTR) req = rem;
	return ret;
}

int main() {
	struct AoWriter ao;
	AoWriter_init(&ao);

	int numsamples = 1000;
	int samplerate = 11025;
	unsigned char samples[numsamples];
	int i;
	for(i = 0; i < numsamples; i++) {
		samples[i] = round(120*sin(i*(2*M_PI)/30.0)+128);
	}

	float delay = ((float)numsamples/(float)samplerate) * 1000.f;
	AoWriter_write(&ao, samples, numsamples);
	AoWriter_close(&ao);
	return 0;
}
