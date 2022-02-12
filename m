Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF2BC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Feb 2022 03:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiBLDCq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Feb 2022 22:02:46 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiBLDCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 22:02:43 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F992E09C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 19:02:41 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id k60-20020a17090a4cc200b001b932781f3eso5446159pjh.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 19:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ad32dWZT1kf5zGTYU4IpBKS5U79fVKO91bchc5qdt+c=;
        b=YIcvtBHXTNBoaFkEt++oOLCdGRkjPb61Eb2AOJ24hL1c1JanvpgCfPl97D6wy5kyez
         1ME99OjKM1XmFZUqtNNqkcvI1MoE6nQEs61BPQIeQQA2NsdO1uAhnmDU9m9pIdW/qA/Z
         zTRcuJF++Wpd+qKqU6MobeH15vJv8MkrsUS40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ad32dWZT1kf5zGTYU4IpBKS5U79fVKO91bchc5qdt+c=;
        b=QlCwz+DQ9mmZtJ5hHuPzSCx+X9BPyUTwIf6DdClVMbf7C40p1fDyDf28yIT8TaWUF4
         j2pA77hGm+sU2TIBpvwQSjpGH/ygtI7IE8ENb87hCks8lwhTZt+AvwfM9Wzvqe21mRwW
         Q6/pnPNwTZtgfNv0LJBEmMsTTYeyBXNnjZh1elMhr0dU4WubuVBxXwIl0Yvyeo5DFlby
         64I/tj9s/2+wfDjhEYsbl13kHzH9QdfeZPKn2CeAPlBf7JiEC/g8yDdQpCsT9pHQmHQt
         QajlAhVybb1IkP4ec8lPjGMSQmmTx5PSETaSIgpvwWh73MyuAbOPwjX5Yh20St5HyPe3
         3ifw==
X-Gm-Message-State: AOAM532y9AhMqcTPNbD2VqIswf10AFulzsZwSTo78Iy393tkziUvKHmS
        I0aRSFQZVA1VB2VhVuYG/lTGHw==
X-Google-Smtp-Source: ABdhPJwJcLIefcGVgT0+0/aVX2/V6aiq6NmbxpACsrDMq0FBiYFJWoQLNO7EJlKl/OEZdfz7lQNQpA==
X-Received: by 2002:a17:90b:3e8e:: with SMTP id rj14mr3437693pjb.35.1644634960526;
        Fri, 11 Feb 2022 19:02:40 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lr8sm6523297pjb.11.2022.02.11.19.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 19:02:40 -0800 (PST)
Date:   Fri, 11 Feb 2022 19:02:38 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Robert =?utf-8?B?xZp3acSZY2tp?= <robert@swiecki.net>,
        Will Drewry <wad@chromium.org>
Subject: [GIT PULL] seccomp fixes for v5.17-rc4
Message-ID: <202202111856.4A98232C9D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these signal and seccomp fixes for v5.17-rc4. This fixes a
corner case of fatal SIGSYS being ignored since v5.15. Along with the
signal fix is a change to seccomp so that seeing another syscall after
a fatal filter result will cause seccomp to kill the process harder.

Thanks!

-Kees

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.17-rc4

for you to fetch changes up to eed09ad261822a7bdc441ed192c6f444375e5527:

  samples/seccomp: Adjust sample to also provide kill option (2022-02-10 19:09:12 -0800)

----------------------------------------------------------------
seccomp fixes for v5.17-rc4

- Force HANDLER_EXIT even for SIGNAL_UNKILLABLE.
- Make seccomp self-destruct after fatal filter results.
- Update seccomp samples for easier behavioral demonstration.

----------------------------------------------------------------
Kees Cook (3):
      signal: HANDLER_EXIT should clear SIGNAL_UNKILLABLE
      seccomp: Invalidate seccomp mode to catch death failures
      samples/seccomp: Adjust sample to also provide kill option

 kernel/seccomp.c          | 10 ++++++++++
 kernel/signal.c           |  5 +++--
 samples/seccomp/dropper.c |  9 +++++++--
 3 files changed, 20 insertions(+), 4 deletions(-)

-- 
Kees Cook
