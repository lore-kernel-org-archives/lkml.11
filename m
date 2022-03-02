Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA75C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 16:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241187AbiCBQNM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 11:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237727AbiCBQNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:13:08 -0500
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17529CD9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:12:23 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id y1so989222uap.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 08:12:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/qRg/Mm/97zJFeWgtUsYDDaU5xcw69+jJupgj9B3Thk=;
        b=igKYxARf2kVHH+A/qGCAYoDftmK3ScJWuPlTpGxEGTO4pc8B+Ji6e/wo1MliVS5HbJ
         Rwsy8oTb7u7jkvsYbJOEVGFjSH3rTsf+zKO5sd3GhigK3QWhPAvSpesj1XTVW5W7O07E
         gdZbOMrOHWeIv6PGKDiN7OlH1wih8JSrSIkAnt3RxNbCJhZUmrQYbGtzvWYXH90GmXrD
         1XKZlkHJc24KQQs9NfyK8iY7AZwPEfTxLL30q4LF8ugFPc/yGkAUbnfRxjMEaOuAjQE8
         6fYHr7SQv0met7K2PJ75eEwZfKwWNxDrvk5WFkVzTlclO9zpw+2+l9HncbPfR5SPkx4q
         wb6w==
X-Gm-Message-State: AOAM532yFLPy9jHE5Eo8j39uFCmOys1WE887vtOxTyswFmZgyTh14KGe
        zVj0QWjVdddC/VF0dnLHJT7SUn4u5VoJ+w==
X-Google-Smtp-Source: ABdhPJxn97amtGJSdQX7NaxHzymPjvm7M2zeavVebRa86ef9DzNny9GodKIGgcGkaDPMgaSrrrNbIQ==
X-Received: by 2002:ab0:7602:0:b0:347:b460:72c2 with SMTP id o2-20020ab07602000000b00347b46072c2mr3682579uap.12.1646237542062;
        Wed, 02 Mar 2022 08:12:22 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id m6-20020a0561023e8600b0031bb1803345sm2130363vsv.6.2022.03.02.08.12.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 08:12:21 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id j9so1155959vkj.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 08:12:21 -0800 (PST)
X-Received: by 2002:a1f:9f82:0:b0:336:8f32:eb24 with SMTP id
 i124-20020a1f9f82000000b003368f32eb24mr1457974vke.0.1646237541363; Wed, 02
 Mar 2022 08:12:21 -0800 (PST)
MIME-Version: 1.0
References: <20220223154718.83500-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220223154718.83500-1-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 2 Mar 2022 17:12:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXAMwmfLoaGnKhgfOEWY+O2Ek6J3nM-5mQThUnJFxhA3Q@mail.gmail.com>
Message-ID: <CAMuHMdXAMwmfLoaGnKhgfOEWY+O2Ek6J3nM-5mQThUnJFxhA3Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] auxdisplay: lcd2s: Fix lcd2s_redefine_char() feature
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Lars Poeschel <poeschel@lemonage.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 2:03 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> It seems that the lcd2s_redefine_char() has never been properly
> tested. The buffer is filled by DEF_CUSTOM_CHAR command followed
> by the character number (from 0 to 7), but immediately after that
> these bytes are got rewritten by the decoded hex stream.
>
> Fix the index to fill the buffer after the command and number.
>
> Fixes: 8c9108d014c5 ("auxdisplay: add a driver for lcd2s character display")
> Cc: Lars Poeschel <poeschel@lemonage.de>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
