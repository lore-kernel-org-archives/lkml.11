Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB060C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Apr 2022 23:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbiDQXYE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Apr 2022 19:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiDQXYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 19:24:00 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591B1DE8B
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 16:21:22 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id m132so23115397ybm.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 16:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O00fc+i0v88lzrSOPGhnMjcXGMFnyoIrLk5UDjc1Hzc=;
        b=qFHzsI7qeUZ5fXwRmYUP/Hj/wYB5cyybn1IeHlq3kg45OhT4qVStQdEjrrfL/aPFO6
         v1sHbifWprmlRKgj7BO9l31IDLY75SF3q+7p6uhINkxsmELnUBweA+afhIm9Q4PEZy43
         6+vyksJUIU1SRz4Hi3tihRj0FJPXCpbZVsuQH7Cl/cm4Bru8XKoQTogqvrH3ts3alyft
         OXGUzUhTh8458s9awnDhx1q+ZjL8rhioQx5xp58ZColvcuAw+3JfY0ByiToRp6MHggS4
         pT6eQivpr1Jq7zNq63qOvk3DxaqfFI+kh3W8EJTFj5nyb4nU2qYxLKrvhCkS3fepvz0/
         E8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O00fc+i0v88lzrSOPGhnMjcXGMFnyoIrLk5UDjc1Hzc=;
        b=LgHjhcoydzphatGxkXKfQ27Ln22Ze6IcFf/cZzzjE3WxR8cDFCSSs2O9o62262p7VB
         rjKAG6Sv7/jrlyElqJjWicdaKNtaV3QPzS3NSvF1fLvdhYLiiGC5jvXBCn56k6dhBrK0
         eTsgRzN6wSqIyRz2gEu+3FwGYWbAygDhTRB9AbqJaE6PceBEyexG/BBhfVfk4Uwn7mMp
         dyU7DKz+8HjI60WJI7+SJArBhTrE8sJtam+Yyi3GAUjLjkuezJAnmAybCo4DWMbx4hAQ
         JvOHnamR7oS0E36lrgwdKb0dQ4zeUVGKAHvYY+iMqaUCL4hHDYpN+1tKFTxkEeIKGsT1
         UkTw==
X-Gm-Message-State: AOAM5333N1MU+IntATEFVP3CaNGfbNSf9D/Glr+kLWMeEOgyqu4ceXL8
        oU+cswCzLjT3f0DHjRTTXoAKrlZMlnQFKk1NxPcSHw==
X-Google-Smtp-Source: ABdhPJzOA7yzfFuAI+Lwd+bL2EF0WqpFIaMIpX0xPSxNn8V7OP5z5OyAlcIyyfHH4KFcVbUmJdTBIMU+m9DbMzZCxTY=
X-Received: by 2002:a25:2fd5:0:b0:641:20df:13e8 with SMTP id
 v204-20020a252fd5000000b0064120df13e8mr8135232ybv.291.1650237681498; Sun, 17
 Apr 2022 16:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220316023356.120595-1-victor@allwinnertech.com>
In-Reply-To: <20220316023356.120595-1-victor@allwinnertech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Apr 2022 01:21:10 +0200
Message-ID: <CACRpkdabVpD8fQYowCFibdc-r7of6JQnUJAeo0Quqg=cCuOjAQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: mmu: fix access to illegal address when using
 earlycon & memblock=debug
To:     Victor Hassan <victor@allwinnertech.com>
Cc:     linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk,
        yanfei.xu@windriver.com, ardb@kernel.org, tglx@linutronix.de,
        mirq-linux@rere.qmqm.pl, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        allwinner-opensource-support@allwinnertech.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 3:33 AM Victor Hassan <victor@allwinnertech.com> wrote:

> earlycon uses fixmap to create a memory map,
> So we need to close earlycon before closing fixmap,
> otherwise printk will access illegal addresses.
> After creating a new memory map, we open earlycon again.
>
> Signed-off-by: Victor Hassan <victor@allwinnertech.com>

I think noone really noticed this because everyone on Arm systems
use CONFIG_DEBUG_LL, and that makes printascii hammer out
stuff on the console very early, it even accounts for whether we have
MMU on or not.

How are you using this on Arm even? What system and what serial
driver?

That said, it looks correct.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
