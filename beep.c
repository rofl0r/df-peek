#include <stdio.h>
#include <unistd.h>
#include <math.h>

#include <AL/al.h>
#include <AL/alc.h>

int main() {

	ALuint buffer;
	ALuint source;
	ALCdevice*  device;
	ALCcontext* context;
	int bufsize = 1000;
	unsigned char test[bufsize];
	int z;
	for(z = 0; z < bufsize; z++) {
		test[z] = round(120*sin(z*(2*M_PI)/30.0)+128);
	}
	device = alcOpenDevice(NULL);
	context = alcCreateContext(device, NULL);
	alcMakeContextCurrent(context);

	alGenBuffers(1, &buffer);
	alBufferData(buffer, AL_FORMAT_MONO8, test, bufsize, 11024);
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

	sleep(1);
	alSourceStop(source);

	alDeleteSources(1, &source);
	alDeleteBuffers(1, &buffer);

	alcMakeContextCurrent(NULL);

	alcDestroyContext(context);
	alcCloseDevice(device);

	return 0;

}
