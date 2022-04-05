Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127DAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 06:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiDEGPN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 02:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiDEGPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:15:08 -0400
X-Greylist: delayed 50931 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Apr 2022 23:13:06 PDT
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC705DA7F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 23:13:06 -0700 (PDT)
Date:   Tue, 05 Apr 2022 06:12:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1649139184;
        bh=CNTzLZuK92HrqxpWUU87ns76MKGf89jrViurLrFSuHw=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=Ne9h1Kqba7jhD0DmJRpXFYLdfnhbpGzFHheFZs/Enp/e9nvT3rOz+irlib3JeRiM2
         WccjYrWAMSrKGmQdSX8hnV/kSMQdPKeLe5Aor0ehlL3YVVCAdVv2Py6HRtL6LpyLt6
         JH2q8kLtOrxBAEahohZLsFIo8awWDP5RtW79xYOieLPEBklUr0/eoXPaT8ufJieAxN
         UzDguh6M2cd0MFi3l8OwiTVHyXHngbUa9Za/kzihe6kxSQkcNIWnReh33DunsSUDs+
         HaRte1+xbdKWZEJgP/+X90sOIkELtbNlaUCQ6Dv6q4DJYhPoRm6JGUxGe19f0xA/vU
         L+vVqD+9UV0bg==
To:     Randy Dunlap <rdunlap@infradead.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/format_helper: fix a kernel-doc typo
Message-ID: <BzpH4s8ZYn84kTlJQ3BHVMQzZlESb2Fk6v-uO5KBaaeBNMvRvC98lpuBLUNLE3a5bdoYTb5JRvo6EU__5AGJ79LUirSppO39I1t1xlwx-fI=@emersion.fr>
In-Reply-To: <b20bbd22-895c-9e74-e579-d2f3561a2fe1@infradead.org>
References: <20220403232902.1753-1-rdunlap@infradead.org> <ttcrpLw9HkdhAH5SkXylXDBi9SBf7LWgOeW09ZvTF4U4_zKJAOXBQZlFxfw6NKY0Hip6dXBFape6zkX09cstuOno72c-c00wmZ_VbNDg6xs=@emersion.fr> <b20bbd22-895c-9e74-e579-d2f3561a2fe1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 4th, 2022 at 23:35, Randy Dunlap <rdunlap@infradead.org> w=
rote:

> On 4/4/22 09:04, Simon Ser wrote:
>
> > Both doc patches pushed, thanks. I had to manually edit them because th=
ey
> > wouldn't apply cleanly. Next time, please use git-send-email (see
> > https://git-send-email.io/ for setup instructions).
>
> That's odd. I did use 'git send-email' and I don't usually have any
> problems (AFAIK). I'll check those setup instructions.

Hm, maybe the issue isn't git-send-email, but the way the patch was
generated? I had to manually edit these lines for the first patch to work:

    --- linux-next-20211217.orig/include/drm/drm_file.h
    +++ linux-next-20211217/include/drm/drm_file.h

I changed these to:

    --- a/include/drm/drm_file.h
    +++ b/include/drm/drm_file.h

This wasn't enough for the second patch, I had to re-do the changes by hand
from scratch.
