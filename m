Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFEBC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 17:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237824AbiCVR1n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 13:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239647AbiCVR1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:27:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42021506EC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:26:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C57B1B81C87
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 17:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B475C340EC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 17:26:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cySeZPZH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1647969959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vlMpDiANaYcFKVW9SSXrgpBBM5wPvo6GBNWee0H326E=;
        b=cySeZPZHjZ5silCQIwzMiLCSyCOtSvNlhrlW0hal3xQE2AbaHb7evQq9kx4BPT2gRVhArq
        PxHebqTuaNYcFrUPPoXoUNzIC3gXCn8MFe1ldqTzaRRjoGqMPQUyCGXlfRNi0jnYEUfQKF
        BCHA4SL0XDnjm3ski5JId/sbFMyjAnQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 71d61a75 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 22 Mar 2022 17:25:59 +0000 (UTC)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2e592e700acso199050557b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:25:59 -0700 (PDT)
X-Gm-Message-State: AOAM533hkCvXbOrTuDpDN1yO4HVhl5TX0DotSI3G62ngOXv1Kiw4Ra2B
        i64aNDEet708FruLIKgNZI/po6lNakrFoRcXFTo=
X-Google-Smtp-Source: ABdhPJzc/0hmDEVWVG3NdnLjmD1S+ybNkER/+3VaJqzzYOObes1Lw1e31Vy1smme3gF21NDJ4JGbaxsK69Le/4WrF5o=
X-Received: by 2002:a0d:c681:0:b0:2db:9ffe:1f00 with SMTP id
 i123-20020a0dc681000000b002db9ffe1f00mr31780181ywd.100.1647969958955; Tue, 22
 Mar 2022 10:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220322005256.3787-1-Jason@zx2c4.com> <YjlwXxVWg1GNUR5J@owl.dominikbrodowski.net>
In-Reply-To: <YjlwXxVWg1GNUR5J@owl.dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 22 Mar 2022 11:25:48 -0600
X-Gmail-Original-Message-ID: <CAHmME9pBXXfhpGngu5GRVF8BRx57VYP4w4W9m=B33zW7AVE9Ng@mail.gmail.com>
Message-ID: <CAHmME9pBXXfhpGngu5GRVF8BRx57VYP4w4W9m=B33zW7AVE9Ng@mail.gmail.com>
Subject: Re: [PATCH] random: skip fast_init if hwrng provides large chunk of entropy
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominik,

On Tue, Mar 22, 2022 at 12:45 AM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> Well, so far, we need 64 bytes input to the fast init stage, and then
> further 32 bytes of randomness to proceed to full init, and we used to mix
> the former into the latter, which provided for some sort of extra margin.
> But as we don't seem to do that any more (mixing some of base_crng back into
> the input_pool), that exercise may have become pointless.

"Some extra margin" but you're comparing 512 bits to 768 bits? That
makes no sense. 256 bits alone would be sufficient here. The whole
point of CONFIG_RANDOM_TRUST_BOOTLOADER=y is that the kernel builder
has chosen to trust the seed that comes from the bootloader. If it's
not trusted, then it goes through add_device_randomness(), which
doesn't have anything to do with fast init or the main init.

The purpose of "fast init" being separate from the full thing is so
that you can't brute force inputs bit by bit. Having a massive tranche
of 512 bits of entropy makes that brute forcing impossible; therefore
it doesn't make sense to do the fast init thing in that case.

Jason
