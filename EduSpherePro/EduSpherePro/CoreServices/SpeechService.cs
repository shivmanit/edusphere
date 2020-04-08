using System;
using System.Collections.Generic;
using System.Linq;
using System.Speech.Synthesis;
using System.Threading.Tasks;
using System.Web;

namespace EduSpherePro.CoreServices
{
    public class SpeechService : ISpeechService
    {
        public async void Speak(string text)
        {
           await ConvertTextToSpeech(text);
        }

        public static Task ConvertTextToSpeech(string text)
        {
            return Task.Run(() =>
            {
                // creating the object of SpeechSynthesizer class  
                SpeechSynthesizer sp = new SpeechSynthesizer();
                //setting volume   
                sp.Volume = 100;
                //ing text box text to SpeakAsync method   
                sp.SpeakAsync(text);
            });

        }
    }
}