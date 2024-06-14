package states;

import flixel.FlxState;
import flixel.FlxG;
import flixel.util.FlxTimer;
import openfl.utils.Assets;
import backend.Song;

#if VIDEOS_ALLOWED
import vlc.MP4Handler;
#end

#if sys
import sys.FileSystem;
import sys.io.File;
#end

using StringTools;

class SkibidiSigmaPomni extends MusicBeatState
{  
    override function create()
    {
        FlxG.sound.music.stop();
        startVideo('Cutscene'); //put the video name here make sure the video on videos folder. you dont need to add like blabla.mp4 just blabla
        FlxG.mouse.visible = false;
    }

    //override function update(elapsed)
    //{
        //if (FlxG.keys.justPressed.SPACE || FlxG.keys.justPressed.ENTER)   FlxG.switchState(new TitleState()); //uncomment this so if you press space or enter the intro will be skipped
    //}

    function startVideo(name:String)
    {
        #if VIDEOS_ALLOWED
        var filepath:String = Paths.video(name);
        #if sys
        if(!FileSystem.exists(filepath))
        #else
        if(!Assets.exists(filepath))
        #end
        {
            FlxG.log.warn('Couldnt find video file: ' + name);
            return;
        }

        var video:MP4Handler = new MP4Handler();
        video.playVideo(filepath);
        video.finishCallback = function()
        {
            PlayState.SONG = Song.loadFromJson('Bloody-Encounter', 'Bloody-Encounter');
            LoadingState.loadAndSwitchState(new PlayState());
            return;
        };

        #else
        FlxG.log.warn('Platform not supported!');
        return;
        #end
    }
}
