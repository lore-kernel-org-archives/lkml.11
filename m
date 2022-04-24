Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DECC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Apr 2022 14:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238140AbiDXO2Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Apr 2022 10:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbiDXO2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 10:28:20 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69176F13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 07:25:19 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id g28so3423538ybj.10
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 07:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L9NLtbmHfsRDaArBldTalYPtlLAhaGbJy0XtjJ42Pc8=;
        b=gotl9zyrPMEpBBB75zHAVtoNcGvrwlv8gZBaUOGgGTTlDKLs9vWnUNX+QVELUI/gFn
         FXNyCW8IQshWwaBZiewM0wu1pkPOXpMlHr8ZJep6Q7dxv9r0IH/TryiMOt/Gp0oZHX72
         HNekPe2jA9hCmFWhnttnDCVGEsVmS3PWQ6Ziz2557b2KnMeZB96WZWBWjN/loEVJCytF
         0u0GkYtyo8ftZNiRulrDGM4Fd1c38QKfHBrr7w5Ow0O2WMhNIJHM4r0Zlj+2upZtzSct
         k4z7OFLdFuFgfuYDZgcbkeOPUi6xiqIuicq/dpDawKpBtECGOhIx6DIFpVwNO118usvh
         Gg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L9NLtbmHfsRDaArBldTalYPtlLAhaGbJy0XtjJ42Pc8=;
        b=mxf9Z0K99ma23aUA4q6Ui3tSfzD6i44kP6/hYHvmf79REnDNlWh6Q26bRWFrkChimj
         R1za39w5wH/ZSRNnmegnMRKfAEVeEWZBkdTKFHL7iBspw1c58f8hg/dRZGdJKMGwlmM9
         ewHnERJlH3QHlRIyjsgg3BDQ+GAiiZSpeJy7cDLZZjfTmsvpOI3Tzer2U/NEpgz9Umtm
         tdkC2h4aM6sQPAR3L27ZQ6tMGVxD8GawYVm3gYKNAMrcVjVBH0AiTGpqVPhh2CqwID5i
         DWXFmACRqrweT0X33oUlgtt+PGZEBhJfOT0VdMHJXiw51clHQK8Ijf9SHPFbaqF9Lsgn
         nwzw==
X-Gm-Message-State: AOAM530NLBGfdxErTdaW+fh8D7F68tbsARsL8v2CWXolvuNHwCu+vMTk
        Wgw3g9nNc3oiWiT3sGxQLiIGTP1ttR6uIjkuHIBEqw==
X-Google-Smtp-Source: ABdhPJz+iM6j4+k7LHj3uRaybDvpyb35LYUQaJtvmlJ8ZZX6TYIcNdRneNYOUbygjhRCK5EMnFO3pQa9yY0C2Cmqzmk=
X-Received: by 2002:a5b:dc5:0:b0:624:f16d:7069 with SMTP id
 t5-20020a5b0dc5000000b00624f16d7069mr12374379ybr.295.1650810318717; Sun, 24
 Apr 2022 07:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220422085240.2776527-1-lv.ruyi@zte.com.cn> <20220424031430.3170759-1-lv.ruyi@zte.com.cn>
In-Reply-To: <20220424031430.3170759-1-lv.ruyi@zte.com.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 24 Apr 2022 16:25:07 +0200
Message-ID: <CACRpkda4Q7M0KNnSx3OP45mdEg2YQiw2bk1JGiHgy8PSuK9adw@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: fix error check return value of irq_of_parse_and_map()
To:     cgel.zte@gmail.com
Cc:     Damien.Horsley@imgtec.com, abrestic@chromium.org,
        ezequiel.garcia@imgtec.com, govindraj.raja@imgtec.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lv.ruyi@zte.com.cn, Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 5:14 AM <cgel.zte@gmail.com> wrote:

> From: Lv Ruyi <lv.ruyi@zte.com.cn>
>
> The irq_of_parse_and_map() function returns 0 on failure, and does not
> return an negative value.
>
> Fixes: cefc03e5995e ("pinctrl: Add Pistachio SoC pin control driver")
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
> v2: don't print irq, and return -EINVAL rather than 0

Patch applied for fixes (changed the subject a bit).

Thanks!
Linus Walleij
