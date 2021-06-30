x= cos(2*pi*12*[0:0.001:1.23]);
x(end) = [];
[b a] = butter(2,[0.6 0.7],'bandpass');
filtered_noise = filter(b,a,randn(1, length(x)*2));
x = (x + 0.5*filtered_noise(500:500+length(x)-1))/length(x)*2;
title('Noisy signal')
xlabel('Samples');
ylabel('Amplitude')
X_mags = abs(fft(x));
figure(10)
plot(X_mags)
xlabel('DFT Bins')
ylabel('Magnitude')
num_bins = length(X_mags);
plot([0:1/(num_bins/2 -1):1], X_mags(1:num_bins/2))
xlabel('Normalised frequency (\pi rads/sample)')
ylabel('Magnitude')
[b a] = butter(2, 0.3, 'low')
H = freqz(b,a, floor(num_bins/2));
hold on
plot([0:1/(num_bins/2 -1):1], abs(H),'r');
x_filtered = filter(b,a,x);
figure(2)
plot(x_filtered,'r')
title('Filtered Signal -Using Second Order Butterworth')
xlabel('Samples');
ylabel('Amplitude')
[b2 a2] = butter(20,0.3, 'low')
H2 = freqz(b2,a2, floor(num_bins/2))
figure(10)
hold on
plot([0:1/(num_bins/2 -1):1], abs(H2),'g');
x_filtered2 = filter(b2,a2,x);
figure(3)
plot(x_filtered2,'g')
title('Filtered Signal -Using 20th Order Butterworth')
xlabel('Samples');
ylabel('Amplitude')
[b_stop a_stop] = butter(20, [0.5 0.8], 'stop');
H_stopband = freqz(b_stop,a_stop, floor(num_bins/2));
figure(10)
hold on
plot([0:1/(num_bins/2 -1):1], abs(H_stopband),'c');
x_filtered_stop =filter(b_stop,a_stop,x);
figure(4);
plot(x_filtered_stop,'c')
title('Filtered Signal -Using Stopband')
xlabel('Samples');
ylabel('Amplitude')
[N Wn] = buttord(0.1, 0.5, 5, 40)
[b3 a3] = butter(N, Wn, 'low');
H3 = freqz(b3,a3, floor(num_bins/2));
figure(10);
hold on
plot([0:1/(num_bins/2 -1):1], abs(H2),'k');
figure(10)
x_filtered3 = filter(b3,a3,x);
figure(5);
plot(x_filtered3,'k')
title(['Filtered Signal -Using ' num2str(N) ' th Order Butterworth'])
xlabel('Samples');
ylabel('Amplitude')
[b_butter a_butter] = butter(4, 0.2, 'low');
H_butter = freqz(b_butter, a_butter);
[b_cheby a_cheby] = cheby1(4, 0.5, 0.2, 'low');
H_cheby = freqz(b_cheby, a_cheby);
[b_ellip a_ellip] = ellip(4, 0.5, 40, 0.2, 'low');
H_ellip = freqz(b_ellip, a_ellip);
figure(11)
norm_freq_axis = [0:1/(512 -1):1];
plot(norm_freq_axis, abs(H_butter))
hold on
plot(norm_freq_axis, abs(H_cheby),'r')
plot(norm_freq_axis, abs(H_ellip),'g')
legend('Butterworth', 'Chebyshev', 'Elliptical')
xlabel('Normalised Frequency');
ylabel('Magnitude')
figure(12);
plot(norm_freq_axis, 20*log10(abs(H_butter)))
hold on
plot(norm_freq_axis, 20*log10(abs(H_cheby)),'r')
plot(norm_freq_axis, 20*log10(abs(H_ellip)),'g')
legend('Butterworth', 'Chebyshev', 'Elliptical')
xlabel('Normalised Frequency ');
ylabel('Magnitude (dB)')