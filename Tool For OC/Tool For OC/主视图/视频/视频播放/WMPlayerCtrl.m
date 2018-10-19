//
//  WMPlayerCtrl.m
//  Tool For OC
//
//  Created by 曹老师 on 2018/4/19.
//  Copyright © 2018年 曹老师. All rights reserved.
//

#import "WMPlayerCtrl.h"
#import "WMPlayer.h"

@interface WMPlayerCtrl () <WMPlayerDelegate>  {
    
    WMPlayer *wmPlayer;
    
}

@end

@implementation WMPlayerCtrl


#pragma mark ========================================生命周期========================================

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    if (wmPlayer) {
        [self releaseWMPlayer];
    }
    
    wmPlayer = [[WMPlayer alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 20, (kScreenWidth - 20) * 0.6)];
    wmPlayer.delegate = self;
    wmPlayer.closeBtnStyle = CloseBtnStyleClose;
    //关闭音量调节的手势
    //        wmPlayer.enableVolumeGesture = NO;
    wmPlayer.titleLabel.text = @"小黄人";
    wmPlayer.URLString = @"http://betaqnv.villago.cn/videos/lib/1535191368117.mp4";
    [_mainView addSubview:wmPlayer];
    
    
    
}




-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self releaseWMPlayer];
}

/**
 *  释放WMPlayer
 */
-(void)releaseWMPlayer{
    //堵塞主线程
    //    [wmPlayer.player.currentItem cancelPendingSeeks];
    //    [wmPlayer.player.currentItem.asset cancelLoading];
    [wmPlayer pause];
    
    
    [wmPlayer removeFromSuperview];
    [wmPlayer.playerLayer removeFromSuperlayer];
    [wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
    wmPlayer.player = nil;
    wmPlayer.currentItem = nil;
    //释放定时器，否侧不会调用WMPlayer中的dealloc方法
    [wmPlayer.autoDismissTimer invalidate];
    wmPlayer.autoDismissTimer = nil;
    
    
    wmPlayer.playOrPauseBtn = nil;
    wmPlayer.playerLayer = nil;
    wmPlayer = nil;
}



#pragma mark ========================================动作响应=============================================

#pragma mark ========================================网络请求=============================================


#pragma mark ========================================代理方法=============================================

-(void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)closeBtn{
    NSLog(@"didClickedCloseButton");
    
    
}
-(void)wmplayer:(WMPlayer *)wmplayer clickedFullScreenButton:(UIButton *)fullScreenBtn{
    NSLog(@"clickedFullScreenButton");
}

///播放器事件
-(void)wmplayer:(WMPlayer *)wmplayer singleTaped:(UITapGestureRecognizer *)singleTap{
    NSLog(@"didSingleTaped");
}
-(void)wmplayer:(WMPlayer *)wmplayer doubleTaped:(UITapGestureRecognizer *)doubleTap{
    NSLog(@"didDoubleTaped");
}

///播放状态
-(void)wmplayerFailedPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    NSLog(@"wmplayerDidFailedPlay");
}
-(void)wmplayerReadyToPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    NSLog(@"wmplayerDidReadyToPlay");
}
-(void)wmplayerFinishedPlay:(WMPlayer *)wmplayer{
    NSLog(@"wmplayerDidFinishedPlay");
//    [self releaseWMPlayer];
}



























@end
