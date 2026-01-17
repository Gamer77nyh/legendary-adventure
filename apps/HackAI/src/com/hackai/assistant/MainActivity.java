package com.hackai.assistant;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.speech.RecognitionListener;
import android.speech.RecognizerIntent;
import android.speech.SpeechRecognizer;
import android.speech.tts.TextToSpeech;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;
import java.util.ArrayList;
import java.util.Locale;

/**
 * HackAI - Voice-Activated AI Assistant for Security Testing
 * Main activity for voice commands and tool execution
 */
public class MainActivity extends Activity implements TextToSpeech.OnInitListener {
    
    private TextView statusText;
    private Button listenButton;
    private SpeechRecognizer speechRecognizer;
    private TextToSpeech tts;
    private CommandProcessor commandProcessor;
    private boolean isListening = false;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        
        statusText = findViewById(R.id.status_text);
        listenButton = findViewById(R.id.listen_button);
        
        // Initialize Text-to-Speech
        tts = new TextToSpeech(this, this);
        
        // Initialize Speech Recognizer
        speechRecognizer = SpeechRecognizer.createSpeechRecognizer(this);
        speechRecognizer.setRecognitionListener(new VoiceRecognitionListener());
        
        // Initialize Command Processor
        commandProcessor = new CommandProcessor(this);
        
        listenButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (!isListening) {
                    startListening();
                } else {
                    stopListening();
                }
            }
        });
        
        updateStatus("HackAI Ready. Tap to activate.");
    }
    
    private void startListening() {
        Intent intent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
        intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL,
                RecognizerIntent.LANGUAGE_MODEL_FREE_FORM);
        intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE, Locale.getDefault());
        intent.putExtra(RecognizerIntent.EXTRA_CALLING_PACKAGE, getPackageName());
        
        speechRecognizer.startListening(intent);
        isListening = true;
        updateStatus("Listening...");
        listenButton.setText("Stop");
    }
    
    private void stopListening() {
        speechRecognizer.stopListening();
        isListening = false;
        updateStatus("HackAI Ready. Tap to activate.");
        listenButton.setText("Listen");
    }
    
    private void updateStatus(String message) {
        statusText.setText(message);
    }
    
    private void processCommand(String command) {
        updateStatus("Processing: " + command);
        
        // Process command through CommandProcessor
        String response = commandProcessor.processVoiceCommand(command);
        
        // Speak the response
        speak(response);
        updateStatus(response);
    }
    
    private void speak(String text) {
        if (tts != null) {
            tts.speak(text, TextToSpeech.QUEUE_FLUSH, null, null);
        }
    }
    
    @Override
    public void onInit(int status) {
        if (status == TextToSpeech.SUCCESS) {
            int result = tts.setLanguage(Locale.US);
            if (result == TextToSpeech.LANG_MISSING_DATA ||
                result == TextToSpeech.LANG_NOT_SUPPORTED) {
                Toast.makeText(this, "TTS language not supported", Toast.LENGTH_SHORT).show();
            }
        } else {
            Toast.makeText(this, "TTS initialization failed", Toast.LENGTH_SHORT).show();
        }
    }
    
    @Override
    protected void onDestroy() {
        if (tts != null) {
            tts.stop();
            tts.shutdown();
        }
        if (speechRecognizer != null) {
            speechRecognizer.destroy();
        }
        super.onDestroy();
    }
    
    /**
     * Custom Recognition Listener for voice input
     */
    private class VoiceRecognitionListener implements RecognitionListener {
        
        @Override
        public void onReadyForSpeech(Bundle params) {
            updateStatus("Ready for speech...");
        }
        
        @Override
        public void onBeginningOfSpeech() {
            updateStatus("Listening...");
        }
        
        @Override
        public void onRmsChanged(float rmsdB) {
            // Audio level monitoring
        }
        
        @Override
        public void onBufferReceived(byte[] buffer) {
            // Audio buffer received
        }
        
        @Override
        public void onEndOfSpeech() {
            updateStatus("Processing...");
        }
        
        @Override
        public void onError(int error) {
            String errorMessage = getErrorText(error);
            updateStatus("Error: " + errorMessage);
            isListening = false;
            listenButton.setText("Listen");
        }
        
        @Override
        public void onResults(Bundle results) {
            ArrayList<String> matches = results.getStringArrayList(
                    SpeechRecognizer.RESULTS_RECOGNITION);
            if (matches != null && matches.size() > 0) {
                String command = matches.get(0);
                processCommand(command);
            }
            isListening = false;
            listenButton.setText("Listen");
        }
        
        @Override
        public void onPartialResults(Bundle partialResults) {
            // Partial results
        }
        
        @Override
        public void onEvent(int eventType, Bundle params) {
            // Event handling
        }
        
        private String getErrorText(int errorCode) {
            switch (errorCode) {
                case SpeechRecognizer.ERROR_AUDIO:
                    return "Audio recording error";
                case SpeechRecognizer.ERROR_CLIENT:
                    return "Client side error";
                case SpeechRecognizer.ERROR_INSUFFICIENT_PERMISSIONS:
                    return "Insufficient permissions";
                case SpeechRecognizer.ERROR_NETWORK:
                    return "Network error";
                case SpeechRecognizer.ERROR_NETWORK_TIMEOUT:
                    return "Network timeout";
                case SpeechRecognizer.ERROR_NO_MATCH:
                    return "No match found";
                case SpeechRecognizer.ERROR_RECOGNIZER_BUSY:
                    return "Recognition service busy";
                case SpeechRecognizer.ERROR_SERVER:
                    return "Server error";
                case SpeechRecognizer.ERROR_SPEECH_TIMEOUT:
                    return "No speech input";
                default:
                    return "Unknown error";
            }
        }
    }
}
