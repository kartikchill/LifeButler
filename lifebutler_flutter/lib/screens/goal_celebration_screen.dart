import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:confetti/confetti.dart';
import 'package:just_audio/just_audio.dart';
import '../utils/quotes.dart';

class CinematicCelebrationOverlay extends StatefulWidget {
  const CinematicCelebrationOverlay({super.key});

  @override
  State<CinematicCelebrationOverlay> createState() => _CinematicCelebrationOverlayState();
}

class _CinematicCelebrationOverlayState extends State<CinematicCelebrationOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _masterController;
  late ConfettiController _confettiController;
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  // Animation Definitions
  late Animation<double> _bgOpacity;
  late Animation<double> _trophyScale;
  late Animation<double> _trophyRotate;
  late Animation<double> _quoteOpacity;
  late Animation<Offset> _quoteSlide;
  
  late String _activeQuote;
  bool _audioInitialized = false;

  @override
  void initState() {
    super.initState();
    _activeQuote = Quotes.getRandomQuote(QuoteType.goal);
    
    // Master Animation Controller (3 Seconds Total)
    _masterController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _confettiController = ConfettiController(duration: const Duration(seconds: 1));

    _setupAnimations();
    _initAudio();
    
    // START SEQUENCE
    _masterController.forward().ignore();
    
    // Schedule Auto-Dismissal
    Future.delayed(const Duration(milliseconds: 3200), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });

    // Confetti Trigger
    Future.delayed(const Duration(milliseconds: 600), () {
       if (mounted) _confettiController.play();
    });
  }

  void _setupAnimations() {
    // 1. Background Gradient Fade In (0 - 500ms)
    _bgOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.0, 0.16, curve: Curves.easeOut), 
      ),
    );

    // 2. Trophy Pop In (300ms - 800ms) with Overshoot
    _trophyScale = TweenSequence<double>([
       TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.2), weight: 60),
       TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 40),
    ]).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.1, 0.27, curve: Curves.easeOut),
      ),
    );
    
    // Trophy Idle Rotation (Gentle Rocking) after pop
    _trophyRotate = TweenSequence<double>([
       TweenSequenceItem(tween: ConstantTween(0.0), weight: 27), // Wait for pop
       TweenSequenceItem(tween: Tween(begin: -0.05, end: 0.05), weight: 20),
       TweenSequenceItem(tween: Tween(begin: 0.05, end: -0.05), weight: 20),
       TweenSequenceItem(tween: Tween(begin: -0.05, end: 0.0), weight: 33),
    ]).animate(
       CurvedAnimation(parent: _masterController, curve: Curves.easeInOut)
    );

    // 3. Quote Slide & Fade (1000ms - 1500ms)
    _quoteOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.33, 0.5, curve: Curves.easeOut),
      ),
    );

    _quoteSlide = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.33, 0.5, curve: Curves.easeOutCubic),
      ),
    );
  }

  Future<void> _initAudio() async {
    try {
      // Load audio
      await _audioPlayer.setAsset('assets/sounds/goal_complete.mp3');
      _audioInitialized = true;
      
      // Schedule Playback
      // FIXME: Audio file 'assets/sounds/goal_complete.mp3' is missing. 
      // Uncomment when file is added to assets/sounds/
      /* 
      Future.delayed(const Duration(milliseconds: 400), () async {
         if (mounted && _audioInitialized) {
           try {
             await _audioPlayer.play();
             HapticFeedback.heavyImpact();
           } catch (e) {
             debugPrint("Audio playback failed: $e");
           }
         }
      });
      */
      
      // Haptics still work!
      Future.delayed(const Duration(milliseconds: 400), () {
         if (mounted) HapticFeedback.heavyImpact();
      });
    } catch (e) {
      debugPrint("Audio init failed: $e");
      // Continue silently
    }
  }

  @override
  void dispose() {
    _masterController.dispose();
    _confettiController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: _masterController,
        builder: (context, child) {
          // Fade out everything at the very end (last 300ms)
          final double exitOpacity = (_masterController.value > 0.9) 
              ? ((1.0 - _masterController.value) * 10).clamp(0.0, 1.0)
              : 1.0;
          
          return Opacity(
            opacity: exitOpacity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                  // 1. Background
                Opacity(
                  opacity: _bgOpacity.value.clamp(0.0, 1.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          Color(0xFFB8860B), // Dark Goldenrod
                          Color(0xFF000000), // Pure Black
                        ],
                        radius: 1.0,
                        stops: [0.0, 0.9],
                      ),
                    ),
                  ),
                ),
        
                // 2. Confetti (Behind Trophy)
                Align(
                  alignment: Alignment.center,
                  child: ConfettiWidget(
                    confettiController: _confettiController,
                    blastDirectionality: BlastDirectionality.explosive,
                    emissionFrequency: 0.05,
                    numberOfParticles: 30,
                    maxBlastForce: 20,
                    minBlastForce: 8,
                    gravity: 0.2,
                    colors: const [
                       Colors.amber, Colors.orange, Colors.yellowAccent, Colors.white 
                    ],
                  ),
                ),
        
                // 3. Trophy
                Transform.scale(
                  scale: _trophyScale.value,
                  child: Transform.rotate(
                    angle: _trophyRotate.value * pi,
                    child: ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: const Icon(
                        Icons.emoji_events,
                        size: 160,
                        color: Colors.white, // Required for shader mask
                      ),
                    ),
                  ),
                ),
        
                // 4. Quote
                Positioned(
                  bottom: 150,
                  left: 30,
                  right: 30,
                  child: Opacity(
                    opacity: _quoteOpacity.value.clamp(0.0, 1.0),
                    child: SlideTransition(
                      position: _quoteSlide,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                             Text(
                            "GOAL CRUSHED!",
                            style: TextStyle(
                              color: Colors.amber.shade200,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "\"$_activeQuote\"",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              height: 1.3,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Outfit',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
