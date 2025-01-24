/// @desc Setting MailPost
mailpost = new MailPost();
mailpost.add_subscription(MESSAGE_BGM_VOLUME_CHANGE, bgm_on_volume_change)
mailpost.add_subscription(MESSAGE_SFX_VOLUME_CHANGE, sfx_on_volume_change)