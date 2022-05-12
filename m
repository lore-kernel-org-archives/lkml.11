Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1534BC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 May 2022 12:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353921AbiELMli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 May 2022 08:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353915AbiELMlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:41:23 -0400
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546625799B
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:41:21 -0700 (PDT)
Date:   Thu, 12 May 2022 12:41:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1652359279;
        bh=UqamLj4BJ8E9gSU1cyoMnFv0DQaZ7oKu0fpmqx4XkMU=;
        h=Date:To:From:Reply-To:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=Er/8a6YP+4nfThL0mlkEjQDoMW+DqHzTUCotJgaVsuWUECGHKzWSOWmi/ZDsychbd
         61BflP9DaK1qfGptv5nseL0+q8KBsaNOYQCPwyMaA6jTZKvn+IKFfG/DRA0xIELbsP
         5tCItORkIZASbXFQ+3zQ913zO/MAnif9eutcMs38MRODYAEFojglFqJbRFxj6PiZvt
         lMKuAlkXkQqcA5GtU+0wdAZaqDIePksoppnwkxBp+A8/DD26LoAY6qlsLc2/wMHt3+
         1r2z22TxAI2w4wCZJcbwxpRavmTO0fRgX/zcm+hersRlbxIaaoQe4yqZegDJvaaVBX
         X0V1oLSbxAf0Q==
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
From:   Simon Ser <contact@emersion.fr>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: procfs: open("/proc/self/fd/...") allows bypassing O_RDONLY
Message-ID: <03l0hfZIzD9KwSxSntGcmfFhvbIKiK45poGUhXtR7Qi0Av0-ZnqnSBPAP09GGpSrKGZWZNCTvme_Gpiuz0Bcg6ewDIXSH24SBx_tvfyZSWU=@emersion.fr>
In-Reply-To: <lGo7a4qQABKb-u_xsz6p-QtLIy2bzciBLTUJ7-ksv7ppK3mRrJhXqFmCFU4AtQf6EyrZUrYuSLDMBHEUMe5st_iT9VcRuyYPMU_jVpSzoWg=@emersion.fr>
References: <lGo7a4qQABKb-u_xsz6p-QtLIy2bzciBLTUJ7-ksv7ppK3mRrJhXqFmCFU4AtQf6EyrZUrYuSLDMBHEUMe5st_iT9VcRuyYPMU_jVpSzoWg=@emersion.fr>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, May 12th, 2022 at 12:37, Simon Ser <contact@emersion.fr> wrote=
:

> what would be a good way to share a FD to another
> process without allowing it to write to the underlying file?

(I'm reminded that memfd + seals exist for this purpose. Still, I'd be
interested to know whether that O_RDONLY/O_RDWR behavior is intended,
because it's pretty surprising. The motivation for using O_RDONLY over
memfd seals is that it isn't Linux-specific.)
