#include <stdio.h>
#include <math.h>

#include <AL/al.h>
#include <AL/alc.h>

#include <time.h>
int msleep(long millisecs) {
	struct timespec req, rem;
	req.tv_sec = millisecs / 1000;
	req.tv_nsec = (millisecs % 1000) * 1000 * 1000;
	return nanosleep(&req, &rem);
}

int main() {

	ALuint buffer;
	ALuint source;
	ALCdevice*  device;
	ALCcontext* context;
	int numsamples = 1000;
	int samplerate = 11025;
	unsigned char samples[numsamples];
	int i;
	for(i = 0; i < numsamples; i++) {
		samples[i] = round(120*sin(i*(2*M_PI)/30.0)+128);
	}
	device = alcOpenDevice(NULL);
	context = alcCreateContext(device, NULL);
	alcMakeContextCurrent(context);

	alGenBuffers(1, &buffer);
	alBufferData(buffer, AL_FORMAT_MONO8, samples, numsamples, samplerate);
	if (alGetError()) return 1;

	alGenSources(1, &source);

	alSourcef(source, AL_PITCH, 1.0);
	alSourcef(source, AL_GAIN, 1.0);
	alSourcei(source, AL_BUFFER, buffer);
	alSourcei(source, AL_LOOPING, AL_FALSE);
	alSourcei(source, AL_BUFFER, buffer);
	if (alGetError()) return 1;

	alSourcePlay(source);
	if (alGetError()) return 1;
	
	float delay = ((float)numsamples/(float)samplerate) * 1000.f;
	
	msleep(((long)(delay))*2);
	alSourceStop(source);

	alDeleteSources(1, &source);
	alDeleteBuffers(1, &buffer);

	alcMakeContextCurrent(NULL);

	alcDestroyContext(context);
	alcCloseDevice(device);

	return 0;

}
