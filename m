Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35241C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 15:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352860AbiBUP2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 10:28:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238567AbiBUP2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:28:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26931EADE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:28:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74FE6B811CE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:28:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDDF2C340EC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:28:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ajJHS1y6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645457285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QbEz44XlEfPnVHEvqWZajF6RzTw22XSS4LtufiFeTR0=;
        b=ajJHS1y67cVDje/kc3hhHED9KzTaHY4UEms5UrwJsRE2j6TG2m0ofUMOYgwWeABM4HUeIo
        muyAtrHgzw1FNHJZGIsz0Sj0PwrlVG/xsQrA/YDdaEyG1friARywMs+YakcymxNEX2GSyp
        thRa4vpRkrbVcojgvfbmlbXsECQJPUU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b8e59d90 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 21 Feb 2022 15:28:05 +0000 (UTC)
Received: by mail-yb1-f178.google.com with SMTP id j2so35267425ybu.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:28:04 -0800 (PST)
X-Gm-Message-State: AOAM531DVcB7moz+3YB/AoE6iLn76r5ufJfJ6Jjvk27v2kMMQV6rBiBw
        P/GzAo4EzMnmc/j0JhAA4ypV+PRrcyO0+uUfl3E=
X-Google-Smtp-Source: ABdhPJyOrrgfbQ25/W2+G0xGlbb/vKCaGhRs+k2hufz4YThTwJHcoSqNxpKARUmaKFZot9vO4jCpZpOfNVrfO6/fBEM=
X-Received: by 2002:a25:d116:0:b0:61d:e8c9:531e with SMTP id
 i22-20020a25d116000000b0061de8c9531emr19227765ybg.637.1645457284110; Mon, 21
 Feb 2022 07:28:04 -0800 (PST)
MIME-Version: 1.0
References: <20220212122318.623435-1-Jason@zx2c4.com> <20220212122318.623435-10-Jason@zx2c4.com>
 <YhMhbKdIH2wwEDxc@sol.localdomain>
In-Reply-To: <YhMhbKdIH2wwEDxc@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 21 Feb 2022 16:27:53 +0100
X-Gmail-Original-Message-ID: <CAHmME9o5FhAWYS7bfnXzNzLBtCadAYWXHjmE2tZNMG3C64NeKw@mail.gmail.com>
Message-ID: <CAHmME9o5FhAWYS7bfnXzNzLBtCadAYWXHjmE2tZNMG3C64NeKw@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] random: group sysctl functions
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 6:21 AM Eric Biggers <ebiggers@kernel.org> wrote:
> This is a nice explanation, but shouldn't
> Documentation/admin-guide/sysctl/kernel.rst be updated instead, and this comment
> point to there?

I'll update kernel.rst for this and for the other thing in a separate
commit to make merge conflicts less annoying.
