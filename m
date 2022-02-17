Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2F2C4332F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 19:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244998AbiBQTIL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 14:08:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244993AbiBQTIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:08:09 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70FC85678
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:07:54 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id j201so3596267vke.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sc+EaJrNQanDC0tIQ/+hLCZwmcOXKaQszAADxGMNESM=;
        b=d+gLtI0iBFxzsdc1bjOFp4XYw3wkM9H8ua5Ht5qwuLPzCq2mtdenqFtfIZDWdRhsWY
         VIWn/r+o3PYhBNfxsKv+GnKX9+RJooqUDpB+rW82OR4DCH3+Zz5d1iKBoLRde/gFw1B9
         FJCfB19/KsaYaqfwLzTeHjBY1IcHyP78eTTVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sc+EaJrNQanDC0tIQ/+hLCZwmcOXKaQszAADxGMNESM=;
        b=beEeQL+ztnh27Z1HcOR4+BWY3W560SsyGdATGwCRwGi07guNHaMSjKH1B8xFGWmnu0
         0D+P+icmWOkbimRxaqqMI9JTeNA1TTLdHj9HBW7DuZ+YsHC+EI9ueupONAD6sukWUGc0
         6uWpVuQmdJ9JxmMUpNcr4y4QnNQQClDbroB72jLkHFW7sR16yABzsAplXqirIWWon8GX
         d54MubFiluaY1GDGPw8IoJqj77mhE90EkNDpw1rSP0/hwAeHipVNuRd7SR0jlJu7lkrW
         vKlZnlx7qpSHhGxi55a75nnf7Qwut9ePxWJASFtnYUVxK2wUdJYCwNZJQtsVZEIrqD3W
         SsAA==
X-Gm-Message-State: AOAM532t2L3frIooQLZs+WqIXC1pMY/rxpFN9r5aaV1FipfvHhK5PCKK
        LmR+CNbfiSFoJZB/1aq4dUacbbAsOPKjag==
X-Google-Smtp-Source: ABdhPJzCb9neWbtUQinxlhMXAX8R9qRob0Fr8V8EeIJbSwqJgk5UX1ox0O94mGMyvfitLbkt0nKl3Q==
X-Received: by 2002:a05:6122:549:b0:330:288:f36d with SMTP id y9-20020a056122054900b003300288f36dmr1905833vko.28.1645124873918;
        Thu, 17 Feb 2022 11:07:53 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id v201sm7753922vkv.54.2022.02.17.11.07.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 11:07:51 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id w4so7428487vsq.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:07:51 -0800 (PST)
X-Received: by 2002:a67:ac0a:0:b0:31b:6b29:f7b4 with SMTP id
 v10-20020a67ac0a000000b0031b6b29f7b4mr1993579vse.84.1645124870982; Thu, 17
 Feb 2022 11:07:50 -0800 (PST)
MIME-Version: 1.0
References: <20220217041427.1.I5dbf50eb1a7a6734ee727bda4a8573358c6d3ec0@changeid>
In-Reply-To: <20220217041427.1.I5dbf50eb1a7a6734ee727bda4a8573358c6d3ec0@changeid>
From:   Harry Cutts <hcutts@chromium.org>
Date:   Thu, 17 Feb 2022 11:07:40 -0800
X-Gmail-Original-Message-ID: <CA+jURcuNRBZrP+aiTMFFoXEpWvKaZRjEbT_JMqu5tNxHZy+i_A@mail.gmail.com>
Message-ID: <CA+jURcuNRBZrP+aiTMFFoXEpWvKaZRjEbT_JMqu5tNxHZy+i_A@mail.gmail.com>
Subject: Re: [PATCH] HID: Add mapping for KEY_DICTATE
To:     William Mahon <wmahon@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        William Mahon <wmahon@google.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Wed, 16 Feb 2022 at 20:15, William Mahon <wmahon@chromium.org> wrote:
>
> Numerous keyboards are adding dicate keys which allows for text
> messages to be dicated by a microphone.

Nit: a couple of typos for "dictate".

>
> This patch adds a new key definition KEY_DICTATE and maps 0x0c/0x0d8
> usage code to this new keycode. Additionally hid-debug is adjusted to
> recognize this new usage code as well.
>
> Signed-off-by: William Mahon <wmahon@google.com>
> ---
>
>  drivers/hid/hid-debug.c                | 1 +
>  drivers/hid/hid-input.c                | 1 +
>  include/uapi/linux/input-event-codes.h | 2 ++
>  3 files changed, 4 insertions(+)
>
> diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
> index 26c31d759914..8aa68416b1d7 100644
> --- a/drivers/hid/hid-debug.c
> +++ b/drivers/hid/hid-debug.c
> @@ -969,6 +969,7 @@ static const char *keys[KEY_MAX + 1] = {
>         [KEY_ASSISTANT] = "Assistant",
>         [KEY_KBD_LAYOUT_NEXT] = "KbdLayoutNext",
>         [KEY_EMOJI_PICKER] = "EmojiPicker",
> +       [KEY_DICTATE] = "Dictate",
>         [KEY_BRIGHTNESS_MIN] = "BrightnessMin",
>         [KEY_BRIGHTNESS_MAX] = "BrightnessMax",
>         [KEY_BRIGHTNESS_AUTO] = "BrightnessAuto",
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 112901d2d8d2..0c6c6db942ca 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -992,6 +992,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>                 case 0x0cd: map_key_clear(KEY_PLAYPAUSE);       break;
>                 case 0x0cf: map_key_clear(KEY_VOICECOMMAND);    break;
>
> +               case 0x0d8: map_key_clear(KEY_DICTATE); break;
>                 case 0x0d9: map_key_clear(KEY_EMOJI_PICKER);    break;
>
>                 case 0x0e0: map_abs_clear(ABS_VOLUME);          break;
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 225ec87d4f22..12246594891c 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -735,6 +735,8 @@
>  #define KEY_KBD_LCD_MENU4              0x2bb
>  #define KEY_KBD_LCD_MENU5              0x2bc
>
> +#define KEY_DICTATE                    0x27b
> +

The list should be sorted in order of evdev code, so KEY_DICTATE
should go just below KEY_SELECTIVE_SCREENSHOT.

>  #define BTN_TRIGGER_HAPPY              0x2c0
>  #define BTN_TRIGGER_HAPPY1             0x2c0
>  #define BTN_TRIGGER_HAPPY2             0x2c1
> --
> 2.35.1.265.g69c8d7142f-goog
>
